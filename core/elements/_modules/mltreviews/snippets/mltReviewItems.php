<?php
/**
 * @var int $user_reviews - Если 1 то выведет ожидающие модерации отзывы пользователя
 * @var int $resource_id - ID ресурса к которому привязаны отзывы
 * @var string $tpl - Обертка отзыва
 * @var string $tplOuter - Обертка отзывов
 * @var string $ratingRowClass - Класс для обертки рейтинга
 * @var string $ratingItemClass - Класс для элемента рейтинга
 */

if (!$pdoTools = $modx->getService("pdoTools")) return;

// Если это вызов неопубликованных комментариев пользователя, то проверяем их дату, и если дата больше user_reviews_days_difference то выводим его на страницу как опубликованный
if (!function_exists('publishedUserReview')) {
    function publishedUserReview($review)
    {
        $user_reviews_days_difference = 3; // Если отзыв пользователя старше 3х дней - опубликовать

        $date_time = new DateTime($review->createdon);
        $current_date = new DateTime();

        $interval = $current_date->diff($date_time);
        $days_difference = $interval->days;

        if ($days_difference > $user_reviews_days_difference) {
            return true;
        } else {
            return false;
        }
    }
}

$modx->getService('mainService', 'mainService', MODX_CORE_PATH . 'components/mltreviews/services/');

if (empty($tpl)) {
    $tpl = '@FILE _modules/mltreviews/chunks/tplItemReview.tpl';
}
if (empty($tplOuter)) {
    $tplOuter =  '@FILE _modules/mltreviews/chunks/tplItemOuter.tpl';
}

$user_session = $_REQUEST['PHPSESSID'] ?: $_COOKIE['PHPSESSID'];

$startCount = $startCount ?: 6;
$limit = $limit ?: 0;

$where = [];
if ($user_reviews) {
    $where['session'] = $user_session;
    $where['published'] = 0;
}

if ($resource_id) {
    $where['resource_id'] = $resource_id;
}

$query = $modx->newQuery('mltReview');
if ($limit) {
    $query->limit($limit);
}
$query->where($where);
$items = $modx->getCollection('mltReview', $query);


$output = '';
$idx = 0;


foreach ($items as $item) {
    if (
        ($user_reviews && !publishedUserReview($item)) || // Если это найденные неопубликованные отзывы пользователя и они меньше определенного времени - публикуем
        (!$user_reviews && $user_session == $item->session && publishedUserReview($item)) // Если это отзыв принадлежит пользователю, и он старше 3х дней - публикуем
    ) {
        $item->set('published', 1);
    }

    if (!$item->published) continue;

    // if(isset($startCount) && $idx > $startCount) break;

    $rating_html = "<div class='$ratingRowClass'>";
    for ($i = 1; $i < $startCount; $i++) {
        if ($i <= $item->rating) $active_class = 'active';
        else $active_class = '';

        $rating_html .= "<span class='$ratingItemClass $active_class'></span>";
    }
    $rating_html .= "</div>";
    $itemArray = $item->toArray();
    $itemArray['hidden'] = $idx++ > $startCount;
    $output .= $pdoTools->getChunk($tpl, array_merge(['rating_html' => $rating_html], $itemArray));
}

if (!empty($output)) {
    // Оборачиваем результаты
    $output = $pdoTools->getChunk($tplOuter, [
        'items' => $output,
        'limit' => $limit,
        'startCount' => $startCount
    ]);
}

return $output;
