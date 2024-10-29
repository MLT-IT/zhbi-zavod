<?php

$tv_name = $tv_name ?: 'services_migx';
$id = $id ?: $modx->resource->id;

$pdoTools = $modx->getService('pdoTools');

if($buttonsData = recurServices($id)){
  $buttons = array_map(function($item) use ($path, $pdoTools) {
    return $pdoTools->getChunk("@FILE chunks/product/services-button.tpl", ['item' => $item]);
  }, json_decode($buttonsData));
  return implode('',$buttons);
}

// recursive function definition, searches for TV value up to 0
function recurServices($id){
  global $modx, $tv_name;
  $res = $modx->getObject('modResource', $id);
  if($res) {
    $gallery = $res->getTVValue('services_migx');
    if(!$gallery && $res->parent > 0){
      $gallery = recurServices($res->parent);
    }
    return $gallery;
  }
  return false;
}
