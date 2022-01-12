<?php

/**
 * Скрипт выполняется в console. Выводит ссылки.
 */

$context = 'paroc';

// ---------------------------------------------
// Толщина
// ---------------------------------------------
$thicknessResult = [];
$result = '';

$itemsIds = $modx->runSnippet('pdoResources', [
    'parents' => '-14193,-10594,-10998,-9125,-15201,-15202',
    'depth' => 1000,
    'where' => '{"template:=": "6"}',
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'context' => $context,
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
    $result .= '<a class="header__column-item" href="/catalog/?msoption|item_thickness=' . urlencode($item) . '">' . $item . '</a><br>';
}

echo $result;


// ---------------------------------------------
// Применение
// ---------------------------------------------
$primenenieResult = [];
$result = '';

$itemsIds = $modx->runSnippet('pdoResources', [
    'parents' => '-14193,-10594,-10998,-9125,-15201,-15202',
    'depth' => 1000,
    'where' => '{"template:=": "6"}',
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'context' => $context,
    'returnIds' => 1
]);
$itemsIds = explode(',', $itemsIds);


foreach ($itemsIds as $id) {
    $item = $modx->getObject('modResource', $id);

    $primenenieArray = $item->get('primenenie');
    if (!empty($primenenieArray) && is_array($primenenieArray)) {
        foreach ($primenenieArray as $primenenie) {
            $primenenieResult[$primenenie] = $primenenie;
        }
    }
}

sort($primenenieResult);

foreach ($primenenieResult as $item) {
    $result .= '<a class="header__column-item" href="/catalog/?msoption|primenenie=' . urlencode($item) . '">' . $item . '</a><br>';
}

echo $result;
