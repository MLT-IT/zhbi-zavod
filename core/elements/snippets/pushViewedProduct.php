<?php
/**
 * @global $modx
 */

if (!isset($_SESSION['RECENT_VIEWED'])) {
    $_SESSION['RECENT_VIEWED'] = [];
}

$price = $modx->resource->get('price');

if ((int) $price <= 0) {
    return;
}

$currentId = $modx->resource->id;
$_SESSION['RECENT_VIEWED'] = array_values(array_filter($_SESSION['RECENT_VIEWED'], function ($id) use ($currentId) {
    return $id !== $currentId;
}));

$_SESSION['RECENT_VIEWED'][] = $currentId;
