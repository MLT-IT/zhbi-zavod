<?php
/**
 * API endpoint для поиска товаров на складе
 */

// Подключение MODX
require_once dirname(__DIR__) . '/config.core.php';
require_once MODX_CORE_PATH . 'model/modx/modx.class.php';

$modx = new modX();
$modx->initialize('web');

// Установка заголовков для JSON ответа
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Обработка preflight запросов
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Проверка метода запроса
if ($_SERVER['REQUEST_METHOD'] !== 'POST' && $_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode([
        'success' => false,
        'error' => 'Только POST и GET запросы разрешены'
    ]);
    exit();
}

$stocksModulePath = MODX_CORE_PATH . "elements/_modules/stocks/php/";
if (!is_dir($stocksModulePath)) {
    $stocksModulePath = MODX_CORE_PATH . "elements/modules/stocks/php/";
}
require_once $stocksModulePath . "stock-constant.php";
require_once $stocksModulePath . "stock.class.php";

const ALIAS_CATALOG = "catalog";


// Получение параметров из POST
$queryPhrase = $_POST['query'] ?? $_GET['query'] ?? '';
$context = $_POST['context'] ?? $_GET['context'] ?? 'web';
$stockName = $_POST['stockName'] ?? $_GET['stockName'] ?? '';
$limit = (int)($_POST['limit'] ?? $_GET['limit'] ?? 10);


// Валидация параметров
if (empty($queryPhrase)) {
    echo json_encode([
        'success' => false,
        'error' => 'Поисковый запрос не может быть пустым'
    ]);
    exit();
}

if (empty($stockName)) {
    echo json_encode([
        'success' => false,
        'error' => 'Название склада не указано'
    ]);
    exit();
}
if (empty($context)) {
    echo json_encode([
        'success' => false,
        'error' => 'Контекст не указан'
    ]);
    exit();
}



try {
  
    // Формирование where
    $wherePagetitle = [];
    $queryWordsArray = [];

    foreach (explode(' ', $queryPhrase) as $index => $queryWord) {
        if (stristr($queryWord, ',') || stristr($queryWord, '.')) {
            $queryWord = preg_replace('/[, .]/', '[,\.]', $queryWord);
            $wherePagetitle[$index] = '`msProduct`.`pagetitle` REGEXP :queryWord' . $index;
        } else {
            $queryWord = '%' . $queryWord . '%';
            $wherePagetitle[$index] = '`msProduct`.`pagetitle` LIKE :queryWord' . $index;
        }
        $queryWordsArray['queryWord' . $index] = $queryWord;
    }

    $wherePagetitle = '(' . implode(' AND ', $wherePagetitle) . ')';
    $queryWordsArray['queryPhrase'] = '%' . $queryPhrase . '%';
    $whereArticle = '(`Data`.`article` LIKE :queryPhrase)';
    $where = $wherePagetitle . ' OR ' . $whereArticle;

    // Получение данных из БД
    $query = "SELECT `msProduct`.`id` 
            
          FROM `modx_site_content` AS `msProduct` 
            
          LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` =  `Data`.`id` 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `msProduct`.`id` AND `TVhitspage`.`tmplvarid` = 7 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `msProduct`.`id` AND `TVpriority1`.`tmplvarid` = 17 
            
          WHERE  `msProduct`.`class_key` = 'msProduct' 
                AND `msProduct`.`published` = 1 
                AND `msProduct`.`deleted` = 0 
                AND `msProduct`.`context_key` = '" . $context . "'
                AND ($where) 
            
          GROUP BY msProduct.id 
          ORDER BY CAST(`TVpriority1`.`value` AS DECIMAL(13,3)) ASC, CAST(`TVhitspage`.`value` AS DECIMAL(13,3)) ASC
          LIMIT 10
          ";


    $stmt = $modx->prepare($query);
    $queryResult = $stmt->execute($queryWordsArray);

    if ($queryResult === false) {
        echo json_encode([
            'success' => false,
            'error' => 'Ошибка выполнения запроса к базе данных'
        ]);
        exit();
    }

    $data = $stmt->fetchAll(PDO::FETCH_COLUMN);

    if (empty($data)) {
        echo json_encode([
            'success' => true,
            'products' => [],
            'message' => 'Товары по запросу не найдены'
        ]);
        exit();
    }

    // Получение каталога для определения шаблона склада
    $catalog = $modx->getObject(
        'modResource',
        [
            'alias' => ALIAS_CATALOG,
            "context_key" => $context
        ]
    );


    if (empty($catalog)) {
        $modx->log(modX::LOG_LEVEL_ERROR, "Каталог не найден для контекста ({$context})");
        echo json_encode([
            'success' => false,
            'error' => 'Каталог не найден'
        ]);
        exit();
    }

    $stockTemplates = json_decode($catalog->getTVValue('stocksTemplates'), true);
    $stocksNames = getStocksNamesByContext($context);
    $resultStocks = [];

    // Обработка каждого найденного товара
    foreach ($data as $productId) {
        // Проверяем кеш для этого товара
        $cacheKey =  CACHE_KEY . $context . "/". 'search_' . $productId;
        $cachedStocks = $modx->cacheManager->get($cacheKey);
        
        if (!empty($cachedStocks)) {
            $resultStocks[$productId] = $cachedStocks;
            continue;
        }

        $parentIds = $modx->getParentIds($productId, 10, array('context' => $context));
        $stockTemplate = null;

        // Поиск подходящего шаблона склада
        foreach ($stockTemplates as $template) {
            $templateCategory = $template['category'] ?? null;
            $isMatched = is_array($templateCategory)
                ? !empty(array_intersect($parentIds, $templateCategory))
                : in_array($templateCategory, $parentIds);

            if ($isMatched) {
                $stockTemplate = $template;
                break;
            }
        }

        if (!$stockTemplate) {
            continue;
        }

        $distribution = getStockDistributionByTemplate(
            (int)($stockTemplate['template'] ?? 0),
            count($stocksNames)
        );
        $templateCountLimitStocks = (int)$distribution['limitStocks'];
        $templateCountNotStocks = (int)$distribution['notStocks'];
        $templateMinLimit = getStockTemplateRangeValue($stockTemplate, 'min_limit');
        $templateMaxLimit = getStockTemplateRangeValue($stockTemplate, 'max_limit');

        $stockTemplateObj = new StockTemplate(
            $stocksNames,
            $templateCountLimitStocks,
            $templateCountNotStocks,
            $productId,
            $templateMinLimit,
            $templateMaxLimit
        );
        $stocks = $stockTemplateObj->make();
        
        // Кешируем результат
        $modx->cacheManager->set($cacheKey, $stocks, CACHE_TIME);
        $resultStocks[$productId] = $stocks;
    }

    if (!function_exists("normalizeStockName")) {
        function normalizeStockName($stockName)
        {
            $normalized = (string)$stockName;
            $normalized = function_exists('mb_strtolower')
                ? mb_strtolower($normalized, 'UTF-8')
                : strtolower($normalized);
            $normalized = str_replace('ё', 'е', $normalized);
            $normalized = preg_replace('/^склад\s+/u', '', $normalized);
            $normalized = preg_replace('/[^a-z0-9а-я-]+/u', '', $normalized);

            return is_string($normalized) ? $normalized : '';
        }
    }

    // Функция для поиска количества на складе
    if (!function_exists("searchCountStock")) {
        function searchCountStock($stockData, $searchStock)
        {
            $searchStock = normalizeStockName($searchStock);

            foreach ($stockData as $stock) {
                if ($searchStock === normalizeStockName($stock['title'] ?? '')) {
                    return $stock["count"];
                }
            }
            return null;
        }
    }

    // Функция для определения статуса товара на складе
    if (!function_exists("getStockStatus")) {
        function getStockStatus($count)
        {
            if ($count >= MIN_STOCKS && $count <= MAX_STOCKS) {
                return 'normal'; // товар в нормальном диапазоне
            } elseif ($count >= MIN_LIMIT_STOCKS && $count <= MAX_LIMIT_STOCKS) {
                return 'limited'; // товар с ограниченным количеством
            } elseif ($count == 0) {
                return 'request'; // товар под запрос
            } else {
                return 'normal'; // по умолчанию нормальный статус
            }
        }
    }

    $finalResults = [];

    foreach ($resultStocks as $productId => $values) {
        $count = searchCountStock($values['stocks']['limitStocks'], $stockName);
        $countLimit = searchCountStock($values['stocks']['stocks'], $stockName);
        $finalCount = $count ?? $countLimit ?? 0;

        $product = $modx->getObject("modResource", $productId);
        if ($product) {
            $finalResults[] = [
                "id" => $productId,
                "title" => $product->get('pagetitle'),
                "count" => $finalCount,
                "status" => getStockStatus($finalCount),
                "url" => $modx->makeUrl($productId)
            ];
        }
    }
    
    if (empty($finalResults)) {
        echo json_encode([
            'success' => true,
            'products' => [],
            'message' => 'Товары по запросу не найдены'
        ]);
        exit();
    }

    echo json_encode([
        'success' => true,
        'products' => $finalResults,
        'query' => $queryPhrase,
        'stockName' => $stockName,
        'total' => count($finalResults)
    ]);

} catch (Exception $e) {
    $modx->log(modX::LOG_LEVEL_ERROR, "Ошибка в warehouseSearch: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'error' => 'Произошла ошибка при поиске товаров'
    ]);
}

