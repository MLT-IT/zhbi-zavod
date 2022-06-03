<?php

/*
TODO: добавь возможность в конец автоматически дописывать "/", так как это разные редиректы:
RewriteRule ^kirpich/braer\/$ https://kirpich-m.ru/braer/ [R=301,L]
RewriteRule ^kirpich/braer?$ https://kirpich-m.ru/braer/ [R=301,L]
*/

!empty($modxStart) or die('No direct script access.');

function additionalRedirects() {
    // Это нужно, т.к. в функции своя область видимости. Тут мы будем делать require_once data.php. А там проверка на определение этой переменной
    global $modxStart;

    // Получаем запрос. Удаляем первый символ, поскольку это слеш
    $currentUrl = mb_substr($_SERVER['REQUEST_URI'], 1);
    // Получаем хост
    $host = $_SERVER['HTTP_HOST'];
    // Получаем значение в нижнем регистре, это нужно для поиска редиректа
    $currentUrlLower = mb_strtolower($currentUrl);
    // Получаем массив со всеми редиректами
    $data = require_once __DIR__ . '/data.php';
    if (empty($data)) {
        return;
    }

    // Получаем массив со значениями from
    $dataFrom = array_column($data, 'from');
    // Получаем данный массив в нижнем регистре, это нужно для поиска редиректа
    $dataFromLower = array_map(function ($val) {
        return mb_strtolower($val);
    }, $dataFrom);

    // Ищем все соответствия
    $indexes = [];
    foreach ($dataFromLower as $i => $val) {
        if ($val === $currentUrlLower) {
            $indexes[] = $i;
        }
    }

    if (empty($indexes)) {
        return;
    }

    // Среди соответствий выделяем те, у которых host либо пустой, либо такой же, как у запроса
    $indexes = array_filter($indexes, function ($i) use ($data, $host) {
        if (empty($data[$i]['host']) || $data[$i]['host'] === $host) {
            return true;
        }
        return false;
    });

    $redirectIndex = false;
    foreach ($indexes as $index) {
        // Ищем первый редирект нечувствительный к регистру
        if (empty($data[$index]['case_sensitive']) && empty($redirectIndex)) {
            $redirectIndex = $index;
        }

        // Ищем первый редирект, который чувствителен к регистру
        if (!empty($data[$index]['case_sensitive']) && ($currentUrl === $data[$index]['from'])) {
            $redirectIndex = $index;
            break;
        }
    }

    // Если редирект не нашли, то выходим из функции
    if ($redirectIndex === false) {
        return;
    }

    header("HTTP/1.1 301 Moved Permanently");
    //header("HTTP/1.1 303 See Other");
    header('Location: ' . $data[$redirectIndex]['to']);
    exit();
}

additionalRedirects();
