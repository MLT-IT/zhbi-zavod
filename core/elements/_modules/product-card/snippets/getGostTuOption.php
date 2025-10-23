<?php
// отдает ссылку на аналогичный товар по опции "markirovka" с альтернативным значением опции "standart"
$resource = $modx->resource;
// Get the current product ID
$currentProductId = $resource->get('id');
// Get the parent category of the current product
$currentParentId = $resource->get('parent');

$currentMarkirovka = $resource->get('markirovka');
$currentStandart = $resource->get('standart');
$currentMarkirovka = is_array($currentMarkirovka) ? $currentMarkirovka[0] : $currentMarkirovka;
$currentStandart = is_array($currentStandart) ? $currentStandart[0] : $currentStandart;

// if no options
if(!$currentStandart || !$currentMarkirovka) return false;

// приподзакэшируем
$cache_name = 'standart-relinking';
$cache_options = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cache_name . '/' . $modx->context->key . '/' . $currentProductId . '/',
];

if($result = $modx->cacheManager->get($cache_name, $cache_options)){
  return $result;
}

// same "markirovka" but different "standart"
$query = $modx->newQuery('msProductOption');
$query->where([
    'msProductOption.key' => 'markirovka',
    'msProductOption.value' => $currentMarkirovka,
    'msProductOption.product_id:!=' => $currentProductId,
]);
$query->innerJoin('msProductOption', 'StandartOption', 'StandartOption.product_id = msProductOption.product_id AND StandartOption.key = "standart"');
$query->where([
    'StandartOption.value:!=' => $currentStandart,
]);
$query->select(['StandartOption.product_id AS id', 'StandartOption.value AS standart']);
// $query->prepare();
// echo $query->toSQL();



$alternatives = $modx->getIterator('msProductOption', $query);

$result = [];

foreach ($alternatives as $product) {
    $standart = $product->get('standart');
    $uri = $product->get('uri');
    $pagetitle = $product->get('pagetitle');
    $result[] = [
      'id' => $product->get('id'),
      'standart' => $standart,
      'uri' => $uri,
      'pagetitle' => $pagetitle,
    ];
}

$result = count($result) ? $result : false;

// подпризакэшировали
$modx->cacheManager->set($cache_name, $result, 0, $cache_options);

return $result;
