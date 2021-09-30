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

$id = $modx->resource->id;
$_SESSION['RECENT_VIEWED'] = array_values(array_filter($_SESSION['RECENT_VIEWED'], function ($elem) use ($id) {
    return $elem['id'] !== $id;
}));

$_SESSION['RECENT_VIEWED'][] = [
    'id' => $id,
    'name' => $modx->resource->menutitle ?: $modx->resource->pagetitle,
    'url' => $modx->makeUrl($modx->resource->id),
    'image' => $modx->resource->get('image'),
    'price' => $price
];
