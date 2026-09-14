<?php

/**
 * Единая точка чтения контекстных настроек.
 * Собирает файлы из config/placeholders/data/*.php и раскладывает их
 * в плейсхолдеры "<config_prefix>.<key>", доступные во всех шаблонах.
 *
 * НЕ КЭШИРУЕМ! Часть значений (телефон/почта) формируется на лету
 * в зависимости от UTM/поддомена/контекста.
 */

$directory = MODX_CORE_PATH . "elements/config/placeholders/data";
if (!is_dir($directory)) return;

$files = scandir($directory);

$result = [
    'main' => [],
    'errors' => []
];
foreach ($files as $file) {
    if ($file === '.' || $file === '..') {
        continue;
    }

    $file_path = $directory . '/' . $file;

    if (is_file($file_path) && pathinfo($file_path, PATHINFO_EXTENSION) === 'php') {
        $data = include $file_path;
        $prefix = $data['config_prefix'];

        foreach ($data['placeholders'] as $placeholder_key => $placeholder_data) {
            $key = $placeholder_key;
            $value = $placeholder_data['value'];

            if (empty($value) && $placeholder_data['show_error_message']) {
                $result['main']["$prefix.$key"] = "Не найден $prefix.$key";
            } else {
                $result['main']["$prefix.$key"] = $value;
            }

            if (empty($value) && $value != 0) {
                $result['errors'][] = "$prefix.$key";
            }
        }
    }
}

foreach ($result['main'] as $key => $value) {
    $modx->setPlaceholder($key, $value);
}

$modx->setPlaceholder("config.errors", $result['errors']);
