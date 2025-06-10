<?php

$warehouses_sub = $modx->runSnippet('pdoResources', [
  'parents' => '307656',
  'tpl' => '@FILE _modules/top_menu/chunks/subitem_json.tpl',
  'tplWrapper' => '@INLINE: [ [[+output]] ]'
]);

$warehouses_sub[strlen($warehouses_sub) - 3] = ' '; //Заменить лишнюю запятую на пробел быстро
//$modx->log(xPDO::LOG_LEVEL_ERROR, print_r($warehouses_sub, true));
$warehouses_sub = json_decode($warehouses_sub, true);

$data = [
  [
    'url' => '/dostavka-i-oplata/',
    'text' => 'Доставка и оплата',
    'link_classes' => '',
    'submenu' => []
  ],
  [
    'url' => '/akcii/',
    'text' => 'Акции'
  ],
  [
    'url' => '/o-kompanii/',
    'text' => 'О компании'
  ],
  [
    'url' => '/otzyvy/',
    'text' => 'Отзывы'
  ],
  [
    'url' => '',
    'text' => 'Склады',
    'submenu' => $warehouses_sub
  ],
  [
    'url' => '/contacts/',
    'text' => 'Контакты'
  ]
];

return $data;
