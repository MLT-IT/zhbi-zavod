<?php

function getMenuData() {
    $cement = 123488;
    $cps = 123489;
    $cley_gazobeton = 123490;
    $cley_uteplitel = 123491;
    $cley_pgp = 123492;
    $cley_plitka = 123493;
    $cladochnie_smesi = 123494;

    $shtukaturka = 123495;
    $gruntovka = 123496;
    $smesi_pol = 123497;
    $shpatlevka = 123498;
    $dobavki = 123499;


    $data = [
        $cement => [
            'column1' => [
                'uri' => '/cement/',
                'name' => 'Цемент',
                'img' => '/assets/template/pictures/menu_ico/001.webp',
                'img2' => '/assets/template/pictures/menu_ico/001w.webp'
            ],
            'column2' => [
                [
                    'uri' => '/cement/?proizvoditel=Heidelbergcement',
                    'name' => 'Heidelbergcement',
                    'popular'=>1,
                ],
                [
                    'uri' => '/cement/?proizvoditel=Mix Master',
                    'name' => 'Mix Master',
                    'popular'=>1,
                ],
                [
                    'uri' => '/cement/?proizvoditel=Полигран',
                    'name' => 'Полигран',
                    'popular'=>1,
                ],
                [
                    'uri' => '/cement/?proizvoditel=Себряков',
                    'name' => 'Себряков',
                    'popular'=>1,
                ],
                
            ],
        ],
        $cps => [
            'column1' => [
                'uri' => '/cementno-peschanaya-smes/',
                'name' => 'Цементно-песчаная смесь',
                'img' => '/assets/template/pictures/menu_ico/002.webp',
                'img2' => '/assets/template/pictures/menu_ico/002w.webp'
            ],
            'column2' => [
                
                [
                    'uri' => '/cementno-peschanaya-smes/?proizvoditel=Mix Master',
                    'name' => 'Mix Master',
                    'popular'=>1,
                ],
                [
                    'uri' => '/cementno-peschanaya-smes/?proizvoditel=Петролит',
                    'name' => 'Петролит',
                    'popular'=>1,
                ],
                [
                    'uri' => '/cementno-peschanaya-smes/?proizvoditel=Полигран',
                    'name' => 'Полигран',
                    'popular'=>1,
                ],
                [
                    'uri' => '/cementno-peschanaya-smes/?proizvoditel=Реал',
                    'name' => 'Реал',
                    'popular'=>1,
                ],
                
            ],
        ],
        $cley_gazobeton => [
            'column1' => [
                'uri' => '/klej-dlya-gazobetona/',
                'name' => 'Клей для газобетона',
                'img' => '/assets/template/pictures/menu_ico/003.webp',
                'img2' => '/assets/template/pictures/menu_ico/003w.webp'
            ],
            'column2' => [
                
                [
                    'uri' => '/klej-dlya-gazobetona/?proizvoditel=BREMER',
                    'name' => 'BREMER',
                    'popular'=>1,
                ],
                [
                    'uri' => '/klej-dlya-gazobetona/?proizvoditel=Mix Master',
                    'name' => 'Mix Master',
                    'popular'=>1,
                ],
                [
                    'uri' => '/klej-dlya-gazobetona/?proizvoditel=Unimix',
                    'name' => 'Unimix',
                    'popular'=>1,
                ],
                [
                    'uri' => '/klej-dlya-gazobetona/?proizvoditel=ЕвроАэроБетон (ЕАБ)',
                    'name' => 'ЕвроАэроБетон (ЕАБ)',
                    'popular'=>1,
                ],
                [
                    'uri' => '/klej-dlya-gazobetona/?proizvoditel=ЛСР',
                    'name' => 'ЛСР',
                    'popular'=>1,
                ],
                
            ],
        ],
        $cley_uteplitel => [
            'column1' => [
                'uri' => '/klej-dlya-uteplitelya/',
                'name' => 'Клей для утеплителя',
                'img' => '/assets/template/pictures/menu_ico/006.webp',
                'img2' => '/assets/template/pictures/menu_ico/006w.webp'
            ],
            'column2' => [
                
                [
                    'uri' => '/klej-dlya-uteplitelya/?proizvoditel=Петромикс',
                    'name' => 'Петромикс',
                    'popular'=>1,
                ],
                [
                    'uri' => '/klej-dlya-uteplitelya/?proizvoditel=Полигран',
                    'name' => 'Полигран',
                    'popular'=>1,
                ],
                [
                    'uri' => '/klej-dlya-uteplitelya/?proizvoditel=Реал',
                    'name' => 'Реал',
                    'popular'=>1,
                ],

            ],
        ],
        $cley_pgp => [
            'column1' => [
                'uri' => '/klej-dlya-pgp/',
                'name' => 'Клей для ПГП',
                'img' => '/assets/template/pictures/menu_ico/008.webp',
                'img2' => '/assets/template/pictures/menu_ico/008w.webp'
            ],
            'column2' => [
                
                [
                    'uri' => '/klej-dlya-pgp/?proizvoditel=BREMER',
                    'name' => 'BREMER',
                    'popular'=>1,
                ],
                [
                    'uri' => '/klej-dlya-pgp/?proizvoditel=Волма',
                    'name' => 'Волма',
                    'popular'=>1,
                ],
                [
                    'uri' => '/klej-dlya-pgp/?proizvoditel=Реал',
                    'name' => 'Реал',
                    'popular'=>1,
                ],

            ],
        ],
        $cley_plitka => [
            'column1' => [
                'uri' => '/klej-dlya-plitki/',
                'name' => 'Клей для плитки',
                'img' => '/assets/template/pictures/menu_ico/007.webp',
                'img2' => '/assets/template/pictures/menu_ico/007w.webp'
            ],
        ],
        $cladochnie_smesi => [
            'column1' => [
                'uri' => '/kladochnaya-smes/',
                'name' => 'Кладочные смеси',
                'img' => '/assets/template/pictures/menu_ico/004.webp',
                'img2' => '/assets/template/pictures/menu_ico/004w.webp',
            ],
        ],





        $shtukaturka => [
            'column1' => [
                'uri' => '/shtukaturka/',
                'name' => 'Штукатурка',
                'img' => '/assets/template/pictures/menu_ico/005.webp',
                'img2' => '/assets/template/pictures/menu_ico/005w.webp'
            ],
        ],
        $gruntovka => [
            'column1' => [
                'uri' => '/gruntovka/',
                'name' => 'Грунтовка',
                'img' => '/assets/template/pictures/menu_ico/011.webp',
                'img2' => '/assets/template/pictures/menu_ico/011w.webp'
            ],
        ],
        $smesi_pol => [
            'column1' => [
                'uri' => '/smesi-dlya-pola/',
                'name' => 'Смеси для пола',
                'img' => '/assets/template/pictures/menu_ico/009.webp',
                'img2' => '/assets/template/pictures/menu_ico/009w.webp'
            ],
        ],
        $shpatlevka => [
            'column1' => [
                'uri' => '/shpatlevka/',
                'name' => 'Шпатлевка',
                'img' => '/assets/template/pictures/menu_ico/012.webp',
                'img2' => '/assets/template/pictures/menu_ico/012w.webp'
            ],
        ],
        $dobavki => [
            'column1' => [
                'uri' => '/dobavki-i-modifikatory/',
                'name' => 'Добавки и модификаторы сухих смесей',
                'img' => '/assets/template/pictures/menu_ico/010.webp',
                'img2' => '/assets/template/pictures/menu_ico/010w.webp'
            ],
        ],
    ];

    return $data;
}
