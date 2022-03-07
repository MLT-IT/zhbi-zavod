<?php

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
$ids = [29981];

foreach ($ids as $id) {
    $prod = $modx->getObject('msProduct', $id);

    // Получаем все картинки
    if ($files = $prod->getMany('Files')) {
        // Фильтруем - нам нужны только оригиналы
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
            $pathToImage = $_SERVER['DOCUMENT_ROOT'] . $f->url;
            // Иногда в пути стоит домен сайта. Например: https://minvata-78.ru. Убираем это
            $pathToImage = preg_replace('/http.*?\.ru/u', '', $pathToImage);

            // Проверяем, существует ли файл
            if (!file_exists($pathToImage)) {
                echo 'Файл ' . $pathToImage . ' не существует (' . $id . ')<br>';
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
                    echo 'Ошибка при сохранении картинки ' . $pathToImage . ' (' . $id . ')<br>';
                    continue;
                }
            }
        }

        // Перегенерация превью
        $regeneratePreviewsResult = $modx->runProcessor('mgr/gallery/generateall', ['product_id' => $id],
            ['processors_path' => $modx->getOption('core_path') . 'components/minishop2/processors/']);

        if ($regeneratePreviewsResult->response['success'] === false) {
            echo 'Ошибка при перегенерации превью (' . $id . ')<br>';
            continue;
        }
    }

    break;
}

echo 'Конец работы скрипта';
