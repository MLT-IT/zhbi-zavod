<?php

// не используется, оставил для справки, если понадобится unit выводить, используем warehouse-remains

$pdoTools = $modx->getService('pdoTools', 'pdoTools');

if (!$pdoTools) {
    // Handle the error: return or throw an exception if necessary
    return 'Error: Unable to initialize pdoTools service.';
}

$warehouse_template  = 39;
$default_range_remains = "50-300";
$unit = $unit ?: 'лист';

if(!function_exists('fixUnit')){
  function fixUnit($value, $unit) {
    global $modx;
    $pdoTools = $modx->getService('pdoTools');
    if (!$pdoTools) {
        return 'Error: pdoTools is not initialized.';
    }

    if ($unit == 'лист'){
      $result = $pdoTools->runSnippet('@FILE snippets/formOfWord.php', [
      'n' => $value,
      'f1' => 'лист',
      'f2' => 'листа',
      'f5' => 'листов'
      ]);
    }
    else{
      $result = $unit;
    }
    return $result ?: '';
  }
}

// when warehouse pages will be ready
$context_key = $modx->context->key;
$table_prefix = $modx->getOption('table_prefix');
$query = "SELECT tv.`value` AS range_remains,c.menutitle AS `name`,c.uri AS link FROM {$table_prefix}site_content AS c LEFT JOIN {$table_prefix}site_tmplvar_contentvalues AS tv ON tv.contentid = c.id WHERE c.template = $warehouse_template AND c.context_key = '$context_key' AND c.published = 1 AND c.deleted = 0";

$result = $modx->query($query);
$warehouses = $result->fetchALL(PDO::FETCH_ASSOC);

$warehouses = $warehouses ?: [
  ['name' => 'Дачное', 'link' => '#'],
  ['name' => 'Янино-1', 'link' => '#'],
  ['name' => 'Шушары', 'link' => '#'],
  ['name' => 'Парголово', 'link' => '#'],
  ['name' => 'Металлострой', 'link' => '#'],
];

$totalStock = 0;

foreach ($warehouses as &$warehouse) {
  $range_remains = $warehouse['range_remains'] ?: $default_range_remains;
  [$begin, $end] = array_map('intval',explode("-", $range_remains));

  $warehouse['stock'] = $pdoTools->runSnippet('@FILE snippets/random.php', [
    'begin' => $begin, 
    'end' => $end, 
    'unique' => md5($warehouse['name'])
  ]);
  $warehouse['unit'] = fixUnit($warehouse['stock'], $unit) ;
  $totalStock += $remains;
}

unset($wh);

return [
  'warehouses' => $warehouses,
  'totalStock' => [
    'value' => $totalStock,
    'unit' => fixUnit($totalStock, $unit)
  ]
];
