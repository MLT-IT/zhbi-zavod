<?
if (!function_exists('composeOptionFilters')) {
    function composeOptionFilters($options) {
        global $modx;

        $optionValues = [];
        foreach ($options as $opt) {
            $val = $modx->resource->get($opt);
            if (is_null($val)) {
                $optionValues[$opt . ':IS'] = null;
            } else {
                if (is_array($val)) {
                    if (count($val) === 1) {
                        $optionValues[$opt . ':='] = reset($val);
                    }
                }
            }
        }
        return json_encode($optionValues, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }
}
if (!function_exists('getIdsFromString')) {
    function getIdsFromString($string) {
        if (empty($string)) {
            return [];
        } else {
            return explode(',', $string);
        }
    }
}

$parentId = $modx->resource->parent;
$thisId = $modx->resource->id;

$thisThick;

$result = "";

// Параметры для сниппетов почти везде одинаковые, заносим их в массив
$params = [
    'parents' => $parentId,
    'depth' => 100,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'resources' => '-' . $modx->resource->id,
    'returnIds' => '1',
];
// Получаем id для всех опций. Это все товары в текущей категории, кроме текущего товара
$idsInParent = $modx->runSnippet('pdoResources', $params);

$idsForThickness = $modx->runSnippet('msProducts', array_merge($params, [
    'optionFilters' => composeOptionFilters(['item_width','item_length','produktovaya-lineyka'])
]));


$idsForThickness1 = str_replace(",",", ",$idsForThickness);
$idsForThickness1 = "(".$idsForThickness1.")";

$sql = "SELECT * FROM `modx_ms2_product_options` WHERE `key` = 'item_thickness' AND `product_id` in ".$idsForThickness1;
$statement = $modx->prepare($sql);
if ( $statement->execute()) {
    $items = $statement->fetchAll(PDO::FETCH_ASSOC);
    
    //print_r($items);

    $sql1 = "SELECT * FROM `modx_ms2_product_options` WHERE `key` = 'item_thickness' AND `product_id` = ".$thisId;
    $statement1 = $modx->prepare($sql1);
    if ( $statement1->execute()) {
        $items1 = $statement1->fetchAll(PDO::FETCH_ASSOC);
        $thisThick = $items1[0]['value'];
    }


    function sortByValue($a, $b){
        return $a['value'] > $b['value'];
    }
    $items[]=['product_id'=>$thisId,'key'=>'item_thickness','value'=>$thisThick];
    usort($items, 'sortByValue');

        
    $result = $result.'<label class="relink_label" for="perelinkovka_2345">Толщина (мм)</label>';
    $result = $result.'<select class="relink_select" id="perelinkovka_2345" >'; 
    foreach ($items as $item){
        $selected="";
        if($item['product_id'] === $thisId){
            $selected="selected";
        }
        $result = $result.'<option value="'.$url = $modx->makeUrl($item['product_id'], '', '', 'full').'" '.$selected.'>'.$item['value'].' мм</option>';
    }
    $result = $result.'</select>';
}




return $result;



// $result = [
//     'item_thickness' => [],
// ];
// $parentId = $modx->resource->parent;

// if (!function_exists('composeOptionFilters')) {
//     function composeOptionFilters($options) {
//         global $modx;

//         $optionValues = [];
//         foreach ($options as $opt) {
//             $val = $modx->resource->get($opt);
//             if (is_null($val)) {
//                 $optionValues[$opt . ':IS'] = null;
//             } else {
//                 if (is_array($val)) {
//                     if (count($val) === 1) {
//                         $optionValues[$opt . ':='] = reset($val);
//                     }
//                 }
//             }
//         }
//         return json_encode($optionValues, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
//     }
// }
// if (!function_exists('getIdsFromString')) {
//     function getIdsFromString($string) {
//         if (empty($string)) {
//             return [];
//         } else {
//             return explode(',', $string);
//         }
//     }
// }

// // Параметры для сниппетов почти везде одинаковые, заносим их в массив
// $params = [
//     'parents' => $parentId,
//     'depth' => 100,
//     'limit' => 0,
//     'sortby' => 'id',
//     'sortdir' => 'ASC',
//     'resources' => '-' . $modx->resource->id,
//     'returnIds' => '1',
// ];
// // Получаем id для всех опций. Это все товары в текущей категории, кроме текущего товара
// $idsInParent = $modx->runSnippet('pdoResources', $params);

// if (empty($idsInParent)) {
//     return $result;
// }
// $idsForThickness = $modx->runSnippet('msProducts', array_merge($params, [
//     'optionFilters' => composeOptionFilters(['item_thickness'])
// ]));
// $idsForThickness = getIdsFromString($idsForThickness);
// $idsForThickness = array_flip($idsForThickness);

// $arr = ['thickness' => $idsForThickness];
// foreach ($arr as $arrKey => $data) {
//     $i = 0;
//     foreach ($data as $key => $val) {
//         $arr[$arrKey][$key] = $i;
//         $i++;
//     }
// }
// $idsForThickness = $arr['thickness'];
// $idsForThickness = array_flip($idsForThickness);
// $ids = [
//     'item_thickness' => $idsForThickness,
// ];