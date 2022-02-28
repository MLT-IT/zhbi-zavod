<?php

$miniShop2 = $modx->getService('miniShop2'); // Сам MiniShop2

// Оттенок
$optId = 108;

// Выбираем все категории
$catIds = $modx->runSnippet('pdoResources', [
    'parents' => 0,
    'limit' => 0,
    'depth' => 0,
    'returnIds' => 1,
    'where' => '{"template:=":"5"}',
    'context' => 'krovlya'
]);

$catIds = explode(',', $catIds);

foreach ($catIds as $cId) {
    $values = [
        'option_id' => $optId,
        'category_id' => $cId,
    ];

    $message = '';
    // Если такая привязка уже есть, то пропускаем
    $categoryOption = $modx->getObject('msCategoryOption', $values);
    if (!empty($categoryOption)) {
        $categoryOption->active = 1;
        $res = $categoryOption->save();
        if ($res) {
            $message = 'Успех ';
        } else {
            $message = 'Неудача ';
        }
        $message .= 'при активации ';
    } else {
        $res = $miniShop2->runProcessor('mgr/category/option/add', array_merge($values, ['active' => 1]));
        if ($res->response['success']) {
            $message = 'Успех ';
        } else {
            $message = 'Неудача ';
        }
        $message .= 'при создании ';
    }
    $message .= 'опции для категории с id ' . $cId . '<br>';
    echo $message;
}
