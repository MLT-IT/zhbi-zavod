<?php

/**
 * Портировано из "Основы" и адаптировано под реальные контексты проекта
 * (тексты взяты из уже существующей логики sections/listing-brands/wrapper.tpl,
 * а не придуманы заново — там же context_key 'web' -> 'утеплителей',
 * 'gbi-zavod78' -> 'железобетонных изделий').
 */

$context_values = [
    'web' => [
        'Утеплители',
        'утеплителей'
    ],
    'gbi-zavod78' => [
        'Железобетонные изделия',
        'железобетонных изделий'
    ],
];

$data = [
    'materials' => [
        'value' => $context_values[$modx->context->key] ?: [],
        'show_error_message' => false
    ],
];

return [
    'config_prefix' => "words",
    'placeholders' => $data,
];
