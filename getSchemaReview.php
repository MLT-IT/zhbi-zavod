<?php
// ------------------------------------
// Основные переменные для работы. И проверка - выполняться ли скрипту
// ------------------------------------
$review = []; // "Случайный" отзыв категории
$reviewAggregate = []; // Все отзывы текущей категории и ее подкатегорий
$result = []; // Результат

if (!empty($idCat)) {
    // Если это главная, то берем рандомную категорию
    $idRes = $modx->runSnippet('pdoResources', [
        'limit' => 1,
        'parents' => $idCat,
        'returnIds' => 1,
        'includeTVs' => 'categoryReviews',
        'where' => '{"template:=":"5", "AND:categoryReviews:IS NOT": null, "AND:categoryReviews:!=": ""}'
    ]);
    if (!empty($idRes)) {
        $resource = $modx->getObject('modResource', $idRes);
    }
} else {
    // Если это категория, то текущую категорию
    $resource = $modx->resource;
}

if (empty($resource)) {
    return $result;
}

// ------------------------------------
// Функции для работы
// ------------------------------------
// Приведение даты в нужный формат (необходимо для "случайного" отзыва)
if (!function_exists('categoryReviewsHandleData')) {
    function categoryReviewsHandleData($date) {
        $date = explode('.', $date);
        $newDate = array_reverse($date);
        return implode('-', $newDate);
    }
}

// Подсчитать кол-во товаров в категории
if (empty($categoryReviewsCountChildren)) {
    $categoryReviewsCountChildren = function ($id) use ($modx) {
        $children = $modx->runSnippet('pdoResources', [
            'parents' => $id,
            'limit' => 0,
            'depth' => 1,
            'where' => '{"template:=": "6"}',
            'returnIds' => 1
        ]);

        if (!empty($children)) {
            $children = mb_substr_count($children, ',');
            $children = $children + 1;
        } else {
            $children = 0;
        }

        return $children;
    };
}

// ------------------------------------
// Работа скрипта
// ------------------------------------
// Отзывы текущей категории
$tv = $resource->getTVValue('categoryReviews');

if (!empty($tv)) {
    $categoryReviews = json_decode($tv, 1);

    $isFirstTime = true;
    foreach ($categoryReviews as $rev) {
        if ($isFirstTime) {
            $review = $rev;
            $review['date'] = categoryReviewsHandleData($review['date']);
            $isFirstTime = false;
        }

        $rev['children'] = $categoryReviewsCountChildren($resource->id);
        $reviewAggregate[] = $rev;
    }
}

// Поиск дочерних категорий с отзывами (parents задан по умолчанию, поэтому его здесь нет)
$ids = $modx->runSnippet('pdoResources', [
    'parents' => $resource->id,
    'returnIds' => 1,
    'depth' => 1,
    'where' => '{"categoryReviews:IS NOT": null}',
    'includeTVs' => 'categoryReviews',
    'limit' => 0
]);

// Получаем отзывы
if (!empty($ids)) {
    $ids = explode(',', $ids);

    foreach ($ids as $id) {
        $object = $modx->getObject('modResource', $id);
        $rev = $object->getTVValue('categoryReviews');
        $rev = json_decode($rev, 1);
        $children = $categoryReviewsCountChildren($id);

        foreach ($rev as $r) {
            $r['children'] = $children;
            $reviewAggregate[] = $r;
        }

        if (empty($review)) {
            $r = $rev[0];
            $r['date'] = categoryReviewsHandleData($r['date']);
            $review = $r;
        }
    }
}

if (!empty($review)) {
    $result['review'] = $review;
}

// Обрабатываем отзывы для вывода (если они есть)
if (!empty($reviewAggregate)) {
    // Установка переменных
    $ratingValue = 0; // Среднее значение всех отзывов с оценками
    $reviewCount = 0; // Количество отзывов
    $ratingCount = 0; // Количество отзывов с оценками

    foreach ($reviewAggregate as $rev) {
        $withRating = !empty($rev['value']) && intval($rev['value']) > 0;

        if (!empty($rev['children'])) {
            $reviewCount += $rev['children'];

            if ($withRating) {
                $ratingCount += $rev['children'];
                $ratingValue += intval($rev['value']) * $rev['children'];
            }
        }
    }

    // Подсчет среднего значения всех отзывов с оценками
    $ratingValue = round($ratingValue / $ratingCount, 1);

    $result['reviewCount'] = $reviewCount;
    $result['ratingValue'] = $ratingValue;
    $result['ratingCount'] = $ratingCount;

    exit(print_r($result, true));
}

return $result;
