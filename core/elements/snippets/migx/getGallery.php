<?php
if (!function_exists('recurGallery')) {
  function recurGallery($id, $tvname)
  {
    global $modx;
    $res = $modx->getObject('modResource', $id);
    if ($res) {
      $gallery = $res->getTVValue($tvname);
      if (!$gallery && $res->parent > 0) {
        $gallery = recurGallery($res->parent);
      }
      return $gallery;
    }
    return false;
  }
}

// рекурсивно собирает все записи из галереи MIGX с полем 'img' - относительный путь
// $path - префикс по источнику файлов ТВ
// $tvname - идентификатор ТВ поля
// $id - айди ресурса галереи, необязательный

$path = $path ?: '/assets';
$tvname = $tvname ?: 'objectsGalleryMigx';
$id = $id ?: $modx->resource->id;

$galleryData = recurGallery($id, $tvname);
$images = array_map(function ($item) use ($path) {
  return $path . '/' . $item->img;
}, json_decode($galleryData));

return $images;
