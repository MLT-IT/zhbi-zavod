<?php
$id = $modx->resource->id;

return array_reverse(array_filter($_SESSION['RECENT_VIEWED'], function ($elem) use ($id) {
    return $elem['id'] !== $id;
}));