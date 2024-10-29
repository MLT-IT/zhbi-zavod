<?php

$path = $path ?: '';
$tv_name = $tv_name ?: 'user_gallery_migx';
$id = $id ?: $modx->resource->id;

if($galleryData = recurGallery($id)){
  $images = array_map(function($item) use ($path) {
    return $path.'/'.$item->image;
  }, json_decode($galleryData));
  return $images;
}

// recursive function definition, searches for TV value up to 0
function recurGallery($id){
  global $modx, $tv_name;
  $res = $modx->getObject('modResource', $id);
  if($res) {
    $gallery = $res->getTVValue('user_gallery_migx');
    if(!$gallery && $res->parent > 0){
      $gallery = recurGallery($res->parent);
    }
    return $gallery;
  }
  return false;
}
