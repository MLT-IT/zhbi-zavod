<?php
$error = [];
if (empty($_POST['ID'])) {
    $error['ID'] = 'Нет данных о ресурсе';

}

if (empty($_POST['NAME'])) {
    $error['NAME'] = 'Вы не заполнили имя';

}
if (empty($_POST['TEXT'])) {
    $error['TEXT'] = 'Вы не заполнили текст отзыва';
}

$text = $_POST['TEXT'];
$author = $_POST['NAME'];
$idResource = $_POST['ID'];

if(!empty($text) && !empty($author) && !empty($idResource)){
    $date = date("D M d, Y G:i");
    $value =  $_POST['RATING'];

    $res = $modx->getObject('modResource', $idResource);

    $mas = json_decode($res->getTVValue("categoryReviews"), true);

    if(!function_exists('createReview')){
        function createReview(
            $id, $author, $date, $value, $text
        ){
            $review =[];
            $review['MIGX_id'] = $id;
            $review['author'] = $author;
            $review['date'] = $date;
            $review['value'] = $value;
            $review['text'] = $text;
            $review['status'] = 0;
            return $review;
        }
    }

    if(!empty($mas)){
        $endElement = end($mas);
        $id = $endElement['MIGX_id'] + 1;
        $review = createReview($id, $author, $date, $value, $text);
        $mas[] = $review;
        $jsonMas = json_encode($mas);
        $res->setTVValue('categoryReviews', $jsonMas);

    }else{
        $id = 1;
        $review = createReview($id, $author, $date, $value, $text);
        $masNew = [];
        $masNew[] = $review;
        $jsonMas = json_encode($masNew);
        $res->setTVValue('categoryReviews', $jsonMas);
    }
    return $AjaxForm->success('Форма прошла проверку');
    
}else{
    return $AjaxForm->error('Ошибки в форме',$error);
}