<?php

// Получаем id всех категорий в определенном контексте
$categoriesIds = $modx->runSnippet('pdoResources', [
    'returnIds' => 1,
    'where' => '{"template:=": 5}',
    'parents' => 0,
    'context' => 'krovlya',
    'limit' => 0,
    'depth' => 9999
]);

$categoriesIds = explode(',', $categoriesIds);

// Проходимся по категориям
foreach ($categoriesIds as $catId) {
    $imageFound = false;
    $cat = $modx->getObject('modResource', $catId);

    // Получаем id всех товаров категории
    $prodIds = $modx->runSnippet('pdoResources', [
        'returnIds' => 1,
        'where' => '{"template:=": 6}',
        'parents' => $catId,
        'limit' => 0,
        'depth' => 9999
    ]);

    $prodIds = explode(',', $prodIds);

    // Проходимся по товарам
    foreach ($prodIds as $prodId) {
        $prod = $modx->getObject('msProduct', $prodId);
        $thumb = $prod->get('image');
        if (!empty($thumb)) {
            // Убираем домен, иначе phpthumb не сможет работать. Нам нужен путь, а не ссылка
            $thumb = str_replace('https://minvata-78.ru', '', $thumb);
            $thumb = str_replace('https://www-knauf.ru', '', $thumb);

            $cat->setTVValue('mainImage', $thumb);
            echo 'Для категории с id ' . $catId . ' установлена картинка от товара с id ' . $prodId . ' (' . $thumb . ')<br>';
            $imageFound = true;
            break;
        }
    }

    if (!$imageFound) {
        echo 'Для категории с id ' . $catId . ' КАРТИНКА НЕ НАЙДЕНА!<br>';
    }
}

