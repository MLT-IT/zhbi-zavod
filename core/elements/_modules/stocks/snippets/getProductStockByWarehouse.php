<?php

/** @var modX $modx */
require_once MODX_CORE_PATH . "elements/modules/stocks/php/stock-constant.php";
require_once MODX_CORE_PATH . "elements/modules/stocks/php/stock.class.php";

$productId = (int)$modx->getOption('productId', $scriptProperties, (int)$modx->resource->id);
$context = (string)$modx->getOption('context', $scriptProperties, (string)$modx->context->get('key'));
$stockName = (string)$modx->getOption('stockName', $scriptProperties, '');
$useCache = (int)$modx->getOption('useCache', $scriptProperties, 1) ? true : false;

if (!$productId || $stockName === '') {
    return '0';
}

$catalog = $modx->getObject(
    'modResource',
    [
        'alias' => 'catalog',
        'context_key' => $context,
    ]
);

if (empty($catalog)) {
    return '0';
}

$stockTemplates = json_decode($catalog->getTVValue('stocksTemplates'), true);
if (empty($stockTemplates) || !is_array($stockTemplates)) {
    return '0';
}

$stocksNames = getStocksNamesByContext($context);

$cacheKey = CACHE_KEY . $context . "/search_" . $productId;
$stocksData = $useCache ? $modx->cacheManager->get($cacheKey) : null;

if (empty($stocksData)) {
    $parentIds = $modx->getParentIds($productId, 10, array('context' => $context));
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
        return '0';
    }

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

    $stocksData = $stockTemplateObj->make();
    if ($useCache) {
        $modx->cacheManager->set($cacheKey, $stocksData, CACHE_TIME);
    }
}

if (!is_array($stocksData)) {
    return '0';
}

$stocksRoot = isset($stocksData[STOCK_KEY_STOCKS]) ? $stocksData[STOCK_KEY_STOCKS] : (isset($stocksData['stocks']) ? $stocksData['stocks'] : array());
foreach (array('limitStocks', 'stocks', 'notStocks') as $key) {
    if (!empty($stocksRoot[$key]) && is_array($stocksRoot[$key])) {
        foreach ($stocksRoot[$key] as $row) {
            if (isset($row['title']) && $row['title'] === $stockName) {
                return (string)(int)(isset($row['count']) ? $row['count'] : 0);
            }
        }
    }
}

return '0';
