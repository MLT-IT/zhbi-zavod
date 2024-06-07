<?php

function getMenuData() {
    $tip = 'tip';
    $frakzia = 'frakzia';
    $upakovka = 'upakovka';
    $razmer = 'razmer';
   
    $data = [
        $tip => [
            'column1' => [
                'uri' => '',
                'name' => 'Тип',
                // 'img' => '/assets/template/pictures/menu_ico/001.webp',
                // 'img2' => '/assets/template/pictures/menu_ico/001w.webp'
            ],
            'column2' => [

                ['name' => 'Керамзитовый песок', 'uri' => '/catalog/melkij-keramzit/keramzitovyij-pesok/', 'popular' => 1],
                ['name' => 'Керамзитовая крошка', 'uri' => '/catalog/melkij-keramzit/keramzitovaya-kroshka/', 'popular' => 1],
                ['name' => 'Керамзитовая засыпка', 'uri' => '/catalog/melkij-keramzit/keramzitovaya-zasyipka/', 'popular' => 1],
                ['name' => 'Керамзитовый гравий', 'uri' => '/catalog/keramzitovyij-gravij/', 'popular' => 1],
                
            ],
        ],
        $frakzia => [
            'column1' => [
                'uri' => '',
                'name' => 'Фракция',
                // 'img' => '/assets/template/pictures/menu_ico/002.webp',
                // 'img2' => '/assets/template/pictures/menu_ico/002w.webp'
            ],
            'column2' => [
                
                ['name' => 'Фракция 0-5', 'uri' => '/catalog/frakczii-0-5/', 'popular' => 1],
                ['name' => 'Фракция 5-10', 'uri' => '/catalog/frakczii-5-10/', 'popular' => 1],
                ['name' => 'Фракция 10-20', 'uri' => '/catalog/frakczii-10-20/', 'popular' => 1],
                ['name' => 'Фракция 20-40', 'uri' => '/catalog/frakczii-20-40/', 'popular' => 1],
                
            ],
        ],
        $upakovka => [
            'column1' => [
                'uri' => '',
                'name' => 'Упаковка',
                // 'img' => '/assets/template/pictures/menu_ico/003.webp',
                // 'img2' => '/assets/template/pictures/menu_ico/003w.webp'
            ],
            'column2' => [
                
                ['name' => 'Керамзит навалом', 'uri' => '/catalog/navalom/', 'popular' => 1],
                ['name' => 'Керамзит в мешках', 'uri' => '/catalog/v-meshkax/', 'popular' => 1],
                ['name' => 'Керамзит в биг-бэгах', 'uri' => '/catalog/v-big-begax/', 'popular' => 1],
                
            ],
        ],
        $razmer => [
            'column1' => [
                'uri' => '',
                'name' => 'Клей для утеплителя',
                // 'img' => '/assets/template/pictures/menu_ico/006.webp',
                // 'img2' => '/assets/template/pictures/menu_ico/006w.webp'
            ],
            'column2' => [
                
                ['name' => 'Мелкий', 'uri' => '/catalog/melkij-keramzit/', 'popular' => 1],
                ['name' => 'Крупный', 'uri' => '/catalog/krupnyij/', 'popular' => 1],

            ],
        ],
      
    ];

    return $data;
}
