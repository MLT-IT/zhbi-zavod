<?php

$cacheFolder = 'getAliasesFromFilters';
$cacheName = $modx->resource->id;
$contextKey = $modx->resource->context_key;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/' . $contextKey . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $filters = $modx->resource->getTVValue('listFilters');
    $filters = explode(',', $filters);

    $result = ['ms|price==price'];
    $result[] = ['ms_product|pagetitle==pagetitle'];

    foreach ($filters as $fltr) {
        $exploded = explode('|', $fltr);
        $result[] = $fltr . '==' . $exploded[1];
    }

    $result = implode(',', $result);

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;