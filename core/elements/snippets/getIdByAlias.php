<?php

if (empty($alias)) {
    return;
}

$obj = $modx->getObject('modResource', [
    'alias' => $alias,
    'context_key' => $modx->resource->context_key
]);

if (empty($obj)) {
    return;
}

return $obj->id;
