<?php
/*
Сортирует массив по значениям ключей, приводя их к целому числу, в указанном порядке
array $input - входной массив
mixed $key - ключ, по которому сортировать
string $dir - ASC - по возрастанию, DESC - по убыванию
*/

$input = $modx->getOption('input', $scriptProperties, false);
if(!$input)return;

$key = $modx->getOption('key', $scriptProperties, false);
if(!$key)return;
$dir = strtoupper($modx->getOption('key', $scriptProperties, 'ASC'));
$less = -1;
$more = 1;
if($dir == 'DESC'){
  $less = 1;
  $more = -1;
}

//$modx->log(xPDO::LOG_LEVEL_ERROR, 'before:');
//$modx->log(xPDO::LOG_LEVEL_ERROR, print_r($input, true));
uasort($input, function($a, $b)use($key, $modx, $less, $more){
  $new_a = intval(preg_replace("/[^0-9]/", "", $a[$key]));
  $new_b = intval(preg_replace("/[^0-9]/", "", $b[$key]));
  if($new_a < $new_b)return $less;
  else if($new_a > $new_b)return $more;
  return 0;
});

//$modx->log(xPDO::LOG_LEVEL_ERROR, 'after:');
//$modx->log(xPDO::LOG_LEVEL_ERROR, print_r($input, true));

return $input;