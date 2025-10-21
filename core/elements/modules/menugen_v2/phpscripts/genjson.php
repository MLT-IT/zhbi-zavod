<?php
/*
  Запускать из консоли MODX
  Генерирует json меню
*/

namespace GenJSON;

error_reporting(E_ALL xor E_NOTICE);

use PDO;
use CallService;
use Throwable;

$CAT_PARENT = 125346;
$TARGET_PATH = MODX_CORE_PATH.'elements/modules/menugen_v2/phpscripts/catalog.json'; //Куда сохранить json

//К какой категории какаую картинку добавить
$manualMap = [
  'linkTextAll' => [
    171134 => 'Смотреть все фиброцементные панели',
    171121 => 'Смотреть весь фиброцементный сайдинг'
  ],
  'images' => [
    171134 => 'assets/images/modules/menugen_v2/fibrofasad/panels.png',
    171121 => 'assets/images/modules/menugen_v2/fibrofasad/siding.png',
    171103 => 'assets/images/modules/menugen_v2/fibrofasad/complect.png',
    171137 => 'assets/images/modules/menugen_v2/fibrofasad/complect.png'
  ]
];

function getChildren($parent, &$manualMap) {
  global $modx;
  //global $imageMap;
  //global $CAT_PARENT;
  include_once MODX_CORE_PATH.'elements/services/CallService.inc.php';
  $cs = new CallService($modx);
  $host = $modx->getOption('http_host');
  $st = $modx->query("SELECT id, pagetitle from modx_site_content where parent = $parent and published = 1 and template != 28 and deleted != 1
  ORDER BY menuindex");
  $rows = $st->fetchAll(PDO::FETCH_CLASS);
  $output = [];
  foreach($rows as $row) {
    $url = $modx->makeUrl($row->id);
    $url = $cs->call('elements/snippets/splitPath.php', ['input' => $url, 'del' => $host]);
    if($manualMap['images'][$row->id])$img = $manualMap['images'][$row->id];
    else $img = '';
    $output[] = [
      'id' => $row->id,
      'link' => $url,
      'title' => $row->pagetitle,
      'img' => $img,
      'children' => [],
      'customClass' => ''
    ];
  }
  return $output;
}

try{

  include_once MODX_CORE_PATH.'elements/services/CallService.inc.php';
  $cs = new CallService($modx);

  $host = $modx->getOption('http_host');

  $st = $modx->query("SELECT id, pagetitle from modx_site_content where parent = $CAT_PARENT and published = 1 and template != 28 and deleted != 1
  ORDER BY menuindex");
  $rows = $st->fetchAll(PDO::FETCH_CLASS);


  $output = [];
  foreach($rows as $row) {
    $url = $modx->makeUrl($row->id);
    //echo $url."\n";
    //echo $host."\n";
    $url = $cs->call('elements/snippets/splitPath.php', ['input' => $url, 'del' => $host]);
    if($manualMap['images'][$row->id])$img = $manualMap['images'][$row->id];
    if($manualMap['linkTextAll'][$row->id])$linkTextAll = $manualMap['linkTextAll'][$row->id];
    else $img = '';
    $output[] = [
      'id' => $row->id,
      'link' => $url,
      'title' => $row->pagetitle,
      'img' => $img,
      'linkTextAll' => $linkTextAll,
      'children' => getChildren($row->id, $manualMap)
    ];
  }
  //print_r($output);
  $json = json_encode($output, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
  file_put_contents($TARGET_PATH, $json);
  echo "JSON saved to $TARGET_PATH\n";
}catch(Throwable $t) {
  echo $t->getMessage().$t->getTraceAsString()."\n";
}