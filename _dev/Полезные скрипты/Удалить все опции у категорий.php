<?php

// Внимание! В выводе получается какая-то ерунда. Надо бы подправить.

// id категорий, у которых будем удалять опции
$catIds = [89370, 89371, 89372, 89373, 89374, 89375, 89376, 89377, 89378, 89379, 89380, 89381, 89383, 89384, 89385, 89387, 89389, 89393, 89395, 89396, 89397, 89398, 89400, 89402, 89406, 89407, 89408, 89409, 89410, 89411, 89412, 89414];

// Контекст
$context = 'armatura-178';


// ------------------------------------------
// Работа скрипта
// ------------------------------------------
$miniShop2 = $modx->getService('miniShop2'); // Сам MiniShop2

foreach ($catIds as $cId) {
    $values = [
        'category_id' => $cId,
    ];

    $message = '';

    $categoryOption = $modx->getCollection('msCategoryOption', $values);
    if (empty($categoryOption)) {
        continue;
    } else {
        foreach ($categoryOption as $catOptLink) {
            $res = $catOptLink->remove();
            if ($res) {
                $message = 'Успех ';
            } else {
                $message = 'Неудача ';
            }
            $message .= 'при удалении ';
            $message .= 'опции для категории с id ' . $cId . '<br>';
        }
    }
    echo $message;
}

echo 'Конец работы скрипта';
