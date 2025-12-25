<?php

$context_values = [
    'web' => [
        'ЖБИ',
        'ЖБИ'
    ],
    'plitnye' => [
        'плитные материалы',
        'плит'
    ],
];

$data = [
    'materials' => [
        'value' => $context_values[$modx->context->key] ?: [],
        'show_error_message' => true
    ],
];

return [
    'config_prefix' => "words",
    'placeholders' => $data,
];
