<?php

$name = $modx->getOption('name', $scriptProperties, false);
if(!$name)return;
return $modx->resource->get($name);
