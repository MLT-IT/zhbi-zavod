<?php
$cacheFolder = 'getRelinkingTags';
$cacheName = $modx->resource->id;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/' . $modx->resource->context_key . '/',
];
if (empty($tpl)) {
    $tpl = "@FILE chunks/selectionFiltersExpanded/selectionsItem.tpl";
}

if (empty($limit)) {
    $limit = 0;
}



// if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    // -------------------------------
    // Пробуем получить теги из TV categoryCustomTags
    // -------------------------------
    $categoryCustomTags = $modx->resource->getTVValue('categoryCustomTags');
    if (!empty($categoryCustomTags) && $categoryCustomTags != '[]') {
        // Нужно для получения доступа к файловым сниппетам и чанкам
        $pdoTools = $modx->getService('pdoTools');

        $output = '';
        $categoryCustomTags = json_decode($categoryCustomTags, true);
        $count = 1;
        foreach ($categoryCustomTags as $val) {
            if ($val['id_tags_block'] !== $idTagsBlock) continue;
            switch ($val['type']) {
                case 'selection':
                    // TODO: вместо получения modResource для каждой итерации лучше написать 1 SQL запрос для всех итераций. Работать будет ГОРАЗДО быстрее.
                    $resource = $modx->getObject('modResource', $val['resource_id']);

                    // $title есть в MIGX, можно взять оттуда. Но тогда если он обновится у ресурса, то надо будет обновить его и в MIGX поле (пересохранить), а это неудобно.
                    $title = $resource->menutitle;
                    $uri = "/" . $resource->uri;
                    $img = $resource->getTVValue('mainImage');
                    break;
                case 'creation':
                    $title = $val['hidden_title'];
                    $uri = $val['uri'];
                    $img = '/' . $val['img'];
                    break;
            }

            $output .= $pdoTools->getChunk($tpl, [
                'mainImage' => $img,
                'menutitle' => $title,
                'uri' => $uri
            ]);

            if ($count == $limit) {
                break;
            }
            $count++;
        }

        $result = $pdoTools->getChunk($tplWrapper, [
            'output' => $output,
        ]);
    }

    // -------------------------------
    // Не удалось получить теги из TV categoryCustomTags. Получаем теги по дочерним категориям или по специально определенному набору
    // -------------------------------
    else {
        // Параметры для вызова сниппета, вывод которого будет в return
        $params = [
            'parents' => $modx->resource->id,
            'tpl' => $tpl,
            'tplWrapper' => $tplWrapper,
            'includeTVs' => 'mainImage',
            'tvPrefix' => '',
            'sortby' => 'menuindex,id',
            'sortdir' => 'ASC',
            'limit' => $limit,
            'depth' => 0,
            'select' => 'id,menutitle,uri'
        ];

        if ($where) {
            $params['where'] = $where;
        }


        // Спрятать ненужные теги на арматуре
        // if ($modx->resource->context_key == 'armatura-178') {
        //     $params['where'] = '{"hidemenu:=": 0}';
        // }

        // Результат
        if (!empty($params['resources'])) {
            $params['sortby'] = 'FIELD(modResource.id, ' . $params['resources'] . ')';
            $params['sortdir'] = '';
        }

        $result = $modx->runSnippet('pdoResources', $params);
    }
//     $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
// }


return $result;
