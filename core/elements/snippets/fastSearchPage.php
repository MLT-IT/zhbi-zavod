<?php

/*
 * Сниппет выводит быстрые результаты на странице поиска
 */

$query_word = $_GET['query'];
if (empty($query_word)) {
    return false;
}

$context = $modx->context->key;

if (stristr($query_word, ',') || stristr($query_word, '.')) {
    $query_word = preg_replace('/[, .]/', '[,\.]', $query_word);
    $where = 'pagetitle REGEXP :query_word';
} else {
    $query_word = '%' . $query_word . '%';
    $where = 'pagetitle LIKE :query_word';
}

$query = "SELECT `msProduct`.`id` -- , IFNULL(`TVhitspage`.`value`, '') AS `HitsPage`, IFNULL(`TVpriority1`         .`value`, '') AS `priority1` 
            
          FROM `modx_site_content` AS `msProduct` 
            
          LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` =  `Data`.`id` 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `msProduct`.`id` AND `TVhitspage`.`tmplvarid` = 7 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `msProduct`.`id` AND `TVpriority1`.`tmplvarid` = 17 
            
          WHERE  (`msProduct`.`class_key` = 'msProduct' 
                AND `msProduct`.`published` = 1 
                AND `msProduct`.`deleted` = 0 
                AND `msProduct`.`context_key` = '$context'
                AND $where)  
            
          GROUP BY msProduct.id 
          ORDER BY CAST(`TVpriority1`.`value` AS DECIMAL(13,3)) ASC, CAST(`TVhitspage`.`value` AS DECIMAL(13,3)) ASC";

$stmt = $modx->prepare($query);
$queryResult = $stmt->execute(['query_word' => $query_word]);

if ($queryResult === false) {
    return false;
}

$data = $stmt->fetchAll(PDO::FETCH_COLUMN);
return [
    'ids' => implode(',', $data),
    'amount' => count($data)
];
