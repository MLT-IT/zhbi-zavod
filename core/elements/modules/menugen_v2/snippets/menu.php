<?php

//шаблон
$tpl = $modx->getOption("tpl", $scriptProperties, "menu.tpl");
// контекст
$context = $modx->getOption("context", $scriptProperties, $modx->resource->context_key?? "web");
//тип меню
$typeMenu = $modx->getOption("type", $scriptProperties, "default");
//папка хранения меню
$menuFilePath = $modx->getOption("path", $scriptProperties, MODX_ASSETS_PATH . "template/json/menu/");


$fileMenu = $menuFilePath . $context . "/$typeMenu.json";
if(!file_exists($fileMenu)){
    $modx->log(modX::LOG_LEVEL_ERROR, "Файл меню $fileMenu не найден");
    return;
}


$fileMenuData = file_get_contents($fileMenu);
$menuData = json_decode($fileMenuData, true);

$pdoTools = $modx->getService("pdoTools");
$output = $pdoTools->getChunk($tpl, ["data" => $menuData]);

return $output;





