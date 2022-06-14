<?php

if (empty($alias)) {
    return;
}

$cacheFolder = 'getIdByAlias';
$cacheName = $cacheFolder . '.' . $alias;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $result = [];

    $alias = explode(',', $alias);

    foreach ($alias as $al) {
        $al = trim($al);
        $obj = $modx->getObject('modResource', [
            'alias' => $al,
            'context_key' => $modx->resource->context_key
        ]);

        if (empty($obj)) {
            continue;
        }

        $val = '';
        if (!empty($addMinus) && $addMinus) {
            $val = '-';
        }

        $result[] = $val . $obj->id;
    }

    $result = implode(',', $result);

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
