<?php

if (empty($title)) {
    $title = $modx->resource->menutitle;
}

$cacheFolder = 'getPricelistName';
$cacheName = $title;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $result = str_replace('/', '-', $title);
    $result = preg_replace('/^[\w\-. ]+$/', '', $result);
    $result = trim($result);

    $result .= '.xlsx';

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
