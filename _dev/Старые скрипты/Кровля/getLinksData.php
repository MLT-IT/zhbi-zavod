<?php

/**
 * Это старая версия скрипта, когда в списках должны были выводиться ТОЛЬКО СООТВЕТСТВУЮЩИЕ выбору опции (по порядку: цвет, покрытие, толщина).
 * Он уже не нужен, но я решил сохранить его на всякий случай - вдруг понадобится вернуть прошлую логику.
 * Если в течение долгого времени не понадобится, то можно его удалить.
 */

// Основные переменные
$result = [
    'cvet' => [],
    'pokrytie' => [],
    'item_thickness' => [],
];
$parentId = $modx->resource->parent;

// Определение функций
if (!function_exists('compareOptionFilters')) {
    function compareOptionFilters($options) {
        global $modx;

        $optionValues = [];

        foreach ($options as $opt) {
            $val = $modx->resource->get($opt);

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

// Получаем id для цветов. Это все товары в текущей категории
$idsForColors = $modx->runSnippet('pdoResources', [
    'parents' => $parentId,
    'depth' => 100,
    'limit' => 0,
    'returnIds' => 1,
    'resources' => '-' . $modx->resource->id
]);

// Получаем id для покрытия. Это все товары в текущей категории с текущим цветом
$idsForPokrytie = $modx->runSnippet('msProducts', [
    'parents' => $parentId,
    'depth' => 100,
    'limit' => 0,
    'tpl' => '@INLINE: [[+id]],',
    'resources' => '-' . $modx->resource->id,
    'optionFilters' => compareOptionFilters(['cvet'])
]);

// Получаем id для толщины. Это все товары в текущей категории с текущим цветом и текущим покрытием
$idsForThickness = $modx->runSnippet('msProducts', [
    'parents' => $parentId,
    'depth' => 100,
    'limit' => 0,
    'tpl' => '@INLINE: [[+id]],',
    'resources' => '-' . $modx->resource->id,
    'optionFilters' => compareOptionFilters(['cvet', 'pokrytie'])
]);

$idsForPokrytie = handleIds($idsForPokrytie);
$idsForThickness = handleIds($idsForThickness);
$idsForColors = explode(',', $idsForColors);

$ids = [
    'pokrytie' => $idsForPokrytie,
    'item_thickness' => $idsForThickness,
    'cvet' => $idsForColors
];

// Результат
foreach ($ids as $key => $data) {
    foreach ($data as $id) {
        $prod = $modx->getObject('msProduct', $id);

        if (!empty($prod->get('cvet')[0])) {
            $result[$key][$prod->get('id')] = $prod->get($key)[0];
        }
    }
}

// Оставляем только уникальные. Если всего 1 уникальный, то делаем массив пустым
foreach ([/*'item_thickness',*/ 'pokrytie', 'cvet'] as $key) {
    $result[$key] = array_unique($result[$key]);

    //if (count($result[$key]) === 1) {
    //    $result[$key] = [];
    //}
}

// Разбиваем cvet на два массива
$result['cvet'] = array_chunk($result['cvet'], ceil(count($result['cvet']) / 2), true);

return $result;
