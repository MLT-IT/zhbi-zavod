<?php

$pdoTools = $modx->getService('pdoTools', 'pdoTools');

if (!$pdoTools) {
    // Handle the error: return or throw an exception if necessary
    return 'Error: Unable to initialize pdoTools service.';
}

$unit = $unit ?: 'лист';

if(!function_exists('fixUnit')){
  function fixUnit($value, $unit) {
    global $modx;
    $pdoTools = $modx->getService('pdoTools', 'pdoTools');
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
    return $result ?: 'XXX';
  }
}

$warehouses = [
  ['name' => 'Дачное', 'link' => '#'],
  ['name' => 'Янино-1', 'link' => '#'],
  ['name' => 'Шушары', 'link' => '#'],
  ['name' => 'Парголово', 'link' => '#'],
  ['name' => 'Металлострой', 'link' => '#'],
];

$totalStock = 0;

foreach ($warehouses as &$wh){
  $wh['stock'] = $pdoTools->runSnippet('@FILE snippets/random.php', [
    'begin' => 150, 
    'end' => 900, 
    'unique' => rand(0, 1000)
  ]);
  $wh['unit'] = fixUnit($wh['stock'], $unit) ;
  $totalStock +=  $wh['stock'];
}
unset($wh);

return [
  'warehouses' => $warehouses,
  'totalStock' => [
    'value' => $totalStock,
    'unit' => fixUnit($totalStock, $unit)
  ]
];
