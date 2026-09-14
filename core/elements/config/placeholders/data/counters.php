<?php

/**
 * Счётчики корзины.
 * Проект использует MiniShop2 (msCartCustom), а не модуль cart из "Основы" —
 * значения берутся напрямую из $miniShop2->cart->status().
 */

$product_total = [
    'total_count' => 0,
    'total_cost' => 0,
    'total_old_cost' => 0,
];

try {
    /** @var miniShop2 $miniShop2 */
    $miniShop2 = $modx->getService('miniShop2');
    if ($miniShop2) {
        $miniShop2->initialize($modx->context->key);
        $product_total = array_merge($product_total, $miniShop2->cart->status());
    }
} catch (Exception $e) {
}

$data = [
    'cart-product-count' => [
        'value' => $product_total['total_count'] ?: 0,
        'show_error_message' => false
    ],
    'cart-product-summ' => [
        'value' => $product_total['total_cost'] ?: 0,
        'show_error_message' => false
    ],
    'cart-product-summ-old' => [
        'value' => $product_total['total_old_cost'] ?: 0,
        'show_error_message' => false
    ],
];

return [
    'config_prefix' => "counters",
    'placeholders' => $data,
];
