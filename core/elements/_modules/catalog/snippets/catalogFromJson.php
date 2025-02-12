<?php
$responce = [];

$ctx = $modx->context->key;
$path = MODX_CORE_PATH.'elements/modules/catalog/v1/data/'.$ctx.'.json';

$responce['categories'] = null;
$responce['data_file_founded']=false;
$responce['path'] = $path;


if(file_exists($path)){
    $json = file_get_contents($path);
    $responce['data_file_founded']=true;
    $responce['categories'] = json_decode($json, true);
    
}
//print_r($responce);
return $responce;
