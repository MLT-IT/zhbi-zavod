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
    case 'web':
        $items = [
            93190 => ["minprice" =>  "999", "custom_unit" =>  "Стоимость за уп."],
            93191 => ["minprice" =>  "1050", "custom_unit" => "Стоимость за уп."],
            93189 => ["minprice" =>  "105", "custom_unit" =>  "Стоимость за лист"],
            93185 => ["minprice" =>  "1490", "custom_unit" => "Стоимость за уп."],
            93188 => ["minprice" =>  "2100", "custom_unit" => "Стоимость за уп."],
            93192 => ["minprice" =>  "989", "custom_unit" =>  "Стоимость за уп."],
            93187 => ["minprice" =>  "995", "custom_unit" =>  "Стоимость за уп."],
            93186 => ["minprice" =>  "995", "custom_unit" =>  "Стоимость за уп."],
            124718 => ["minprice" => "2000", "custom_unit" => "Стоимость за уп."],
            167261 => ["minprice" => "980", "custom_unit" =>  "Стоимость за уп."],
            167260 => ["minprice" => "1005", "custom_unit" => "Стоимость за уп."],
            167262 => ["minprice" => "990", "custom_unit" =>  "Стоимость за уп."],
            167263 => ["minprice" => "1100", "custom_unit" => "Стоимость за уп."],
            167265 => ["minprice" => "1205", "custom_unit" => "Стоимость за уп."],
            167264 => ["minprice" => "1290", "custom_unit" => "Стоимость за уп."],
            167266 => ["minprice" => "1300", "custom_unit" => "Стоимость за уп."],
            167718 => ["minprice" => "1500", "custom_unit" => "Стоимость за уп."],
            167657 => ["minprice" => "1780", "custom_unit" => "Стоимость за уп."],
            167836 => ["minprice" => "1490", "custom_unit" => "Стоимость за уп."],
            167217 => ["minprice" => "1600", "custom_unit" => "Стоимость за уп."],
            168218 => ["minprice" => "1370", "custom_unit" => "Стоимость за уп."],
            168256 => ["minprice" => "1500", "custom_unit" => "Стоимость за уп."],
            168257 => ["minprice" => "1270", "custom_unit" => "Стоимость за уп."],
            168258 => ["minprice" => "1600", "custom_unit" => "Стоимость за уп."],
            175241 => ["minprice" => "1200", "custom_unit" => "Стоимость за уп."],
        ];
        break;
    case 'gbi-zavod78':
        $items = [
            256065 => ["minprice" =>  "6000", "custom_unit" =>  "Стоимость за шт."],
            256066 => ["minprice" =>  "15000", "custom_unit" =>  "Стоимость за шт."],
            256237 => ["minprice" =>  "3200", "custom_unit" =>  "Стоимость за шт."],
            256238 => ["minprice" =>  "3400", "custom_unit" =>  "Стоимость за шт."],
            255998 => ["minprice" =>  "1200", "custom_unit" =>  "Стоимость за шт."],
            255999 => ["minprice" =>  "18000", "custom_unit" =>  "Стоимость за шт."],
            256002 => ["minprice" =>  "1020", "custom_unit" =>  "Стоимость за шт."],
            256003 => ["minprice" =>  "2200", "custom_unit" =>  "Стоимость за шт."],
            256005 => ["minprice" =>  "1010", "custom_unit" =>  "Стоимость за шт."],
            255876 => ["minprice" =>  "9900", "custom_unit" =>  "Стоимость за шт."],
            255842 => ["minprice" =>  "200", "custom_unit" =>  "Стоимость за шт."],
            255840 => ["minprice" =>  "350", "custom_unit" =>  "Стоимость за шт."],
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
    echo $pdoTools->getChunk('@FILE sections/pop-slide/wrapper.tpl', $data);
}
