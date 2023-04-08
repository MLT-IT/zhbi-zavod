<?php

// TODO: по-хорошему, это надо как-нибудь объединить с fastSearchAjax.php, т.к. код почти одинаковый.

/**
 * Сниппет выводит быстрые результаты на странице поиска
 */
$queryPhrase = trim($_GET['query']);
if (empty($queryPhrase)) {
    return false;
}

// Формирование where
$wherePagetitle = [];
$queryWordsArray = [];

foreach (explode(' ', $queryPhrase) as $index => $queryWord) {
    if (stristr($queryWord, ',') || stristr($queryWord, '.')) {
        $queryWord = preg_replace('/[, .]/', '[,\.]', $queryWord);
        $wherePagetitle[$index] = '`msProduct`.`pagetitle` REGEXP :queryWord' . $index;
    } else {
        $queryWord = '%' . $queryWord . '%';
        $wherePagetitle[$index] = '`msProduct`.`pagetitle` LIKE :queryWord' . $index;
    }
    $queryWordsArray['queryWord' . $index] = $queryWord;
}

$wherePagetitle = '(' . implode(' AND ', $wherePagetitle) . ')';
$queryWordsArray['queryPhrase'] = '%' . $queryPhrase . '%';
$whereArticle = '(`Data`.`article` LIKE :queryPhrase)';
$where = $wherePagetitle . ' OR ' . $whereArticle;

// Получение данных из БД
$query = "SELECT `msProduct`.`id` 
            
          FROM `modx_site_content` AS `msProduct` 
            
          LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` =  `Data`.`id` 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `msProduct`.`id` AND `TVhitspage`.`tmplvarid` = 7 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `msProduct`.`id` AND `TVpriority1`.`tmplvarid` = 17 
            
          WHERE  `msProduct`.`class_key` = 'msProduct' 
                AND `msProduct`.`published` = 1 
                AND `msProduct`.`deleted` = 0 
                AND `msProduct`.`context_key` = '" . $modx->context->key . "'
                AND ($where) 
            
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
