<?php

$context = $modx->resource->get('context_key');

$cacheName = 'createMenu';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    require_once MODX_CORE_PATH . 'elements/snippets/create-menu/data/' . $context . '.php';
    $result = [
        'values' => getMenuData()
    ];

    switch ($context) {
        case 'web':
            $result['column1'] = ['title' => 'Товар', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Продуктовая линейка', 'type' => 'composite'];
            $result['column3'] = ['title' => 'Толщина', 'type' => 'composite'];
            $result['column4'] = ['title' => 'Применение', 'type' => 'composite'];
            break;
        case 'gazosilikatstroy':
            $result['column1'] = ['title' => 'Товар', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Плотность', 'type' => 'simple'];
            $result['column3'] = ['title' => 'Размеры', 'type' => 'composite'];
            break;

        case 'kraska':
            $result['column1'] = ['title' => 'Раздел', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Подраздел', 'type' => 'simple'];
            break;
        case 'krovelnyjstroymarket':
            $result['column1'] = ['title' => 'Раздел', 'type' => 'simple'];
            $result['column2'] = ['title' => '', 'type' => 'composite'];
            $result['column_type_tovara'] = ['title' => 'Тип товара', 'type' => 'simple'];
            $result['column_vid'] = ['title' => 'Вид', 'type' => 'simple'];
            $result['column_tip'] = ['title' => 'Тип', 'type' => 'simple'];
            $result['column_proizvoditel'] = ['title' => 'Производитель', 'type' => 'simple'];
            $result['column_cvet'] = ['title' => 'Цвет', 'type' => 'composite'];
            $result['column_ottenok'] = ['title' => 'Оттенок', 'type' => 'simple'];
            $result['column_collection'] = ['title' => 'Коллекция', 'type' => 'simple'];
            $result['column_tolshina'] = ['title' => 'Толщина', 'type' => 'simple'];
            $result['column_naznachenie'] = ['title' => 'По назначению', 'type' => 'simple'];
            $result['column_pokritie'] = ['title' => 'Покрытие', 'type' => 'simple'];
            $result['column_profil'] = ['title' => 'Профиль', 'type' => 'simple'];
            $result['column_forma'] = ['title' => 'Форма', 'type' => 'simple'];
            $result['column_material'] = ['title' => 'Материал', 'type' => 'simple'];
            break;
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
