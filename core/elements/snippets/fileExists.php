<?php

$input = $modx->getOption('input', $scriptProperties, '');
//echo MODX_BASE_PATH.$input;
return file_exists(MODX_BASE_PATH.$input) && (filetype(MODX_BASE_PATH.$input) == 'file');