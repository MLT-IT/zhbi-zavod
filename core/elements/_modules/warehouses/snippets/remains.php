<?php

/**
 * Скрипт получет ресурсы (склады)
 * У ресурса (склад) должно быть заполнено TV поле range_remains
 * 
 * return [
 *          'warehouses' => $warehouses, // Склады
 *          'total_remains' => $total_remains // Итоговое кол-во по товара со всех складов
 *         ]
 * 
 * !!!ВНИМАНИЕ!!!
 * Данный скрипт так же вызывается в листинге на карточках товара, для вывода остатков total_remains
 * Передать ID товара, он пойдет в elements/snippets/random.php
 */
try{

$id = $modx->getOption('id', $scriptProperties, $modx->resource->id);

$warehouse_template  = 39;
$default_range_remains = "50-300";
$TV_RANGEREMAINS_ID = 47;

// >>> Кэшируем получение складов в контексте для оптимизации в цикле листинга
$cache_name = 'warehouseRemains';
$cache_options = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cache_name . '/' . $modx->context->key . '/',
];

if (!$warehouses = $modx->cacheManager->get($cache_name, $cache_options)) {
    $context_key = $modx->context->key;
    $table_prefix = $modx->getOption('table_prefix');
    $query = "SELECT tv.`value` AS range_remains,c.menutitle,c.pagetitle,c.uri FROM {$table_prefix}site_content AS c LEFT JOIN {$table_prefix}site_tmplvar_contentvalues AS tv ON tv.contentid = c.id AND tv.tmplvarid = $TV_RANGEREMAINS_ID WHERE c.template = $warehouse_template AND c.context_key = '$context_key' AND c.published = 1 AND c.deleted = 0";

    $result = $modx->query($query);
    $warehouses = $result->fetchALL(PDO::FETCH_ASSOC);

    $modx->cacheManager->set($cache_name, $warehouses, 0, $cache_options);
}
// <<<

//$modx->log(xPDO::LOG_LEVEL_ERROR, 'remains id:'.$id);
$pdoFetch = $modx->getService('pdoFetch');

$isInCat = $pdoFetch->runSnippet('@FILE snippets/ultimateParent.php', [
   'id' => $id,
   'ancestor' => 93445 //если товар в этой категории, то кол-во по запросу
]);
//$modx->log(xPDO::LOG_LEVEL_ERROR, 'isInCat: '.$isInCat);
if($isInCat){
    foreach ($warehouses as &$warehouse) {
        $warehouse['remains'] = 'Под запрос';
    }
    $total_remains = 'Под запрос';
    $unit = '';
}else{

    $total_remains = 0;
    foreach ($warehouses as &$warehouse) {
        $range_remains = $warehouse['range_remains'] ?: $default_range_remains;
        $range_remains = explode("-", $range_remains);

        $begin = (int)$range_remains[0];
        $end = (int)$range_remains[1];
        $remains = include MODX_CORE_PATH . "elements/snippets/random.php";

        $warehouse['remains'] = $remains;
        $total_remains += $remains;
    }

    switch($modx->context->key){
        case 'plitnye':
            $unit = 'лист';
        break;
        default:
            $unit = 'уп.';
        break;
    }
    //$total_remains .= $unit;

}

return ['warehouses' => $warehouses, 'total_remains' => $total_remains, 'unit' => $unit];
}catch(Throwable $t) {
    //$modx->log(xPDO::LOG_LEVEL_ERROR, $t->getMessage().$t->getTraceAsString());
}
