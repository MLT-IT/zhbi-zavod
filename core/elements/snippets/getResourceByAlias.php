<?php

if (empty($alias)) {
    return;
}

$alias = trim($alias);

return $modx->getObject('modResource', [
    'alias' => $alias,
    'context_key' => $modx->resource->context_key
]);
