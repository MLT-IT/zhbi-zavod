<?php
/*
* Сниппет выводит быстрые результаты при вводе запроса в поле поиска
*/
if ($_SERVER['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest' || empty($_REQUEST['action']) || $_REQUEST['action'] !== 'fast-search') return;

$pdoTools = $modx->getService('pdoTools');
if (!$pdoTools) {
    $modx->log(MOD_LOG_LEVEL_ERROR, 'Couldn`t get pdoTools');
    return;
}

$getData = function ($resources, $chunk) use ($pdoTools) {
    $data = '';
    foreach ($resources as $resource) {
        if ($resource->menutitle) {
            $menutitle = $resource->menutitle;
        } else {
            $menutitle = $resource->pagetitle;
        }

        $data .= $pdoTools->getChunk($chunk, [
            'menutitle' => $menutitle,
            'uri' => $resource->uri,
            'image' => $resource->get('thumb')
        ]);
    }
    return  $data;
};

$getCategoryIds = function ($product_resources) {
    $category_ids = [];
    foreach ($product_resources as $product_resource) {
        $category_ids[] = $product_resource->parent;
    }
    return  $category_ids;
};

$where  = [
    [
        'class_key' => 'msProduct',
        'context_key' => $modx->context->key,
        'published' => 1
    ]
];
foreach (explode(' ', trim($_REQUEST['query'])) as $query_word) {
    if (stristr($query_word, ',') || stristr($query_word, '.')) {
        $where[]['pagetitle:REGEXP'] = preg_replace('/[, .]/', '[,\.]', $query_word);
    } else {
        $where[]['pagetitle:LIKE'] = '%' . $query_word . '%';
    }
}
$modx_query = $modx->newQuery('modResource');
$modx_query->where($where);
$modx_query->limit(10);

$product_resources = $modx->getCollection('modResource', $modx_query);
$category_resources = $modx->getCollection('modResource', ['id:IN' => $getCategoryIds($product_resources)]);

$products = $getData($product_resources, $tplProduct);
$categories = $getData($category_resources, $tplCategory);

// Формируем результат
if ($products || $categories) {
    $result = $pdoTools->getChunk($tplWrapper, [
        'products' => $products,
        'categories' => $categories,
    ]);
} else {
    $result = null;
}

die($result);
