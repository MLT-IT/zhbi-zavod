<?php

$rootResource = 48793;

// ------------------------------------
// Получаем все дочерние категории
// ------------------------------------
$ids = $modx->runSnippet('pdoResources', [
    'parents' => $rootResource,
    'returnIds' => 1,
    'depth' => 1000,
    'limit' => 0,
    'showUnpublished' => 1,
    'showDeleted' => 1,
    'where' => '{"template:=":"5"}'
]);

$ids .= ',' . $rootResource;

// ------------------------------------
// Получаем все опции для каждой категории
// ------------------------------------
$sql = 'SELECT o.id, o.key, o.caption
        FROM modx_ms2_category_options as co
        JOIN modx_ms2_options AS o ON co.option_id = o.id
        WHERE co.category_id IN (' . $ids . ')
        GROUP BY o.key';
$data = $modx->query($query);
$data = $data2->fetchAll(PDO::FETCH_ASSOC);
