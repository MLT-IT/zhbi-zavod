<?php
/*
Первые 3 названия складов (без префикса "Склад ") из того же файла,
что использует карта в _src-vite/js/modules/districts_map.js:
склады поддомена региона приоритетнее складов контекста.
*/
$ctx = $modx->resource->get('context_key');
$localdata = $modx->getPlaceholder('localdata');
$region = $localdata['region'] ?? null;

$useRegionStores = $region && $ctx != 'gazoclone' && !($region == 'moscow' && $ctx != 'gazosilikatstroy');

$path = null;
if ($useRegionStores) {
    $candidate = MODX_ASSETS_PATH . "template/json/district_stores/{$region}.json";
    if (file_exists($candidate)) $path = $candidate;
}
if (!$path) {
    $candidate = MODX_ASSETS_PATH . "template/json/location/toponims/{$ctx}/district_stores.json";
    if (file_exists($candidate)) $path = $candidate;
}

if (!$path) return [];

$json = json_decode(file_get_contents($path), true);
if (empty($json['warehouses'])) return [];

$output = [];
foreach (array_slice($json['warehouses'], 0, 3) as $warehouse) {
    $output[] = preg_replace('/^Склад\s+/u', '', $warehouse['name'] ?? '');
}

return $output;
