<?
$responce = [];

$ctx = $modx->context->key;
$path = MODX_CORE_PATH.'elements/snippets/context_config/data/'.$ctx.'.json';
$path_default = MODX_CORE_PATH.'elements/snippets/context_config/data/default.json';


if(file_exists($path_default)){
    $json = file_get_contents($path_default);
    $responce = json_decode($json, true);
}
if(file_exists($path)){
    $json = file_get_contents($path);
    $responce = json_decode($json, true);
}

$modx->setPlaceholder('context_config',$responce);