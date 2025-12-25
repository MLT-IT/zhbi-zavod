<?php

/**
 * @param $limit - Лимит товаров
 * @param @tpl - Шаблон к чанку товара
 */
$cacheKey = 'bestseller_products';
$cacheOptions = [
  xPDO::OPT_CACHE_KEY => 'default/msproducts/' . $modx->resource->context_key . '/',
];

$pdoTools = $modx->getService('pdoTools');

// Попытка получить из кэша
$products = $modx->cacheManager->get($cacheKey, $cacheOptions);

if (!$products) {
  $context = $modx->context->get('key');
  $tablePrefix = $modx->getOption('table_prefix');

  $sql = "
        SELECT p.id, p.pagetitle, prod.price, prod.thumb, tv.value AS priority
        FROM {$tablePrefix}site_content AS p
        LEFT JOIN {$tablePrefix}ms2_products AS prod
            ON prod.id = p.id
        LEFT JOIN {$tablePrefix}site_tmplvar_contentvalues AS tv
            ON tv.contentid = p.id
            AND tv.tmplvarid = (SELECT id FROM {$tablePrefix}site_tmplvars WHERE name = 'priority')
        WHERE p.class_key = 'msProduct'
          AND p.context_key = '{$context}'
          AND tv.value IS NOT NULL
        ORDER BY tv.value ASC
        LIMIT {$limit}
    ";

  $result = $modx->query($sql);
  $products = $result->fetchAll(PDO::FETCH_ASSOC);

  $modx->cacheManager->set($cacheKey, $products, 0, $cacheOptions);
}

// Рендерим через чанки
$output = '';
foreach ($products as $product) {
  $product['price'] = number_format($product['price'], 0, '.', ' ');
  $output .= $pdoTools->getChunk($tpl, $product);
}

return $output;
