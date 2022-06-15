<?php

$ids = $modx->runSnippet('msProducts', [
    'parents' => 0,
    'depth' => 10000,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'context' => 'fasady-pro',
    'returnIds' => 1,
    'optionFilters' => '{"kol-vokub-sh:IS": null}'
]);

$ids = explode(',', $ids);
foreach ($ids as $id) {
    $object = $modx->getObject('msProduct', $id);
    if (empty($object)) {
        echo 'Ошибка при поиске ресурса с id ' . $id . '<br>';
        continue;
    }

    $options = $object->loadData()->get('options');
    $needyOptions = ['item_thickness', 'item_width', 'item_length'];
    foreach ($needyOptions as $opt) {
        if (empty($options[$opt]) || empty($options[$opt][0])) {
            echo 'Работа с товаром ' . $id . ' пропущена, поскольку у него не заполнена опция ' . $opt . '<br>';
            continue 2;
        }
    }

    if (!empty($options['kol-vokub-sh'][0])) {
        echo 'У товара заполнено kol-vokub-sh<br>';
        continue;
    }

    $newVal = str_replace(',', '.', $options['item_thickness'][0]) * str_replace(',', '.', $options['item_width'][0]) * str_replace(',', '.', $options['item_length'][0]);
    $newVal = $newVal / 1000000000;
    $newVal = 1 / $newVal;
    $newVal = round($newVal, 3);

    $options['kol-vokub-sh'] = [$newVal];
    echo 'Теперь у товара с id ' . $id . ' опция kol-vokub-sh будет такой: ' . $newVal . '(длина: '.$options['item_length'][0].', ширина: '.$options['item_width'][0].', толщина: '.$options['item_thickness'][0].')<br>';

    $object->set('options', $options);
    // $object->save();
}

echo 'Конец работы скрипта';
