<?php
$cacheFolder = 'getTags';
$cacheName = $modx->resource->id;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/' . $modx->resource->context_key . '/',
];
$itemTemplateFile = '@FILE chunks/create-menu/tags-item.tpl';
$itemsTemplateInline = '@INLINE <div class="catalog-screen__products"><ul class="catalog-screen__items">[[+output]]<li class="catalog-screen__tag catalog-screen__tag_type_more"></li></ul></div>';

//if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
// -------------------------------
// Пробуем получить теги из TV categoryCustomTags
// -------------------------------
$categoryCustomTags = $modx->resource->getTVValue('categoryCustomTags');
if (!empty($categoryCustomTags) && $categoryCustomTags != '[]') {
    // Нужно для получения доступа к файловым сниппетам и чанкам
    $pdoTools = $modx->getService('pdoTools');

    $output = '';
    $categoryCustomTags = json_decode($categoryCustomTags, true);

    foreach ($categoryCustomTags as $val) {
        switch ($val['type']) {
            case 'selection':
                // TODO: вместо получения modResource для каждой итерации лучше написать 1 SQL запрос для всех итераций. Работать будет ГОРАЗДО быстрее.
                $resource = $modx->getObject('modResource', $val['resource_id']);

                // $title есть в MIGX, можно взять оттуда. Но тогда если он обновится у ресурса, то надо будет обновить его и в MIGX поле (пересохранить), а это неудобно.
                $title = $resource->getTVValue('tagName');
                if (empty($title)) {
                    $title = $resource->menutitle;
                }
                $uri = $resource->uri;
                $img = $resource->getTVValue('mainImage');
                break;
            case 'creation':
                $title = $val['hidden_title'];
                $uri = $val['uri'];
                $img = '/' . $val['img'];
                break;
        }

        $output .= $pdoTools->getChunk("$itemTemplateFile", [
            'tv.mainImage' => $img,
            'menutitle' => $title,
            'uri' => $uri
        ]);
    }

    $result = $pdoTools->getChunk("$itemsTemplateInline", [
        'output' => $output,
    ]);
    //$modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

// -------------------------------
// Не удалось получить теги из TV categoryCustomTags. Получаем теги по дочерним категориям или по специально определенному набору
// -------------------------------
else {
    // Параметры для вызова сниппета, вывод которого будет в return
    $params = [
        'parents' => $modx->resource->id,
        'tpl' => "$itemTemplateFile",
        'templates' => '5',
        'includeTVs' => 'mainImage,tagName',
        'context' => $modx->resource->context_key,
        'sortby' => 'menuindex,id',
        'sortdir' => 'ASC',
        'limit' => 0,
        'depth' => 0,
        'tplWrapper' => "$itemsTemplateInline"
    ];

    if (!empty($tagsIds)) {
        $params['resources'] = implode(',', $tagsIds);
    }

    // Результат
    if (!empty($params['resources'])) {
        $params['sortby'] = 'FIELD(modResource.id, ' . $params['resources'] . ')';
        $params['sortdir'] = '';
        $params['templates'] = '';
        $params['parents'] = 0;
    }

    $result = $modx->runSnippet('pdoResources', $params);
    //$modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}
//}


return $result;
