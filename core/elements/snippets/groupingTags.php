<?php

/**
 * Сниппет по TV полю groupingTags отдает на страницу сгруппированные теги
 * $tplItem - Шаблон тега
 * $tplFirstItems - Шаблон с предварительными тегами
 * $tplItems - Шаблон с дочерними ресурсами
 * $tplOuter - Контейнер
 */

if (!$pdoTools = $modx->getService('pdoTools')) return;

$TV_TAGS_NAME = "groupingTags"; // TV migx с данными по тегам
$TV_IMAGE_ID = 5; // TV картинки категории (тега)
$TABLE_PREFIX = $modx->getOption('table_prefix');

$selections = json_decode($modx->resource->getTVValue($TV_TAGS_NAME), true);

/**
 * 1. Собираем все категории которые встретились в TV и одним запросом получаем по ним данные
 * Нам необхдимы uri|pagetitle|menutitle|image по всем категориям
 */
$category_ids = [];
foreach ($selections as $selection) {
    $links = json_decode($selection['links'], true);

    foreach ($links as $link) {
        if (empty($link['category_id'])) continue;
        $category_ids[] = $link['category_id'];
    }
}
if (empty($category_ids)) return false;

$sql = "SELECT sc.id,sc.pagetitle,sc.menutitle,sc.uri,tv.value as `image` FROM {$TABLE_PREFIX}site_content AS sc LEFT JOIN {$TABLE_PREFIX}site_tmplvar_contentvalues AS tv ON tv.contentid = sc.id AND tv.tmplvarid = $TV_IMAGE_ID WHERE sc.id IN (" . implode(',', $category_ids) . ")";
$result = $modx->query($sql);
$rows = $result->fetchAll(PDO::FETCH_ASSOC);
if (empty($rows)) return false;

/**
 * 2. Формируем удобный массив для получения категории по ID
 */
$categories = [];
foreach ($rows as $row) {
    $categories[$row['id']] = $row;
}

/**
 * Результат
 */
$output = "";

// Предварительный результат
$first = [
    "output" => "",
    "items" => [],
    "limit" => 9
];

foreach ($selections as $selection) {
    $links = json_decode($selection['links'], true);

    $items = "";
    foreach ($links as $link) {
        if (empty($link['category_id']))  continue;

        $category = $categories[(int)$link['category_id']];
        $category['name'] = $link['name'];

        $item = $pdoTools->getChunk($tplItem, $category);
        $items .= $item;

        if ($first["limit"] >= count($first["items"])) $first["items"][] = $item;
    }

    $output .= $pdoTools->getChunk($tplItems, [
        'group_title' => $selection['name'],
        'items' => $items
    ]);
}

$first["output"] = $pdoTools->getChunk($tplFirstItems, [
    'items' => implode('', $first["items"])
]);

return $pdoTools->getChunk($tplOuter, [
    'output_first' => $first["output"],
    'output' => $output
]);
