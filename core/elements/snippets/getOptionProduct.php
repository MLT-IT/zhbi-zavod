<?php

$idResource = $modx->resource->get('id');

$option = $modx->getObject("msProductOption", ['product_id' => $idResource, "key" => $key]);

if($option)
{
    return $option->get('value');
}else{
    return null;
}
