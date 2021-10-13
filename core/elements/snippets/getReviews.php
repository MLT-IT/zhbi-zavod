<?php

$reviews = '';

$currentResource = $modx->resource;

// 10 - максимальная вложенность
for ($i = 0; $i < 10; $i++) {
    $parentId = $currentResource->parent;

    // Если родителей больше нет
    if (empty($parentId)) {
        break;
    }

    $parent = $modx->getObject('modResource', $parentId);

    // Если по какой-то причине не удалось получить родителя
    if (empty($parent)) {
        break;
    }

    $reviews = $parent->getTVValue('categoryReviews');

    if (!empty($reviews)) {
        break;
    }

    $currentResource = $parent;
}

return $reviews;
