<?php

if (empty($title)) {
    $title = $modx->resource->menutitle;
}

if (empty($append)) {
    $append = '';
}

$cacheFolder = 'getPricelistName';
$cacheName = md5($title . $append . $maxLength);
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $result = str_replace('/', '-', $title);
    $result = preg_replace('/^[\w\-. ]+$/', '', $result);
    $result = trim($result);

    if (!empty($maxLength) && $maxLength > 0) {
        if (mb_strlen($result) > $maxLength) {
            $result = mb_substr($result, 0, $maxLength - 1);
            $result .= '…';
        }
    }

    $result .= $append;
    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
