<?php

// Откликаться будет ТОЛЬКО на ajax запросы
if (empty($_SERVER['HTTP_X_REQUESTED_WITH']) || strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) != 'xmlhttprequest' || empty($_REQUEST['ajax_action'])) {
    return;
}

$result = '';
switch ($_REQUEST['ajax_action']) {
    case "prdouctImage":

        $product_id = $_REQUEST['product_id'];
        $sql = "SELECT * FROM modx_ms2_product_files WHERE product_id = " . $product_id;
        $statement = $modx->query($sql);
        $rows = $statement->fetchAll(PDO::FETCH_ASSOC);
        $count = count($rows);

        if($count > 0){
            $site_url = $modx->getOption("site_url");
            $site_url = "https://osnova.spb.ru/";
            $src =  $site_url . $rows[0]['url'];
        }

        $result = $modx->toJSON(
            [
                'success' => true,
                'count' => $count,
                'src' => $src
            ]);
        break;
}

exit($result);
