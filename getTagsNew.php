<?php
// -------------------------------
// Основные переменные
// -------------------------------
// Нужно для получения доступа к файловым сниппетам и чанкам
$pdoTools = $modx->getService('pdoTools');

// Какие теги исключить
$removeIds = [];
// Какие теги добавить
$addIds = [];

// Параметры для вызова сниппета, вывод которого будет в return
$params = [
    'parents' => $modx->resource->id,
    'tpl' => '@FILE sections/category/listing-tags-item.tpl',
    'tplWrapper' => "@FILE sections/category/listing-tags-wrapper.tpl",
    'templates' => '5,4',
    'includeTVs' => 'mainImage',
    'sortby' => 'menuindex',
    'sortdir' => 'ASC',
    'limit' => 0,
    'depth' => 0,
];


// -------------------------------
// Регионы для утеплителей
// -------------------------------
switch ($modx->resource->parent) {
    case 13127:
        $params['parents'] = 4;
        break;
    case 10987:
        $params['parents'] = 3028;
        break;
    case 13128:
        $params['parents'] = 3989;
        break;
    case 13129:
        $params['parents'] = 4950;
        break;
    case 13130:
        $params['parents'] = 5911;
        break;
    case 13131:
        $params['parents'] = 6872;
        break;
    case 13132:
        $params['parents'] = 7833;
        break;
}


// -------------------------------
// Спрятать ненужные теги на арматуре
// -------------------------------
if ($modx->resource->context_key === 'armatura-178') {
    $params['where'] = '{"hidemenu:=": 0}';
}


// -------------------------------
// Страница "Продажа досок" на Пиломатериалах
// -------------------------------
if ($modx->resource->id === 80986) {
    $params['parents'] = 0;

    // Id, которые нужно выводить в тегах
    $tagsIds = [
        48826,
        48827,
        48828,
        48825,

        80817,
        80818,
        80819,
        80820,
        80821,

        80823,
        80824,
        80825,
        80826,
        80827,
        80828,
        80829,

        80832,
        80833,
        80834,
        80835,
        80836,
    ];

    // Указываем параметры
    $params['resources'] = implode(',', $tagsIds);
}


/*
// -------------------------------
// Проверка tagsFromCatalog
// -------------------------------
if ($modx->resource->getTVValue('tagsFromCatalog') == 1) {
    $pdoTools->runSnippet('@FILE snippets/getIdByAlias.php', ['alias' => 'catalog']);
    $params['parents'] = $idCat;
    $removeIds[] = $modx->resource->id;
}


// -------------------------------
// Обработка removeCategories и addCategories
// -------------------------------
// Обработка TV removeCategories
$removeCategories = $modx->resource->getTVValue('removeCategories');
if (!empty($removeCategories)) {
    $removeCategories = explode(',', $removeCategories);
    $removeIds = array_merge($removeIds, $removeCategories);
    unset($removeCategories);
}

// Обработка TV addCategories
$addCategories = $modx->resource->getTVValue('addCategories');
if (!empty($addCategories)) {
    $addIds = explode(',', $addCategories);
}
*/


// -------------------------------
// Дополнительные теги из tv
// -------------------------------
$categoryCustomTags = $modx->resource->getTVValue('categoryCustomTags');
if (!empty($categoryCustomTags)) {
    $categoryCustomTags = json_decode($categoryCustomTags, 1);
    if (!is_null($categoryCustomTags) && $categoryCustomTags !== false) {
        $ids = array_column($categoryCustomTags, 'categoryId');
        if (!empty($ids)) {
            //if (!empty($params['resources'])) {
            //    $params['resources'] .= ',';
            //} else {
            //$params['resources'] = '';
            $params['parents'] = 0;
            //}

            $params['resources'] .= implode(',', $ids);
        }
    }
}


// -------------------------------
// Дополнительные теги для кровли
// -------------------------------
$extraTagsIdsArray = [56941, 15436];
$extraTagsIdsString = implode(',', $extraTagsIdsArray);
if (($modx->resource->context_key === 'krovlya') &&
    $modx->resource->template !== 4 &&
    !in_array($modx->resource->id, $extraTagsIdsArray)) {

    // Получаем все категории-потомки для $extraTagsIds, чтобы проверить, может, текущий ресурс - это один из них?
    $excludeDescendantsIds = $modx->runSnippet('pdoResources', [
        'parents' => $extraTagsIdsString,
        'templates' => '5,4',
        'depth' => 9000,
        'limit' => 0,
        'returnIds' => 1,
        'sortby' => 'id',
        'sortdir' => 'ASC',
    ]);
    $excludeDescendantsIds = explode(',', $excludeDescendantsIds);

    // Если текущий ресурс - это не тот тег, который мы хотим добавить к основным. И не его потомок. То добавляем дополнительные теги
    if (!in_array($modx->resource->id, $excludeDescendantsIds)) {
        // Если ресурсы определены, то просто добавляем в конец дополнительные id
        if (empty($params['resources'])) {
            // Получаем id дочерних элементов текущей категории. Это необходимо для вывода основных тегов, т.к. теперь вывожу теги я через resources
            $resourcesIds = $modx->runSnippet('pdoResources', [
                'parents' => $modx->resource->id,
                'templates' => '5,4',
                'depth' => 0,
                'limit' => 0,
                'returnIds' => 1,
            ]);
        } else {
            $resourcesIds = '';
        }

        if (!empty($resourcesIds)) {
            $resourcesIds = $resourcesIds . ',';
        }

        $resourcesIds = $resourcesIds . $extraTagsIdsString;
        $params['resources'] = $resourcesIds;
        $params['parents'] = 0;
    }
}


// -------------------------------
// Сортировка для ресурсов
// -------------------------------
if (!empty($params['resources'])) {
    $params['sortby'] = 'FIELD(id, "'.$params['resources'].'")';
}


// -------------------------------
// Результат
// -------------------------------
return $modx->runSnippet('pdoResources', $params);
