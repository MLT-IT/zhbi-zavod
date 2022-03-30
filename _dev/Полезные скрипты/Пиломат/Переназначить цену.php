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
    $currentPrice = $prod->get('price');
    $amountInCube = $prod->get('kol-vokub-sh')[0];
    $newPrice = $amountInCube * $currentPrice;

    if ($newPrice > 100) {
        $tmp = $newPrice % 100;
        $newPrice = $newPrice - $tmp;
    }

    $prod->set('price', $newPrice);
    $prod->save();

    echo 'У товара с id ' . $id . ' старая цена: ' . $currentPrice . ', новая цена: ' . $newPrice . '<br>';
}
