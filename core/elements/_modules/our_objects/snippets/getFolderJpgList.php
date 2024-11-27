<?php

if(empty($file_suffix)) return; // or it will return all files

$folder = $folder ?: '/assets/images/show-room'; // default is show-room
$path = $_SERVER['DOCUMENT_ROOT'].$folder;


$files = scandir($path);
$res_list = [];
foreach($files as $file) {
    if($file == '.' || $file == '..') continue;
    if(strstr($file, $file_suffix) && strstr($file, '.jpg')) {
      $res_list[] = $file;
    }
}

return $res_list;
