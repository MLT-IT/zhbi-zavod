<?php
/*
  id уходит в сниппет random.php для генерации остатка для конкретного товара
  зпукается со страницы склада. В id уйдет id товара + id склада
*/
$range_remains = $modx->getOption('range', $scriptProperties, "50-300");
$id = $modx->getOption('id', $scriptProperties, 0).$modx->resource->get('id');
$range_remains = explode("-", $range_remains);
$begin = (int)$range_remains[0];
$end = (int)$range_remains[1];
$remains = include MODX_CORE_PATH . "elements/snippets/random.php";
return $remains;