<?php

/**
 * Отдает подсказку по фильтру
 * 
 * @param string $filter_key - Ключ опции для получения подсказки
 * @param string $filter_value - Значение опции для получения подсказки
 */

static $data = null;
$path = MODX_BASE_PATH . '/assets/template/json/filters-tips.json';

if ($data === null && file_exists($path)) {
  $content = file_get_contents($path);
  $data = json_decode($content, true);
}

if ($data && isset($data[$filter_key][$filter_value])) {
  return $data[$filter_key][$filter_value];
}

return null;
