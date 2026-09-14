<?php

if (! $pdo = $modx->getService('pdoTools')) {
  return false;
}

$parent_id = $parent_id ?: $pdo->runSnippet('@FILE snippets/getIdByAlias.php', ['alias' => 'catalog']);

$context = $context ?: $modx->context->key;

// check cache
$cache_name = 'catalog-v2';
$cache_options = [
  xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cache_name . '/' . $modx->context->key . '/' . $parent_id . '/',
];

if ($result = $modx->cacheManager->get($cache_name, $cache_options)) {
  return $result;
}
//

$result = [];

foreach (
  $modx->getCollection('modResource', [
    'parent' => $parent_id,
    'class_key' => 'msCategory',
    'published' => true,
    'context_key' => $context
  ]) as $subcat
) {
  $subcat_data = [
    "name" => $subcat->menutitle ?: 'Каталог',
    "link" => $modx->makeUrl($subcat->id),
    "assort_id" => $subcat->alias,
    "ico_id" => $subcat->getTVValue('mainIcon') ?: $subcat->getTVValue('mainImage'),
    "menuindex" => $subcat->menuindex,
    'childs' =>  array()
  ];
  foreach (
    $modx->getCollection('modResource', [
      'parent' => $subcat->id,
      'class_key' => 'msCategory',
      'published' => true,
    ]) as $childcat
  ) {
    $subcat_data['childs'][] = [
      "name" => $childcat->menutitle,
      "link" => $modx->makeUrl($childcat->id),
      "img" => $childcat->getTVValue('mainImage') ?: $childcat->getTVValue('mainIcon')
    ];
  }
  $result[] = $subcat_data;
}

// sort
if(count($result) > 0){
  usort($result, function ($a, $b) {
    return $a['menuindex'] <=> $b['menuindex'];
  });
} 

// set cache
$modx->cacheManager->set($cache_name, $result, 360000, $cache_options);

return $result;
