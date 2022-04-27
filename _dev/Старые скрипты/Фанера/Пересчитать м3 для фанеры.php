<?php

$ids = $modx->runSnippet('msProducts', [
    'parents' => 0,
    'depth' => 10000,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'context' => 'pro-fanera',
    'returnIds' => 1
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

    $newVal = $options['item_thickness'][0] * $options['item_width'][0] * $options['item_length'][0];
    $newVal = $newVal / 1000000000;
    $newVal = round($newVal, 3);

    $options['obyem_m3'] = [$newVal];
    echo 'Теперь у товара с id ' . $id . ' опция obyem_m3 будет такой: ' . $newVal . '<br>';

    $object->set('options', $options);
    $object->save();
}

echo 'Конец работы скрипта';
