<?php

/**
 * генерирует TV - simillarProductIds с похожими ID товаров по характеристикам сохраняемого 
 * 
 * Вызывать - php core/cron/setSimillarProductIds.php <НОМЕР ТЕКУЩЕГО ПОТОКА начинаем с 1> <КОЛ-ВО ПОТОКОВ>  
 * php core/cron/setSimillarProductIds.php 1 3
 * php core/cron/setSimillarProductIds.php 2 3
 * php core/cron/setSimillarProductIds.php 3 3
 */

//> Получаем аргументы
$flow_current = $argv[1]; // Номер текущего потока
$flow_count = $argv[2]; // Кол-во потоков
if (!isset($flow_current) || !isset($flow_count)) return 'Ошибка аргументов';
//<

//> Подключаем MODX
@include_once(dirname(dirname(__DIR__)) . '/config.core.php');
@include_once(dirname(dirname(__DIR__)) . '/core/model/modx/modx.class.php');

$modx = new modX();
$modx->initialize('mgr');
//<

//> Основные настройки
const SET_TV_NAME = 'simillarProductIds'; // TV куда сохранять результат
const ALLOWED_CONTEXTS = ['krovelnyjstroymarket']; // Доступные для данного действия контексты
const IGNORE_OPTIONS = ['edizm', 'edizm2', 'cvet'];
const LIMIT = 8;
//<

//> Рассчет $limit и $offset
$products_count = $modx->getCount('modResource', [
    'class_key' => 'msProduct',
    'context_key:IN' => ALLOWED_CONTEXTS
]);
$limit = ceil($products_count / $flow_count);
$offset = $limit * ($flow_current - 1);
if ($offset > $products_count) return;
//<

//> Получение товаров согласно полтоку
$query = $modx->newQuery('modResource');
$query->where([
    'class_key' => 'msProduct',
    'context_key:IN' => ALLOWED_CONTEXTS
]);
$query->limit($limit, $offset);
$products = $modx->getCollection('modResource', $query);
//<

foreach ($products as $product) {
    //> Формируем массив с опциями товара
    if ($data = $product->getOne('Data')) {
        $optionKeys = $data->getOptionKeys();
    }
    if (empty($optionKeys)) return '';

    $productData = $product->loadOptions();

    $options = [];
    foreach ($optionKeys as $key) {
        if (in_array($key, IGNORE_OPTIONS)) continue;
        $options[$key] = $product->get($key) ? $product->get($key)[0] : null;
    }
    //<

    //> Запрос в базу и получение ids похожих ресов
    $count = 0;
    $where = 'product_id != ' . $product->id . ' AND ';
    foreach ($options as $key => $value) {
        if ($count != 0) {
            $where .= " OR ";
        }
        $where .= "(`key` = '" . $key . "' AND `value` = '" . $value . "')";
        $count++;
    }
    $table_prefix = $modx->getOption('table_prefix');
    $sql = "SELECT product_id
                FROM {$table_prefix}ms2_product_options
                WHERE " . $where . "
                GROUP BY product_id";
    if ($count > 1) {
        $sql .= " HAVING COUNT(DISTINCT `key`) = " . $count;
    }
    $sql .= " LIMIT " . LIMIT;
    $ids = [];
    $statement = $modx->prepare($sql);
    if ($statement->execute()) {
        $items = $statement->fetchAll(PDO::FETCH_ASSOC);
        foreach ($items as $item) {
            $ids[] = $item['product_id'];
        }
    }
    //<

    if (count($ids)) {
        $ids_str = implode(",", $ids);
        $product->setTVValue(SET_TV_NAME,  $ids_str);
    }

    // echo "Поток: $flow_current; Ресурс: {$product->id}" . PHP_EOL;
}
