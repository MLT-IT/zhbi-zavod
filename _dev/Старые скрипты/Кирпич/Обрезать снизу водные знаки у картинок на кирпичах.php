<?php

// ---------------------------
// ВАЖНО!
// Кирилл сказал, что обрезать фотки надо со второй. В Excel файле, из которого была сделана выгрузка, в столбце "Фото 1" запись есть ВСЕГДА. Если будут другие файлы, где в некоторых случаях нет записи в "Фото 1", скрипт сработает некорректно.
// ---------------------------
$message = '';
$isCli = php_sapi_name() === 'cli';
$logTime = time();
$basepath = __DIR__ . DIRECTORY_SEPARATOR . 'logs';


// ---------------------------
// Основные функции
// ---------------------------
// Логирование
function logToFile($text, $isEnd = false) {
    global $message;
    global $isCli;
    global $logTime;
    global $basepath;

    if ($isCli) {
        fwrite(STDOUT, $text . "\n");
    } else {
        $message .= $text . '<br>';
    }

    if (!is_dir($basepath)) {
        mkdir($basepath);
    }
    file_put_contents($basepath . DIRECTORY_SEPARATOR . 'log-' . $logTime . '.txt', $text . "\r\n", FILE_APPEND);

    if ($isEnd) {
        if (!$isCli) {
            echo $message;
        }
    }
}

// Сохранение данных в файл
function saveToFile($id) {
    global $basepath;
    $pathToSave = $basepath . DIRECTORY_SEPARATOR . 'saved.txt';

    if ($id === true) {
        $data = file_get_contents($pathToSave);
        $data = explode(',', $data);
        $data = array_filter($data);
        $data = array_unique($data);
        $data = implode(',', $data);
        $data .= ',';
        file_put_contents($pathToSave, $data);
    } else {
        if (!is_dir($basepath)) {
            mkdir($basepath);
        }

        $text = $id . ',';
        file_put_contents($pathToSave, $text, FILE_APPEND);
    }

}


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
logToFile('Начало работы скрипта');

// Загружаем все обработанные картинки
$saved = $basepath . DIRECTORY_SEPARATOR . 'saved.txt';
if (file_exists($saved)) {
    $saved = file_get_contents($saved);
    $saved = explode(',', $saved);
    $saved = array_filter($saved);
} else {
    $saved = [];
}

// Получение id кирпичей
$ids = $modx->runSnippet('msProducts', [
    'parents' => 0,
    'limit' => 0,
    'depth' => 999999,
    'returnIds' => 1,
    'sortby' => 'id',
    'sortdir' => 'ASC',

    'context' => 'plity-mdvp'
]);

$ids = explode(',', $ids);

// Это временная мера
$ids = [69940];

// -------------------------------------
// phpThumb
// -------------------------------------
// Подключаем класс phpThumb
$phpThumb = $modx->getService('modphpthumb', 'modPhpThumb', MODX_CORE_PATH . 'model/phpthumb/', []);
// Массив параметров для phpThumb
$params = [
    'fltr' => [
        'crop|0|0|0|' . 236
    ]
];
// Устанавливаем параметры
foreach ($params as $k => $v) {
    $phpThumb->setParameter($k, $v);
}
// -------------------------------------

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

        // Убираем первую, т.к. Кирилл сказал, что ее обрабатывать не надо
        //array_shift($files);

        // Фильтруем - убираем уже обработанные картинки
        $files = array_filter($files, function ($val) {
            global $saved;
            $check = array_search($val->id, $saved);
            if (is_null($check) || $check === false) {
                return true;
            } else {
                return false;
            }
        });

        if (empty($files)) {
            logToFile('Товар с id ' . $id . ' пропускается, поскольку у него нет или только одна картинка');
            continue;
        }

        // Обрезаем каждую картинку
        foreach ($files as $f) {
            $pathToImage = $ROOT . $f->url;
            // Иногда в пути стоит домен сайта. Например: https://minvata-78.ru. Убираем это
            $pathToImage = preg_replace('/http.*?\.ru/u', '', $pathToImage);

            // Проверяем, существует ли файл
            if (!file_exists($pathToImage)) {
                logToFile('Ошибка при попытке обрезать картинку - файл ' . $pathToImage . ' не существует (товар ' . $id . ')');
                continue;
            }

            // Обрабатываем файл
            // Устанавливаем источик
            $phpThumb->setSourceFilename($pathToImage);

            // Заменяем картинку
            if (!$phpThumb->GenerateThumbnail()) {
                logToFile('Ошибка при обрезании картинки ' . $pathToImage . ' (товар ' . $id . ')');
                continue;
            }

            if (!$phpThumb->renderToFile($pathToImage)) {
                logToFile('Ошибка при сохранении картинки ' . $pathToImage . ' (товар ' . $id . ')');
                continue;
            }

            // Сохраняем информацию о том, что с этой картинкой больше работать не надо
            saveToFile($f->id);
        }

        // Перегенерация превью
        $regeneratePreviewsResult = $modx->runProcessor('mgr/gallery/generateall', ['product_id' => $id],
            ['processors_path' => $modx->getOption('core_path') . 'components/minishop2/processors/']);

        if ($regeneratePreviewsResult->response['success'] === false) {
            logToFile('Ошибка при перегенерации превью (' . $id . ')');
            continue;
        }

        logToFile('Работа с товаром с id ' . $id . ' завершена');
    }
}

saveToFile(true);
logToFile('Конец работы скрипта', 1);
