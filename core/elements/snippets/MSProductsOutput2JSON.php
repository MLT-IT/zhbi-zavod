<?php

$input = $modx->getOption('input', $scriptProperties, false);
if(!$input)return;

$input[strlen($input) - 2] = ' ';
$input = '['.$input.']';
return $input; 
