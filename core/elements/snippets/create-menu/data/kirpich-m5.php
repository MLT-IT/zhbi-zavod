<?php

function getMenuData() {
    global $modx;
    $ctx = $modx->context->key;
    $kirpich = 231028;
    $face_kirpich = 231027;
    $keramobloki = 1; //Нет данных
    $fasad_plitka = 231040;
    $pechnoy_kirpich = 231033;
    $brus_mosch = 231029;
    $kladoch = 231034;

    $data = [
        $kirpich => [
            'column1' => [
                'uri' => '/stroitelnye/',
                'name' => 'Строительный (рядовой) кирпич',
                'img' => '/assets/template/pictures/menu_ico/'.$ctx.'/stroitelnyj-ryadovoj-kirpich.webp',
                //'img2' => '/assets/template/pictures/menu_ico/001w.webp'
            ],
            'column2' => [
                ['uri' => '/stroitelnye/',
                'name' => 'Рядовой кирпич'],
                ['uri' => '/stroitelnye/?voidness=Полнотелый',
                'name' => 'Полнотелый'],
                ['uri' => '/stroitelnye/?voidness=Пустотелый',
                'name' => 'Пустотелый'],
            ]
        ],

        $face_kirpich => [
            'column1' => [
                'uri' => '/oblicovochnye/',
                'name' => 'Облицовочный (лицевой) кирпич',
                'img' => '/assets/template/pictures/menu_ico/'.$ctx.'/oblicovochnyj-licevoj-kirpich.webp',
                //'img2' => '/assets/template/pictures/menu_ico/001w.webp'
            ],
            'column2' => [
                ['uri' => '/keramicheskie-oblicovochnye/',
                'name' => 'Керамический лицевой кирпич'],
                ['uri' => '/klinkernye/',
                'name' => 'Клинкреный кирпич'],
                ['uri' => '/ruchnoj-formovki/',
                'name' => 'Кирпич ручной формовки'],
                ['uri' => '/lsr/',
                'name' => 'Кирпич ЛСР'],
            ]
        ],

        $keramobloki => [
            'column1' => [
                'uri' => '/krupnoformatnyj-blok/',
                'name' => 'Крупноформатные блоки',
                'img' => '/assets/template/pictures/menu_ico/'.$ctx.'/keramicheskij-shirokoformatnyj-blok.webp',
                //'img2' => '/assets/template/pictures/menu_ico/001w.webp'
            ],
            'column2' => [
                ['uri' => '/keramobloki/?proizvoditel=%D0%9B%D0%A1%D0%A0',
                'name' => 'Керамоблоки ЛСР'],
                ['uri' => '/keramobloki/?proizvoditel=%D0%A0%D0%B0%D0%B4%D0%BE%D1%88%D0%BA%D0%BE%D0%B2%D0%B8%D1%87%D0%B8%20(Ceglar)',
                'name' => 'Радошковичи (Ceglar)'],
                ['uri' => '/keramobloki/?proizvoditel=Porotherm%20(Wienerberger)',
                'name' => 'Керамоблоки Porotherm (Wienerberger)'],
                ['uri' => '/keramobloki/?proizvoditel=BRAER',
                'name' => 'Керамоблоки BRAER'],
            ]
        ],
        
        $fasad_plitka => [
            'column1' => [
                'uri' => '/fasadnaya-plitka/',
                'name' => 'Фасадная плитка, камень, декор',
                'img' => '/assets/template/pictures/menu_ico/'.$ctx.'/fasadnaya-plitka-kamen-dekor.webp',
                //'img2' => '/assets/template/pictures/menu_ico/001w.webp'
            ],
            'column2' => [
                ['uri' => '/plitka-pod-kirpich/',
                'name' => 'Плитка под кирпич'],
                ['uri' => '/klinkernaya-plitka/',
                'name' => 'Клинкерная плитка'],
                ['uri' => '/keramicheskaya-plitka/',
                'name' => 'Керамическая плитка'],
                ['uri' => '/dekorativnyj-kirpich/',
                'name' => 'Декоративный кирпич'],
                ['uri' => '/plitka-dlya-pechej-i-kaminov/',
                'name' => 'Плитка для печей и каминов'],
                ['uri' => '/iskusstvennyj-kamen-dlya-fasada/',
                'name' => 'Искусственный камень для фасада'],
                ['uri' => '/dekorativnyij-kamen-dlya-vnutrennej-otdelki/',
                'name' => 'Декоративный камень для внутренней отделки'],
                ['uri' => '/plitka-dlya-navesnyh-fasadov/',
                'name' => 'Плитка для навесных фасадов'],
                ['uri' => '/fasadnyj-dekor/',
                'name' => 'Фасадный декор'],
                ['uri' => '/arhitekturnye-elementy-fasada/',
                'name' => 'Архитектурные элементы фасада'],
                ['uri' => '/klinkernye-podokonniki-i-vodootlivy/',
                'name' => 'Клинкерные подоконники и водоотливы'],
            ],
        ],
        
        $pechnoy_kirpich => [
            'column1' => [
                'uri' => '/pechnoj-kirpich/',
                'name' => 'Печной кирпич',
                'img' => '/assets/template/pictures/menu_ico/'.$ctx.'/pechnoj-kirpich.webp',
                //'img2' => '/assets/template/pictures/menu_ico/001w.webp'
            ],
            'column2' => [
                ['uri' => '/pechnoj-kirpich/shamotnye/',
                'name' => 'Шамотный кирпич'],
                ['uri' => '/pechnoj-kirpich/pechnoj-kirpich-keramicheskiy/',
                'name' => 'Керамический кирпич для печей'],
            ]
        ],

        $brus_mosch => [
            'column1' => [
                'uri' => '/bruschatka-i-moshchenie/',
                'name' => 'Брусчатка и мощение',
                'img' => '/assets/template/pictures/menu_ico/'.$ctx.'/bruschatka-i-moshchenie.webp',
                //'img2' => '/assets/template/pictures/menu_ico/001w.webp'
            ],
            'column2' => [
                ['uri' => '/bruschatka-i-plitka-dlya-mosheniya/',
                'name' => 'Брусчатка'],
                ['uri' => '/klinkernaya-bruschatka/',
                'name' => 'Клинкерная брусчатка'],
                ['uri' => '/betonnaya-trotuarnaya-plitka/',
                'name' => 'Бетонная брусчатка'],
                ['uri' => '/bordury/',
                'name' => 'Бордюры'],
                ['uri' => '/bordury-dorozhnyie/',
                'name' => 'Дорожные'],
                ['uri' => '/bordury-trotuarnyie/',
                'name' => 'Тротуарные'],
                ['uri' => '/bordury-sadovyie/',
                'name' => 'Садовые'],
            ]
        ],

        $kladoch => [
            'column1' => [
                'uri' => '/kladochnye-smesi/',
                'name' => 'Кладочные смеси',
                'img' => '/assets/template/pictures/menu_ico/'.$ctx.'/kladochnye-smesi.webp',
                //'img2' => '/assets/template/pictures/menu_ico/001w.webp'
            ],
            'column2' => [
                ['uri' => '/kladochnye-smesi/',
                'name' => 'Кладочные смеси'],
                ['uri' => '/klej-dlya-gazobetona/',
                'name' => 'Клей для газобетона'],
                ['uri' => '/cvetnye-kladochnye-rastvory/',
                'name' => 'Цветные кладочные растворы'],
                ['uri' => '/legkie-teplye-rastvory/',
                'name' => 'Легкие, теплые растворы'],
                ['uri' => '/ogneupornye-smesi/',
                'name' => 'Огнеупорные смеси'],
                ['uri' => '/necvetnye-smesi/',
                'name' => 'Нецветные смеси'],
            ]
        ]

    ];


    /* разбиваем меню на колонки*/
    foreach ($data as $key => $v) {

        if(array_key_exists('column2', $data[$key]))
        {
            $data[$key]['column2'] = array_chunk($v['column2'], 8);
        }

    }


    return $data;
}
