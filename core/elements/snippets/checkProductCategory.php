<?php

/**
 * $catIds (обязательно) - строка с id категорий, которые надо проверить.
 * $prodId (необязательно) - id товара, который проверяем на нахождение в категориях $catIds. По умолчанию берется id текущего товара.
 * $mode (необязательно) - 1 или 2. По умолчанию указано 1 - это означает, что нахождение товара будет проверяться за счет дополнительных категорий и родителя. Можно указать 2 - это означает, что нахождение товара будет проверяться в $catIds и всех его (их) потомках.
 */

// Проверка обязательного параметра $catIds
if (empty($catIds)) {
    return;
}

// Установка $prodId - если он не отправлен в сниппет
if (empty($prodId)) {
    $prodId = $modx->resource->id;
}

// Установка $mode - если он не отправлен в сниппет
if (empty($mode) || in_array($mode, [1, 2])) {
    $mode = 1;
}

$cacheName = 'checkProductCategory-' . $prodId . '-' . md5($catIds . $mode);
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/checkProductCategory/' . $modx->context->key . '/',
];

$result = $modx->cacheManager->get($cacheName, $cacheOptions);
if (!$result && $result !== false) {
    $result = false;

    switch ($mode) {
        case 1:
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
            break;

        case 2:
            $ids = $modx->runSnippet('pdoResources', [
                'parents' => $catIds,
                'limit' => 0,
                'depth' => 1000,
                'returnIds' => 1,
                'where' => '{"template:=":"5"}',
            ]);

            if (empty($ids)) {
                $ids = $catIds;
            } else {
                $ids .= ',' . $catIds;
            }

            $ids = explode(',', $ids);
            $result = in_array($prodId, $ids);

            break;
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
