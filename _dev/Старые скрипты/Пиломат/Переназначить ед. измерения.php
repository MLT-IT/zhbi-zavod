<?php

$ids = $modx->runSnippet('pdoResources', [
    'parents' => 48793,
    'depth' => 100,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'returnIds' => 1,
    'where' => '{"template:=": 6}'
]);

echo 'ids = ' . $ids . '<br>';

$ids = explode(',', $ids);

foreach ($ids as $id) {
    $prod = $modx->getObject('msProduct', $id);
    $currentUnit = $prod->get('unit')[0];
    $newUnit = 'куб';

    $options = $prod->loadData()->get('options');
    $options['unit'][0] = 'куб';
    $prod->set('options', $options);
    $prod->save();

    echo 'У товара с id ' . $id . ' старый unit: ' . $currentUnit . ', новый unit: ' . $newUnit . '<br>';
}
