<?php

/**
 * Сниппет: listProductsStocksSorted
 * Назначение: получить товары по родителю, посчитать наличие/статус, отсортировать и вывести по tpl
 * Параметры:
 *  - parent (int) — id категории (обязательный)
 *  - limit (int) — лимит выборки, по умолчанию 50
 *  - tpl (string) — путь к чанку строки, по умолчанию item-with-stock-status.tpl
 *  - context (string) — контекст, по умолчанию текущий
 *  - useCache (int|bool) — использовать кэш, по умолчанию 1
 */

/** @var modX $modx */
require_once MODX_CORE_PATH . "elements/modules/stocks/php/stock-constant.php";
require_once MODX_CORE_PATH . "elements/modules/stocks/php/stock.class.php";

const ALIAS_CATALOG = "catalog";

$parentId = (int)$modx->getOption('parent', $scriptProperties, 0);
$limit    = (int)$modx->getOption('limit', $scriptProperties, 50);
$stockName = (string)$modx->getOption('stockName', $scriptProperties, '');
$tpl      = (string)$modx->getOption('tpl', $scriptProperties, '@FILE modules/warehoses/sections/universal/item-with-stock-status.tpl');
$context  = (string)$modx->getOption('context', $scriptProperties, (string)$modx->context->get('key'));
$useCache = (int)$modx->getOption('useCache', $scriptProperties, 1) ? true : false;

if (!$parentId) {
    return '';
}

/** @var pdoTools $pdo */
$pdo = $modx->getService('pdoTools');

// Получаем каталог с шаблонами складов
$catalog = $modx->getObject('modResource', ['alias' => ALIAS_CATALOG, 'context_key' => $context]);
if (!$catalog) {
    return '';
}

$stockTemplates = json_decode($catalog->getTVValue('stocksTemplates'), true);
if (empty($stockTemplates) || !is_array($stockTemplates)) {
    return '';
}

// Получаем товары категории
$criteria = $modx->newQuery('modResource');
$criteria->select($modx->getSelectColumns('modResource', 'modResource', '', ['id', 'pagetitle']));
$criteria->where([
    'class_key' => 'msProduct',
    'published' => 1,
    'deleted' => 0,
    'context_key' => $context,
]);

// Ограничиваем выборку текущей категорией и её вложенными категориями,
// иначе одна и та же общая выборка выводится в каждом блоке категории.
$parentIds = $modx->getChildIds($parentId, 10, ['context' => $context]);
$parentIds[] = $parentId;
$parentIds = array_values(array_unique(array_map('intval', $parentIds)));
$criteria->where([
    'parent:IN' => $parentIds,
]);
if ($limit > 0) {
    $criteria->limit($limit);
}

$products = $modx->getIterator('modResource', $criteria);

// Вспомогательные функции
if (!function_exists('lp_getStockStatus')) {
    function lp_getStockStatus($count)
    {
        if ($count === 0) {
            return 'request';
        }
        if ($count >= MIN_LIMIT_STOCKS && $count <= MAX_LIMIT_STOCKS) {
            return 'limited';
        }
        return 'normal';
    }
}

if (!function_exists('lp_normalizeStockTitle')) {
    function lp_normalizeStockTitle($title)
    {
        $title = trim((string)$title);
        if ($title === '') {
            return '';
        }

        $title = function_exists('mb_strtolower')
            ? mb_strtolower($title, 'UTF-8')
            : strtolower($title);
        $title = str_replace('ё', 'е', $title);
        $title = preg_replace('/^\s*склад\s+/u', '', $title);
        $title = preg_replace('/\s+/u', ' ', $title);

        return trim($title);
    }
}

// Подбор шаблона склада для товара
$getTemplateForProduct = function (int $productId, array $stockTemplates, modX $modx, string $context) {
    $parentIds = $modx->getParentIds($productId, 10, ['context' => $context]);
    foreach ($stockTemplates as $template) {
        $templateCategory = $template['category'] ?? null;
        $isMatched = is_array($templateCategory)
            ? !empty(array_intersect($parentIds, $templateCategory))
            : in_array($templateCategory, $parentIds);
        if ($isMatched) {
            return $template;
        }
    }
    return null;
};

// Сбор данных, расчёт статуса и сортировка
$rows = [];
foreach ($products as $product) {
    /** @var modResource $product */
    $productId = (int)$product->get('id');
    $pagetitle = (string)$product->get('pagetitle');

    $cacheKey =  CACHE_KEY . $context . "/". 'search_' . $productId;
    $stocksData = $useCache ? $modx->cacheManager->get($cacheKey) : null;

    if (empty($stocksData)) {
        $stocksNames = getStocksNamesByContext($context);
        $tmpl = $getTemplateForProduct($productId, $stockTemplates, $modx, $context);
        if ($tmpl) {
            $distribution = getStockDistributionByTemplate(
                (int)($tmpl['template'] ?? 0),
                count($stocksNames)
            );
            $tmplCountLimit = (int)$distribution['limitStocks'];
            $tmplCountNot   = (int)$distribution['notStocks'];
            $tmplMinLimit   = getStockTemplateRangeValue($tmpl, 'min_limit');
            $tmplMaxLimit   = getStockTemplateRangeValue($tmpl, 'max_limit');
        } else {
            $distribution = getStockDistributionByTemplate(0, count($stocksNames));
            $tmplCountLimit = (int)$distribution['limitStocks'];
            $tmplCountNot   = (int)$distribution['notStocks'];
            $tmplMinLimit   = null;
            $tmplMaxLimit   = null;
        }

        $stockTemplateObj = new StockTemplate(
            $stocksNames,
            (int)$tmplCountLimit,
            (int)$tmplCountNot,
            $productId,
            $tmplMinLimit,
            $tmplMaxLimit
        );
        $stocksData = $stockTemplateObj->make();
        if ($useCache) {
            $modx->cacheManager->set($cacheKey, $stocksData, CACHE_TIME);
        }
    }

    // Подсчёт остатков: для конкретного склада или суммарно
    $total = 0;
    if (is_array($stocksData)) {
        $stocksRoot = isset($stocksData[STOCK_KEY_STOCKS]) ? $stocksData[STOCK_KEY_STOCKS] : (isset($stocksData['stocks']) ? $stocksData['stocks'] : []);
        if ($stockName !== '') {
            // Поддерживаем оба варианта: "Колпино" и "Склад Колпино".
            $found = null;
            $normalizedStockName = lp_normalizeStockTitle($stockName);
            foreach (['stocks', 'limitStocks'] as $k) {
                if (!empty($stocksRoot[$k]) && is_array($stocksRoot[$k])) {
                    foreach ($stocksRoot[$k] as $row) {
                        if (
                            isset($row['title'])
                            && (
                                $row['title'] === $stockName
                                || lp_normalizeStockTitle($row['title']) === $normalizedStockName
                            )
                        ) {
                            $found = (int)$row['count'];
                            break 2;
                        }
                    }
                }
            }
            $total = (int)($found ?? 0);
        } else {
            foreach (['stocks', 'limitStocks'] as $k) {
                if (!empty($stocksRoot[$k]) && is_array($stocksRoot[$k])) {
                    foreach ($stocksRoot[$k] as $row) {
                        if (isset($row['count'])) {
                            $total += (int)$row['count'];
                        }
                    }
                }
            }
        }
    }

    $status = lp_getStockStatus((int)$total);
    $weight = $status === 'normal' ? 0 : ($status === 'limited' ? 1 : 2);

    $rows[] = [
        'id' => $productId,
        'pagetitle' => $pagetitle,
        'count' => (int)$total,
        'status' => $status,
        'weight' => $weight,
    ];
}

usort($rows, function ($a, $b) {
    return (int)$b['count'] <=> (int)$a['count'];
});

// Рендер
$output = [];
foreach ($rows as $row) {
    $output[] = $pdo->getChunk($tpl, $row);
}

return implode("\n", $output);

