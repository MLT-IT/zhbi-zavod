<?php

$category_id = $modx->resource->id;
$table_prefix = $modx->getOption('table_prefix');

try {
    $res = $modx->query("SELECT * FROM {$table_prefix}catprod_rules WHERE category_id = $category_id");
    $data = $res->fetch(PDO::FETCH_ASSOC);

    if ($data) {
        $rules = json_decode($data['rules'], true);
        return [
            'parents' => implode(',', $rules['parents']),
            'options' => str_replace(["{", "}"], ["{ ", " }"], json_encode($rules['options'], JSON_UNESCAPED_UNICODE))
        ];
    } else {
        return null;
    }
} catch (Exception $e) {
}
