<?php

if (empty($alias)) {
    return;
}

$result = [];

$alias = explode(',', $alias);

foreach ($alias as $al) {
    $al = trim($al);
    $obj = $modx->getObject('modResource', [
        'alias' => $al,
        'context_key' => $modx->resource->context_key
    ]);

    if (empty($obj)) {
        continue;
    }

    $val = '';
    if (!empty($addMinus) && $addMinus) {
        $val = '-';
    }

    $result[] = $val . $obj->id;
}

return implode(',', $result);
