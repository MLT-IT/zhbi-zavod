<?php
$s = $modx->getOption('input', $scriptProperties, false);
if(!$s)return false;

return str_replace(' ', '%20', $s);