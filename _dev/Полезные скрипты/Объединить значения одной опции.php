<?php

// --------------------------------------
// Настройки
// --------------------------------------
$optKey = 'proizvoditel';
$removeValue1 = 'Wienerberger';
$removeValue2 = 'Porotherm';
$addValue = 'Porotherm (Wienerberger)';

// --------------------------------------
// Работа скрипта
// --------------------------------------
$ids = $modx->runSnippet('msProducts', [
    'parents' => 18986,
    'depth' => 100,
    'limit' => 0,
    'showDeleted' => 1,
    'showUnpublished' => 1,
    'optionFilters' => '{"' . $optKey . ':IN": ["' . $removeValue1 . '", "' . $removeValue2 . '"]}',
    'returnIds' => 1,
]);

if (empty($ids)) {
    echo 'Товары не найдены';
    return;
}

$ids = explode(',', $ids);

foreach ($ids as $id) {
    $prod = $modx->getObject('msProduct', $id);

    $options = $prod->loadData()->get('options');
    $optVal = $options[$optKey];

    $optValNew = array_diff($optVal, [$removeValue1, $removeValue2, $addValue]);
    $optValNew[] = $addValue;

    echo 'У товара с id ' . $id . ' значение было такое: "' . implode(', ', $optVal) . '", стало таким: "' . implode(', ', $optValNew) . '"<br>';

    $options[$optKey] = $optValNew;
    $prod->set('options', $options);
    $prod->save();
}
