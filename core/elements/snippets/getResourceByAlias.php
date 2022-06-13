<?php

if (empty($alias)) {
    return;
}

$cacheName = 'getResourceByAlias.' . $alias;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $alias = trim($alias);

    $result = $modx->getObject('modResource', [
        'alias' => $alias,
        'context_key' => $modx->resource->context_key
    ]);

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
