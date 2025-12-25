<?php
const MODULE_PATH = "modules/menu/uteplitel/"; // Путь к модулю
const MODULE_CHUNKS_PATH = MODULE_PATH . "chunks/"; // Путь к чанкам

$tplOuter = $modx->getOption("tplOuter", $scriptProperties, "tplMenuOuter.tpl");

$context = $modx->getOption("context", $scriptProperties, $modx->resource->context_key ?? "web");
$menuFilePath = $modx->getOption("menuFilePath", $scriptProperties, MODX_ASSETS_PATH . "template/json/menu/");

$fileMenu = $menuFilePath . $context . '.json';

// Проверка существования файла
if (!file_exists($fileMenu)) {
    return "Меню не найдено.";
}

$fileMenuData = file_get_contents($fileMenu);
$menuData = json_decode($fileMenuData, true);
$pdoTools = $modx->getService("pdoTools");
$output = $pdoTools->getChunk("@FILE " . MODULE_CHUNKS_PATH . $tplOuter, $menuData);

return $output;
