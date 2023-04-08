<?php

// TODO: по-хорошему, это надо как-нибудь объединить с fastSearch.php, т.к. код почти одинаковый.

/**
 * Сниппет выводит быстрые результаты при вводе запроса в поле поиска
 */
if ($_SERVER['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest' || empty($_REQUEST['action']) || $_REQUEST['action'] !== 'fast-search') {
    return;
}

$queryPhrase = trim($_GET['query']);
if (empty($queryPhrase)) {
    die(null);
}

$pdoTools = $modx->getService('pdoTools');
if (!$pdoTools) {
    $modx->log(MOD_LOG_LEVEL_ERROR, 'Couldn`t get pdoTools');
    return;
}
$CATEGORIES_LIMIT = 16;
$PRODUCTS_LIMIT = 10;

// Функция для занесения данных в чанки
$getData = function ($resourcesData, $chunk) use ($pdoTools) {
    $result = '';

    foreach ($resourcesData as $data) {
        $menutitle = $data['menutitle'] ?: $data['pagetitle'];
        $uri = $pdoTools->makeUrl($data['id']);
        $image = $data['thumb'] ?: '';

        $result .= $pdoTools->getChunk($chunk, [
            'menutitle' => $menutitle,
            'uri' => $uri,
            'image' => $image
        ]);
    }

    return $result;
};

// Формирование where
$wherePagetitle = [];
$wherePagetitle_category = [];
$queryWordsArray = [];

foreach (explode(' ', $queryPhrase) as $index => $queryWord) {
    if (stristr($queryWord, ',') || stristr($queryWord, '.')) {
        $queryWord = preg_replace('/[, .]/', '[,\.]', $queryWord);
        $wherePagetitle[$index] = '`msProduct`.`pagetitle` REGEXP :queryWord' . $index;
        $wherePagetitle_category[] = "`msProduct`.`pagetitle` REGEXP '$queryWord'";
    } else {
        $queryWord = '%' . $queryWord . '%';
        $wherePagetitle[$index] = '`msProduct`.`pagetitle` LIKE :queryWord' . $index;
        $wherePagetitle_category[] = "`msProduct`.`pagetitle` LIKE '$queryWord'";
    }
    $queryWordsArray['queryWord' . $index] = $queryWord;
}

$wherePagetitle = '(' . implode(' AND ', $wherePagetitle) . ')';
$queryWordsArray['queryPhrase'] = '%' . $queryPhrase . '%';
$whereArticle = '(`Data`.`article` LIKE :queryPhrase)';
$where = $wherePagetitle . ' OR ' . $whereArticle;
$where_category = '(' . implode(' AND ', $wherePagetitle_category) . ')';

// Получение данных из БД
$query = "SELECT `msProduct`.`id`, `msProduct`.`menutitle`, `msProduct`.`pagetitle`, `Data`.`thumb`, `Parent`.`id` AS parent_id, `Parent`.`pagetitle` AS parent_pagetitle, `Parent`.`menutitle` AS parent_menutitle
            
          FROM `modx_site_content` AS `msProduct` 
            
          LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` =  `Data`.`id` 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `msProduct`.`id` AND `TVhitspage`.`tmplvarid` = 7 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `msProduct`.`id` AND `TVpriority1`.`tmplvarid` = 17 
          LEFT JOIN `modx_site_content` `Parent` ON `Parent`.`id` = `msProduct`.`parent`

          WHERE  `msProduct`.`class_key` = 'msProduct' 
                AND `msProduct`.`published` = 1 
                AND `msProduct`.`deleted` = 0 
                AND `msProduct`.`context_key` = '" . $modx->context->key . "'
                AND ($where)  
            
          GROUP BY msProduct.id 
          ORDER BY CAST(`TVpriority1`.`value` AS DECIMAL(13,3)) ASC, CAST(`TVhitspage`.`value` AS DECIMAL(13,3)) ASC
          
          #LIMIT 10";

$stmt = $modx->prepare($query);
$queryResult = $stmt->execute($queryWordsArray);

if ($queryResult === false) {
    $result = null;
}

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (count($data)) {
    // Получение данных
    $parentsValues = [];
    $productsValues = [];
    foreach ($data as $itemIndex => $itemValues) {
        if (count($parentsValues) < $CATEGORIES_LIMIT) {
            $parent_id = $itemValues['parent_id'];
            $parentsValues[$parent_id]['id'] = $itemValues['parent_id'];
            $parentsValues[$parent_id]['pagetitle'] = $itemValues['parent_pagetitle'];
            $parentsValues[$parent_id]['menutitle'] = $itemValues['parent_menutitle'];
        }
        if (count($productsValues) < $PRODUCTS_LIMIT) {
            $productsValues[$itemIndex]['id'] = $itemValues['id'];
            $productsValues[$itemIndex]['pagetitle'] = $itemValues['pagetitle'];
            $productsValues[$itemIndex]['menutitle'] = $itemValues['menutitle'];
            $productsValues[$itemIndex]['thumb'] = $itemValues['thumb'];
        }
    }

    // Получение товаров для вывода
    $products = $getData($productsValues, $tplProduct);
    // Получение категорий для вывода
    $categories = $getData($parentsValues, $tplCategory);

    // Формирование данных для вывода товаров
    $result = $pdoTools->getChunk($tplWrapper, [
        'products' => $products,
        'categories' => $categories,
    ]);
} else {

    $query = "SELECT `msProduct`.`id`, `msProduct`.`menutitle`, `msProduct`.`pagetitle`
            
          FROM `modx_site_content` AS `msProduct` 
            
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `msProduct`.`id` AND `TVhitspage`.`tmplvarid` = 7 
          LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `msProduct`.`id` AND `TVpriority1`.`tmplvarid` = 17 

          WHERE  `msProduct`.`class_key` = 'msCategory' 
                AND `msProduct`.`published` = 1 
                AND `msProduct`.`deleted` = 0 
                AND `msProduct`.`context_key` = '" . $modx->context->key . "'
                AND ($where_category)  
            
          GROUP BY msProduct.id 
          ORDER BY CAST(`TVpriority1`.`value` AS DECIMAL(13,3)) ASC, CAST(`TVhitspage`.`value` AS DECIMAL(13,3)) ASC
          
          LIMIT $CATEGORIES_LIMIT";

    $queryResult =  $modx->query($query);
    $data = $queryResult->fetchAll(PDO::FETCH_ASSOC);

    if (count($data)) {
        $categories = $getData($data, $tplCategory);

        $result = $pdoTools->getChunk($tplWrapper, [
            'categories' => $categories,
        ]);
    } else {
        $result = null;
    }
}

die($result);
