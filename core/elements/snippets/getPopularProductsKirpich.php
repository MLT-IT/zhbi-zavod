<?php

/*
Кажется, этот сниппет нигде не используется.
Если все же используется, то нужно убедиться, что в $params, который передается сюда, нет returnIds. Если есть, то желательно заменить вызов msProductsMy на вызов msProducts. Но необязательно.
*/

/**
 * Принимает $params (обязательно) - массив с параметрами для вызова msProducts.
 */

// Проверка обязательного параметра
if (empty($params)) {
    return;
}

$cacheName = 'getPopularProductsKirpich-' . $modx->resource->id . '-'. md5(json_encode($optionFilters, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/getPopularProductsKirpich/'
];

$result = $modx->cacheManager->get($cacheName, $cacheOptions);
if (!$result && $result !== '') {
    $product = $modx->resource;

    $cvet = $product->get('cvet');
    $ottenok = $product->get('ottenok');
    $factura = $product->get('factura')[0];

    $optionFilters = [];

    if (!empty($cvet)) {
        $optionFilters['cvet:IN'] = $cvet;
    }
    if (!empty($ottenok)) {
        $optionFilters['ottenok:IN'] = $ottenok;
    }
    if (!empty($factura)) {
        $optionFilters['factura:='] = $factura;
    }

    $count = 0;
    foreach ($optionFilters as $key => $val) {
        $count++;
        if ($count == 1) {
            continue;
        }

        // Вроде бы "AND" не работает в optionFilters. Нужно переписывать на обычном where. Но пока это не требуется
        //$optionFilters['AND:' . $key] = $val;
        //unset($optionFilters[$key]);
    }

    if (!empty($optionFilters)) {
        $optionFilters = json_encode($optionFilters, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        $params['optionFilters'] = $optionFilters;
    }

    $result = $modx->runSnippet('msProductsMy', $params);

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
