<?php

$cacheFolder = 'getReviews';
$cacheName = 'resource-' . $modx->resource->id;
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $currentResource = $modx->resource;
    $result = '{}';

    // 15 - максимальная вложенность
    for ($i = 0; $i < 15; $i++) {
        // Этот сниппет запускается на странице товара. Поэтому сначала проверяем отзывы у текущего ресурса, т.к. это 100% товар
        if ($i === 0) {
            $reviews = $currentResource->getTVValue('categoryReviews');

            if (!empty($reviews)) {
                break;
            }
        }

        // Получаем id родителя
        $parentId = $currentResource->parent;

        // Если родителя нет, то выходим из цикла
        if (empty($parentId)) {
            break;
        }

        // Получаем ресурс по id родителя
        $parent = $modx->getObject('modResource', $parentId);

        // Если по какой-то причине не удалось получить ресурс, то выходим из цикла
        if (empty($parent)) {
            break;
        }

        // Получаем отзывы родителя
        $reviews = $parent->getTVValue('categoryReviews');

        // Если отзывы получены, то выходим из цикла
        if (!empty($reviews)) {
            break;
        }

        // Если отзывы не получены, то попробуем взять их у предка. И так по циклу
        $currentResource = $parent;
    }

    if (!empty($reviews)) {
        $result = $reviews;
    }
    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
