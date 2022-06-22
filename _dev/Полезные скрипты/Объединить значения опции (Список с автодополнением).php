<?php

// --------------------------------------------
// Настройки
// --------------------------------------------
$oldVal = ['сосна, ель'];
$newVal = ['Сосна', 'Ель'];
$targetOption = 'poroda-drevesiny';
$targetCategoryId = '25885';


// --------------------------------------------
// Работа скрипта
// --------------------------------------------
$ids = $modx->runSnippet('msProducts', [
    'parents' => $targetCategoryId,
    'depth' => 9000,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'innerJoin' => '{"Options":{"class":"msProductOption"}}',
    'returnIds' => '1',
    'where' => '{"1":{"Options.key":"' . $targetOption . '","Options.value:=":"' . $oldVal[0] . '"}}',
]);

$ids = explode(',', $ids);
$ids = array_map(function ($id) {
    return trim($id);
}, $ids);

foreach ($ids as $index => $id) {
    $prod = $modx->getObject('msProduct', $id);
    if (empty($prod)) {
        echo 'Не найден товар с id ' . $id . '<br>';
        continue;
    }

    $options = $prod->loadData()->get('options');
    $opt = $prod->get($targetOption);

    // Старое значение должно быть массивом. Если это не так, то делаем массивом
    if (!is_array($opt)) {
        $opt = [$opt];
    }

    $diff = array_diff($opt, $oldVal);

    if (empty($diff)) {
        // Если новое и старое значения ОТЛИЧАЮТСЯ
        echo '++ У товара с id ' . $id . ' ' . $targetOption . ' ' . $opt[0] . ' будет изменен на ' . print_r($newVal, true) . '<br>';

        $options[$targetOption] = $newVal;
    } else {
        // Если новое и старое значения ОДИНАКОВЫЕ
        echo 'У товара с id ' . $id . ' опции одинаковые<br>';
        continue;
    }

    $prod->set('options', $options);
    //$prod->save();
}

echo 'Конец работы скрипта';
