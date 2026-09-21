<?php

/**
 * Отдаёт ссылки на аналогичный товар (по опции "markirovka") с другим
 * значением опции "standart" (ТУ/ГОСТ) — для переключателя "Стандарт"
 * на карточке товара.
 */

$resource = $modx->resource;
$currentProductId = (int) $resource->get('id');

$currentMarkirovka = $resource->get('markirovka');
$currentStandart = $resource->get('standart');
$currentMarkirovka = is_array($currentMarkirovka) ? reset($currentMarkirovka) : $currentMarkirovka;
$currentStandart = is_array($currentStandart) ? reset($currentStandart) : $currentStandart;

if (!$currentStandart || !$currentMarkirovka) return false;

$cache_name = 'standart-relinking';
$cache_options = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cache_name . '/' . $modx->context->key . '/' . $currentProductId . '/',
];

if ($result = $modx->cacheManager->get($cache_name, $cache_options)) {
    return $result;
}

$prefix = $modx->getOption('table_prefix');

$sql = "
    SELECT po.product_id AS id, so.value AS standart, sc.uri AS uri, sc.pagetitle AS pagetitle
    FROM {$prefix}ms2_product_options po
    INNER JOIN {$prefix}ms2_product_options so
        ON so.product_id = po.product_id AND so.`key` = 'standart'
    INNER JOIN {$prefix}site_content sc
        ON sc.id = po.product_id
    WHERE po.`key` = 'markirovka'
        AND po.value = :markirovka
        AND po.product_id != :current_id
        AND so.value != :standart
        AND sc.context_key = :context_key
        AND sc.published = 1
        AND sc.deleted = 0
";

$stmt = $modx->prepare($sql);
$stmt->execute([
    ':markirovka' => $currentMarkirovka,
    ':current_id' => $currentProductId,
    ':standart' => $currentStandart,
    ':context_key' => $modx->context->key,
]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$result = [];
foreach ($rows as $row) {
    $result[] = [
        'id' => (int) $row['id'],
        'standart' => $row['standart'],
        'uri' => $row['uri'],
        'pagetitle' => $row['pagetitle'],
    ];
}

$result = count($result) ? $result : false;

$modx->cacheManager->set($cache_name, $result, 0, $cache_options);

return $result;
