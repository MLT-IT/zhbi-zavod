<?php

// ------------------------------------------
// Основные настройки
// ------------------------------------------
// id опции, которую будем привязывать к категориям
$optId = 624;
//$optId = 623;
//$optId = 625;

// Корневая категория для поиска других категорий
$rootCatId = 18986;

// Контекст
$context = 'kirpich-m';


// ------------------------------------------
// Работа скрипта
// ------------------------------------------
$miniShop2 = $modx->getService('miniShop2'); // Сам MiniShop2

// Выбираем категории, к которым надо привязать опцию
$catIds = $modx->runSnippet('pdoResources', [
    'parents' => $rootCatId,
    'limit' => 0,
    'depth' => 1000,
    'returnIds' => 1,
    'where' => '{"template:=":"5"}',
    'context' => $context
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
    $message .= 'привязки опции для категории с id ' . $cId . '<br>';
    echo $message;
}

echo 'Конец работы скрипта';
