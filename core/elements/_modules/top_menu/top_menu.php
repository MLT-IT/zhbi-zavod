<?php

$ctx = $modx->context->key;
//$ctx = 'trotuarnaya-plitka';
$data = [];
$path = MODX_CORE_PATH."elements/_modules/top_menu/contexts/".$ctx.".php";
$default = MODX_CORE_PATH."elements/_modules/top_menu/contexts/default.php";
if(file_exists($path)){
  $data = include $path;
}else{
  $data = require $default;
}
return $data;