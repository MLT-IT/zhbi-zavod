<?php

error_reporting(E_ALL & ~E_NOTICE);
$message = '';
$isCli = php_sapi_name() === 'cli';

// ---------------------------
// Основные функции
// ---------------------------
function logToFile($text, $isEnd = false) {
    global $message;
    global $isCli;

    if ($isCli) {
        fwrite(STDOUT, $text . "\n");
    } else {
        $message .= $text . '<br>';
    }

    $dirpath = __DIR__ . DIRECTORY_SEPARATOR . 'logs';
    if (!is_dir($dirpath)) {
        mkdir($dirpath);
    }
    file_put_contents($dirpath . DIRECTORY_SEPARATOR . 'log.txt', $text . "\r\n", FILE_APPEND);

    if ($isEnd) {
        if (!$isCli) {
            echo $message;
        }
    }
}

logToFile('Начало работы скрипта');

// ---------------------------
// Подключаем MODX
// ---------------------------
define('MODX_API_MODE', true);

$current_dir = !empty($current_dir) ? $current_dir : dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR;
$index_php = $current_dir . 'index.php';

$i = 0;
while (!file_exists($index_php) && $i < 9) {
    $current_dir = dirname(dirname($index_php)) . '/';
    $index_php = $current_dir . 'index.php';
    $i++;
}

if (file_exists($index_php)) {
    require_once $index_php;
}

$ROOT = dirname($index_php);

if (!is_object($modx)) {
    logToFile('ERROR: Не удалось подгрузить MODX');
    die;
}


// ---------------------------
// Кодировка
// ---------------------------
header('Content-Type: text/html; charset=utf-8');


// ---------------------------
// Работа скрипта
// ---------------------------
// Получение id кирпичей
$ids = $modx->runSnippet('pdoResources', [
    'parents' => 0,
    'limit' => 0,
    'depth' => 999999,
    'returnIds' => 1,
    'where' => '{"template:=": 6}',
    'sortby' => 'id'
]);

$ids = explode(',', $ids);

// Это временная мера
//$ids = [37929];
//$ids = [16806];

foreach ($ids as $id) {
    $prod = $modx->getObject('msProduct', $id);

    // Получаем все картинки
    if ($files = $prod->getMany('Files')) {
        // Фильтруем - нам нужны только оригиналы (small и webp не нужны)
        $files = array_filter($files, function ($val) {
            if (mb_substr_count($val->path, '/') === 1) {
                return true;
            } else {
                return false;
            }
        });

        // Убираем первую, т.к. Кирилл сказал, что у нее все хорошо
        array_shift($files);

        // Обрезаем каждую картинку
        foreach ($files as $f) {
            $pathToImage = $ROOT . $f->url;
            // Иногда в пути стоит домен сайта. Например: https://minvata-78.ru. Убираем это
            $pathToImage = preg_replace('/http.*?\.ru/u', '', $pathToImage);

            // Проверяем, существует ли файл
            if (!file_exists($pathToImage)) {
                logToFile('Файл ' . $pathToImage . ' не существует (' . $id . ')');
                continue;
            }

            // Обрабатываем файл
            // Основные переменные
            $size = getimagesize($pathToImage);
            $width = $size[0];
            $height = $size[1];
            $cropPixelsBottom = 71;

            // Массив параметров для phpThumb
            $params = [
                'fltr' => [
                    'crop|0|0|0|' . $cropPixelsBottom
                ]
            ];

            // Подключаем класс phpThumb
            $phpThumb = $modx->getService('modphpthumb', 'modPhpThumb', MODX_CORE_PATH . 'model/phpthumb/', []);
            // Устанавливаем источик
            $phpThumb->setSourceFilename($pathToImage);

            // Устанавливаем параметры
            foreach ($params as $k => $v) {
                $phpThumb->setParameter($k, $v);
            }

            // Заменяем картинку
            if ($phpThumb->GenerateThumbnail()) {
                if (!$phpThumb->renderToFile($pathToImage)) {
                    logToFile('Ошибка при сохранении картинки ' . $pathToImage . ' (' . $id . ')');
                    continue;
                }
            }
        }

        // Перегенерация превью
        $regeneratePreviewsResult = $modx->runProcessor('mgr/gallery/generateall', ['product_id' => $id],
            ['processors_path' => $modx->getOption('core_path') . 'components/minishop2/processors/']);

        if ($regeneratePreviewsResult->response['success'] === false) {
            logToFile('Ошибка при перегенерации превью (' . $id . ')');
            continue;
        }
    }

    logToFile('Работа с товаром с id ' . $id . ' завершена');
}

logToFile('Конец работы скрипта', 1);
