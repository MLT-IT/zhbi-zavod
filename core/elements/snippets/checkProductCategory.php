<?php

/**
 * Принимает $catIds (обязательно) - строка с категориями, которые надо проверить.
 * Принимает $prodId (необязательно) - id товара, который проверяем на вывод в категориях $catIds.
 */

// Установка $prodId - если он не отправлен в сниппет
if (empty($prodId)) {
    $prodId = $modx->resource->id;
}

// Проверка обязательного параметра $catIds
if (empty($catIds)) {
    return;
}

$cacheName = 'checkProductCategory-' . $prodId . '-' . md5($catIds);
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/checkProductCategory/' . $modx->context->key . '/',
];

$result = $modx->cacheManager->get($cacheName, $cacheOptions);
if (!$result && $result !== false) {
    $result = false;

    // Возможно, РОДИТЕЛЬ явлется одной из тех категорий, которая нам нужна
    $catIdsArray = explode(',', $catIds);
    if (in_array($modx->resource->parent, $catIdsArray)) {
        $result = true;
    } // РОДИТЕЛЬ не является ни одной из тех категорий, которая нам нужна
    else {
        $table = $modx->getOption('table_prefix') . 'ms2_product_categories';
        $query = "SELECT *
          FROM $table
          WHERE product_id = $prodId AND category_id IN ($catIds)";

        $items = $modx->query($query);
        $items = $items->fetchAll(PDO::FETCH_ASSOC);

        $result = !empty($items);
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
