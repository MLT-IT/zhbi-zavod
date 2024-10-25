<?php

if (empty($tplWrapper)) {
    $tplWrapper = "@FILE modules/warehoses/chunks/wrapper.tpl";
}

if (empty($tpl)) {
    $tpl = "@FILE modules/warehoses/chunks/product-on-warehouse.tpl";
}

if (empty($parents)) {
    return "Не указан parents";
}

if (empty($unique)) {
    return "Не указан уникальный ключ (unique)";
}


if (empty($start)) {
    $start = 300;
}

if (empty($end)) {
    $end = 1600;
}

if (empty($prefix)) {
    $prefix = "л.";
}
if (empty($where)) {
    $where = [];
}


if (!function_exists("warehousesList")) {
    function warehousesList(
        string $tplWrapper,
        string $tpl = "@FILE modules/warehoses/chunks/product-on-warehouse.tpl",
        $parents,
        int $start,
        int $end,
        $unique,
        string $prefix,
        $where
    ) {
        /**@var ModX $modx */
        /**@var pdoTools $pdoTools */
        global $modx;

        $pdoTools = $modx->getService("pdoTools");
        $rows = "";
        $output = "";


        $productsIds = $modx->runSnippet("msProducts", [
            "parents" => $parents,
            "returnIds" => 1,
            "limit" => 0,
        ]);


        $products = $modx->getCollection("modResource", [
            "id:IN" => explode(",", $productsIds),
            "published" => 1,
            "deleted" => 0
        ]);

        foreach ($products as $product) {
            if (!empty($where)) {
                foreach ($where as $conditional) {
                    $parents = explode(",", $conditional["parents"]);
                    if (in_array($product->parent, $parents) && $conditional["unique"] == $unique) {
                        $start = $conditional["start"];
                        $end = $conditional["end"];
                        break;
                    }
                }
            }

            $count = $pdoTools->runSnippet("@FILE snippets/random.php", [
                "id" => $product->id,
                "start" => $start,
                "end" => $end,
                "unique" => $unique
            ]);

            $rows .= $pdoTools->getChunk($tpl, [
                "pagetitle" => $product->pagetitle,
                "count" => $count,
                "prefix" => $prefix,
            ]);
        }

        $output = $pdoTools->getChunk($tplWrapper, [
            "output" => $rows
        ]);

        return $output;
    }
}


return warehousesList(
    $tplWrapper,
    $tpl,
    $parents,
    $start,
    $end,
    $unique,
    $prefix,
    $where
);