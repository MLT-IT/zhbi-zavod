<?php
/*
  Убирает из пути часть del и все, что слева от нее.
  Возвращает правую часть пути.
  Возвращает input, если не удалось найти del в input.
*/
$input = $modx->getOption('input', $scriptProperties, false);
$del = $modx->getOption('del', $scriptProperties, 0);
//$modx->log(xPDO::LOG_LEVEL_ERROR, "Del: ".$del);
//$modx->log(xPDO::LOG_LEVEL_ERROR, "input: ".$input);
if(!$input)return;

$p = strpos($input, $del);
//$modx->log(xPDO::LOG_LEVEL_ERROR, "strpos: ".$p);
if($p === false)return $input;
$offset = $p + strlen($del);
$result = substr($input, $offset);
//$modx->log(xPDO::LOG_LEVEL_ERROR, "result: ".$result);
return $result;
