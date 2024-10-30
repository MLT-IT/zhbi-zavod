<?php

$context = $modx->resource->get('context_key');

$cacheName = 'createMenu';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $data_path = MODX_CORE_PATH . 'elements/snippets/create-menu/data/' . $context . '.php';

    if (!file_exists($data_path)) {
        $modx->log(1, 'Не найден файл для содания меню ');
        return;
    }

    require_once $data_path;
    $result = [
        'values' => getMenuData()
    ];

    switch ($context) {
        case 'web':
            $result['column1'] = ['title' => 'Товар', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Продуктовая линейка', 'type' => 'composite'];
            $result['column3'] = ['title' => 'Толщина', 'type' => 'composite'];
            $result['column4'] = ['title' => 'Применение', 'type' => 'composite'];
            $result['column5'] = ['title' => 'Производитель', 'type' => 'composite'];
            break;
        case 'plitnye':
            $result['column1'] = ['title' => 'Товар', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Категория', 'type' => 'composite'];
            $result['column3'] = ['title' => 'Толщина', 'type' => 'composite'];
            $result['column4'] = ['title' => 'Применение', 'type' => 'composite'];
            break;
        case 'stenovye':
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
        case 'suhiesmesi':
            $result['column1'] = ['title' => 'Товар', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Производитель', 'type' => 'simple'];
            break;

        case 'gibkaya-cherepiza':
            $result['column1'] = ['title' => 'Производитель', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Серия', 'type' => 'composite'];
            break;
        case 'falcevaya-krovlya':
            $result['column1'] = ['title' => 'Производитель', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Серия', 'type' => 'simple'];
            break;
        case 'metallocherepica':
            $result['column1'] = ['title' => 'Производитель', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Коллекция', 'type' => 'simple'];
            $result['column3'] = ['title' => 'Доборные элементы', 'type' => 'simple'];
            break;

        case 'fibrofasad':
            $result['column1'] = ['title' => 'Товар', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Категория', 'type' => 'simple'];
            break;
        case 'beltermo':
            $result['column1'] = ['title' => 'Марка', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Толщина', 'type' => 'composite'];
            $result['column3'] = ['title' => 'Тип кромки', 'type' => 'composite'];
            $result['column4'] = ['title' => '', 'type' => 'composite'];
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
        case 'tagnerud':
            $result['column1'] = ['title' => 'Керамзит', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Фракция', 'type' => 'simple'];
            break;
        case 'profnastil':
            $result['column1'] = ['title' => 'Применение', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Бренд', 'type' => 'simple'];
            break;
        default:
            $result['column1'] = ['title' => 'Товар', 'type' => 'simple'];
            $result['column2'] = ['title' => 'Производитель', 'type' => 'simple'];
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
