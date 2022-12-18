<?php

// ---------------------------------------
// Настройки вывода ошибок
// ---------------------------------------
ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);


// ---------------------------------------
// Кодировка
// ---------------------------------------
header('Content-Type: text/html; charset=utf-8');


// ---------------------------------------
// Подключение MODX и vendor
// ---------------------------------------
// Подключение MODX
define('MODX_API_MODE', true);

$rootDir = !empty($rootDir) ? $rootDir : dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR;
$indexPhp = $rootDir . 'index.php';

$i = 0;
while (!file_exists($indexPhp) && $i < 9) {
    $rootDir = dirname(dirname($indexPhp)) . '/';
    $indexPhp = $rootDir . 'index.php';
    $i++;
}

if (file_exists($indexPhp)) {
    require_once $indexPhp;
}

if (!is_object($modx)) {
    echo('ERROR: Не удалось подгрузить MODX');
    die;
}

// Подключение vendor
require_once $rootDir . 'vendor/autoload.php';

// Пространства имен
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;



// Получение $pdo, он нужен, чтобы вызывать файловые сниппеты
$pdo = $modx->getService('pdoTools');


// ---------------------------------------
// Работа с MODX (выборка)
// ---------------------------------------
$context = 'pro-fanera';
// Получаем все категории (id и menutitle)
$categories = $modx->runSnippet('pdoResources', [
    'parents' => 0,
    'depth' => 1000,
    'limit' => 0,
    'where' => '{"template:=":5}',
    'context' => $context,
    'tpl' => '@INLINE [[+id]]=[[+menutitle]]',
    'outputSeparator' => '||'
]);
$categories = explode('||', $categories);
$categories = array_filter($categories);

if (empty($categories)) {
    return;
}

// Проходим по всем категориям и создаем Excel для каждой
foreach ($categories as $cat) {
    $modx = $GLOBALS['modx'];

    // Получаем id и menutitle категории
    $cat = explode('=', $cat);
    $catId = $cat[0];
    $catMenutitle = $cat[1];

    // Проверяем, является ли категория СЕО выборкой
    $modx->runSnippet('msPCS', [
        'rid' => $catId
    ]);
    if (!empty($modx->getPlaceholder('mspcs.option')) || !empty($modx->getPlaceholder('mspcs.where'))) {
        $isSeoPage = 1;
    } else {
        $isSeoPage = 0;
    }

    // Получаем данные о товарах (pagetitle и price)
    $values = $modx->runSnippet('msProducts', [
        'depth' => 1000,
        'limit' => 0,
        'tpl' => '@INLINE [[+pagetitle]]=[[+price]]',
        'outputSeparator' => '||',

        'sortby' => '{"priority1":"ASC","HitsPage":"ASC"}',
        'includeTVs' => 'priority1,HitsPage',
        'parents' => $modx->runSnippet('excludeIds', [
            'isSeoPage' => $isSeoPage,
            'resource' => $modx->getObject('modResource', $catId)
        ]),
        'where' => $modx->getPlaceholder('mspcs.where'),
        'optionFilters' => $modx->getPlaceholder('mspcs.option'),
    ]);

    // Сбрасываем информацию о СЕО выборке (для следующего цикла)
    unset($modx->placeholders['mspcs.option']);
    unset($modx->placeholders['mspcs.where']);

    $values = explode('||', $values);
    $values = array_filter($values);

    if (empty($values)) {
        continue;
    }

    // Создаем Excel
    createXlsx($catMenutitle, $values);
}

/**
 * Создать xlsx файл.
 */
function createXlsx($title, $values) {
    // Создаем таблицу
    $spreadsheet = new Spreadsheet();
    // Получаем первый лист
    $sheet = $spreadsheet->getActiveSheet();

    // Получаем id ресурса, в котором находятся СЕО выборки
    $title = $GLOBALS['pdo']->runSnippet('@FILE snippets/getPricelistName.php', [
        'title' => $title
    ]);
    // 32 - это макс. кол-во символов для названия листа. Если название длиннее, то обрезаем
    if (mb_strlen($title) > 31) {
        $title = mb_substr($title, 0, 30);
        $title .= '…';
    }
    $sheet->setTitle($title);

    // Установка первой строки (заголовков столбцов)
    $range = range('A', 'Z');
    $headers = ['Название', 'Цена'];
    foreach ($headers as $index => $val) {
        $sheet->setCellValue($range[$index] . '1', $val);
    }

    // Установка значений
    foreach ($values as $index => $val) {
        $val = explode('=', $val);
        $val[1] = preg_replace('/\s+/', '', $val[1]);

        foreach ($val as $vidx => $vval) {
            $sheet->setCellValue($range[$vidx] . ($index + 2), $vval);
        }
    }

    // Установка ширины ячейки
    for ($i = 0; $i < count($headers); $i++) {
        $letter = $range[$i];
        $sheet->getColumnDimension($letter)->setAutoSize(true);
    }

    // Сохранение Excel в файловую систему
    $writer = new Xlsx($spreadsheet);
    $path = $GLOBALS['rootDir'] . 'excel/' . $GLOBALS['context'] . '/';
    if (!file_exists($path)) {
        mkdir($path, 0777, true);
    }
    $writer->save($path . $title);
}

