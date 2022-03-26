<?php

/**
 * Запускается в console.
 * Все настройки в самому верху. Ниже ничего менять не нужно.
 */

// ------------------------------------
// Настройка скрипта
// ------------------------------------
$resourceId = 12149;
$options = [
    'cvet',
    'pokrytie',
    'item_thickness'
];


// ------------------------------------
// Определение функций
// ------------------------------------
if (!function_exists('composeOptionFilters')) {
    function composeOptionFilters($options, $resource) {
        $optionValues = [];

        foreach ($options as $opt) {
            $val = $resource->get($opt);

            if (is_null($val)) {
                $optionValues[$opt . ':IS'] = null;
            } else {
                if (is_array($val)) {
                    if (count($val) === 1) {
                        $optionValues[$opt . ':='] = reset($val);
                    }
                }
            }
        }

        return json_encode($optionValues, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }
}

if (!function_exists('handleIds')) {
    function handleIds($ids) {
        $ids = explode(',', $ids);

        // Удаляем пробелы и переносы строк
        $ids = array_map(function ($item) {
            return trim($item);
        }, $ids);

        // Удаляем пустые элементы
        $ids = array_filter($ids);

        return $ids;
    }
}


// ------------------------------------
// Работа скрипта
// ------------------------------------
$resource = $modx->getObject('msProduct', $resourceId);
$parentId = $resource->parent;
$ids = $modx->runSnippet('msProducts', [
    'parents' => $parentId,
    'depth' => 100,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'tpl' => '@INLINE: [[+id]],',
    'resources' => '-' . $resource->id,
    'optionFilters' => composeOptionFilters($options, $resource)
]);

$ids = handleIds($ids);

$strings = [
    'current - cvet = ' . $resource->get('cvet')[0] . ', pokrytie = ' . $resource->get('pokrytie')[0] . ', толщина = ' . $resource->get('item_thickness')[0]
];
foreach ($ids as $id) {
    $product = $modx->getObject('msProduct', $id);
    $strings[] = $product->get('id') . ' - cvet = ' . $product->get('cvet')[0] . ', pokrytie = ' . $product->get('pokrytie')[0] . ', толщина = ' . $product->get('item_thickness')[0];
}

echo implode('<br>', $strings);
