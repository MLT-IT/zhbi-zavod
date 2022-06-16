<?php

/**
 * Принимает id опции для удаления и опции для сохранения.
 * Опция для удаления - это та опция, с которой все значения будут скопированы в опцию для сохранения.
 *
 * Скрипт сначала находит категории, которым назначена опция для удаления. Потом этим категориям назначает и активирует опцию для сохранения. Потом копирует значение опции для удаления в опцию для сохранения.
 *
 * Опцию для удаления можно удалять. Но делать это надо самостоятельно - через админку MODX. Я не стал добавлять это в скрипт, потому что это несложно. И может быть рискованно (при удалении опции удаляются все ее значения навсегда).
 *
 */

// ====================================
// Настройки
// ====================================
// id ненужной опции (опции, которая будет удаляться)
$idOptToDelete = 683;

// id нужной опции (опции, в которую будут перенесены значения от удаляемой)
$idOptToSave = 128;

// Это отладка?
$isDebug = false;


// ====================================
// Работа скрипта
// ====================================
// Получаем ключ ненужной опции. Заодно проверяем, существует ли она вообще
$keyOptToDelete = $modx->getObject('msOption', $idOptToDelete);
if (empty($keyOptToDelete)) {
    echo 'Опции, которую нужно удалить, не существует.<br>Конец работы скрипта';
    return;
}
$keyOptToDelete = $keyOptToDelete->key;

// Получаем ключ нужной опции
$keyOptToSave = $modx->getObject('msOption', $idOptToSave);
if (empty($keyOptToSave)) {
    echo 'Опции, в которую нужно перенести значения, не существует.<br>Конец работы скрипта';
    return;
}
$keyOptToSave = $keyOptToSave->key;


// ------------------------------------
// Привязка нужной опции к категориям с ненужной опцией
// ------------------------------------
// Сам MiniShop2. Он нужен для вызова процессора
$miniShop2 = $modx->getService('miniShop2');

// Получение категорий с опцией, которую будем удалять
$categoryOptions = $modx->getCollection('msCategoryOption', ['option_id' => $idOptToDelete]);
$categoriesWithOptToDelete = [];
foreach ($categoryOptions as $v) {
    $categoriesWithOptToDelete[] = $v->category_id;
}

// Получение категорий с опцией, в которую будем переносить значения из удаляемой
$categoryOptions = $modx->getCollection('msCategoryOption', ['option_id' => $idOptToSave]);
$categoriesWithOptToSave = [];
foreach ($categoryOptions as $v) {
    $categoriesWithOptToSave[] = $v->category_id;
}

// Привязка опции OptToSave для тех категорий, у которых сейчас OptToDelete (позже мы будем копировать значения в OptToSave из OptToDelete. Для этого необходимо, чтобы была привязка)
foreach ($categoriesWithOptToDelete as $cId) {
    $values = [
        'option_id' => $idOptToSave,
        'category_id' => $cId,
    ];

    $message = '';

    // Если такая привязка уже есть, то просто активируем
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
        // Если такой привязки нет, то добавляем
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

echo 'Конец работы с привязками<br><br>';


// ------------------------------------
// Копирование значений из ненужной опции в нужную опцию
// ------------------------------------
// Получаем ресурсы, у которых заполнена ненужная опция
$ids = $modx->runSnippet('msProducts', [
    'parents' => 0,
    'depth' => 9000,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'returnIds' => 1,
    'innerJoin' => '{"Options":{"class":"msProductOption"}}',
    'where' => '{"1":{"Options.key":"' . $keyOptToDelete . '","Options.value:IS NOT":null}}',
]);

$ids = explode(',', $ids);

// Копируем значения
foreach ($ids as $index => $id) {
    $prod = $modx->getObject('msProduct', $id);
    if (empty($prod)) {
        echo 'Не найден товар с id ' . $id . '<br>';
        continue;
    }

    $optToSave = $prod->get($keyOptToSave)[0];
    if (!empty($optToSave)) {
        echo 'Внимание! У товара ' . $id . ' опция "' . $keyOptToSave . '" не пустая. Пропускается работа с этим товаром<br>';
        continue;
    }

    $options = $prod->loadData()->get('options');
    $optToDelete = $prod->get($keyOptToDelete);
    $options[$keyOptToSave] = $optToDelete;

    echo 'У товара с id ' . $id . ' значение опции ' . $keyOptToDelete . ' (' . implode(',', $optToDelete) . ') будет перенесено в опцию ' . $keyOptToSave . '<br>';

    $prod->set('options', $options);

    if (!$isDebug) {
        $prod->save();
    }

    // Для отладки
    if ($isDebug) {
        if ($index >= 20) {
            break;
        }
    }
}

echo 'Конец работы с опциями<br>Конец работы скрипта';
