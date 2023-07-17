<?php

function getMenuData() {
    $grunty = 102922;
    $voddis = 103255;
    $pokder = 103193;
    $emali = 117397;
    $laki = 113157;
    $rastvoch = 112001;
    $coleri = 119822;
    $shpat = 107936;
    $instr = 120953;
    $dobsuh = 107935;

    $data = [
        $grunty => [
            'column1' => [
                'uri' => '/grunty/',
                'name' => 'Грунты',
                'svg' => 'paint-roller'
            ],
            'column2' => [
                [
                    "uri" => "/gruntovki/",
                    "name" => "Грунтовки",
                ],
                [
                    "uri" => "/betonokontakt/",
                    "name" => "Бетоноконтакт",
                ],
                [
                    "uri" => "/gidrofobizatory/",
                    "name" => "Гидрофобизаторы",
                ],
                [
                    "uri" => "/zhidkoe-steklo/",
                    "name" => "Жидкое стекло",
                ],
            ],
        ],
        $voddis => [
            'column1' => [
                'uri' => '/vodno-dispersionnyie-kraski/',
                'name' => 'Водно-дисперсионные краски',
                'svg' => 'kraska'
            ],
        ],
        $pokder => [
            'column1' => [
                'uri' => '/vodno-dispersionnyie-kraski/',
                'name' => 'Покрытия для дерева',
                'svg' => 'pint'
            ],
            'column2' => [
                [
                    "uri" => "/propitki-dlya-dereva/",
                    "name" => "Пропитки для дерева",
                ],
                [
                    "uri" => "/ognebiozashhita/",
                    "name" => "Огнебиозащита",
                ],
                [
                    "uri" => "/otbelivateli-drevesiny/",
                    "name" => "Отбеливатели древесины",
                ],
                [
                    "uri" => "/masla-i-voski-dlya-dereva/",
                    "name" => "Масла и воски для дерева",
                ],
                [
                    "uri" => "/morilki/",
                    "name" => "Морилки",
                ],
                [
                    "uri" => "/lazuri-dlya-dereva/",
                    "name" => "Лазури для дерева",
                ],
            ],
        ],
        $emali => [
            'column1' => [
                'uri' => '/emali/',
                'name' => 'Эмали',
                'svg' => 'paint-bucket'
            ],
        ],
        $laki => [
            'column1' => [
                'uri' => '/laki/',
                'name' => 'Лаки',
                'svg' => 'lak'
            ],
        ],
        $rastvoch => [
            'column1' => [
                'uri' => '/rastvoriteli-i-ochistiteli/',
                'name' => 'Растворители и очистители',
                'svg' => 'canister'
            ],
            'column2' => [
                [
                    "uri" => "/ochistiteli/",
                    "name" => "Очистители",
                ],
                [
                    "uri" => "/rastvoriteli/",
                    "name" => "Растворители",
                ],
            ],
        ],
        $coleri => [
            'column1' => [
                'uri' => '/kolery/',
                'name' => 'Колеры',
                'svg' => 'colour'
            ],
        ],
        $shpat => [
            'column1' => [
                'uri' => '/shpatlevki/',
                'name' => 'Шпатлевки',
                'svg' => 'putty-knife'
            ],
            'column2' => [
                [
                    "uri" => "/shpatlevki-gotovyie/",
                    "name" => "Готовые",
                ],
            ],
        ],
        $instr => [
            'column1' => [
                'uri' => '/instrumenty/',
                'name' => 'Инструменты',
                'svg' => 'customer-support'
            ],
        ],
        $dobsuh => [
            'column1' => [
                'uri' => '/dobavki-v-suhie-stroitelnyie-smesi/',
                'name' => 'Добавки в сухие строительные смеси',
                'svg' => 'glue'
            ],
        ],
    ];

    return $data;
}
