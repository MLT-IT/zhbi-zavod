<?php

/**
 * Портировано из "Основы" как заготовка на будущее.
 * ВАЖНО: текущий проект хранит логотипы по другой схеме —
 * assets/template/pictures/<context_key>.png (см. свитч в chunks/header.tpl) —
 * и эти плейсхолдеры пока НИКЕМ не используются. Путь ниже ("images/logo/<ctx>/...")
 * не существует на диске; чтобы реально включить эти плейсхолдеры, либо перенести
 * логотипы в новую структуру, либо поменять value на актуальный путь.
 */

$data = [
    'logo-default' => [
        'value' => '/assets/template/images/logo/' . $modx->context->key . '/default.png',
        'show_error_message' => false
    ],
    'logo-white' => [
        'value' => '/assets/template/images/logo/' . $modx->context->key . '/white.png',
        'show_error_message' => false
    ],
];

return [
    'config_prefix' => "images",
    'placeholders' => $data,
];
