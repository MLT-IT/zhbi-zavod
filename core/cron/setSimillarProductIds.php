<?php

/**
 * генерирует TV - simillarProductIds с похожими ID товаров по характеристикам сохраняемого 
 */


//--- Подключаем MODX
@include_once(dirname(dirname(__DIR__)) . '/config.core.php');
@include_once(dirname(dirname(__DIR__)) . '/core/model/modx/modx.class.php');

$modx = new modX();
$modx->initialize('mgr');
//---

const SET_TV_NAME = 'simillarProductIds'; // TV куда сохранять результат
const ALLOWED_CONTEXTS = ['krovelnyjstroymarket']; // Доступные для данного действия контексты
const IGNORE_OPTIONS = ['edizm', 'edizm2', 'cvet'];
const LIMIT = 8;


$products = $modx->getCollection('modResource', [
    'class_key' => 'msProduct',
    'context_key:IN' => ALLOWED_CONTEXTS
]);

foreach ($products as $product) {

    /**
     * Формируем массив с опциями товара
     */
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

    /** 
     * Запрос в базу
     */
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

    if (count($ids)) {
        $ids_str = implode(",", $ids);
        $product->setTVValue(SET_TV_NAME,  $ids_str);
    }
}
