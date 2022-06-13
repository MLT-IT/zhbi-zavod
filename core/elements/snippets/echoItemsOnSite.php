<?php

$cacheName = 'echoItemsOnSite';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $contextKey = $modx->resource->get('context_key');
    $contextKey = "'" . $contextKey . "'";

    $query = "SELECT COUNT(*) 
          FROM " . $modx->getOption('table_prefix') . "ms2_products AS prod
          INNER JOIN " . $modx->getOption('table_prefix') . "site_content AS cont 
          ON  prod.id = cont.id
          WHERE cont.context_key = " . $contextKey;
    $val = $modx->query($query);
    $val = $val->fetchAll(PDO::FETCH_COLUMN);
    $val = reset($val);

    $valOutput = preg_replace('/\B(?=(\d{3})+(?!\d))/', ' ', $val);
    $textOutput = $modx->runSnippet('formOfWord', [
        'n' => $val,
        'f1' => 'товар',
        'f2' => 'товара',
        'f5' => 'товаров'
    ]);

    $result = $valOutput . ' ' . $textOutput;

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;


