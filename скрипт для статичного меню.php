<?php
$thicknessResult = [];
$result = '';

$itemsIds = $modx->runSnippet('pdoResources', [
    'parents' => '-9125,-10594,-10998',
    'depth' => 1000,
    'where' => '{"template:=": "6"}',
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'context' => 'penoplex',
    'returnIds' => 1
]);
$itemsIds = explode(',', $itemsIds);


foreach ($itemsIds as $id) {
    $item = $modx->getObject('modResource', $id);

    $thicknessArray = $item->get('item_thickness');
    if (!empty($thicknessArray) && is_array($thicknessArray)) {
        foreach ($thicknessArray as $thickness) {
            $thicknessResult[$thickness] = $thickness;
        }
    }
}

sort($thicknessResult);

foreach ($thicknessResult as $item) {
    $result .= '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=' . urlencode($item) . '">' . $item . '</a><br>';
}

echo $result;
