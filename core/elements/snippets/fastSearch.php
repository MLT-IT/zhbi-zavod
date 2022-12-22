<?php

/**
 * Сниппет выводит быстрые результаты на странице поиска
 */
$queryWord = $_GET['query'];
if (empty($queryWord)) {
    return false;
}

// Формирование where
$where = [];
$queryWordsArray = [];
foreach (explode(' ', $queryWord) as $index => $queryWord) {
    if (stristr($queryWord, ',') || stristr($queryWord, '.')) {
        $queryWord = preg_replace('/[, .]/', '[,\.]', $queryWord);
        $where[$index] = 'pagetitle REGEXP :queryWord' . $index;
    } else {
        $queryWord = '%' . $queryWord . '%';
        $where[$index] = 'pagetitle LIKE :queryWord' . $index;
    }
    $queryWordsArray['queryWord' . $index] = $queryWord;
}
$where = implode(' AND ', $where);

// Получение данных из БД
$query = "SELECT `msProduct`.`id` 
            
          FROM `modx_site_content` AS `msProduct` 
            
          LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` =  `Data`.`id` 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `msProduct`.`id` AND `TVhitspage`.`tmplvarid` = 7 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `msProduct`.`id` AND `TVpriority1`.`tmplvarid` = 17 
            
          WHERE  (`msProduct`.`class_key` = 'msProduct' 
                AND `msProduct`.`published` = 1 
                AND `msProduct`.`deleted` = 0 
                AND `msProduct`.`context_key` = '" . $modx->context->key . "'
                AND $where)  
            
          GROUP BY msProduct.id 
          ORDER BY CAST(`TVpriority1`.`value` AS DECIMAL(13,3)) ASC, CAST(`TVhitspage`.`value` AS DECIMAL(13,3)) ASC";

$stmt = $modx->prepare($query);
$queryResult = $stmt->execute($queryWordsArray);

if ($queryResult === false) {
    return false;
}

$data = $stmt->fetchAll(PDO::FETCH_COLUMN);
return [
    'ids' => implode(',', $data),
    'amount' => count($data)
];
