<?php

/**
 * Сниппет получает данные из JSON файлов и отдает массивом
 * JSON хранятся в папке assets/template/json/
 * Для получения файла необходимо указать $path от корня сайта
 */

/**
 * Вызов 
 * 
 * {set $data = "@FILE snippets/getJsonData.php" | snippet : [
 *     "path" => "/assets/template/json/sections/factories/"~$_modx->context.key~".json"
 * ]}
 * 
 * {if $data['status'] == 'success'}
 *  Логика
 * {/if}
 */

if (empty($path)) return;

$path = MODX_BASE_PATH . $path;
if (file_exists($path)) {

    $json_content = file_get_contents($path);

    $data = json_decode($json_content, true);

    if (json_last_error() === JSON_ERROR_NONE) {
        return ["status" => "success", "data" => $data];
    } else {
        return ["status" => "error", "message" => "Ошибка при декодировании"];
    }
} else {
    return ["status" => "error", "message" => "Файл не найден"];
}
