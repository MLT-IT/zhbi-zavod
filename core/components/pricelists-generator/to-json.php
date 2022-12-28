<?php

// ---------------------------------------
// Параметры скрипта
// ---------------------------------------
$contexts = [
    'pilomat',
    'fasady-pro'
];


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

// Получение $pdo, он нужен, чтобы вызывать файловые сниппеты
$pdo = $modx->getService('pdoTools');


// ---------------------------------------
// Работа с MODX (выборка)
// ---------------------------------------
$defaultValues = [];

foreach ($contexts as $ctx) {
    // TODO: размеры лого лучше получать через код, а не хардкодить. Логика такая: максимальная ширина: 193, максимальная высота: 38. Вычисляем наибольшее значение, а второе подбираем по пропорциям
    switch ($ctx) {
        case 'pilomat':
            $defaultValues = [
                'email' => 'tsk@pilomat-pro.ru',
                'phone' => '+7 (812) 209-19-68',
                'centerText' => 'Поставка пиломатериалов по Санкт-Петербургу и Ленинградской области',
                'logoWidth' => 193,
                'logoHeight' => 27,
                'headerBgColor' => [79, 112, 173]
            ];
            break;
        case 'fasady-pro':
            $defaultValues = [
                'email' => 'tsk@fasady-pro.ru',
                'phone' => '+7 (812) 209-19-68',
                'centerText' => 'Поставка деревянных фасадов по Санкт-Петербургу и Ленинградской области',
                'logoWidth' => 100,
                'logoHeight' => 38,
                'headerBgColor' => [11, 112, 62]
            ];
            break;
    }

    $logoPath = '/assets/template/img/logos/for-pricelists/' . $ctx . '.png';
    $defaultValues['logoPath'] = $logoPath;

    // Получаем все категории (id и menutitle)
    $categories = $modx->runSnippet('pdoResources', [
        'parents' => 0,
        'depth' => 1000,
        'where' => '{"template:=":5}',
        'context' => $ctx,
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
        $items = $modx->runSnippet('msProducts', [
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

        $items = explode('||', $items);
        $items = array_filter($items);
        if (empty($items)) {
            continue;
        }
        $items = array_map(function ($val) {
            $val = explode('=', $val);
            $val[1] = preg_replace('/\s+/', '', $val[1]);
            return $val;

        }, $items);

        $values = $defaultValues;
        $values['title'] = $catMenutitle;
        $values['items'] = $items;
        $values = json_encode($values, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);


        // ---------------------------------------
        // Создаем json
        // ---------------------------------------
        // Генерация названия json-файла
        $titleFile = $GLOBALS['pdo']->runSnippet('@FILE snippets/getPricelistName.php', [
            'title' => $catMenutitle,
            // Здесь тоже может быть проблема с emoji. Я попробовал написать название файла на 100% из emoji, вместилось 122 символа. -5 для для ".json" = 117
            'maxLength' => 117,
            'append' => '.json'
        ]);
        $path = $GLOBALS['rootDir'] . 'assets/pricelists/json/' . $ctx . '/';
        if (!file_exists($path)) {
            mkdir($path, 0777, true);
        }
        file_put_contents($path . $titleFile, $values);
    }
}

echo 'Конец работы скрипта';
