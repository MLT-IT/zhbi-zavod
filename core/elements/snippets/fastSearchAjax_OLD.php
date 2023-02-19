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
    return false;
}

$pdoTools = $modx->getService('pdoTools');
if (!$pdoTools) {
    $modx->log(MOD_LOG_LEVEL_ERROR, 'Couldn`t get pdoTools');
    return;
}

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
          
          LIMIT 10";

$stmt = $modx->prepare($query);
$queryResult = $stmt->execute($queryWordsArray);

if ($queryResult === false) {
    return false;
}

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (count($data)) {
    // Получение данных родителей
    $parentsValues = [];
    foreach ($data as $itemIndex => $itemValues) {
        $parentsValues[$itemIndex]['id'] = $itemValues['parent_id'];
        $parentsValues[$itemIndex]['pagetitle'] = $itemValues['parent_pagetitle'];
        $parentsValues[$itemIndex]['menutitle'] = $itemValues['parent_menutitle'];
        unset($data[$itemIndex]['parent_id']);
        unset($data[$itemIndex]['parent_pagetitle']);
        unset($data[$itemIndex]['parent_menutitle']);
    }

    // Удаление повторяющихся родителей
    $uniqueParentsIndexes = array_unique(array_column($parentsValues, 'id'));
    $parentsValues = array_intersect_key($parentsValues, $uniqueParentsIndexes);

    // Получение товаров для вывода
    $products = $getData($data, $tplProduct);
    // Получение категорий для вывода
    $categories = $getData($parentsValues, $tplCategory);

    // Формирование данных для вывода товаров
    $result = $pdoTools->getChunk($tplWrapper, [
        'products' => $products,
        'categories' => $categories,
    ]);
} else {
    $result = null;
}

die($result);
