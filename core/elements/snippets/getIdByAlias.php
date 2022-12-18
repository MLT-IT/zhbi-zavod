<?php

if (empty($alias)) {
    return;
}

if (empty($contextKey)) {
    $contextKey = $modx->context->key;
}

$cacheFolder = 'getIdByAlias';
$cacheName = $alias;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/' . $contextKey . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $result = [];

    $alias = explode(',', $alias);

    foreach ($alias as $al) {
        $al = trim($al);
        $obj = $modx->getObject('modResource', [
            'alias' => $al,
            'context_key' => $contextKey
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
