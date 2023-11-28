<?php

/**
 * Снипет для поиска товаров по смежным опциям, возвращает id товары у каоторых есть смежные опции
 *
 * @params $jsonParams ключи для поиска
 * пример ключей '{ "tip":"Волновой" , "garantiya":"15" , "unit":"шт" , "item_thickness":"5.2" ,
 *                 "item_width":"980" , "item_length":"1750" , "sostav":"Цемент, хризотил, вода" ,
 *                 "ploshad_m2":"1.34" , "massa":"20.8" , "kolichestvo-voln":"7" , "shagvolny":"150" ,
 *                 "vysota-volny":"40" }
 * @params $limit максимальное кол возвращаемых ключей по умолчанию
 * @params $returnString вывод id в виде строки через ,
 * @params $ignoreId не включать в выборку id товара
 * @author Ivan Zhiltsov @devmonolit
 *
 **/


// оставлю тут для дебага
//$jsonParams = '{ "tip":"Волновой" , "garantiya":"15" , "unit":"шт" , "item_thickness":"5.2" , "item_width":"980" , "item_length":"1750" , "sostav":"Цемент, хризотил, вода" , "ploshad_m2":"1.34" , "massa":"20.8" , "kolichestvo-voln":"7" , "shagvolny":"150" , "vysota-volny":"40" }';

if (!isset($limit)) {
    $limit = 8;
}
$searchParams = json_decode($jsonParams, true);

$count = 0;

foreach ($searchParams as $key => $value) {
    if ($count != 0) {
        $where .= " OR ";
    }
    $where .= "(`key` = '" . $key . "' AND `value` = '" . $value . "')";
    $count++;
}


$sql = "SELECT product_id
        FROM modx_ms2_product_options
        WHERE " . $where . "
        GROUP BY product_id";


if ($count > 1) {
    $sql .= " HAVING COUNT(DISTINCT `key`) = " . $count;
}

$sql .= " LIMIT " . $limit;


$productsIds = [];
$statement = $modx->prepare($sql);
if ($statement->execute()) {
    $items = $statement->fetchAll(PDO::FETCH_ASSOC);
    foreach ($items as $item) {
        if($ignoreId !=  $item['product_id'])
        {
            $productsIds[] = $item['product_id'];
        }
    }
}

if($returnString)
{
    return implode(",", $productsIds);
}
return $productsIds;