<?php

/**
 * Сниппет получает галерею товара и преобразует в необходимый массив данных
 *
 * @product_id - ID товара
 * @limit - Лимит картинок
 */

if (!$product_id) {
    return;
}

// >>> cache
$cacheName = $product_id;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/getProductGallery/' . $modx->context->key . '/' . $modx->resource->id . '/',
];
// <<<

if (!$output = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $output = [];

    $query = $modx->newQuery('msProductFile');
    $query->where([
        'product_id' => $product_id,
        'path:LIKE' => '%small%'
    ]);
    $query->limit($limit ?: 5);
    // $query->sortby('rank', 'asc');
    $files = $modx->getIterator('msProductFile', $query);

    foreach ($files as $file) {
        if (strpos($file->url, "small") == false) {
            continue;
        }
        // $output[] = [
        //     "url" => str_replace("small/", "", $file->url),
        //     "thumb" => $file->url,
        // ];

        $output[] = $file->url;
    }

    $modx->cacheManager->set($cacheName, $output, 0, $cacheOptions);
}

return $output;
