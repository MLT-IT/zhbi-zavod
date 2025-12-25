<?php

$data = [
    'phone' => [
        'value' => $modx->getPlaceholder('virtual-router')['phone'] ?: $modx->getOption('phone'),
        'show_error_message' => true
    ],
    'email' =>   [
        'value' => $modx->getPlaceholder('virtual-router')['email'] ?: $modx->getOption('email'),
        'show_error_message' => true
    ],
    'address' =>   [
        'value' => $modx->getPlaceholder('virtual-router')['address'] ?: $modx->getOption('address'),
        'show_error_message' => true
    ],
    'opening_hours' => [
        'value' => 'Ежедневно: 8:00 - 21:00',
        'show_error_message' => true
    ],
];

// Телефон без лишних символов
$data['phone_href'] = [
    'value' => preg_replace('/\D/', '', $data['phone']['value']),
    'show_error_message' => true
];

return [
    'config_prefix' => "contacts",
    'placeholders' => $data,
];
