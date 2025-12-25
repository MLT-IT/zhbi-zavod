<?php

if (!$pdoTools = $modx->getService('pdoTools')) return;

// Получили данные
$data_path = MODX_CORE_PATH . "elements/modules/slider-categories/data/" . $modx->context->key . "/data.json";
if (!file_exists($data_path)) return;

$data = file_get_contents($data_path);
$data = json_decode($data, true);

// Получаем необходимы категории из карты ресурсов
$categories = $pdoTools->runSnippet("@FILE modules/map-resources/mapSeparateResources.php", [
    'data' => $modx->getPlaceholder('map-resources.category'),
    'ids' => array_keys($data)
]);

$output = [];
foreach ($categories as $category) {
    $category_data = $data[$category['id']];
    $output[] = [
        'menutitle' => $category['menutitle'],
        'uri' => $category['uri'],
        'main_image' => $category['main_image'],
        'price' => $category_data['price'],
        'unit' => $category_data['unit'],
    ];
}

return $output;
