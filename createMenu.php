<?php
// Линейки продуктов
$categories = $modx->runSnippet('pdoResources', [
    'parents' => 0,
    'depth' => 0,
    'where' => '{"template:=": "5"}',
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'context' => $modx->resource->get('context_key'),
    'tpl' => '@INLINE : <a class="header__column-item" href="{$_modx->makeUrl($id, \'\', \'\', \'full\')}">{$menutitle}</a>',
    'outputSeparator' => '___'
]);
$categories = explode('___', $categories);

// Товары
$primenenieResult = [];
$thicknessResult = [];
$itemsIds = $modx->runSnippet('pdoResources', [
    'parents' => 0,
    'depth' => 1000,
    'where' => '{"template:=": "6"}',
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'context' => $modx->resource->get('context_key'),
    'returnIds' => 1
]);
$itemsIds = explode(',', $itemsIds);

foreach ($itemsIds as $id) {
    $item = $modx->getObject('modResource', $id);

    // Применение
    $primenenieArray = $item->get('primenenie');
    if (!empty($primenenieArray) && is_array($primenenieArray)) {
        foreach ($primenenieArray as $primenenie) {
            $primenenieResult[$primenenie] = '<a class="header__column-item" href="{\'site_url\' | option}catalog/?msoption|primenenie=' . urlencode($primenenie) . '">' . $primenenie . '</a>';
        }
    }

    // Толщина
    $thicknessArray = $item->get('item_thickness');
    if (!empty($thicknessArray) && is_array($thicknessArray)) {
        foreach ($thicknessArray as $thickness) {
            $thicknessResult[$thickness] = '<a class="header__column-item" href="{\'site_url\' | option}catalog/?msoption|item_thickness=' . urlencode($thickness) . '">' . $thickness . '</a>';
        }
    }
}

$result = [];
if (!empty($categories)) {
    $result['Линейки продуктов'] = $categories;
}
if (!empty($primenenieResult)) {
    $result['По назначению'] = $primenenieResult;
}
if (!empty($thicknessResult)) {
    $result['По толщине листа'] = $thicknessResult;
}

return $result;
