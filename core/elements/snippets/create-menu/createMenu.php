<?php

$context = $modx->resource->get('context_key');

$cacheName = 'createMenu';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    require_once MODX_CORE_PATH . 'elements/snippets/create-menu/data/' . $context . '.php';
    $result = getMenuData();

    switch ($context) {
        // alterteplo.ru
        case 'web':
            $resources = '93190,93191,93189,93185,93188,93192,93187,93186';
            break;

        // gazosilikatstroy.ru
        case 'gazosilikatstroy':
            $resources = '101938,101936,101934,101932,101937,101929,101930,101933,101935,101931';
            break;
    }

    $params = [
        'resources' => $resources,
        'parents' => '0',
        'sortby' => 'FIELD(modResource.id, ' . $resources . ')',
        'sortdir' => 'ASC'
    ];

    $params = array_merge([
        'depth' => 0,
        'limit' => 0,
        'tpl' => '@FILE chunks/create-menu/category-item-json.tpl',
        'tplWrapper' => '@INLINE {[[+output]]}',
        'where' => '{"template:=":"5"}',
        'includeTVs' => 'mainImage'
    ], $params);

    // Формируем массив
    // Столбец 1, это категории самого верхнего уровня
    $json = $modx->runSnippet('pdoResources', $params);
    $json = str_replace([',}'], [' }'], $json);
    $array = json_decode($json, 1);
    foreach ($array as $catId => $catVals) {
        $result[$catId]['column1'] = $catVals;
    }

    $result = [
        'values' => $result
    ];

    switch ($context) {
        case 'web':
            $result['column1'] = ['title' => 'Товар', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Продуктовая линейка', 'type' => 'composite'];
            $result['column3'] = ['title' => 'Толщина', 'type' => 'simple'];
            $result['column4'] = ['title' => 'Применение', 'type' => 'composite'];
            break;
        case 'gazosilikatstroy':
            $result['column1'] = ['title' => 'Товар', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Плотность', 'type' => 'simple'];
            $result['column3'] = ['title' => 'Размеры', 'type' => 'composite'];
            break;
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
