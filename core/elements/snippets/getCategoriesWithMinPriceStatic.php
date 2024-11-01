<?php
$pdoTools = $modx->getService('pdoTools');
if (empty($pdoTools)) return;

/**
 * Ключ - ID ресурса, по ним будут найдены ресы для получения других полей
 */
switch ($modx->context->key) {
    case "trotuarnaya-plitka":
        $items = [
            250504 => [
                "minprice" => "540",
            ],
            250506 => [
                // "pagetitle" => "Тротуарная плитка",
                "minprice" => "360",
            ],
            250505 => [
                "minprice" => "1040",
            ],
            255074 => [
                "minprice" => "1300",
            ],
            255075 => [
                "minprice" => "1800",
            ],
            254702 => [
                "pagetitle" => "Фасадная плитка",
                "minprice" => "1340",
            ],
            254426 => [
                "minprice" => "180",
                "custom_unit" => "Стоимость за шт"
            ],
            250509 => [
                "minprice" => "100",
                "custom_unit" => "Стоимость за шт"
            ],
            250512 => [
                "minprice" => "190",
                "custom_unit" => "Стоимость за шт"
            ],
            250510 => [
                "minprice" => "410",
                "custom_unit" => "Стоимость за шт"
            ],
            250515 => [
                "minprice" => "79",
                "custom_unit" => "Стоимость за шт"
            ],
            250518 => [
                "minprice" => "390",
                "custom_unit" => "Стоимость за уп"
            ],
        ];
        break;
    default:
        return;
}

$resource_ids = array_keys($items);
$query = $modx->newQuery('modResource', [
    "id:in" => $resource_ids
]);
$query->sortby('FIELD(modResource.id, ' . implode(',', $resource_ids) . ')');
$resources = $modx->getCollection('modResource', $query);

foreach ($resources as $resource) {
    $data = [
        "name" => $items[$resource->id]['pagetitle'] ?? $resource->pagetitle,
        "minprice" => $items[$resource->id]['minprice'],
        "custom_unit" => $items[$resource->id]['custom_unit'],
        "img" => $resource->getTVValue('mainImage'),
        "uri" => $resource->uri
    ];
    echo $pdoTools->getChunk('@FILE sections/pop-slide.tpl', $data);
}
