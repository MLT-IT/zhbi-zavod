<?php

$data = [
    'logo-default' =>   [
        'value' => '/assets/template/images/logo/' . $modx->context->key . '/default.png',
        'show_error_message' => false
    ],
    'logo-white' =>   [
        'value' => '/assets/template/images/logo/' . $modx->context->key . '/white.png',
        'show_error_message' => false
    ],
];

return [
    'config_prefix' => "images",
    'placeholders' => $data,
];
