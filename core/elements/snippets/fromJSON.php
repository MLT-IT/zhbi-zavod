<?php

/*
Путь относительно assets/template/json
*/
//echo 'here!';
//$modx->log(xPDO::LOG_LEVEL_ERROR, 'Это сообщение об ошибке');
$input = $modx->getOption('input', $scriptProperties, false);
if(!$input)return;

$data = file_get_contents(MODX_ASSETS_PATH."template/json/".$input);
//echo $data;
return json_decode($data, true);