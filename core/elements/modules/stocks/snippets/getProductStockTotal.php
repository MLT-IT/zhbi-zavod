<?php

/**
 * Сниппет: getProductStockTotal
 * Назначение: вернуть суммарное количество наличия по товару (всех складов), с кэшированием
 * Параметры:
 *  - productId (int) — id товара, по умолчанию текущий ресурс
 *  - context (string) — контекст, по умолчанию текущий
 *  - useCache (int|bool) — использовать кэш (1|0), по умолчанию 1
 * Возвращает: целое число (сумма по складам)
 */

/** @var modX $modx */
require_once MODX_CORE_PATH . "elements/modules/stocks/php/stock-constant.php";
require_once MODX_CORE_PATH . "elements/modules/stocks/php/stock.class.php";

const ALIAS_CATALOG = "catalog";

$productId = (int)$modx->getOption('productId', $scriptProperties, (int)$modx->resource->id);
$context   = (string)$modx->getOption('context', $scriptProperties, (string)$modx->context->get('key'));
$useCache  = (int)$modx->getOption('useCache', $scriptProperties, 1) ? true : false;

if (!$productId) {
    return 0;
}

// Найти корневой каталог для определения шаблонов складов
$catalog = $modx->getObject(
    'modResource',
    [
        'alias' => ALIAS_CATALOG,
        'context_key' => $context,
    ]
);

if (empty($catalog)) {
    $modx->log(modX::LOG_LEVEL_ERROR, "Каталог не найден для товара ({$productId})");
    return 0;
}

$cacheKey =  CACHE_KEY . $context . "/". 'search_' . $productId;
$resultStocks = null;

if ($useCache) {
    $resultStocks = $modx->cacheManager->get($cacheKey);
}

if (empty($resultStocks)) {
    $stockTemplates = json_decode($catalog->getTVValue('stocksTemplates'), true);
    if (empty($stockTemplates) || !is_array($stockTemplates)) {
        return 0;
    }

    $parentIds = $modx->getParentIds($productId, 10, ['context' => $context]);
    $matchedTemplate = null;

    foreach ($stockTemplates as $template) {
        $templateCategory = isset($template['category']) ? $template['category'] : null;
        $isMatched = is_array($templateCategory)
            ? !empty(array_intersect($parentIds, $templateCategory))
            : in_array($templateCategory, $parentIds);

        if ($isMatched) {
            $matchedTemplate = $template;
            break;
        }
    }

    if (!$matchedTemplate) {
        return 0;
    }

    // Параметры шаблона
    $stocksNames = getStocksNamesByContext($context);
    $distribution = getStockDistributionByTemplate(
        (int)($matchedTemplate['template'] ?? 0),
        count($stocksNames)
    );
    $templateCountLimitStocks = (int)$distribution['limitStocks'];
    $templateCountNotStocks = (int)$distribution['notStocks'];

    $templateMinLimit = getStockTemplateRangeValue($matchedTemplate, 'min_limit');
    $templateMaxLimit = getStockTemplateRangeValue($matchedTemplate, 'max_limit');

    $stockTemplateObj = new StockTemplate(
        $stocksNames,
        $templateCountLimitStocks, 
        $templateCountNotStocks, 
        $productId, 
        $templateMinLimit, 
        $templateMaxLimit
    );
    $resultStocks = $stockTemplateObj->make();

    if ($useCache) {
        $modx->cacheManager->set($cacheKey, $resultStocks, CACHE_TIME);
    }
}

// Подсчёт суммарного количества по всем типам складов
$total = 0;
if (is_array($resultStocks)) {
    // ожидаемая структура: [ 'stocks' => [ 'stocks' => [...], 'limitStocks' => [...] ] ]
    $stocksRoot = isset($resultStocks[STOCK_KEY_STOCKS]) ? $resultStocks[STOCK_KEY_STOCKS] : (isset($resultStocks['stocks']) ? $resultStocks['stocks'] : []);

    foreach (['stocks', 'limitStocks'] as $key) {
        if (isset($stocksRoot[$key]) && is_array($stocksRoot[$key])) {
            foreach ($stocksRoot[$key] as $row) {
                if (isset($row['count'])) {
                    $total += (int)$row['count'];
                }
            }
        }
    }
}

return (string)(int)$total;


