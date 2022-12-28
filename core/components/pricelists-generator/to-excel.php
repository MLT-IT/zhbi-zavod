<?php

// ---------------------------------------
// Параметры скрипта
// ---------------------------------------
$context = 'pro-fanera';

switch ($context) {
    case 'pro-fanera':
        $email = 'tsk@pro-fanera.ru';
        $phone = '+7 (812) 209-19-68';
        break;
}


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
// Получаем все категории (id и menutitle)
$categories = $modx->runSnippet('pdoResources', [
    'parents' => 0,
    'depth' => 1000,
    'where' => '{"template:=":5}',
    'context' => $context,
    'tpl' => '@INLINE [[+id]]=[[+menutitle]]',
    'outputSeparator' => '||',
    'limit' => 0
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
    // ----------------------------------
    // Основные характеристики Excel файла
    // ----------------------------------
    // Создание таблицы
    $spreadsheet = new Spreadsheet();
    // Получение первого листа
    $sheet = $spreadsheet->getActiveSheet();

    // Генерация названия прайслиста
    $titleExcel = $GLOBALS['pdo']->runSnippet('@FILE snippets/getPricelistName.php', [
        'title' => $title,
        // Я попробовал написать самое длинное название листа, получился 31 символ. Но если вводить emoji, то символов вместится меньше
        'maxLength' => 31,
    ]);
    $sheet->setTitle($titleExcel);

    // Генерация названия Excel-файла
    $titleFile = $GLOBALS['pdo']->runSnippet('@FILE snippets/getPricelistName.php', [
        'title' => $title,
        // Здесь тоже может быть проблема с emoji. Я попробовал написать название файла на 100% из emoji, вместилось 122 символа. -5 для для ".xlsx" = 117
        'maxLength' => 117,
        'append' => '.xlsx'
    ]);


    // ----------------------------------
    // Работа с логотипом таблицы
    // ----------------------------------
    // Вставка логотипа
    $drawingLogo = new \PhpOffice\PhpSpreadsheet\Worksheet\Drawing();
    $drawingLogo->setName('Logo');
    $drawingLogo->setPath($GLOBALS['rootDir'] . 'assets/template/img/for-pricelists/logo-' . $GLOBALS['context'] . '.png');
    $drawingLogo->setCoordinates('A1');
    $drawingLogo->setWorksheet($sheet);

    // Вставка почты (Кирилл сказать сделать это через картинку)
    // $sheet->setCellValue('A2', $GLOBALS['email']);
    $drawingEmail = new \PhpOffice\PhpSpreadsheet\Worksheet\Drawing();
    $drawingEmail->setName('email');
    $drawingEmail->setPath($GLOBALS['rootDir'] . 'assets/template/img/for-pricelists/email-' . $GLOBALS['context'] . '.png');
    $drawingEmail->setHeight(13);
    $drawingEmail->setOffsetX(4);
    $drawingEmail->setOffsetY(4);
    $drawingEmail->setCoordinates('A2');
    $drawingEmail->setWorksheet($sheet);

    // Вставка телефона
    $sheet->setCellValue('A3', $GLOBALS['phone']);

    // Вставка расписания
    $sheet->setCellValue('A4', 'Ежедневно с 8:00 до 21:00');


    // ----------------------------------
    // Работа с со значениями прайс-листа (название и цена)
    // ----------------------------------
    // 1 - картинка, 2 - email, 3 - телефон, 4 - расписание, 5 - пустая строка
    $startFrom = 6;

    // Установка заголовков
    $range = range('A', 'Z');
    $headers = ['Название', 'Цена'];
    foreach ($headers as $index => $val) {
        $sheet->setCellValue($range[$index] . $startFrom, $val);
    }

    // Установка значений
    foreach ($values as $index => $val) {
        $val = explode('=', $val);
        $val[1] = preg_replace('/\s+/', '', $val[1]);

        foreach ($val as $vidx => $vval) {
            $sheet->setCellValue($range[$vidx] . ($index + 7), $vval);
        }
    }

    // Сохранение кол-ва значений
    $count = $index + 1;

    // Установка формата ячеек
    $sheet->getStyle('B' . $startFrom . ':B' . ($count + $startFrom))
        ->getNumberFormat()
        ->setFormatCode('#,##0.00_-"₽"');


    // ----------------------------------
    // Работа с размерами столбцов и строк
    // ----------------------------------
    // Установка автоматической ширины столбцов А и B (так как значения только в них)
    for ($i = 0; $i < 2; $i++) {
        $letter = $range[$i];
        $sheet->getColumnDimension($letter)->setAutoSize(true);
    }

    // Вычисление автоматической ширины
    $sheet->calculateColumnWidths();
    // Получение ширины столбцов
    $columnWidthA = $sheet->getColumnDimension('A')->getWidth();
    $columnWidthB = $sheet->getColumnDimension('B')->getWidth();

    // Получение размеров картинки. Размеры картинки вычисляются в пикселях. Ширина ячеек вычисляется в символах (относительно шрифта). Чтобы соотнести эти размеры, необходимо определить шрифт. В А1 находится картинка, текста там нет. А вот в А2 есть текст. Высота ячеек вычисляется в пунктах, для этого есть специальная функция
    $excelFont = $sheet->getStyle('A2')->getFont();
    $imageHeight = $drawingLogo->getHeight();
    $imageWidth = $drawingLogo->getWidth();
    $imageHeightPoints = \PhpOffice\PhpSpreadsheet\Shared\Drawing::pixelsToPoints($imageHeight);
    // Я заметил, что ширина вычисляется не совсем правильно. Получается немного большее значение
    $imageWidthSymbols = \PhpOffice\PhpSpreadsheet\Shared\Drawing::pixelsToCellDimension($imageWidth, $excelFont);

    // Установка высоты первой строки (там картинка)
    $sheet->getRowDimension(1)->setRowHeight($imageHeightPoints);

    // Если автоматическая ширина столбца A+B меньше, чем ширина картинки, то надо увеличить
    if ($imageWidthSymbols > ($columnWidthA + $columnWidthB)) {
        $sheet->getColumnDimension('A')->setAutoSize(false);
        $sheet->getColumnDimension('B')->setAutoSize(false);
        $newValHalf = ($imageWidthSymbols - ($columnWidthA + $columnWidthB)) / 2;
        $sheet->getColumnDimension('A')->setWidth($columnWidthA + $newValHalf);
        $sheet->getColumnDimension('B')->setWidth($columnWidthB + $newValHalf);
    }

    // Объединение A1 и B1 - там картинка, а она широкая
    $sheet->mergeCells('A1:B1');


    // ----------------------------------
    // Дизайн таблицы
    // ----------------------------------
    $bottomCells = $startFrom + $count;
    $topCells = $startFrom;

    // Добавление пустых столбцов и строк - так было в примере Василия (он поставил мне задачу)
    $sheet->insertNewColumnBefore('A', 1);
    $sheet->setCellValue('D' . ($bottomCells + 1), ' ');
    $sheet->getColumnDimension('D')->setWidth(3.5);
    $sheet->getColumnDimension('A')->setWidth(3.5);

    // Добавление границ для нужных ячеек
    // Границы слева
    $sheet
        ->getStyle('B' . $topCells . ':C' . $bottomCells)
        ->getBorders()
        ->getAllBorders()
        ->setBorderStyle(PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN)
        ->setColor(new PhpOffice\PhpSpreadsheet\Style\Color('000000'));

    // Скрытие границ у ненужных ячеек
    $sheet->setShowGridlines(false);

    // Активация PAGE_LAYOUT
    $sheet->getSheetView()->setView(PhpOffice\PhpSpreadsheet\Worksheet\SheetView::SHEETVIEW_PAGE_BREAK_PREVIEW);


    // ----------------------------------
    // Сохранение Excel файла
    // ----------------------------------
    $writer = new Xlsx($spreadsheet);
    $path = $GLOBALS['rootDir'] . 'assets/pricelists/excel/' . $GLOBALS['context'] . '/';
    if (!file_exists($path)) {
        mkdir($path, 0777, true);
    }
    $writer->save($path . $titleFile);
}

echo 'Конец работы скрипта';
