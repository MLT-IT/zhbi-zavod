<?php

// https://docs.modx.pro/komponentyi/minishop2/poleznyie-vyiborki/vyivod-ssyilok-na-dopolnitelnyie-kategorii-tovara

if (empty($id)) {
    $id = $modx->resource->id;
}
if (empty($tpl)) {
    $tpl = '@INLINE <a href="[[~[[+id]]]]">[[+pagetitle]]</a>';
}
$pdo = $modx->getService('pdoFetch');

$conditions = ['product_id' => $id];
$options = [
    'innerJoin' => [
        'msCategory' => ['on' => 'msCategoryMember.category_id = msCategory.id']
    ],
    'select' => ['msCategory' => 'all'],
    'sortby' => 'msCategory.id'
];
$rows = $pdo->getCollection('msCategoryMember', $conditions, $options);

$output = '';
foreach ($rows as $row) {
    $output .= $pdo->getChunk($tpl, $row);
}

return $output;
