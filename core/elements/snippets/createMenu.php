<?php

$context = $modx->resource->get('context_key');
$result = [];

$cacheName = 'createMenu';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    switch ($context) {
        // -------------------------------------
        // knauf
        // -------------------------------------
        case 'web':
            $result = [
                [
                    'param1' => [
                        'link' => '/podkategoriya-1/',
                        'text' => 'Подкатегория 1',
                        'img' => '/assets/template/pictures/products/item-2.png'
                    ],
                    'param2' => [
                        'link' => '/catalog/?msoption|proizvoditel=ЕвроАэроБетон',
                        'text' => 'ЕвроАэроБетон',
                    ],
                    'param3' => [
                        'link' => '/catalog/?msoption|razmer=300*625*400',
                        'text' => '300*625*400',
                    ],
                ],
                [
                    'param1' => [
                        'link' => '/podkategoriya-2/',
                        'text' => 'Подкатегория 2',
                        'img' => '/assets/template/pictures/products/item-2.png'
                    ],
                    'param3' => [
                        'link' => '/catalog/?msoption|razmer=400*250*625/',
                        'text' => '400*250*625',
                    ],
                ],
                [
                    'param1' => [
                        'link' => '/podkategoriya-3/',
                        'text' => 'Подкатегория 3',
                        'img' => '/assets/template/pictures/products/item-2.png'
                    ],
                    'param3' => [
                        'link' => '/catalog/?msoption|razmer=400*300*500',
                        'text' => '400*300*500',
                    ],
                ],
                [
                    'param1' => [
                        'link' => '/podkategoriya-4/',
                        'text' => 'Подкатегория 4',
                        'img' => '/assets/template/pictures/products/item-2.png'
                    ],
                    'param3' => [
                        'link' => '/catalog/?msoption|razmer=400*300*500',
                        'text' => '400*300*625',
                    ],
                ],
                [
                    'param1' => [
                        'link' => '/podkategoriya-5/',
                        'text' => 'Подкатегория 5',
                        'img' => '/assets/template/pictures/products/item-2.png'
                    ],
                    'param3' => [
                        'link' => '/catalog/?msoption|razmer=625*250*400',
                        'text' => '625*250*400',
                    ],
                ],
            ];
            break;
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
