<?
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
    'optionFilters' => composeOptionFilters(['item_width', 'item_length', 'vid', 'primenenie', 'tip', 'viddekora', 'nazvanie-dekora', 'struktura'])
]));


$idsForThickness1 = str_replace(",", ", ", $idsForThickness);
$idsForThickness1 = "(" . $idsForThickness1 . ")";


$sql = "SELECT * FROM `modx_ms2_product_options` WHERE `key` = 'item_thickness' AND `product_id` in " . $idsForThickness1;
$statement = $modx->prepare($sql);
if ($statement->execute()) {
    $items = $statement->fetchAll(PDO::FETCH_ASSOC);

    //print_r($items);

    $sql1 = "SELECT * FROM `modx_ms2_product_options` WHERE `key` = 'item_thickness' AND `product_id` = " . $thisId;
    $statement1 = $modx->prepare($sql1);
    if ($statement1->execute()) {
        $items1 = $statement1->fetchAll(PDO::FETCH_ASSOC);
        $thisThick = $items1[0]['value'];
    }


    function sortByValue($a, $b)
    {
        return $a['value'] > $b['value'];
    }
    $items[] = ['product_id' => $thisId, 'key' => 'item_thickness', 'value' => $thisThick];
    usort($items, 'sortByValue'); // SORTED


    $options = "";
    $selected = "";
    
    $showThickness = count(array_column($items, 'value')) !== count(array_unique(array_column($items, 'value'))); // если дублируются значения толщины, тогда дополняем плотностью
    // echo "ITEMS: ".count($items)." - ".count(array_unique($items))." (".print_r($items).")".PHP_EOL;
    // добавка плотности, надо бы алгоритмизировать
    if ($showThickness) {
        $sqlPlotnost = "SELECT * FROM `modx_ms2_product_options` WHERE `key` = 'ottenok' AND `product_id` in " . $idsForThickness1;
        $requestPlotnost = $modx->prepare($sqlPlotnost);
        if ($requestPlotnost->execute()) {
            $itemsPlotnost = $requestPlotnost->fetchAll(PDO::FETCH_ASSOC);
            $thisPlot = $itemsPlotnost[0]['value'];
            $itemsPlotnost[] = ['product_id' => $thisId, 'key' => 'ottenok', 'value' => $thisPlot];
        }
    }

    foreach ($items as $item) {
        // добавка плотности, надо бы как-то алгоритмизировать
        if ($showThickness && count($itemsPlotnost) > 0) {
            $item['ottenok'] = findValueByPid($itemsPlotnost, $item['product_id']);
        }
        if ($item['product_id'] === $thisId) {
            $selected = $item['value'];
        }
        if ($item['value'] != "") {
            $options = $options . '
            <a href="' . $url = $modx->makeUrl($item['product_id']) . '" class="euv-custom-select__option">' . $item['value'] . " мм" . ($item['ottenok']  ? ' (' . $item['ottenok'] . ')' : '') . "</a>";
        }
    }

    $result = $result . '<div class="product-info__relinkav_wrapper">';
    $result = $result . '<span class="product-info__volume-title">Толщина' . ($item['ottenok'] ? ' (Оттенок)' : '') . ':</span>';
    $result = $result . '<div class="product-info__relinkav">';
    $result = $result . '<div class="product-info__euv-custom-select euv-custom-select">';

    $result = $result . '<div class="euv-custom-select__input">';
    $result = $result . '
    <span class="euv-custom-select__input-value">
     <svg
      viewBox="0 0 13 10"
      xmlns="http://www.w3.org/2000/svg"
      xmlns:svg="http://www.w3.org/2000/svg">
        <path d="m6.7 0.39c-0.044 0-0.079 0.033-0.079 0.075v3.6l-1.3-1.2c-0.041-0.04-0.11-0.04-0.15 0-0.041 0.04-0.041 0.1 0 0.14l1.4 1.4c0.0014 0.0014 3e-3 0.0026 0.0045 0.0038h-6.3v1.4h6.3l-1.4 1.3c-0.041 0.04-0.041 0.1 0 0.14s0.11 0.04 0.15 0l1.3-1.2v3.6c0 0.042 0.035 0.075 0.079 0.075h0.054c0.044 0 0.079-0.033 0.079-0.075v-3.6l1.3 1.2c0.041 0.04 0.11 0.04 0.15 0 0.041-0.04 0.041-0.1 0-0.14l-1.4-1.3h6.1v-1.4h-6.1c0.0014-0.0013 0.0031-0.0025 0.0045-0.0038l1.4-1.4c0.041-0.04 0.041-0.1 0-0.14s-0.11-0.04-0.15 0l-1.3 1.2v-3.6c0-0.042-0.035-0.075-0.079-0.075zm-6.13 4.33 12.1-0.0127 5e-6 0.813-12.1-6e-7z" stroke-width="0"/>
     </svg>
    ' . $selected . ' мм' . ($item['ottenok'] ? ' (' . $item['ottenok'] . ')' : '') . '</span>';
    $result = $result . '</div>';
    $result = $result . '<span class="euv-custom-select__btn"></span>';

    $result = $result . '<div class="euv-custom-select__options-wrap" style="display: none;">';

    $result = $result . $options;

    $result = $result . '</div>';
    $result = $result . '</div>';
    $result = $result . '</div>';
    $result = $result . '</div>';
}


if ($options != "") {
    return $result;
} else {
    return "";
}
