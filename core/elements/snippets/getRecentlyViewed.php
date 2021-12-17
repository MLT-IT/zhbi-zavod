<?php

$currentId = $modx->resource->id;

$data = array_reverse(array_filter($_SESSION['RECENT_VIEWED'], function ($id) use ($currentId) {
    return $id !== $currentId;
}));

return implode(',', $data);
