<?php
declare(strict_types=1);

/**
 * ЖБИ-500 (zbi.sonclick.dev) Catalog API — front controller (MiniShop2 adapter).
 *
 * Реализует контракт PK-Beton /api/v1 поверх каталога MiniShop2
 * (modx_site_content + modx_ms2_products). "pricelist" == msCategory,
 * "product" == msProduct внутри неё, идентификация товара — индексом.
 *
 * ЦЕНООБРАЗОВАНИЕ (движок наценок).
 * У MiniShop2, в отличие от pricelister, нет render-слоя, который применял бы
 * наценки/коэффициент при выводе. Поэтому считаем итоговую цену здесь и пишем
 * её прямо в modx_ms2_products.price, а исходную («базовую») цену храним отдельно,
 * чтобы наценки не накручивались поверх уже наценённой цены.
 *
 *   site_price (ms2_products.price) = round( base × coefficient × (1 + effMarkup/100) )
 *   base       = COALESCE(price_override, base_price)        // что редактируется в поле «цена»
 *   effMarkup  = markup_percent>0 ? markup_percent : pricelist_markup(категории)
 *   coefficient= коэффициент сайта (по умолчанию 1)
 *
 * Состояние хранится в modx_mltagent_pricing (по товару) и modx_mltagent_meta
 * (коэффициент сайта + наценки прайс-листов). GET /pricelists отдаёт именно base,
 * поэтому в дашборде/синке цена не накручивается.
 */

class ApiException extends Exception
{
    public string $errCode;
    public int $httpStatus;
    public function __construct(string $code, string $message, int $http)
    {
        parent::__construct($message);
        $this->errCode = $code;
        $this->httpStatus = $http;
    }
}

$config = require __DIR__ . '/config.php';

// ---- CORS ----
$origin = $_SERVER['HTTP_ORIGIN'] ?? '';
if ($origin && in_array($origin, $config['allowed_origins'] ?? [], true)) {
    header("Access-Control-Allow-Origin: $origin");
    header('Vary: Origin');
    header('Access-Control-Allow-Methods: GET, POST, PATCH, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, X-API-Key, X-Context-Key');
    header('Access-Control-Max-Age: 600');
}
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
    http_response_code(204);
    exit;
}

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');
header('X-Content-Type-Options: nosniff');

try {
    [$method, $seg] = parseRequest();
    $pdo = makePdo();
    $prefix = $GLOBALS['__zbi_prefix'] ?? 'modx_';
    ensurePricingSchema($pdo, $prefix);
    $result = dispatch($method, $seg, $pdo, $prefix, $config);
    jsonOk($result);
} catch (ApiException $e) {
    jsonErr($e->errCode, $e->getMessage(), $e->httpStatus);
} catch (Throwable $e) {
    error_log('[zbi-api] ' . $e->getMessage() . "\n" . $e->getTraceAsString());
    jsonErr('INTERNAL', 'Unexpected error', 500);
}

// ---------------------------------------------------------------------------

function jsonOk($data): void
{
    echo json_encode(['ok' => true, 'data' => $data], JSON_UNESCAPED_UNICODE);
    exit;
}

function jsonErr(string $code, string $msg, int $http): void
{
    http_response_code($http);
    echo json_encode(['ok' => false, 'error' => ['code' => $code, 'message' => $msg]], JSON_UNESCAPED_UNICODE);
    exit;
}

function parseRequest(): array
{
    $method = strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET');
    $path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
    $path = preg_replace('#^/api/mltagent/?#', '/', $path) ?? '/';
    $seg = array_values(array_filter(explode('/', $path), fn($s) => $s !== ''));
    if (!$seg || $seg[0] !== 'v1') {
        throw new ApiException('NOT_FOUND', 'Unknown API version (expected /api/mltagent/v1/...)', 404);
    }
    array_shift($seg);
    return [$method, $seg];
}

function makePdo(): PDO
{
    $modxConfig = __DIR__ . '/../../core/config/config.inc.php';
    if (!is_file($modxConfig)) {
        throw new ApiException('SERVER_MISCONFIGURED', 'MODX config missing', 500);
    }
    require $modxConfig;
    $GLOBALS['__zbi_prefix'] = $table_prefix ?? 'modx_';
    if (empty($database_dsn)) {
        throw new ApiException('SERVER_MISCONFIGURED', 'Database DSN missing', 500);
    }
    return new PDO($database_dsn, $database_user, $database_password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
        PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8mb4',
    ]);
}

function requireAuth(array $config): void
{
    $key = (string)($config['api_key'] ?? '');
    if ($key === '') {
        throw new ApiException('SERVER_MISCONFIGURED', 'api_key is not set on server', 500);
    }
    $given = $_SERVER['HTTP_X_API_KEY'] ?? '';
    if (!is_string($given) || !hash_equals($key, $given)) {
        throw new ApiException('UNAUTHORIZED', 'Invalid or missing API key', 401);
    }
}

function jsonBody(): array
{
    $raw = file_get_contents('php://input') ?: '';
    if ($raw === '') {
        return [];
    }
    $d = json_decode($raw, true);
    if (!is_array($d)) {
        throw new ApiException('BAD_REQUEST', 'Invalid JSON body', 400);
    }
    return $d;
}

/** decimal "23290.00" -> "23290", "1234.50" -> "1234.5". */
function fmtPrice($p): string
{
    $s = (string)$p;
    if (strpos($s, '.') !== false) {
        $s = rtrim(rtrim($s, '0'), '.');
    }
    if ($s === '' || $s === '-0') {
        $s = '0';
    }
    return $s;
}

function dispatch(string $method, array $seg, PDO $pdo, string $prefix, array $config)
{
    $n = count($seg);

    if ($n === 1 && $seg[0] === 'health' && $method === 'GET') {
        return ['status' => 'ok', 'time' => gmdate('c')];
    }

    if ($n === 1 && $seg[0] === 'catalog' && $method === 'GET') {
        return ['categories' => []];
    }

    if ($seg[0] === 'pricelists') {
        if ($n === 1 && $method === 'GET') {
            return listPricelists($pdo, $prefix);
        }
        if ($n === 2 && $method === 'GET') {
            return getPricelist($pdo, $prefix, (int)$seg[1]);
        }
        if ($n === 2 && $method === 'PATCH') {
            requireAuth($config);
            return updatePricelist($pdo, $prefix, (int)$seg[1], jsonBody());
        }
        if ($n === 4 && $seg[2] === 'products' && $method === 'GET') {
            return findProduct($pdo, $prefix, (int)$seg[1], (int)$seg[3]);
        }
        if ($n === 4 && $seg[2] === 'products' && $method === 'PATCH') {
            requireAuth($config);
            return updateProduct($pdo, $prefix, (int)$seg[1], (int)$seg[3], jsonBody());
        }
        if ($n === 5 && $seg[2] === 'products' && $seg[4] === 'price' && $method === 'PATCH') {
            requireAuth($config);
            $b = jsonBody();
            if (!isset($b['price'])) {
                throw new ApiException('BAD_REQUEST', "'price' is required", 400);
            }
            return updateProduct($pdo, $prefix, (int)$seg[1], (int)$seg[3], ['price' => $b['price']]);
        }
    }

    if ($n === 1 && $seg[0] === 'bulk' && $method === 'POST') {
        requireAuth($config);
        $b = jsonBody();
        return bulkUpdate($pdo, $prefix, $b['updates'] ?? []);
    }

    if ($n === 1 && $seg[0] === 'history' && $method === 'GET') {
        requireAuth($config);
        return ['backups' => []];
    }

    if ($seg[0] === 'settings') {
        if ($n === 2 && $seg[1] === 'price-coefficient' && $method === 'PATCH') {
            requireAuth($config);
            return applyCoefficient($pdo, $prefix, jsonBody());
        }
        if ($n === 2 && $seg[1] === 'markups' && $method === 'PATCH') {
            requireAuth($config);
            return applyMarkups($pdo, $prefix, jsonBody());
        }
    }

    throw new ApiException('NOT_FOUND', 'Route not found: ' . $method . ' /' . implode('/', $seg), 404);
}

// ============================ READ =========================================

function listPricelists(PDO $pdo, string $prefix): array
{
    $sql = "SELECT c.id, c.pagetitle AS name, c.longtitle AS title, c.parent
            FROM {$prefix}site_content c
            WHERE c.class_key = 'msCategory' AND c.deleted = 0
              AND EXISTS (SELECT 1 FROM {$prefix}site_content p
                          WHERE p.parent = c.id AND p.class_key = 'msProduct' AND p.deleted = 0)
            ORDER BY c.menuindex, c.id";
    $rows = $pdo->query($sql)->fetchAll();
    return array_map(static fn($r) => [
        'id' => (int)$r['id'],
        'name' => (string)$r['name'],
        'title' => (string)($r['title'] ?? ''),
        'parent' => (int)$r['parent'],
    ], $rows);
}

function loadCategory(PDO $pdo, string $prefix, int $id): array
{
    $st = $pdo->prepare("SELECT id, pagetitle, longtitle, parent, class_key FROM {$prefix}site_content WHERE id = :id LIMIT 1");
    $st->execute([':id' => $id]);
    $c = $st->fetch();
    if (!$c || $c['class_key'] !== 'msCategory') {
        throw new ApiException('NOT_FOUND', 'Pricelist (category) not found', 404);
    }
    return $c;
}

/** SELECT-выражение «базовой» цены для дашборда: override -> base -> текущая. */
function baseExpr(string $prefix): string
{
    return "COALESCE(pr.price_override, pr.base_price, ms.price)";
}

function getPricelist(PDO $pdo, string $prefix, int $id): array
{
    $c = loadCategory($pdo, $prefix, $id);
    $st = $pdo->prepare("SELECT sc.pagetitle, " . baseExpr($prefix) . " AS price
        FROM {$prefix}site_content sc
        JOIN {$prefix}ms2_products ms ON ms.id = sc.id
        LEFT JOIN {$prefix}mltagent_pricing pr ON pr.product_id = sc.id
        WHERE sc.parent = :id AND sc.class_key = 'msProduct' AND sc.deleted = 0
        ORDER BY sc.menuindex, sc.id");
    $st->execute([':id' => $id]);
    $products = [];
    $i = 0;
    foreach ($st->fetchAll() as $r) {
        $products[] = ['_index' => $i++, 'name' => (string)$r['pagetitle'], 'price' => fmtPrice($r['price'])];
    }
    return [
        'id' => (int)$c['id'],
        'name' => (string)$c['pagetitle'],
        'title' => (string)($c['longtitle'] ?? ''),
        'parent' => (int)$c['parent'],
        'headers' => ['Наименование', 'Цена'],
        'colTemplates' => ['((name))', '((price))'],
        'price_key' => null,
        'products' => $products,
    ];
}

function resolveProductRow(PDO $pdo, string $prefix, int $catId, int $index): array
{
    if ($index < 0) {
        throw new ApiException('NOT_FOUND', 'Product index out of range', 404);
    }
    $sql = "SELECT sc.id, sc.pagetitle, " . baseExpr($prefix) . " AS price
            FROM {$prefix}site_content sc
            JOIN {$prefix}ms2_products ms ON ms.id = sc.id
            LEFT JOIN {$prefix}mltagent_pricing pr ON pr.product_id = sc.id
            WHERE sc.parent = :id AND sc.class_key = 'msProduct' AND sc.deleted = 0
            ORDER BY sc.menuindex, sc.id LIMIT 1 OFFSET " . ((int)$index);
    $st = $pdo->prepare($sql);
    $st->execute([':id' => $catId]);
    $r = $st->fetch();
    if (!$r) {
        throw new ApiException('NOT_FOUND', 'Product index out of range', 404);
    }
    return $r;
}

function findProduct(PDO $pdo, string $prefix, int $id, int $index): array
{
    loadCategory($pdo, $prefix, $id);
    $p = resolveProductRow($pdo, $prefix, $id, $index);
    return [
        'pricelist_id' => $id,
        'index' => $index,
        'product' => ['_index' => $index, 'name' => (string)$p['pagetitle'], 'price' => fmtPrice($p['price'])],
        'price_key' => null,
    ];
}

// ============================ WRITE ========================================

function updatePricelist(PDO $pdo, string $prefix, int $id, array $body): array
{
    loadCategory($pdo, $prefix, $id);
    $fields = [];
    $params = [':id' => $id];
    if (array_key_exists('name', $body)) {
        $name = trim((string)$body['name']);
        if ($name === '') {
            throw new ApiException('BAD_REQUEST', 'name must not be empty', 400);
        }
        $fields[] = 'pagetitle = :name';
        $params[':name'] = $name;
    }
    if (array_key_exists('title', $body)) {
        $fields[] = 'longtitle = :title';
        $params[':title'] = (string)$body['title'];
    }
    if ($fields) {
        $pdo->prepare("UPDATE {$prefix}site_content SET " . implode(', ', $fields) . " WHERE id = :id")->execute($params);
        clearResourceCache($id);
        clearElementCaches();
    }
    $c = loadCategory($pdo, $prefix, $id);
    return ['updated' => ['id' => $id, 'name' => (string)$c['pagetitle'], 'title' => (string)($c['longtitle'] ?? '')]];
}

function updateProduct(PDO $pdo, string $prefix, int $id, int $index, array $body): array
{
    loadCategory($pdo, $prefix, $id);
    $res = doUpdateProduct($pdo, $prefix, $id, $index, $body);
    clearElementCaches();
    return $res;
}

function doUpdateProduct(PDO $pdo, string $prefix, int $id, int $index, array $body): array
{
    $p = resolveProductRow($pdo, $prefix, $id, $index);

    if (isset($body['expected_name'])) {
        $exp = trim((string)$body['expected_name']);
        if ($exp !== '' && $exp !== trim((string)$p['pagetitle'])) {
            throw new ApiException('CONFLICT', 'expected_name does not match current — index drifted', 409);
        }
    }

    $pid = (int)$p['id'];

    if (array_key_exists('price', $body)) {
        $price = str_replace(',', '.', (string)$body['price']);
        if (!is_numeric($price) || (float)$price < 0) {
            throw new ApiException('BAD_REQUEST', 'price must be a number >= 0', 400);
        }
        // Прямая правка цены = установка абсолютного override (как поле «цена» в дашборде),
        // на который дальше накладываются наценка/коэффициент.
        setProductOverride($pdo, $prefix, $pid, number_format((float)$price, 2, '.', ''));
        recompute($pdo, $prefix, 'ms.id = :pid', [':pid' => $pid]);
        clearResourceCache($pid);
        clearResourceCache($id);
    }

    if (array_key_exists('name', $body)) {
        $name = trim((string)$body['name']);
        if ($name === '') {
            throw new ApiException('BAD_REQUEST', 'name must not be empty', 400);
        }
        $pdo->prepare("UPDATE {$prefix}site_content SET pagetitle = :n WHERE id = :id")->execute([':n' => $name, ':id' => $pid]);
        clearResourceCache($pid);
    }

    $p2 = resolveProductRow($pdo, $prefix, $id, $index);
    return ['updated' => ['_index' => $index, 'name' => (string)$p2['pagetitle'], 'price' => fmtPrice($p2['price'])], 'index' => $index];
}

function bulkUpdate(PDO $pdo, string $prefix, $updates): array
{
    if (!is_array($updates)) {
        throw new ApiException('BAD_REQUEST', 'updates must be an array', 400);
    }
    $pdo->beginTransaction();
    try {
        $out = [];
        foreach ($updates as $u) {
            if (!is_array($u)) {
                throw new ApiException('BAD_REQUEST', 'each update must be an object', 400);
            }
            $pid = (int)($u['pricelist_id'] ?? 0);
            $idx = isset($u['index']) ? (int)$u['index'] : -1;
            $payload = [];
            foreach (['price', 'name', 'expected_name'] as $k) {
                if (array_key_exists($k, $u)) {
                    $payload[$k] = $u[$k];
                }
            }
            loadCategory($pdo, $prefix, $pid);
            $res = doUpdateProduct($pdo, $prefix, $pid, $idx, $payload);
            $out[] = ['pricelist_id' => $pid, 'index' => $idx, 'product' => $res['updated']];
        }
        $pdo->commit();
        clearElementCaches();
        return ['updated' => $out];
    } catch (Throwable $e) {
        $pdo->rollBack();
        throw $e;
    }
}

// ======================= PRICING ENGINE ====================================

function ensurePricingSchema(PDO $pdo, string $prefix): void
{
    $pdo->exec("CREATE TABLE IF NOT EXISTS {$prefix}mltagent_pricing (
        product_id INT UNSIGNED NOT NULL,
        base_price DECIMAL(12,2) NOT NULL DEFAULT 0,
        price_override DECIMAL(12,2) NULL,
        markup_percent DECIMAL(8,2) NOT NULL DEFAULT 0,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (product_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");
    $pdo->exec("CREATE TABLE IF NOT EXISTS {$prefix}mltagent_meta (
        mkey VARCHAR(64) NOT NULL,
        mval VARCHAR(255) NOT NULL DEFAULT '',
        PRIMARY KEY (mkey)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");
}

function metaGet(PDO $pdo, string $prefix, string $key, string $default = ''): string
{
    $st = $pdo->prepare("SELECT mval FROM {$prefix}mltagent_meta WHERE mkey = :k LIMIT 1");
    $st->execute([':k' => $key]);
    $v = $st->fetchColumn();
    return ($v === false || $v === null) ? $default : (string)$v;
}

function metaSet(PDO $pdo, string $prefix, string $key, string $val): void
{
    $pdo->prepare("INSERT INTO {$prefix}mltagent_meta (mkey, mval) VALUES (:k, :v)
                   ON DUPLICATE KEY UPDATE mval = :v2")
        ->execute([':k' => $key, ':v' => $val, ':v2' => $val]);
}

/** Запоминаем исходную (чистую) цену товара один раз. */
function ensureBaseProduct(PDO $pdo, string $prefix, int $pid): void
{
    $pdo->prepare("INSERT INTO {$prefix}mltagent_pricing (product_id, base_price)
                   SELECT id, price FROM {$prefix}ms2_products WHERE id = :pid
                   ON DUPLICATE KEY UPDATE product_id = product_id")
        ->execute([':pid' => $pid]);
}

function ensureBaseCategory(PDO $pdo, string $prefix, int $catId): void
{
    $pdo->prepare("INSERT INTO {$prefix}mltagent_pricing (product_id, base_price)
                   SELECT p.id, p.price
                   FROM {$prefix}ms2_products p
                   JOIN {$prefix}site_content sc ON sc.id = p.id
                   WHERE sc.parent = :cat AND sc.class_key = 'msProduct' AND sc.deleted = 0
                   ON DUPLICATE KEY UPDATE product_id = {$prefix}mltagent_pricing.product_id")
        ->execute([':cat' => $catId]);
}

function ensureBaseAll(PDO $pdo, string $prefix): void
{
    $pdo->exec("INSERT INTO {$prefix}mltagent_pricing (product_id, base_price)
                SELECT p.id, p.price
                FROM {$prefix}ms2_products p
                JOIN {$prefix}site_content sc ON sc.id = p.id
                WHERE sc.class_key = 'msProduct' AND sc.deleted = 0
                ON DUPLICATE KEY UPDATE product_id = {$prefix}mltagent_pricing.product_id");
}

function setProductOverride(PDO $pdo, string $prefix, int $pid, ?string $absPrice): void
{
    ensureBaseProduct($pdo, $prefix, $pid);
    $pdo->prepare("UPDATE {$prefix}mltagent_pricing SET price_override = :v WHERE product_id = :pid")
        ->execute([':v' => $absPrice, ':pid' => $pid]);
}

function setProductMarkup(PDO $pdo, string $prefix, int $pid, string $pct): void
{
    ensureBaseProduct($pdo, $prefix, $pid);
    $pdo->prepare("UPDATE {$prefix}mltagent_pricing SET markup_percent = :v WHERE product_id = :pid")
        ->execute([':v' => $pct, ':pid' => $pid]);
}

/**
 * Пересчитать ms2_products.price из движка для строк, попадающих под $where.
 * Учитывает: base (override -> base_price), коэффициент сайта, наценку товара
 * с фолбэком на наценку прайс-листа.
 */
function recompute(PDO $pdo, string $prefix, string $where = '1=1', array $params = []): void
{
    $sql = "UPDATE {$prefix}ms2_products ms
            JOIN {$prefix}mltagent_pricing pr ON pr.product_id = ms.id
            JOIN {$prefix}site_content sc ON sc.id = ms.id
            LEFT JOIN {$prefix}mltagent_meta cm ON cm.mkey = 'coefficient'
            LEFT JOIN {$prefix}mltagent_meta pm ON pm.mkey = CONCAT('plmarkup:', sc.parent)
            SET ms.price = ROUND(
                COALESCE(pr.price_override, pr.base_price)
                * CAST(COALESCE(NULLIF(cm.mval, ''), '1') AS DECIMAL(12,4))
                * (1 + (CASE WHEN pr.markup_percent != 0 THEN pr.markup_percent
                             ELSE CAST(COALESCE(NULLIF(pm.mval, ''), '0') AS DECIMAL(10,2)) END) / 100)
            , 2)
            WHERE {$where}";
    $pdo->prepare($sql)->execute($params);
}

function inPlaceholders(array $ids): string
{
    $ids = array_values(array_unique(array_map('intval', $ids)));
    if (!$ids) {
        return '(NULL)';
    }
    return '(' . implode(',', $ids) . ')';
}

/**
 * PATCH /settings/markups — приходят полные наборы из админки:
 *   product_markups          {plId:{idx:pct}}   — наценка товара (%)
 *   pricelist_markups        {plId:pct}         — наценка прайс-листа (%)
 *   product_price_overrides  {plId:{idx:price}} — абсолютная цена (база товара)
 */
function applyMarkups(PDO $pdo, string $prefix, array $body): array
{
    $stats = ['product_markups' => 0, 'pricelist_markups' => 0, 'product_overrides' => 0];
    $touched = false;

    // --- абсолютные оверрайды цены товара (поле «цена») ---
    if (array_key_exists('product_price_overrides', $body)) {
        $map = decodeJsonObject($body['product_price_overrides'], 'product_price_overrides');
        $prevIds = fetchIds($pdo, "SELECT product_id FROM {$prefix}mltagent_pricing WHERE price_override IS NOT NULL");
        $newIds = [];
        foreach ($map as $plId => $byIndex) {
            if (!is_array($byIndex)) continue;
            foreach ($byIndex as $idx => $price) {
                $priceStr = str_replace(',', '.', (string)$price);
                if (!is_numeric($priceStr) || (float)$priceStr < 0) continue;
                try { $row = resolveProductRow($pdo, $prefix, (int)$plId, (int)$idx); }
                catch (ApiException $e) { continue; }
                $pid = (int)$row['id'];
                setProductOverride($pdo, $prefix, $pid, number_format((float)$priceStr, 2, '.', ''));
                $newIds[] = $pid;
                $stats['product_overrides']++;
            }
        }
        $toClear = array_diff($prevIds, $newIds);
        if ($toClear) {
            $pdo->exec("UPDATE {$prefix}mltagent_pricing SET price_override = NULL WHERE product_id IN " . inPlaceholders($toClear));
        }
        $affected = array_merge($newIds, $toClear);
        if ($affected) {
            recompute($pdo, $prefix, "ms.id IN " . inPlaceholders($affected));
            $touched = true;
        }
    }

    // --- наценка товара (%) ---
    if (array_key_exists('product_markups', $body)) {
        $map = decodeJsonObject($body['product_markups'], 'product_markups');
        $prevIds = fetchIds($pdo, "SELECT product_id FROM {$prefix}mltagent_pricing WHERE markup_percent != 0");
        $newIds = [];
        foreach ($map as $plId => $byIndex) {
            if (!is_array($byIndex)) continue;
            foreach ($byIndex as $idx => $pct) {
                $pctStr = str_replace(',', '.', (string)$pct);
                if (!is_numeric($pctStr) || (float)$pctStr < -99.99 || (float)$pctStr > 9999.99) continue;
                try { $row = resolveProductRow($pdo, $prefix, (int)$plId, (int)$idx); }
                catch (ApiException $e) { continue; }
                $pid = (int)$row['id'];
                setProductMarkup($pdo, $prefix, $pid, number_format((float)$pctStr, 2, '.', ''));
                $newIds[] = $pid;
                $stats['product_markups']++;
            }
        }
        $toClear = array_diff($prevIds, $newIds);
        if ($toClear) {
            $pdo->exec("UPDATE {$prefix}mltagent_pricing SET markup_percent = 0 WHERE product_id IN " . inPlaceholders($toClear));
        }
        $affected = array_merge($newIds, $toClear);
        if ($affected) {
            recompute($pdo, $prefix, "ms.id IN " . inPlaceholders($affected));
            $touched = true;
        }
    }

    // --- наценка прайс-листа (%) ---
    if (array_key_exists('pricelist_markups', $body)) {
        $map = decodeJsonObject($body['pricelist_markups'], 'pricelist_markups');
        $prevPl = array_map(static fn($k) => (int)substr($k, strlen('plmarkup:')),
            fetchIds($pdo, "SELECT mkey FROM {$prefix}mltagent_meta WHERE mkey LIKE 'plmarkup:%'", 'mkey'));
        $pdo->exec("DELETE FROM {$prefix}mltagent_meta WHERE mkey LIKE 'plmarkup:%'");
        $newPl = [];
        foreach ($map as $plId => $pct) {
            $pctStr = str_replace(',', '.', (string)$pct);
            if (!is_numeric($pctStr) || (float)$pctStr < -99.99 || (float)$pctStr > 9999.99) continue;
            metaSet($pdo, $prefix, 'plmarkup:' . (int)$plId, number_format((float)$pctStr, 2, '.', ''));
            ensureBaseCategory($pdo, $prefix, (int)$plId);
            $newPl[] = (int)$plId;
            $stats['pricelist_markups']++;
        }
        $affectedPl = array_values(array_unique(array_merge($prevPl, $newPl)));
        if ($affectedPl) {
            recompute($pdo, $prefix, "sc.parent IN " . inPlaceholders($affectedPl));
            $touched = true;
        }
    }

    if ($touched) {
        clearElementCaches();
    }
    return ['applied' => true] + $stats;
}

/** PATCH /settings/price-coefficient — коэффициент сайта применяется ко всем товарам. */
function applyCoefficient(PDO $pdo, string $prefix, array $body): array
{
    if (!isset($body['coefficient'])) {
        throw new ApiException('BAD_REQUEST', "'coefficient' is required", 400);
    }
    $coef = (float)str_replace(',', '.', (string)$body['coefficient']);
    if (!is_finite($coef) || $coef < 0.1 || $coef > 100) {
        throw new ApiException('BAD_REQUEST', 'coefficient must be a number from 0.1 to 100', 400);
    }
    $value = rtrim(rtrim(number_format($coef, 4, '.', ''), '0'), '.');
    if ($value === '') {
        $value = '1';
    }
    metaSet($pdo, $prefix, 'coefficient', $value);
    // Коэффициент действует на весь сайт — фиксируем базу всех товаров и пересчитываем.
    ensureBaseAll($pdo, $prefix);
    recompute($pdo, $prefix, '1=1');
    clearElementCaches();
    return ['applied' => true, 'coefficient' => $value];
}

function decodeJsonObject($raw, string $name): array
{
    if (!is_string($raw) || $raw === '' || $raw === '{}') {
        return [];
    }
    $d = json_decode($raw, true);
    if (!is_array($d)) {
        throw new ApiException('BAD_REQUEST', "$name must be valid JSON object", 400);
    }
    return $d;
}

function fetchIds(PDO $pdo, string $sql, string $col = 'product_id'): array
{
    $out = [];
    foreach ($pdo->query($sql)->fetchAll() as $r) {
        $out[] = $r[$col];
    }
    return $out;
}

// ============================ CACHE ========================================

function clearResourceCache(int $id): void
{
    $base = __DIR__ . '/../../core/cache/resource';
    foreach (glob($base . '/*/resources/' . $id . '.cache.php') ?: [] as $f) {
        @unlink($f);
    }
}

/** Сбрасываем кэш отрендеренных элементов (pdoTools/MiniShop2/кэшируемые сниппеты). */
function clearElementCaches(): void
{
    $root = __DIR__ . '/../../core/cache';
    // resource — закэшированный HTML страниц (листинги/карточки); pdotools/default/minishop2 — кэш элементов.
    foreach (['resource', 'pdotools', 'default', 'minishop2'] as $dir) {
        rrmdirContents($root . '/' . $dir);
    }
}

function rrmdirContents(string $dir): void
{
    if (!is_dir($dir)) {
        return;
    }
    $items = scandir($dir);
    if ($items === false) {
        return;
    }
    foreach ($items as $item) {
        if ($item === '.' || $item === '..') {
            continue;
        }
        $path = $dir . '/' . $item;
        if (is_dir($path) && !is_link($path)) {
            rrmdirContents($path);
            @rmdir($path);
        } else {
            @unlink($path);
        }
    }
}
