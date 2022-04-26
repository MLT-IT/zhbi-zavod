<?php

$resultIds = [];

// Получаем id родителей
$parentsIds = $modx->runSnippet('pdoResources', [
    'parents' => 16788,
    'depth' => 1000,
    'limit' => 0,
    'returnIds' => 1,
    'where' => '{"template:=":"5"}'
]);

$parentsIds = explode(',', $parentsIds);

// Проходимся по каждому родителю
foreach ($parentsIds as $pId) {
    // Получаем id товаров родителя
    $productsIds = $modx->runSnippet('pdoResources', [
        'parents' => $pId,
        'depth' => 0,
        'limit' => 0,
        'returnIds' => 1,
        'where' => '{"template:IN":[6,17]}'
    ]);

    if (empty($productsIds)) {
        continue;
    }

    $productsIds = explode(',', $productsIds);

    // Проходимся по каждому товару
    foreach ($productsIds as $id) {
        $prod = $modx->getObject('msProduct', $id);

        $options = [];
        $options[] = $prod->get('cvet')[0];
        $options[] = $prod->get('item_thickness')[0];
        $options[] = $prod->get('pokrytie')[0];

        $options = implode($options);
        $options = md5($options);

        if (empty($resultIds[$pId][$options])) {
            $resultIds[$pId][$options] = [];
        }
        $resultIds[$pId][$options][] = $id;
    }
}

$resultIds = array_filter($resultIds, function($e) {
    if  ($e > 1) {
        return true;
    } else {
        return false;
    }
});

$resultIdsLast = [];
$resultString = '';

foreach ($resultIds as $parentId => $hashes) {
    foreach ($hashes as $hash => $elems) {
        if (count($elems) > 1) {
            $resultIdsLast[$parentId][$hash] = $elems;

            $resultString .= 'У категории с id ' . $parentId . ' есть одинаковые товары: ' . implode(', ', $elems) . '<br>';
        }
    }
}

echo $resultString;
