<?php

function additionalRedirects() {
    // Получаем URI запроса. Удаляем первый символ, поскольку это слеш
    $currentUrl = mb_substr($_SERVER['REQUEST_URI'], 1);

    // Получаем значение в нижнем регистре, оно нужно для поиска по списку с редиректами
    $currentUrlLower = mb_strtolower($currentUrl);

    // Получаем массив со всеми редиректами
    $data = require_once __DIR__ . '\data.php';
    if (empty($data)) {
        return;
    }

    // Получаем массив со значениями from
    $dataFrom = array_column($data, 'from');

    // Преобразуем в нижний регистр
    $dataFromLower = array_map(function ($val) {
        return mb_strtolower($val);
    }, $dataFrom);

    // Ищем все соответствия
    $indexes = array_keys($dataFromLower, $currentUrlLower);
    if (empty($indexes)) {
        return;
    }

    $redirectIndex = reset($indexes);
    if (count($indexes) > 1) {
        foreach ($indexes as $index) {
            // Ищем тот редирект, который чувствителен к регистру
            if (!empty($data[$index]['case']) && in_array($data[$index]['case'], [1, '1', true, 'true']) && ($currentUrl === $data[$index]['from'])) {
                $redirectIndex = $index;
                break;
            }
        }
    }

    header("HTTP/1.1 301 Moved Permanently");
    header('Location: ' . $data[$redirectIndex]['to']);
    exit();
}

additionalRedirects();


