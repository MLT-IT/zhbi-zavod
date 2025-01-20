<?php
if (!function_exists('composeOptionFilters')) {
    function composeOptionFilters($options)
    {
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
    function getIdsFromString($string)
    {
        if (empty($string)) {
            return [];
        } else {
            return explode(',', $string);
        }
    }
}

if (!function_exists('findValueByPid')) {
    function findValueByPid($array, $pid, $search_field = 'product_id')
    {
        foreach ($array as $element) {
            if (isset($element[$search_field]) && $element[$search_field] == $pid) {
                return $element['value'];
            }
        }
        // Return null if the element with the required 'pid' is not found
        return null;
    }
}

$parentId = $modx->resource->parent;
$thisId = $modx->resource->id;

$additionalOption = 'plotnost'; // for Boswool
$additionalPid = [168262];

$thisOttenok;

$result = ['ottenok' => [
    'items' => [],
    'selected' => ''
]];

// Параметры для сниппетов почти везде одинаковые, заносим их в массив
$params = [
    'parents' => $parentId,
    'depth' => 0,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'resources' => '-' . $thisId,
    'returnIds' => '1',
];

// Получаем id для всех опций. Это все товары в текущей категории, кроме текущего товара
$idsInParent = $modx->runSnippet('pdoResources', $params);


$idsForOttenok = $modx->runSnippet('msProducts', array_merge($params, [
    // 'optionFilters' => composeOptionFilters(['kolichestvo-sloev', 'proizvoditel', 'pokrytie', 'seria', 'forma-narezki'])
    'optionFilters' => composeOptionFilters(['proizvoditel'])
]));


$idsForOttenokSql = "(" . str_replace(",", ", ", $idsForOttenok) . ")";


// $sql = "SELECT * FROM `modx_ms2_product_options` WHERE `key` = 'ottenok' AND `product_id` in " . $idsForOttenokSql;
$sql = "SELECT * FROM `modx_ms2_product_options` WHERE `key` = 'ottenok' AND `product_id` in " . $idsForOttenokSql;
$statement = $modx->prepare($sql);
if ($statement->execute()) {
    $items = $statement->fetchAll(PDO::FETCH_ASSOC);

    //print_r($items);

    $thisOttenok = $modx->resource->get('ottenok')[0];
    // $sql1 = "SELECT * FROM `modx_ms2_product_options` WHERE `key` = 'ottenok' AND `product_id` = " . $thisId;
    // $statement1 = $modx->prepare($sql1);
    // if ($statement1->execute()) {
    //     $items1 = $statement1->fetchAll(PDO::FETCH_ASSOC);
    //     $thisOttenok = $items1[0]['value'];
    // }


    function sortByValue($a, $b)
    {
        return $a['value'] > $b['value'];
    }
    $items[] = ['product_id' => $thisId, 'key' => 'ottenok', 'value' => $thisOttenok];
    usort($items, 'sortByValue'); // SORTED


    // $options = "";
    // $selected = "";
    $uniqueOptions = [];

    foreach ($items as $item) {

        if ($item['product_id'] === $thisId) {
            $result['ottenok']['selected'] = $item['value'];
        }
        
        if (isset($uniqueOptions[$item['value']]) && $uniqueOptions[$item['value']] == 1) continue;

        if ($item['value'] != "") {
            
            $result['ottenok']['items'][] = $item;
            // $options .= '<a href="' . $url = $modx->makeUrl($item['product_id'], '', '', 'full') . '" class="euv-custom-select__option">' . $item['value'] . "</a>";
        }

        $uniqueOptions[$item['value']] = 1;
    }

    // $result[] = '
    // <div class="product-info__top"><div class="product-info__grid">
    //     <div class="product-info__relinkav_wrapper">
    //       <span class="product-info__volume-title">Оттенок:</span>
    //       <div class="product-info__relinkav">
    //         <div class="product-info__euv-custom-select euv-custom-select">
    //           <div class="euv-custom-select__input">
    //             <span class="euv-custom-select__input-value">' . $selected . '</span>
    //           </div>
    //           <span class="euv-custom-select__btn"></span>
    //           <div class="euv-custom-select__options-wrap" style="display: none;">
    //           '.$options.'
    //           </div>
    //         </div>
    //       </div>
    //     </div>
    // </div>';
}


if (count($result['ottenok']['items'])) {
    return $result;
} else {
    return "";
}