<?php

if (empty($alias)) {
    return;
}

$cacheFolder = 'getResourceByAlias';
$cacheName = $alias;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $alias = trim($alias);

    $result = $modx->getObject('modResource', [
        'alias' => $alias,
        'context_key' => $modx->resource->context_key
    ]);

    if (!empty($result)) {
        // Важный момент. Сниппет кешируется. Но из кеша будет доставаться массив, а не объект. И в чанке нужно будет обращаться к значению, как к массиву, а не как к объекту. Из-за этого будет баг. Нужно привести к одному виду. Приводим к массиву
        $result = $result->toArray();
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
