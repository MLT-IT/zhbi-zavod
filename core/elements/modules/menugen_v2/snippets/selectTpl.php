<?php

$ctx = $modx->resource->context_key;
$type = $modx->getOption('type', $scriptProperties, 'catalog');
//Пример вывода: @FILE modules/menugen_v2/chunks/fibrofasad/menu_catalog.tpl
return "@FILE modules/menugen_v2/chunks/$ctx/menu_$type.tpl";
