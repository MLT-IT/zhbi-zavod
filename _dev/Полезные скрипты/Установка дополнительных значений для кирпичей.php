<?php

error_reporting(E_ALL ^ E_NOTICE);

$ids = $modx->runSnippet('msProducts', [
    'parents' => 18986,
    'returnIds' => 1,
    'depth' => 1000,
    'showUnpublished' => 1,
    'showDeleted' => 1,
    'where' => '{"template:=":"6"}',
    'sortby' => 'id',
    'sortdir' => 'ASC',

    'limit' => 1000,
    'offset' => 5994
]);

if (empty($ids)) {
    return;
}

$ids = explode(',', $ids);

foreach ($ids as $id) {
    //echo 'Работа с товаром с id ' . $id . '<br>';

    $obj = $modx->getObject('msProduct', $id);
    $options = $obj->loadData()->get('options');
    $razmer = $options['razmer-mm'][0];
    $format = $options['format'][0];

    // Формула 1 - это когда формат пустой или <= 10NF. Формула 2 - когда формат > 10NF.
    $formula = 1;

    // Проверка
    if (empty($razmer)) {
        echo 'Пропущена работа с товаром ' . $id . ', так как не заполнено поле razmer-mm<br>';
        continue;
    }

    // Установка длины, ширины, высоты
    $razmerTmp = explode('х', $razmer);
    if (count($razmerTmp) !== 3) {
        echo 'Пропущена работа с товаром ' . $id . ', так как razmer-mm не удалось разбить на 3 элемента: ' . $razmer . '<br>';
        continue;
    }

    $l = $razmerTmp[0];
    $b = $razmerTmp[1];
    $h = $razmerTmp[2];

    // Валидация $l, $b, $h, это должны быть числа
    if (floatval($l) == 0 || floatval($b) == 0 || floatval($h) == 0) {
        echo 'Пропущена работа с товаром ' . $id . ', так как одно из значений опции razmer-mm не является числовым или равно нулю: ' . $razmer . '<br>';
        continue;
    }

    // Установка формулы
    if (!empty($format)) {
        $format = str_replace([',', ' '], ['.', ''], $format);
        $format = floatval($format);
        if ($format > 10) {
            $formula = 2;
        }
    }

    // Рассчеты
    switch ($formula) {
        case 1:
            $m3seamless = 1 / (($l / 1000) * ($b / 1000) * ($h / 1000));
            $m3seam = 1 / ((($l + 10) / 1000) * (($b + 10) / 1000) * (($h + 10) / 1000));
            $m2seam = 1 / ((($l + 10) / 1000) * (($h + 12) / 1000));
            break;
        case 2:
            $m3seamless = 1 / (($l / 1000) * ($b / 1000) * ($h / 1000));
            $m3seam = 1 / (($l / 1000) * ($b / 1000) * (($h + 12) / 1000));
            $m2seam = 1 / (($l / 1000) * (($h + 12) / 1000));
            break;
    }

    // Округление
    $m3seamless = round($m3seamless);
    $m3seam = round($m3seam);
    $m2seam = round($m2seam);

    // Установка
    $options['k_m3seamless'] = [$m3seamless];
    $options['k_m3seam'] = [$m3seam];
    $options['k_m2seam'] = [$m2seam];

    // echo 'Новые значения: ' . implode(', ', [$m3seamless, $m3seam, $m2seam]) . '<br>';

    // Сохранение
    $obj->set('options', $options);
    if (!$obj->save()) {
        echo 'Не удалось сохранить товар с id ' . $id . '<br>';
    }
}

echo 'Конец работы скрипта';
