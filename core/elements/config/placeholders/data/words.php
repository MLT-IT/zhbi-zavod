<?php

$context_values = [
    'web' => [
        'Кровельные материалы',
        'Кровельные материалы'
    ],
    'gbi-zavod78' => [
        'Продажа железобетонных изделий',
        'Продажа железобетонных изделий'
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
