<?php

/**
 * Snippet: getWarehouseCategoryIdsSorted
 *
 * Returns comma-separated first-level category ids from catalog, sorted by:
 * 1) categories with available products first;
 * 2) number of products in stock (desc);
 * 3) total stock amount (desc).
 *
 * Categories where all products are on request are moved to the end.
 */

/** @var modX $modx */
require_once MODX_CORE_PATH . "elements/modules/stocks/php/stock-constant.php";
require_once MODX_CORE_PATH . "elements/modules/stocks/php/stock.class.php";

$catalogAlias = (string)$modx->getOption('catalogAlias', $scriptProperties, 'catalog');
$catalogIdInput = (string)$modx->getOption('catalogId', $scriptProperties, '');
$context = (string)$modx->getOption('context', $scriptProperties, (string)$modx->context->get('key'));
$stockName = (string)$modx->getOption('stockName', $scriptProperties, (string)$modx->resource->get('pagetitle'));
$productsLimit = (int)$modx->getOption('productsLimit', $scriptProperties, 50);
$useCache = (int)$modx->getOption('useCache', $scriptProperties, 1) ? true : false;

preg_match('/\d+/', $catalogIdInput, $catalogIdMatch);
$catalogId = isset($catalogIdMatch[0]) ? (int)$catalogIdMatch[0] : 0;

if ($catalogId <= 0) {
    $catalogByAlias = $modx->getObject('modResource', [
        'alias' => $catalogAlias,
        'context_key' => $context,
        'deleted' => 0,
    ]);
    if ($catalogByAlias) {
        $catalogId = (int)$catalogByAlias->get('id');
    }
}

if ($catalogId <= 0) {
    return '';
}

$catalog = $modx->getObject('modResource', [
    'id' => $catalogId,
    'context_key' => $context,
    'deleted' => 0,
]);

if (!$catalog) {
    return '';
}

$stockTemplates = json_decode($catalog->getTVValue('stocksTemplates'), true);
if (empty($stockTemplates) || !is_array($stockTemplates)) {
    return '';
}

$stocksNames = getStocksNamesByContext($context);
if (empty($stocksNames) || !is_array($stocksNames)) {
    return '';
}

$normalizeStockTitle = function ($title) {
    $title = trim((string)$title);
    if ($title === '') {
        return '';
    }

    $title = function_exists('mb_strtolower')
        ? mb_strtolower($title, 'UTF-8')
        : strtolower($title);
    $title = preg_replace('/\s+/u', ' ', $title);

    return trim((string)$title);
};

$stripFirstWord = function ($title) {
    $title = trim((string)$title);
    if ($title === '') {
        return '';
    }

    $withoutFirstWord = preg_replace('/^\S+\s+/u', '', $title);
    return trim((string)$withoutFirstWord);
};

$getTemplateForProduct = function (int $productId) use ($stockTemplates, $modx, $context) {
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

$getStockCountForProduct = function (int $productId) use (
    $modx,
    $context,
    $stockName,
    $useCache,
    $stocksNames,
    $getTemplateForProduct,
    $normalizeStockTitle,
    $stripFirstWord
) {
    $cacheKey = CACHE_KEY . $context . '/search_' . $productId;
    $stocksData = $useCache ? $modx->cacheManager->get($cacheKey) : null;

    if (empty($stocksData)) {
        $tmpl = $getTemplateForProduct($productId);
        if ($tmpl) {
            $distribution = getStockDistributionByTemplate(
                (int)($tmpl['template'] ?? 0),
                count($stocksNames)
            );
            $tmplCountLimit = (int)$distribution['limitStocks'];
            $tmplCountNot = (int)$distribution['notStocks'];
            $tmplMinLimit = getStockTemplateRangeValue($tmpl, 'min_limit');
            $tmplMaxLimit = getStockTemplateRangeValue($tmpl, 'max_limit');
        } else {
            $distribution = getStockDistributionByTemplate(0, count($stocksNames));
            $tmplCountLimit = (int)$distribution['limitStocks'];
            $tmplCountNot = (int)$distribution['notStocks'];
            $tmplMinLimit = null;
            $tmplMaxLimit = null;
        }

        $stockTemplateObj = new StockTemplate(
            $stocksNames,
            $tmplCountLimit,
            $tmplCountNot,
            $productId,
            $tmplMinLimit,
            $tmplMaxLimit
        );
        $stocksData = $stockTemplateObj->make();

        if ($useCache) {
            $modx->cacheManager->set($cacheKey, $stocksData, CACHE_TIME);
        }
    }

    if (!is_array($stocksData)) {
        return 0;
    }

    $stocksRoot = isset($stocksData[STOCK_KEY_STOCKS])
        ? $stocksData[STOCK_KEY_STOCKS]
        : (isset($stocksData['stocks']) ? $stocksData['stocks'] : []);

    if ($stockName !== '') {
        $found = null;

        $normalizedStockName = $normalizeStockTitle($stockName);
        $normalizedStockNameNoFirstWord = $stripFirstWord($normalizedStockName);

        foreach (['stocks', 'limitStocks'] as $key) {
            if (!empty($stocksRoot[$key]) && is_array($stocksRoot[$key])) {
                foreach ($stocksRoot[$key] as $row) {
                    $rowTitle = isset($row['title']) ? (string)$row['title'] : '';
                    $normalizedRowTitle = $normalizeStockTitle($rowTitle);
                    $normalizedRowTitleNoFirstWord = $stripFirstWord($normalizedRowTitle);

                    if (
                        $rowTitle === $stockName
                        || $normalizedRowTitle === $normalizedStockName
                        || $normalizedRowTitleNoFirstWord === $normalizedStockName
                        || $normalizedRowTitle === $normalizedStockNameNoFirstWord
                        || $normalizedRowTitleNoFirstWord === $normalizedStockNameNoFirstWord
                    ) {
                        $found = (int)($row['count'] ?? 0);
                        break 2;
                    }
                }
            }
        }

        return (int)($found ?? 0);
    }

    $total = 0;
    foreach (['stocks', 'limitStocks'] as $key) {
        if (!empty($stocksRoot[$key]) && is_array($stocksRoot[$key])) {
            foreach ($stocksRoot[$key] as $row) {
                if (isset($row['count'])) {
                    $total += (int)$row['count'];
                }
            }
        }
    }

    return $total;
};

$categoriesQuery = $modx->newQuery('modResource');
$categoriesQuery->select($modx->getSelectColumns('modResource', 'modResource', '', ['id', 'pagetitle']));
$categoriesQuery->where([
    'class_key' => 'msCategory',
    'parent' => (int)$catalog->get('id'),
    'published' => 1,
    'deleted' => 0,
    'context_key' => $context,
]);
$categoriesQuery->sortby('menuindex', 'ASC');

$categories = $modx->getIterator('modResource', $categoriesQuery);
$scores = [];
$allCategoryIds = [];

foreach ($categories as $category) {
    /** @var modResource $category */
    $categoryId = (int)$category->get('id');
    $categoryTitle = (string)$category->get('pagetitle');
    $allCategoryIds[] = $categoryId;

    $parentIds = $modx->getChildIds($categoryId, 10, ['context' => $context]);
    $parentIds[] = $categoryId;
    $parentIds = array_values(array_unique(array_map('intval', $parentIds)));

    $productsQuery = $modx->newQuery('modResource');
    $productsQuery->select($modx->getSelectColumns('modResource', 'modResource', '', ['id']));
    $productsQuery->where([
        'class_key' => 'msProduct',
        'published' => 1,
        'deleted' => 0,
        'context_key' => $context,
        'parent:IN' => $parentIds,
    ]);
    if ($productsLimit > 0) {
        $productsQuery->limit($productsLimit);
    }

    $products = $modx->getIterator('modResource', $productsQuery);

    $availableProducts = 0;
    $totalStock = 0;
    $productsCount = 0;

    foreach ($products as $product) {
        /** @var modResource $product */
        $productsCount++;
        $count = $getStockCountForProduct((int)$product->get('id'));
        $totalStock += $count;

        if ($count > 0) {
            $availableProducts++;
        }
    }

    if ($productsCount === 0) {
        continue;
    }

    $scores[] = [
        'id' => $categoryId,
        'title' => $categoryTitle,
        'availableProducts' => $availableProducts,
        'totalStock' => $totalStock,
        'requestOnly' => $availableProducts === 0 ? 1 : 0,
    ];
}

usort($scores, function ($a, $b) {
    if ((int)$a['requestOnly'] !== (int)$b['requestOnly']) {
        return (int)$a['requestOnly'] <=> (int)$b['requestOnly'];
    }

    $cmp = (int)$b['availableProducts'] <=> (int)$a['availableProducts'];
    if ($cmp !== 0) {
        return $cmp;
    }

    $cmp = (int)$b['totalStock'] <=> (int)$a['totalStock'];
    if ($cmp !== 0) {
        return $cmp;
    }

    return strcmp((string)$a['title'], (string)$b['title']);
});

$sortedIds = array_map(static function ($row) {
    return (int)$row['id'];
}, $scores);

if (empty($sortedIds)) {
    if (!empty($allCategoryIds)) {
        return implode(',', $allCategoryIds) . ',';
    }

    return '';
}

return implode(',', $sortedIds) . ',';
