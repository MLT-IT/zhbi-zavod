<?php


$pdoTools = $modx->getService("pdoTools");

$where = $pdoTools->runSnippet("@FILE modules/warehoses/snippets/dataSetWarehouse.php");
$parentObject = $modx->getObject("modResource", ['id' => $parent]);
// Получаем список всех родителей, ex для ресурса 72811: Array ( [0] => 36789 [1] => 36784 [2] => 36782 [3] => 29293 [4] => 0 )
$parent = $modx->getParentIds($parentObject->id, 10,array('context' => $parentObject->context_key)); 
$parent[] = $parentObject->id;

// Проверяем есть ли готовые настройки для товара(по категории) или возращаем null
foreach ($where as $conditional) {
    $parents =  explode(",", $conditional["parents"]);

    if ( !empty(array_intersect($parent, $parents)) && $conditional["unique"] == md5($warehouse))
    {
        return $conditional;
    }
}

return null;