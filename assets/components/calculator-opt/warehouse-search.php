<?php
/**
 * Warehouse search endpoint.
 * Kept ASCII-only to avoid encoding issues across environments.
 */

$configCorePath = dirname(dirname(dirname(__DIR__))) . '/config.core.php';
if (!is_file($configCorePath)) {
    $configCorePath = dirname(__DIR__) . '/config.core.php';
}
require_once $configCorePath;
require_once MODX_CORE_PATH . 'model/modx/modx.class.php';

$modx = new modX();
$modx->initialize('web');

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

$debugMode = true;
$sendServerError = static function (string $message, array $debug = []): void {
    if (!headers_sent()) {
        http_response_code(500);
        header('Content-Type: application/json; charset=utf-8');
    }

    $response = [
        'success' => false,
        'error' => $message,
    ];

    if (!empty($debug)) {
        $response['debug'] = $debug;
    }

    echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit();
};

register_shutdown_function(static function () use (&$modx, $sendServerError, $debugMode): void {
    $error = error_get_last();
    if (!$error) {
        return;
    }

    $fatalTypes = [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR, E_USER_ERROR];
    if (!in_array($error['type'], $fatalTypes, true)) {
        return;
    }

    if ($modx instanceof modX) {
        $modx->log(modX::LOG_LEVEL_ERROR, '[warehouse-search] fatal: ' . ($error['message'] ?? 'unknown'));
    }

    $sendServerError('Fatal server error', $debugMode ? [
        'type' => $error['type'] ?? null,
        'message' => $error['message'] ?? '',
        'file' => $error['file'] ?? '',
        'line' => $error['line'] ?? 0,
    ] : []);
});

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST' && $_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode([
        'success' => false,
        'error' => 'Only POST and GET are allowed',
    ]);
    exit();
}

$stocksModuleCandidates = [
    MODX_CORE_PATH . 'elements/_modules/stocks/php/',
    MODX_CORE_PATH . 'elements/modules/stocks/php/',
];

$stocksConstantsLoaded = false;
foreach ($stocksModuleCandidates as $candidatePath) {
    $constantsFile = $candidatePath . 'stock-constant.php';
    if (is_file($constantsFile)) {
        require_once $constantsFile;
        $stocksConstantsLoaded = true;

        $classFile = $candidatePath . 'stock.class.php';
        if (is_file($classFile)) {
            require_once $classFile;
        }
        break;
    }
}

if (!$stocksConstantsLoaded) {
    if (!defined('MIN_STOCKS')) define('MIN_STOCKS', 50);
    if (!defined('MAX_STOCKS')) define('MAX_STOCKS', 100);
    if (!defined('MIN_LIMIT_STOCKS')) define('MIN_LIMIT_STOCKS', 1);
    if (!defined('MAX_LIMIT_STOCKS')) define('MAX_LIMIT_STOCKS', 5);
}

$queryPhrase = $_POST['query'] ?? $_GET['query'] ?? '';
$context = $_POST['context'] ?? $_GET['context'] ?? 'web';
$stockName = $_POST['stockName'] ?? $_GET['stockName'] ?? '';
$limit = (int)($_POST['limit'] ?? $_GET['limit'] ?? 10);

$queryPhrase = trim((string)$queryPhrase);
$stockName = trim((string)$stockName);
$context = preg_replace('/[^a-z0-9_-]/i', '', (string)$context) ?: 'web';
$limit = max(1, min(50, $limit));

if ($queryPhrase === '') {
    echo json_encode([
        'success' => false,
        'error' => 'Query is required',
    ]);
    exit();
}

if ($stockName === '') {
    echo json_encode([
        'success' => false,
        'error' => 'stockName is required',
    ]);
    exit();
}

if ($context === '') {
    echo json_encode([
        'success' => false,
        'error' => 'Context is required',
    ]);
    exit();
}

try {
    if ($modx->context->key !== $context) {
        $targetContext = $modx->getObject('modContext', $context);
        if ($targetContext) {
            $modx->switchContext($context);
        }
    }

    $whereTitleParts = [];
    $bind = [];

    $words = preg_split('/\s+/u', $queryPhrase, -1, PREG_SPLIT_NO_EMPTY);
    foreach ($words as $index => $word) {
        if (strpos($word, ',') !== false || strpos($word, '.') !== false) {
            $wordPrepared = preg_replace('/[, .]/', '[,\\.]', $word);
            $whereTitleParts[] = "`msProduct`.`pagetitle` REGEXP :queryWord{$index}";
            $bind["queryWord{$index}"] = $wordPrepared;
        } else {
            $whereTitleParts[] = "`msProduct`.`pagetitle` LIKE :queryWord{$index}";
            $bind["queryWord{$index}"] = '%' . $word . '%';
        }
    }

    if (empty($whereTitleParts)) {
        $whereTitleParts[] = "`msProduct`.`pagetitle` LIKE :queryWord0";
        $bind['queryWord0'] = '%' . $queryPhrase . '%';
    }

    $bind['queryPhrase'] = '%' . $queryPhrase . '%';
    $bind['context'] = $context;
    $bind['limit'] = $limit;

    $whereTitle = '(' . implode(' AND ', $whereTitleParts) . ')';
    $whereArticle = '(`Data`.`article` LIKE :queryPhrase)';
    $where = $whereTitle . ' OR ' . $whereArticle;

    $query = "SELECT `msProduct`.`id`
        FROM `modx_site_content` AS `msProduct`
        LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` = `Data`.`id`
        LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `msProduct`.`id` AND `TVhitspage`.`tmplvarid` = 7
        LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `msProduct`.`id` AND `TVpriority1`.`tmplvarid` = 17
        WHERE `msProduct`.`class_key` = 'msProduct'
            AND `msProduct`.`published` = 1
            AND `msProduct`.`deleted` = 0
            AND `msProduct`.`context_key` = :context
            AND ({$where})
        GROUP BY `msProduct`.`id`
        ORDER BY CAST(`TVpriority1`.`value` AS DECIMAL(13,3)) ASC, CAST(`TVhitspage`.`value` AS DECIMAL(13,3)) ASC
        LIMIT :limit";

    $stmt = $modx->prepare($query);
    if (!$stmt) {
        $sendServerError('SQL prepare error', $debugMode ? [
            'query' => $query,
            'context' => $context,
        ] : []);
    }

    foreach ($bind as $key => $value) {
        if ($key === 'limit') {
            $stmt->bindValue(':' . $key, (int)$value, PDO::PARAM_INT);
        } else {
            $stmt->bindValue(':' . $key, $value, PDO::PARAM_STR);
        }
    }

    $queryResult = $stmt->execute();
    if ($queryResult === false) {
        $sendServerError('SQL execution error', $debugMode ? [
            'errorInfo' => $stmt->errorInfo(),
            'context' => $context,
        ] : []);
    }

    $data = $stmt->fetchAll(PDO::FETCH_COLUMN);
    if (empty($data)) {
        echo json_encode([
            'success' => true,
            'products' => [],
            'message' => 'No products found',
        ]);
        exit();
    }

    if (!function_exists('normalizeStockName')) {
        function normalizeStockName($stockName): string
        {
            $normalized = trim((string)$stockName);
            if ($normalized === '') {
                return '';
            }

            $normalized = function_exists('mb_strtolower')
                ? mb_strtolower($normalized, 'UTF-8')
                : strtolower($normalized);

            $normalized = preg_replace('/[^\p{L}\p{N}-]+/u', '', $normalized);
            return is_string($normalized) ? $normalized : '';
        }
    }

    if (!function_exists('normalizeStockTitleForCompare')) {
        function normalizeStockTitleForCompare($title): string
        {
            $title = trim((string)$title);
            if ($title === '') {
                return '';
            }

            $title = function_exists('mb_strtolower')
                ? mb_strtolower($title, 'UTF-8')
                : strtolower($title);
            $title = preg_replace('/\s+/u', ' ', $title);

            return trim((string)$title);
        }
    }

    if (!function_exists('stripFirstWord')) {
        function stripFirstWord($title): string
        {
            $title = trim((string)$title);
            if ($title === '') {
                return '';
            }

            $withoutFirstWord = preg_replace('/^\S+\s+/u', '', $title);
            return trim((string)$withoutFirstWord);
        }
    }

    if (!function_exists('guessWarehouseAliasByName')) {
        function guessWarehouseAliasByName(string $name): string
        {
            $name = trim($name);
            if ($name === '') {
                return '';
            }

            $ascii = $name;
            if (function_exists('transliterator_transliterate')) {
                $tmp = transliterator_transliterate('Any-Latin; Latin-ASCII; Lower()', $name);
                if (is_string($tmp) && $tmp !== '') {
                    $ascii = $tmp;
                }
            } elseif (function_exists('iconv')) {
                $tmp = @iconv('UTF-8', 'ASCII//TRANSLIT//IGNORE', $name);
                if (is_string($tmp) && $tmp !== '') {
                    $ascii = strtolower($tmp);
                }
            }

            $slug = strtolower($ascii);
            $slug = preg_replace('/[^a-z0-9]+/', '-', $slug);
            $slug = trim((string)$slug, '-');

            $map = [
                'dachnoe' => 'dachnoe',
                'yanino-1' => 'yanino-1',
                'yanino1' => 'yanino-1',
                'shushary' => 'shushary',
                'pargolovo' => 'pargolovo',
                'metallostroy' => 'metallostroy',
            ];

            return $map[$slug] ?? '';
        }
    }

    if (!function_exists('extractWarehouseAlias')) {
        function extractWarehouseAlias($uri): string
        {
            $path = parse_url((string)$uri, PHP_URL_PATH);
            $path = trim((string)$path, '/');
            if ($path === '') {
                return '';
            }

            $parts = explode('/', $path);
            $alias = end($parts);
            return strtolower((string)$alias);
        }
    }

    if (!function_exists('isRequestRemainsValue')) {
        function isRequestRemainsValue($value): bool
        {
            if (is_int($value) || is_float($value)) {
                return false;
            }

            if (is_string($value)) {
                $v = trim($value);
                if ($v === '') {
                    return false;
                }

                $numericCandidate = str_replace(',', '.', $v);
                return !is_numeric($numericCandidate);
            }

            return false;
        }
    }

    if (!function_exists('generateLegacyRandomNumber')) {
        function generateLegacyRandomNumber($id, $start, $end, $unique = 1): int
        {
            $start = (int)$start;
            $end = (int)$end;
            $start = $start ?: 100;
            $end = $end ?: 1000;

            $currentDate = date('Ymd');
            $seed = hexdec(substr(md5($currentDate . $id . $unique), 0, 8));
            mt_srand($seed);

            return mt_rand($start, $end);
        }
    }

    if (!function_exists('isProductInAncestor')) {
        function isProductInAncestor(modX $modx, int $productId, int $ancestorId): bool
        {
            if ($productId <= 0 || $ancestorId <= 0) {
                return false;
            }

            $servicePath = MODX_CORE_PATH . 'elements/services/UltimateParentService.inc.php';
            if (is_file($servicePath)) {
                include_once $servicePath;
                if (class_exists('UltimateParentService')) {
                    $svc = new UltimateParentService($modx);
                    $ultimateParent = $svc->getUltimateParent($productId, $ancestorId);
                    if ($ultimateParent == $ancestorId || $ultimateParent == $productId) {
                        return true;
                    }
                }
            }

            $prefix = $modx->getOption('table_prefix');
            $sql = "SELECT 1
                FROM {$prefix}site_content AS child
                INNER JOIN {$prefix}site_content AS anc
                    ON child.lft BETWEEN anc.lft AND anc.rgt
                WHERE child.id = :productId
                    AND anc.id = :ancestorId
                LIMIT 1";

            $stmt = $modx->prepare($sql);
            if (!$stmt) {
                return false;
            }

            $stmt->bindValue(':productId', $productId, PDO::PARAM_INT);
            $stmt->bindValue(':ancestorId', $ancestorId, PDO::PARAM_INT);
            if (!$stmt->execute()) {
                return false;
            }

            return (bool)$stmt->fetchColumn();
        }
    }

    if (!function_exists('getWarehouseRemainsDataInline')) {
        function getWarehouseRemainsDataInline(modX $modx, int $productId): array
        {
            $warehouseTemplateId = 39;
            $rangeRemainsTvId = 47;
            $defaultRange = '50-300';
            $onRequestAncestorId = 93445;

            $prefix = $modx->getOption('table_prefix');
            $contextKey = (string)$modx->context->key;

            static $warehousesCache = [];
            $warehousesCacheKey = $contextKey . ':' . $warehouseTemplateId . ':' . $rangeRemainsTvId;

            if (!array_key_exists($warehousesCacheKey, $warehousesCache)) {
                $warehousesSql = "SELECT
                        c.id,
                        c.menutitle,
                        c.pagetitle,
                        c.uri,
                        tv.value AS range_remains
                    FROM {$prefix}site_content AS c
                    LEFT JOIN {$prefix}site_tmplvar_contentvalues AS tv
                        ON tv.contentid = c.id AND tv.tmplvarid = :tvId
                    WHERE c.template = :templateId
                        AND c.context_key = :contextKey
                        AND c.published = 1
                        AND c.deleted = 0";

                $stmt = $modx->prepare($warehousesSql);
                if ($stmt) {
                    $stmt->bindValue(':tvId', $rangeRemainsTvId, PDO::PARAM_INT);
                    $stmt->bindValue(':templateId', $warehouseTemplateId, PDO::PARAM_INT);
                    $stmt->bindValue(':contextKey', $contextKey, PDO::PARAM_STR);
                    $stmt->execute();
                    $warehousesCache[$warehousesCacheKey] = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
                } else {
                    $warehousesCache[$warehousesCacheKey] = [];
                }
            }

            $warehouses = $warehousesCache[$warehousesCacheKey];
            if (empty($warehouses)) {
                return ['warehouses' => [], 'total_remains' => 0];
            }

            $productRange = null;
            $productRangeSql = "SELECT tv.value
                FROM {$prefix}site_tmplvar_contentvalues AS tv
                INNER JOIN {$prefix}site_content AS c ON c.id = tv.contentid
                WHERE c.id = :productId
                    AND c.class_key = 'msProduct'
                    AND tv.tmplvarid = :tvId
                LIMIT 1";
            $stmt = $modx->prepare($productRangeSql);
            if ($stmt) {
                $stmt->bindValue(':productId', $productId, PDO::PARAM_INT);
                $stmt->bindValue(':tvId', $rangeRemainsTvId, PDO::PARAM_INT);
                if ($stmt->execute()) {
                    $value = $stmt->fetchColumn();
                    if ($value !== false && $value !== null && trim((string)$value) !== '') {
                        $productRange = (string)$value;
                    }
                }
            }

            if (isProductInAncestor($modx, $productId, $onRequestAncestorId)) {
                foreach ($warehouses as &$warehouse) {
                    $warehouse['remains'] = 'request';
                }
                unset($warehouse);

                return [
                    'warehouses' => $warehouses,
                    'total_remains' => 'request',
                ];
            }

            $totalRemains = 0;
            foreach ($warehouses as &$warehouse) {
                $rangeRemains = $warehouse['range_remains'] ?: $defaultRange;
                if ($productRange) {
                    $rangeRemains = $productRange;
                }

                $rangeParts = explode('-', (string)$rangeRemains);
                $begin = (int)($rangeParts[0] ?? 0);
                $end = (int)($rangeParts[1] ?? 0);
                $randomId = (string)$productId . (string)($warehouse['id'] ?? '');

                $remains = generateLegacyRandomNumber($randomId, $begin, $end, 1);
                $warehouse['remains'] = $remains;
                $totalRemains += $remains;
            }
            unset($warehouse);

            return [
                'warehouses' => $warehouses,
                'total_remains' => $totalRemains,
            ];
        }
    }

    if (!function_exists('getStockStatus')) {
        function getStockStatus($count): string
        {
            if ($count >= MIN_STOCKS && $count <= MAX_STOCKS) {
                return 'normal';
            }
            if ($count >= MIN_LIMIT_STOCKS && $count <= MAX_LIMIT_STOCKS) {
                return 'limited';
            }
            if ($count === 0) {
                return 'request';
            }
            return 'normal';
        }
    }

    $finalResults = [];
    $searchNormalized = normalizeStockName($stockName);
    $searchTitleNormalized = normalizeStockTitleForCompare($stockName);
    $searchTitleNoFirst = stripFirstWord($searchTitleNormalized);
    $searchAlias = guessWarehouseAliasByName($stockName);

    foreach ($data as $productId) {
        $finalCount = 0;
        $isRequest = false;

        $remainsData = getWarehouseRemainsDataInline($modx, (int)$productId);

        foreach (($remainsData['warehouses'] ?? []) as $warehouse) {
            $warehouseName1 = normalizeStockName($warehouse['menutitle'] ?? '');
            $warehouseName2 = normalizeStockName($warehouse['pagetitle'] ?? '');
            $warehouseAlias = extractWarehouseAlias($warehouse['uri'] ?? '');

            $warehouseTitle1 = normalizeStockTitleForCompare($warehouse['menutitle'] ?? '');
            $warehouseTitle2 = normalizeStockTitleForCompare($warehouse['pagetitle'] ?? '');
            $warehouseTitle1NoFirst = stripFirstWord($warehouseTitle1);
            $warehouseTitle2NoFirst = stripFirstWord($warehouseTitle2);

            $isMatchedByName = $searchNormalized !== '' && (
                $warehouseName1 === $searchNormalized ||
                $warehouseName2 === $searchNormalized
            );
            if (!$isMatchedByName && $searchTitleNormalized !== '') {
                $isMatchedByName =
                    $warehouseTitle1 === $searchTitleNormalized ||
                    $warehouseTitle2 === $searchTitleNormalized ||
                    $warehouseTitle1NoFirst === $searchTitleNormalized ||
                    $warehouseTitle2NoFirst === $searchTitleNormalized ||
                    $warehouseTitle1 === $searchTitleNoFirst ||
                    $warehouseTitle2 === $searchTitleNoFirst ||
                    $warehouseTitle1NoFirst === $searchTitleNoFirst ||
                    $warehouseTitle2NoFirst === $searchTitleNoFirst;
            }
            $isMatchedByAlias = $searchAlias !== '' && $warehouseAlias === $searchAlias;

            if (!$isMatchedByName && !$isMatchedByAlias) {
                continue;
            }

            $remainsValue = $warehouse['remains'] ?? 0;
            $isRequest = isRequestRemainsValue($remainsValue);
            $finalCount = $isRequest ? 0 : (int)$remainsValue;
            break;
        }

        if (!$isRequest && isRequestRemainsValue($remainsData['total_remains'] ?? null)) {
            $isRequest = true;
            $finalCount = 0;
        }

        $product = $modx->getObject('modResource', $productId);
        if ($product) {
            $finalResults[] = [
                'id' => (int)$productId,
                'title' => $product->get('pagetitle'),
                'count' => (int)$finalCount,
                'status' => $isRequest ? 'request' : getStockStatus((int)$finalCount),
                'url' => $modx->makeUrl($productId),
            ];
        }
    }

    if (empty($finalResults)) {
        echo json_encode([
            'success' => true,
            'products' => [],
            'message' => 'No products found',
        ]);
        exit();
    }

    echo json_encode([
        'success' => true,
        'products' => $finalResults,
        'query' => $queryPhrase,
        'stockName' => $stockName,
        'total' => count($finalResults),
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
} catch (Throwable $e) {
    $modx->log(modX::LOG_LEVEL_ERROR, '[warehouse-search] exception: ' . $e->getMessage());
    $sendServerError('Exception during warehouse search', $debugMode ? [
        'message' => $e->getMessage(),
        'file' => $e->getFile(),
        'line' => $e->getLine(),
    ] : []);
}
