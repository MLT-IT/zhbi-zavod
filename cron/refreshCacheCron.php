<?php

// -------------------------------
// Основные переменные и константы
// -------------------------------
define('IS_CLI', php_sapi_name() === 'cli');
define('START_TIME', time());
define('PATH_LOGS', __DIR__ . DIRECTORY_SEPARATOR . 'logs');
define('LIMIT', 1000);
$message = '';

// Кодировка - если это режим HTTP
if (!IS_CLI) {
    header('Content-Type: text/html; charset=utf-8');
}

output('Начало работы скрипта');


// -------------------------------
// Настройки для отладки
// -------------------------------
// Вывод ошибок - если это режим HTTP
if (!IS_CLI) {
    ini_set('display_errors', '1');
    ini_set('display_startup_errors', '1');
    error_reporting(E_ALL);
}


// -------------------------------
// Определение функций
// -------------------------------
// Логирование
function output($text, $isEnd = false) {
    global $message;

    if (IS_CLI) {
        fwrite(STDOUT, $text . "\n");
    } else {
        $message .= $text . '<br>';
    }

    if (!is_dir(PATH_LOGS)) {
        mkdir(PATH_LOGS);
    }
    file_put_contents(PATH_LOGS . DIRECTORY_SEPARATOR . 'log-' . START_TIME . '.txt', $text . "\r\n", FILE_APPEND);

    if ($isEnd) {
        if (!IS_CLI) {
            output($message);
        }
    }
}


// -------------------------------
// Подключение MODX
// -------------------------------
define('MODX_API_MODE', true);

// Ищем и подключаем index.php
$currentDir = dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR;
$indexPhp = $currentDir . 'index.php';

$i = 0;
while (!file_exists($indexPhp) && $i < 9) {
    $currentDir = dirname(dirname($indexPhp)) . '/';
    $indexPhp = $currentDir . 'index.php';
    $i++;
}

if (file_exists($indexPhp)) {
    require_once $indexPhp;
}

if (!is_object($modx)) {
    output('Не удалось подгрузить MODX', 1);
    die;
}


// -------------------------------
// Работа скрипта
// -------------------------------
// Временная установка настройки для MODX
$modx->setOption("syncsite_default", false);

// Формирование запроса на выборку ресурсов
$where = 'cacheable = 1 AND published = 1 AND deleted = 0';

// Получение общего количества
$query = 'SELECT COUNT(id) FROM ' . $modx->getOption('table_prefix') . 'site_content WHERE ' . $where;
$count = $modx->query($query);
$count = $count->fetchAll(PDO::FETCH_COLUMN);
$count = reset($count);

// Запрос для получения ресурсов
$query = 'SELECT id
          FROM ' . $modx->getOption('table_prefix') . 'site_content
          WHERE ' . $where . '
          LIMIT ' . LIMIT;

// Основная работа скрипта
for ($offset = 0; $offset < $count; $offset += LIMIT) {
    // Выборка id из БД
    $q = $query . ' OFFSET ' . $offset;
    $data = $modx->query($q);
    $data = $data->fetchAll(PDO::FETCH_COLUMN);

    // Обработка выборки
    foreach ($data as $id) {
        if ($resource = $modx->getObject('modResource', $id)) {
            output('Обработка ресурса с id ' . $id);

            $modx->invokeEvent("OnDocFormSave", [
                "object" => $resource,
            ]);
        } else {
            output('Не удалось найти ресурс с id ' . $id);
        }
    }
}

output('Конец работы скрипта', 1);
