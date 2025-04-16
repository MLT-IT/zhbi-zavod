<?php

$services_sub = $modx->runSnippet('pdoResources', [
    'parents' => '230724',
    'tpl' => '@FILE _modules/top_menu/chunks/subitem_json.tpl',
    'tplWrapper' => '@INLINE: [ [[+output]] ]'
]);

$services_sub[strlen($services_sub) - 3] = ' '; //Заменить лишнюю запятую на пробел быстро
$services_sub = json_decode($services_sub, true);

$data = [
    [
        'url' => '/dostavka-i-oplata/',
        'text' => 'Доставка и оплата',
        'link_classes' => '',
        'submenu' => []
    ],
    [
        'url' => '/servisyi-rascheta/',
        'text' => 'Сервисы расчета',
        'submenu' => $services_sub
    ],
    [
        'url' => '/akcii/',
        'text' => 'Акции'
    ],
    [
        'url' => '/shourum/',
        'text' => 'Шоурум'
    ],
    [
        'url' => '/otzyivyi/',
        'text' => 'Отзывы'
    ],
    [
        'url' => '/contacts/',
        'text' => 'Контакты'
    ]
];

return $data;