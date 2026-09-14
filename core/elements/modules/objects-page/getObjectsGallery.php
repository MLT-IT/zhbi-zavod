<?php

$objects = json_decode($modx->resource->getTVValue('objects_migx'));
$result = ['raw' => $objects];
foreach ($objects as &$object){
  $object->products = explode(',',str_replace(' ','', $object->products));
  $result['group'][$object->type][] = $object;
}

return $result;
