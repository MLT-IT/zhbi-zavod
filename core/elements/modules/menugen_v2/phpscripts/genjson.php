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
    171121 => 'Смотреть весь фиброцементный сайдинг',
    313901 => 'Смотреть весь виниловый сайдинг',
    314877 => 'Смотреть весь металлический сайдинг',
    314878 => 'Смотреть весь вспененный сайдинг',
    314879 => 'Смотреть весь акриловый сайдинг',
    314880 => 'Смотреть весь формованный сайдинг',
    314881 => 'Смотреть все софиты',
    314882 => 'Смотреть все фасадные пластиковые панели',
    314883 => 'Смотреть всю фасадную плитку Технониколь Haubek',
    314884 => 'Смотреть все фасадные термопанели',
    315199 => 'Смотреть всю фасадную штукатурку',
  ],
  'images' => [
    171134 => 'assets/template/img/modules/menugen_v2/fibrofasad/panels.png',
    171121 => 'assets/template/img/modules/menugen_v2/fibrofasad/siding.png',
    313901 => 'assets/template/img/modules/menugen_v2/fibrofasad/vinyl.png',
    314877 => 'assets/template/img/modules/menugen_v2/fibrofasad/metal.png',
    314878 => 'assets/template/img/modules/menugen_v2/fibrofasad/foam.png',
    314879 => 'assets/template/img/modules/menugen_v2/fibrofasad/akril.png',
    314880 => 'assets/template/img/modules/menugen_v2/fibrofasad/form.png',
    314881 => 'assets/template/img/modules/menugen_v2/fibrofasad/sofity.png',
    314882 => 'assets/template/img/modules/menugen_v2/fibrofasad/plastik.png',
    314883 => 'assets/template/img/modules/menugen_v2/fibrofasad/tn.png',
    314884 => 'assets/template/img/modules/menugen_v2/fibrofasad/termo.png',
    315199 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster.png',
    171103 => 'assets/template/img/modules/menugen_v2/fibrofasad/complect.png',
    171137 => 'assets/template/img/modules/menugen_v2/fibrofasad/complect.png',
    315008 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Грунтовка для фасада.png',
    315010 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Акриловая штукатурка.png',
    315011 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Силикатно-силиконовой штукатурки.png',
    315012 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Силиконовая штукатурка.png',
    315016 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Декоративная минеральная штукатурка.png',
    315018 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Мозаичная штукатурка.png',
    315031 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Кладочные растворы и смеси.png',
    315040 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Клееевые и штукатурные смеси.png',
    315043 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Растворы для расшивки швов.png',
    315044 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Краска для фасадов.png',
    315049 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Штукатурка гипсовая.png',
    315050 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Цементная штукатурка.png',
    315053 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Шпаклевки.png',
    315065 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Смесь для выравнивая пола.png',
    315070 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Гидроизоляция.png',
    315079 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Монтажная смесь.png',
    315090 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Цементно-известковая штукатурка.png',
    315105 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Силикатная штукатурка.png',
    315111 => 'assets/template/img/modules/menugen_v2/fibrofasad/plaster/Силоксановая штукатурка.png',
    315184 => 'assets/template/img/modules/menugen_v2/fibrofasad/Софиты виниловые.png',
    315132 => 'assets/template/img/modules/menugen_v2/fibrofasad/Софиты металлические.png'

  ],
  'brands' => [
    'комплектующие' => 'assets/template/img/modules/menugen_v2/fibrofasad/complect.png',
    'docke' => 'assets/template/img/modules/menugen_v2/fibrofasad/Docke.png',
    'технониколь' => 'assets/template/img/modules/menugen_v2/fibrofasad/технониколь.jpg',
    'альта-профиль' => 'assets/template/img/modules/menugen_v2/fibrofasad/Альта Профиль.png',
    'grand line' => 'assets/template/img/modules/menugen_v2/fibrofasad/Grand Line.png',
    'grand-line' => 'assets/template/img/modules/menugen_v2/fibrofasad/Grand Line.png',
    'ю-пласт' => 'assets/template/img/modules/menugen_v2/fibrofasad/Ю-Пласт.png',
    'nord-side' => 'assets/template/img/modules/menugen_v2/fibrofasad/NordSide.png',
    'nordside' => 'assets/template/img/modules/menugen_v2/fibrofasad/NordSide.png',
    'mitten' => 'assets/template/img/modules/menugen_v2/fibrofasad/Mitten.png',
    'vox' => 'assets/template/img/modules/menugen_v2/fibrofasad/VOX.png',
    'fineber' => 'assets/template/img/modules/menugen_v2/fibrofasad/FineBer.png',
    'vinylon' => 'assets/template/img/modules/menugen_v2/fibrofasad/Vinylon.png',
    'металл-профиль' => 'assets/template/img/modules/menugen_v2/fibrofasad/Металлпрофиль.jpg',
    'Металл Профиль' => 'assets/template/img/modules/menugen_v2/fibrofasad/Металлпрофиль.jpg',
    'аквасистем' => 'assets/template/img/modules/menugen_v2/fibrofasad/Аквасистем.png',
    'tecos' => 'assets/template/img/modules/menugen_v2/fibrofasad/Tecos.png',
    'vilostone' => 'assets/template/img/modules/menugen_v2/fibrofasad/Vilostone.png',
    'baumit' => 'assets/template/img/modules/menugen_v2/fibrofasad/Baumit.png',
    'короед' => 'assets/template/img/modules/menugen_v2/fibrofasad/Короед.png',
    'FIBRA PLANK' => 'assets/template/img/modules/menugen_v2/fibrofasad/Fibraplank.webp',
    'kmew' => 'assets/template/img/modules/menugen_v2/fibrofasad/kmew.jpg',
    'equitone' => 'assets/template/img/modules/menugen_v2/fibrofasad/Equitone.jpg',
    'nichiha' => 'assets/template/img/modules/menugen_v2/fibrofasad/Nichiha.webp',
    'бетэко' => 'assets/template/img/modules/menugen_v2/fibrofasad/БЕТЭКО.png',
    'дековер' => 'assets/template/img/modules/menugen_v2/fibrofasad/Decover.png',
    'кедрал' => 'assets/template/img/modules/menugen_v2/fibrofasad/Cedral.png',
    'фибратек' => 'assets/template/img/modules/menugen_v2/fibrofasad/Фибратек.png',
    'asahi' => 'assets/template/img/modules/menugen_v2/fibrofasad/Asahi.jpeg',
    'fcs group' => 'assets/template/img/modules/menugen_v2/fibrofasad/fcs-group.png',
    'fibraplank' => 'assets/template/img/modules/menugen_v2/fibrofasad/Fibraplank.webp',
    'latonit' => 'assets/template/img/modules/menugen_v2/fibrofasad/LATONIT.png',
    'каньон' => 'assets/template/img/modules/menugen_v2/fibrofasad/КАНЬОН.png',
    'см борд' => 'assets/template/img/modules/menugen_v2/fibrofasad/CM BORD.png',
  ]
];

function getBrandImg(&$title, &$manualMap) {
  foreach($manualMap['brands'] as $brand => &$img) {
    if(mb_stripos($title, $brand) !== false)return $img;
  }
  return '';
}

function getChildren($parent, &$manualMap) {
  global $modx;
  //global $imageMap;
  //global $CAT_PARENT;
  include_once MODX_CORE_PATH.'elements/services/CallService.inc.php';
  $cs = new CallService($modx);
  $host = $modx->getOption('http_host');
  $st = $modx->query("SELECT id, pagetitle, menutitle from modx_site_content where parent = $parent and published = 1 and not template in (28, 17, 27, 6, 40) and deleted != 1
  ORDER BY menuindex");
  $rows = $st->fetchAll(PDO::FETCH_CLASS);
  $output = [];
  foreach($rows as $row) {
    $url = $modx->makeUrl($row->id);
    $title = $row->menutitle?$row->menutitle:$row->pagetitle;
    $url = $cs->call('elements/snippets/splitPath.php', ['input' => $url, 'del' => $host]);
    if($manualMap['images'][$row->id])$img = $manualMap['images'][$row->id];
    else $img = getBrandImg($title, $manualMap);
    $output[] = [
      'id' => $row->id,
      'link' => $url,
      'title' => $title,
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