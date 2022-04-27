<?php

/*
На кирпичах есть товары с ценой за упаковку. Надо поменять у них единицу измерения на "шт". И цену: Текущая цена / Кол-во в упаковке, шт.
Я это сделал с помощью данного кода. Но у некоторых кирпичей не заполнено поле v_upakovke. Этот код еще понадобится - когда поле заполнят.
*/

$ids = $modx->runSnippet('msProducts', [
    'parents' => 18986,
    'returnIds' => 1,
    'depth' => 1000,
    'limit' => 0,
    'showUnpublished' => 1,
    'showDeleted' => 1,
    'where' => '{"template:=":"6"}',
    'optionFilters' => '{"unit:=": "упаковка"}'
]);

if (empty($ids)) {
    return;
}

$ids = explode(',', $ids);
foreach ($ids as $id) {
    $obj = $modx->getObject('msProduct', $id);

    // Проверки
    $options = $obj->loadData()->get('options');
    if ($options['unit'][0] !== 'упаковка') {
        echo 'Пропущена работа с товаром ' . $id . ', так как unit !== упаковка';
        continue;
    }

    if (empty($options['v_upakovke'][0])) {
        echo 'Пропущена работа с товаром ' . $id . ', так как пустой v_upakovke';
        continue;
    }

    // Смена единицы измерения
    $options['unit'] = ['шт.'];
    $obj->set('options', $options);

    // Смена цены
    $newPrice = $obj->get('price') / $options['v_upakovke'][0];
    $obj->set('price', $newPrice);

    $obj->save();
}
