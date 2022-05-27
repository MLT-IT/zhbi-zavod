<?php

error_reporting(E_ALL ^ E_NOTICE);

$ids = $modx->runSnippet('msProducts', [
    'parents' => 69079,
    'returnIds' => 1,
    'depth' => 1000,
    'showUnpublished' => 1,
    'showDeleted' => 1,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'limit' => 0,
    'offset' => 0,
    'optionFilters' => '{"razmer-mm:IS NOT": null}'
]);

echo $ids . '<br>';
$ids = explode(',', $ids);

foreach ($ids as $id) {
    $obj = $modx->getObject('msProduct', $id);

    // Валидация полей на заполненность
    if (empty($obj->get('razmer-mm')) || empty($obj->get('razmer-mm')[0])) {
        echo 'Работа с товаром ' . $id . ' пропускается, поскольку у него пустое поле razmer-mm<br>';
        continue;
    }

    $razmer = $obj->get('razmer-mm')[0];
    $razmer = str_replace('x', 'х', $razmer);
    $razmer = explode('х', $razmer);
    $count = count($razmer);

    // Валидация поля $razmer на правильность
    if ($count < 2) {
        echo 'Работа с товаром ' . $id . ' пропускается, поскольку у него в поле razmer-mm всего одно значение<br>';
        continue;
    }
    if ($count > 3) {
        echo 'Работа с товаром ' . $id . ' пропускается, поскольку у него в поле razmer-mm очень много значений (> 3), что подозрительно<br>';
        continue;
    }

    // Подсчет м2
    $m2 = $razmer[0] * $razmer[1];
    if (empty($m2)) {
        echo 'Работа с товаром ' . $id . ' пропускается, поскольку у него не получилось посчитать $m2<br>';
        continue;
    }
    $m2 = $m2 / 1000000;

    // Установка опций
    $options = $obj->loadData()->get('options');

    // Установка
    $options['ploshad_m2'] = [$m2];

    // Сохранение
    $obj->set('options', $options);
    if (!$obj->save()) {
        echo 'Не удалось сохранить товар с id ' . $id . '<br>';
    }
}

echo 'Конец работы скрипта';
