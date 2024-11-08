<?php

/**
 * -------------------------
 * Обязательные переменные
 * 
 * $tpl - Элемент
 * $tplWrapper - Контейнер
 * 
 * -------------------------
 * Необязательные
 * 
 * $idTagsBlock - ID Блока тегов. 
 *                По нему будут выбраны кастомные теги. 
 *                Делается для разделения одного ТВ поля на несколько блоков
 *                Передается из MIGX поля. Править в конфигурациях MIGX - id_tags_block
 * 
 * $where - Условие для pdoResources
 */

if (!$tplWrapper || !$tpl) return;

$pdoTools = $modx->getService('pdoTools');

/**
 * Теги из ТВ поля categoryCustomTags
 */
$categoryCustomTags = $modx->resource->getTVValue('categoryCustomTags');
$custom_tags_out = '';
$resource_ids = []; // ID ресурсов собранных из TV поля
if (!empty($categoryCustomTags) && $categoryCustomTags != '[]') {
    $categoryCustomTags = json_decode($categoryCustomTags, true);

    foreach ($categoryCustomTags as $val) {
        $resource_ids[] = $val['resource_id'];

        if (($idTagsBlock && isset($val['id_tags_block']) && $val['id_tags_block'] !== $idTagsBlock)) continue;

        /**
         * selection - Выбранная категория из ресурсов
         * creation - Созданная вручную
         */
        if ($val['type'] == "selection") {
            $resource_fields = $val['resource_fields'];
            if (!$resource_fields) continue;
            $resource_fields = json_decode($resource_fields);

            $img = $resource_fields->img;
            $menutitle = $resource_fields->title;
            $uri = $resource_fields->uri;
        } elseif ($val['type'] == "creation") {
            $img = "/assets/".$val['img'];
            $menutitle = $val['title'];
            $uri = $val['uri'];
        }

        $custom_tags_out .= $pdoTools->getChunk($tpl, [
            'tv.mainImage' => $img,
            'menutitle' => $menutitle,
            'uri' => $uri
        ]);
    }
}

/**
 * Условие для вывода только тегов из TV поля
 * И если они были получены
 */
if ($onlyCustomTags && !empty($custom_tags_out))
    return $pdoTools->getChunk($tplWrapper, [
        'output' => $custom_tags_out
    ]);

/**
 * Теги по дочерним ресурсам
 */
$params = [
    'parents' => $modx->resource->id,
    'tpl' => $tpl,
    'templates' => 5,
    'includeTVs' => 'mainImage,tagName',
    'context' => $modx->resource->context_key,
    'sortby' => 'menuindex,id',
    'sortdir' => 'ASC',
    'limit' => 0,
    'depth' => 0,
];

if ($where) {
    $params['where'] = $where;
}

// Не получаем ресурсы которые уже выводятся через TV
if (!empty($resource_ids)) {
    $params['resources'] = '-' . implode(',-', $resource_ids);
}

// if (!empty($tagsIds)) {
//     $params['resources'] = implode(',', $tagsIds);
//     $params['sortby'] = 'FIELD(modResource.id, ' . $params['resources'] . ')';
//     $params['sortdir'] = '';
//     $params['templates'] = '';
//     $params['parents'] = 0;
// }

$children_tags = $modx->runSnippet('pdoResources', $params);

return $pdoTools->getChunk($tplWrapper, [
    'output' => $children_tags . $custom_tags_out
]);
