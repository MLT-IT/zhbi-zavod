<?php
// optimized 12/2024 tedgregory

if (!function_exists('getDeepArrayValues')) {
  function getDeepArrayValues($array, $field = null)
  {
    $result = [];
    foreach ($array as $key => $value) {
      if (is_array($value)) {
        // Merge recursively
        $result = array_merge($result, getDeepArrayValues($value, $field));
      } else {
        // Add scalar values directly
        // echo $value.PHP_EOL;
        if ($field == $key) {
          $result[] = $array;
        }
      }
    
    }
    return $result;
  }
}

$context = $context ?: 'web';
$tvName = 'certs';

// Get the TV ID
$tv = $modx->getObject('modTemplateVar', ['name' => $tvName]);
if (!$tv) {
  return 'TV not found!';
}
$tvId = $tv->get('id');

// Query
$query = $modx->newQuery('modTemplateVarResource');
$query->leftJoin('modResource', 'Resource', 'modTemplateVarResource.contentid = Resource.id');
$query->where([
  'modTemplateVarResource.tmplvarid' => $tvId,
  'Resource.class_key' => 'msProduct',
  'Resource.context_key' => $context,
]);

$query->select('modTemplateVarResource.value');
$tvs = $modx->getIterator('modTemplateVarResource', $query);

$values = [];
foreach ($tvs as $tv) {
  $filesArray = json_decode($tv->get('value'), true); // array(array1(),,,arrayN())
  if ($filesArray) {
    $values[] = $filesArray;
  }
}
$values = getDeepArrayValues($values, 'file'); // linearize array
$values = array_values(array_reduce($values, function ($carry, $item) {
    $carry[$item['file']] = $item;
    return $carry;
}, []));

return $values;
