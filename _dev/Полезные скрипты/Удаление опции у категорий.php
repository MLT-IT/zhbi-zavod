<?php

// ------------------------------------------
// Основные настройки
// ------------------------------------------
// id опции, которую будем удалять у категорий
$optId = 511;

// Корневая категория для поиска других категорий. У этой категории опция тоже будет удалена
$rootCatId = 36784;


// ------------------------------------------
// Работа скрипта
// ------------------------------------------
// Сам MiniShop2
$miniShop2 = $modx->getService('miniShop2');

// Выбираем категории, у которых надо удалить опцию
$catIds = $modx->runSnippet('pdoResources', [
    'parents' => $rootCatId,
    'limit' => 0,
    'depth' => 1000,
    'returnIds' => 1,
    'where' => '{"template:=":"5"}',
]);

$catIds = explode(',', $catIds);
$catIds[] = $rootCatId;
foreach ($catIds as $cId) {
    $message = '';
    $values = [
        'option_id' => $optId,
        'category_id' => $cId,
    ];

    // Находим привяку "Категория - Опция"
    $categoryOption = $modx->getObject('msCategoryOption', $values);
    if (empty($categoryOption)) {
        echo 'У категории: ' . $cId . ' и так нет опции ' . $optId . '<br>';
        continue;
    }

    // Если привязка есть, то удаляем
    $procRes = $miniShop2->runProcessor('mgr/category/option/multiple', [
        'method' => 'delete',
        'ids' => '[{"option_id":' . $optId . ',"category_id":' . $cId . '}]'
    ]);

    if ($procRes->response['success']) {
        echo 'Успех при удалении опции у категории: ' . $cId . '<br>';
    } else {
        echo 'Ошибка при попытке удалить опцию у категории: ' . $cId . '<br>';
    }
}

echo 'Конец работы скрипта';
