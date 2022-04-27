<?php
// --------------------------------------------
// Настройки
// --------------------------------------------
$oldVal = 'Braer';
$newVal = 'BRAER';
$targetOption = 'proizvoditel';

// --------------------------------------------
// Работа скрипта
// --------------------------------------------
$ids = $modx->runSnippet('msProducts', [
    'parents' => 0,
    'depth' => 9000,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'innerJoin' => '{"Options":{"class":"msProductOption"}}',
    'returnIds' => '1',
    'where' => '{"1":{"Options.key":"' . $targetOption . '","Options.value:=":"' . $oldVal . '"}}',
    'context' => 'kirpich-m'
]);

$ids = explode(',', $ids);
$ids = array_map(function ($id) {
    return trim($id);
}, $ids);

foreach ($ids as $index => $id) {
    $prod = $modx->getObject('msProduct', $id);
    if (!empty($prod)) {
        $options = $prod->loadData()->get('options');
        $opt = $prod->get($targetOption);

        foreach ($opt as $key => $val) {
            if ($val === $oldVal) {
                echo '++ У товара с id ' . $id . ' ' . $targetOption . ' ' . $val . ' будет изменен на ' . $newVal . '<br>';

                $options[$targetOption][$key] = $newVal;
            } else {
                echo $id . ' ' . $val . ' !== ' . $oldVal . '<br>';
            }
        }

        $prod->set('options', $options);
        //$prod->save();
    } else {
        echo 'Не найден товар с id ' . $id;
    }
}
