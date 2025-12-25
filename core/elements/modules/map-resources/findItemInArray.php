<?php

/**
 * Скрипт отдает найденный элемент в многомерном массиве по ключу
 * $data - Массив с данными
 * $field_key - Поле для поиска
 * $field_value - Искмое значение
 */

if (!isset($data) || !isset($field_key) || !isset($field_value)) return;

if (!function_exists('xxx')) {
    function xxx($items, $field_key, $field_value)
    {
        foreach ($items as $item) {
            if (array_key_exists($field_key,  $item) && $item[$field_key] == $field_value) {
                return $item;
            }

            if (!empty($item['children'])) {
                $item['children'] = xxx($item['children'], $field_key, $field_value);
            }
        }
    }
}

$find_item = xxx($data, $field_key, $field_value);

return $find_item;
