<?php

/**
 * Список товаров той же категории (родителя) с ценой и ключевыми
 * характеристиками — для вкладки "Прайс" на карточке товара.
 */

$resource = $modx->resource;
$parentId = (int) $resource->get('parent');
if (!$parentId) return [];

$dimensionKeys = ['dlina-mm', 'shirina-mm', 'vysota-mm', 'tolshchina-sm'];
$dimensionLabels = [
    'dlina-mm' => 'Длина, мм',
    'shirina-mm' => 'Ширина, мм',
    'vysota-mm' => 'Высота, мм',
    'tolshchina-sm' => 'Толщина, см',
];

$products = $modx->getCollection('msProduct', [
    'parent' => $parentId,
    'context_key' => $modx->context->key,
    'published' => 1,
    'deleted' => 0,
]);

$output = [];
foreach ($products as $product) {
    $characteristics = [];
    foreach ($dimensionKeys as $key) {
        $value = $product->get($key);
        if (is_array($value)) {
            $value = reset($value);
        }
        if ($value !== null && $value !== false && $value !== '') {
            $characteristics[] = ['label' => $dimensionLabels[$key], 'value' => $value];
        }
    }

    $markirovka = $product->get('markirovka');
    if (is_array($markirovka)) {
        $markirovka = reset($markirovka);
    }

    $output[] = [
        'id' => $product->get('id'),
        'name' => $product->get('pagetitle'),
        'url' => $modx->makeUrl($product->get('id')),
        'markirovka' => $markirovka,
        'characteristics' => $characteristics,
        'price' => $product->get('price'),
        'current' => $product->get('id') == $resource->get('id'),
    ];
}

return $output;
