<?php
/*
Первые 3 названия складов (без префикса "Склад ") из того же файла,
что использует карта в base.tpl / map-create.js:
assets/template/json/address-map/warehouses/{region}.json, регион по умолчанию — spb.
*/
$region = $modx->getPlaceholder('virtual-router')['region']['key'] ?? 'spb';

$path = MODX_ASSETS_PATH . "template/json/address-map/warehouses/{$region}.json";
if (!file_exists($path)) return [];

$json = json_decode(file_get_contents($path), true);
if (empty($json['warehouses'])) return [];

$output = [];
foreach (array_slice($json['warehouses'], 0, 3) as $warehouse) {
    $output[] = preg_replace('/^Склад\s+/u', '', $warehouse['name'] ?? '');
}

return $output;
