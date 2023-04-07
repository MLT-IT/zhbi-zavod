<?php

$cacheName = 'getCategoriesWithMinPrice';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    // Шаг 1 - получаем поля категорий (JSON)
    $params = [
        'parents' => 0,
        'depth' => 50,
        'limit' => 500,
        //'sortby' => '',
        //'sortdir' => '',
        'tplWrapper' => '@INLINE { [[+output]] }',
        'where' => '{"template:=": "5"}',
        'includeTVs' => 'mainImage',
        'context' => $modx->resource->context_key,
        'resources' => '-4', // Исключаем каталог
        'tpl' => '@FILE chunks/categoryWithMinPriceJson.tpl',
    ];
    $json = $modx->runSnippet('pdoResources', $params);
    $json = str_replace('}, }', '} }', $json);
    $data = json_decode($json, 1);
    $ids = array_keys($data);

    // Шаг 2 - получаем минимальную цену для каждой категории
    $query = '
        SELECT parent, MIN(price) as minprice
        FROM modx_site_content AS resources
        INNER JOIN modx_ms2_products AS products ON products.id = resources.id
        WHERE parent IN (' . implode(',', $ids) . ')
        GROUP BY parent
    ';
    $vals = $modx->query($query);
    $vals = $vals->fetchAll(PDO::FETCH_ASSOC);

    // Шаг 3 - добавляем минимальные цены в массив с полями категорий
    foreach ($vals as $val) {
        $data[$val['parent']]['minprice'] = $val['minprice'];
    }

    // Шаг 4 - убираем категории без товаров (у которых нет minprice)
    $result = array_filter($data, function($v) {
        return count($v) == 4;
    });

    // Шаг 5 - сохраняем данные в кеш
    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

// Оборачиваем данные в чанк
$pdo = $modx->getService('pdoTools');
$result = array_map(function($v) use ($pdo) {
    return $pdo->getChunk('@FILE sections/popular/pop-slide.tpl', $v);
}, $result);

return implode('', $result);
