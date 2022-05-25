<?php

/**
 * Данный сниппет заменяет excludeIds. В отличие от excludeIds, он не только исключает id определенных категорий из выборки, но и добавляет дополнительные.
 * Создавался, чтобы выводить в категориях на кровле дополнительные товары (из категорий 56941,15436). Но из-за этого страницы стали тормозить, т.к. товаров стало слишком много. В итоге мы выводим дополнительные теги (56941,15436). А товары те же.
 *
 * Принимает $isSeoPage
 */

// TODO: Почти такой же код, как в чанке listing-tags.tpl. Думаю, эти коды можно объединить, чтобы страница загружалась быстрее. Но это не очень просто. И ненамного ускорит загрузку. *}

// ------------------------------------
// Определение функций
// ------------------------------------
if (!function_exists('excludeIds_checkCategory')) {
    /**
     * Проверяет, находится ли $catId в массиве $arrayIds. Если нет, то получает категории-потомки для каждой категории в $arrayIds. И снова проверяет. Если снова нет, то возвращает $arrayIds с категориями-потомками.
     * @param $catId
     * @param $arrayIds
     * @return array
     */
    function excludeIds_checkCategory($catId, $arrayIds) {
        global $modx;
        $result = [];

        if (!in_array($catId, $arrayIds)) {
            // Получаем дочерние ресурсы
            $arrayIdsDescendant = $modx->runSnippet('pdoResources', [
                'parents' => implode(',', $arrayIds),
                'depth' => 500,
                'limit' => 0,
                'returnIds' => 1,
                'where' => '{"template:=":"5"}',
                'sortby' => 'id',
                'sortdir' => 'ASC'
            ]);
            $arrayIdsDescendant = explode(',', $arrayIdsDescendant);

            // Еще раз проверяем (теперь с дочерними)
            if (!in_array($catId, $arrayIdsDescendant)) {
                // Совмещаем дочерние с основными
                $arrayIds = array_merge($arrayIds, $arrayIdsDescendant);

                // Помещаем в $result
                $result = $arrayIds;
            }
        }

        return $result;
    }
}


// ------------------------------------
// Основные переменные
// ------------------------------------
// $pdo - нужен, чтобы вызывать файловые сниппеты
$pdo = $modx->getService('pdoTools');
// Родитель
$parent = $modx->resource->id;
// Результат
$result = [];
// Категории, которые не должны выводиться в каталоге
$excludeIdsCatalog = [];
// id текущей категории (ресурса)
$catId = $modx->resource->get('id');
// Дополнительные категории
$includeIds = [];
// Условия, они понадобятся дальше
$condIsCatalog = $modx->resource->template === 4;
$condIsSeoPage = $isSeoPage;


// ------------------------------------
// Определяем категории, товары которых нужно выводить во всех категориях (кроме дочерних от этих категорий)
// Здесь !$condIsCatalog, чтобы не было не нужных вычислений, т.к. ниже в коде написано, что именно эти ресурсы не должны быть в каталоге
// ------------------------------------
if ($modx->resource->context_key === 'krovlya' && !$condIsCatalog) {
    $includeIds = [
        56941, // Комплектующие
        15436  // Доборные элементы для кровли
    ];

    $includeIds = excludeIds_checkCategory($catId, $includeIds);
}


// ------------------------------------
// Если это страница с шаблоном Каталог, то определяем категории, которые не должны выводиться в каталоге
// ------------------------------------
if ($condIsCatalog) {
    $excludeIdsCatalog = [
        9125,  // Сопутствующие товары Penoplex
        10594, // Сопутствующие товары Rockwool
        10998, // Сопутствующие товары Технониколь
        49018, // Комплектующие к арматуре
        56941, // Комплектующие (krovlyasp)
        15436  // Доборные элементы для кровли
    ];

    // Получаем категории-потомки для таких категорий. Их id тоже надо будет добавить
    $excludeIdsCatalogDescendant = $modx->runSnippet('pdoResources', [
        'parents' => implode(',', $excludeIdsCatalog),
        'depth' => 500,
        'limit' => 0,
        'returnIds' => 1,
        'where' => '{"template:=":"5"}',
        'sortby' => 'id',
        'sortdir' => 'ASC'
    ]);

    $excludeIdsCatalogDescendant = explode(',', $excludeIdsCatalogDescendant);
    $excludeIdsCatalog = array_merge($excludeIdsCatalog, $excludeIdsCatalogDescendant);
}


// ------------------------------------
// Определяем категории, товары которых нужно выводить отдельно. Под "отдельно" подразумевается то, что они должны выводиться ТОЛЬКО у своих родителей и потомков родителей
// ------------------------------------
$excludeIds = [];
switch ($modx->resource->context_key) {
    case 'krovlya':
        $excludeIds[] = 16784; // Ондутисс
        $excludeIds[] = 16786; // Комплектующие для Ондулина
        $excludeIds[] = 66861; // Комплектующие Braas
        break;

    case 'fasady-pro':
        $excludeIds[] = 29922; // Комплектующие Grand Line
        break;
}

if (!empty($excludeIds)) {
    $result = excludeIds_checkCategory($catId, $excludeIds);
}


// ------------------------------------
// Проверка на Каталог и msProductsComposerSelection
// ------------------------------------
if ($condIsCatalog || $condIsSeoPage) {
    $catalogId = $pdo->runSnippet('@FILE snippets/getIdByAlias.php', [
        'alias' => 'catalog'
    ]);

    // Независимо от параметров msProductsComposerSelection для ресурса с шаблоном "Каталог" устанавливаем родителя - ресурс с псевдонимом catalog. Почему?
    // 1. Если это страница msProductsComposerSelection, то товаров у нее нет - они должны браться из Каталога.
    // 2. Бывает такое, что аргументы msProductsComposerSelection пустые. Я так понимаю, такие страницы делаются, чтобы изменить мета-теги (h1, title...). Вот пример такой страницы: https://www-minvata.ru/gatchina/ . Если не задать родителя, то выборка будет из текущего ресурса. А он пустой.
    $parent = $catalogId;

    // Добавляем в исключение из вывода те категории, которые там не должны выводиться
    if ($condIsCatalog) {
        $result = array_merge($result, $excludeIdsCatalog);
    }

    // Если это страница msProductsComposerSelection, то товаров у нее нет - они должны браться из Каталога. Но исключать товары, которых не должно быть в каталоге, не надо
    if ($condIsSeoPage) {
        $parent = $catalogId;
    }
}


// ------------------------------------
// Формируем результат
// ------------------------------------
// Обрабатываем на уникальность
$result = array_unique($result);

// Обрабатываем $includeIds на конфликты с $result (по идее конфликтов не должно быть. Но вдруг они почему-то есть)
$includeIds = array_diff($includeIds, $result);

// Добавляем минусы в $result, чтобы исключить данные категории из выборки
$result = array_map(function ($elem) {
    return '-' . $elem;
}, $result);

// Добавляем родителя
array_unshift($result, $parent);

// Добавляем дополнительные категории
$result = array_merge($result, $includeIds);

// Возвращаем результат
return implode(',', $result);
