<?php

function getMenuData() {
    $dlya_zabora = 218619;
    $dlya_krovli = 218600;
    $dlya_angarov = 218645;


    $data = [
        $dlya_zabora => [
            'column1' => [
                'uri' => '/profilirovannyy-list-dlya-zabora/',
                'name' => 'Для забора',
                'img' => '/assets/template/pictures/menu_ico/002/001.webp',
                'img2' => '/assets/template/pictures/menu_ico/002/001w.webp',
                
            ],
            'column2' => [
                [
                    'uri' => '/profilirovannyy-list-dlya-zabora-grand-layn/',
                    'name' => 'Гранд Лайн',
                    'popular'=>1,
                ],
                [
                    'uri' => '/profilirovannyj-list-dlya-zabora-metall-profil/',
                    'name' => 'Металл Профиль',
                    'popular'=>1,
                ],
                // [
                //     'uri' => '/proflist-dlya-zabora-ooo-pk-proflist-metall/',
                //     'name' => 'Профлист Металл',
                //     'popular'=>1,
                // ],
                // [
                //     'uri' => '/proflist-dlya-zabora-ooo-pk-proflist-moment/',
                //     'name' => 'Профлист Момент',
                //     'popular'=>1,
                // ],
                
            ],
        ],
        $dlya_krovli => [
            'column1' => [
                'uri' => '/proflist-dlya-krovli/',
                'name' => 'Для кровли',
                'img' => '/assets/template/pictures/menu_ico/002/002.webp',
                'img2' => '/assets/template/pictures/menu_ico/002/002w.webp',
                
            ],
            'column2' => [
                
                [
                    'uri' => '/proflist-grand-line/',
                    'name' => 'Гранд Лайн',
                    'popular'=>1,
                ],
                [
                    'uri' => '/proflist-metall-profil/',
                    'name' => 'Металл Профиль',
                    'popular'=>1,
                ],
                // [
                //     'uri' => '/proflist-dlya-krovli-metall-profil/',
                //     'name' => 'Профлист Металл',
                //     'popular'=>1,
                // ],
                // [
                //     'uri' => '/proflist-dlya-krovli-ooo-pk-proflist-moment/',
                //     'name' => 'Профлист Момент',
                //     'popular'=>1,
                // ],
                
            ],
        ],
        $dlya_angarov => [
            'column1' => [
                'uri' => '/proflist-dlya-angarov/',
                'name' => 'Для ангара',
                'img' => '/assets/template/pictures/menu_ico/002/003.webp',
                'img2' => '/assets/template/pictures/menu_ico/002/003w.webp',
                
            ],
            'column2' => [
                
                // [
                //     'uri' => '/proflist-dlya-angarov-ooo-pk-proflist-metall/',
                //     'name' => 'Профлист Металл',
                //     'popular'=>1,
                // ],
                // [
                //     'uri' => '/proflist-dlya-angarov-ooo-pk-proflist-moment/',
                //     'name' => 'Профлист Момент',
                //     'popular'=>1,
                // ],
                
            ],
        ],
    ];

    return $data;
}
