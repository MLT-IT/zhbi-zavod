<?php

function getMenuData() {
    $fanera = 178116;
    $gipsokarton = 177263;
    $ldsp = 177288;
    $dsp = 177282;
    $osb = 177289;
    $csp = 177299;
    $gidrovolokno = 177264;
    $fibrolit = 177296;
    $mdvp = 177042;
    $mdf = 230898;

    $data = [
        $fanera => [
            'column1' => [
                'uri' => '/fanera/',
                'name' => 'Фанера',
                'img' => 'assets/template/pictures/menu_ico/001/fanera.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/fanera1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/fanera/fsf/',
                    'name' => 'Фанера ФСФ',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/fk/',
                    'name' => 'Фанера ФК',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/laminirovannaya/',
                    'name' => 'Ламинированная фанера',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/transportnaya/',
                    'name' => 'Транспортная фанера',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/bakelitovaya/',
                    'name' => 'Бакелитовая фанера',
                    'popular'=>1,
                ],
                
            ],
            'column3' => [
                [
                    'uri' => '/fanera/3-mm/',
                    'name' => '3мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/4-mm/',
                    'name' => '4мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/5-mm/',
                    'name' => '5мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/6-mm/',
                    'name' => '6мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/6.5-mm/',
                    'name' => '6.5мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/7-mm/',
                    'name' => '7мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/8-mm/',
                    'name' => '8мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/9-mm/',
                    'name' => '9мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/10-mm/',
                    'name' => '10мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/12-mm/',
                    'name' => '12мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/15-mm/',
                    'name' => '15мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/18-mm/',
                    'name' => '18мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/20-mm/',
                    'name' => '20мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/21-mm/',
                    'name' => '21мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/24-mm/',
                    'name' => '24мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/27-mm/',
                    'name' => '27мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/30-mm/',
                    'name' => '30мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/35-mm/',
                    'name' => '35мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/40-mm/',
                    'name' => '40мм',
                    'popular'=>1,
                ],
            ],
            'column4' => [
                [
                    'uri' => '/fanera/dlya-podelok/',
                    'name' => 'Для поделок',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/dlya-transporta/',
                    'name' => 'Для транспорта',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/dlya-pola/',
                    'name' => 'Для пола',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/dlya-lodok/',
                    'name' => 'Для лодок',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/dlya-opalubki/',
                    'name' => 'Для опалубки',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/dlya-lazernoj-rezki/',
                    'name' => 'Для лазерной резки',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/dlya-mebeli/',
                    'name' => 'Для мебели',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/dlya-igrushek/',
                    'name' => 'Для игрушек',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/dlya-potolka/',
                    'name' => 'Для потолка',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fanera/dlya-sten/',
                    'name' => 'Для стен',
                    'popular'=>1,
                ]
            ],
        ],
        $gipsokarton => [
            'column1' => [
                'uri' => '/giprok-gipsokarton/',
                'name' => 'Гипсокартон',
                'img' => 'assets/template/pictures/menu_ico/001/gipsokarton.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/gipsokarton1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/giprok-gipsokarton/gyproc/',
                    'name' => 'Gyproc',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/volma/',
                    'name' => 'Волма',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/knauf/',
                    'name' => 'Knauf',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/profil-dlya-gipsokartona/',
                    'name' => 'Профиль для гипсокартона',
                    'popular'=>1,
                ],
            ],
            'column3' => [
                [
                    'uri' => '/giprok-gipsokarton/6.5-mm/',
                    'name' => '6.5мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/8-mm/',
                    'name' => '8мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/9.5-mm/',
                    'name' => '9.5мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/12.5-mm/',
                    'name' => '12.5мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/15-mm/',
                    'name' => '15мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/16-mm/',
                    'name' => '16мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/20-mm/',
                    'name' => '20мм',
                    'popular'=>1,
                ],
               
            ],
            'column4' => [
                [
                    'uri' => '/giprok-gipsokarton/dlya-peregorodok/',
                    'name' => 'Для перегородок',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/dlya-potolka/',
                    'name' => 'Для потолка',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/dlya-ventilyaczii/',
                    'name' => 'Для вентиляции',
                    'popular'=>1,
                ],
                [
                    'uri' => '/giprok-gipsokarton/dlya-sten/',
                    'name' => 'Для стен',
                    'popular'=>1,
                ],
            ],
        ],
        $ldsp => [
            'column1' => [
                'uri' => '/ldsp/',
                'name' => 'ЛДСП',
                'img' => 'assets/template/pictures/menu_ico/001/ldsp.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/ldsp1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/ldsp/egger/',
                    'name' => 'Egger',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ldsp/kronospan/',
                    'name' => 'Kronospan',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ldsp/cleaf/',
                    'name' => 'CLEAF',
                    'popular'=>1,
                ],
            ],
            'column3' => [
                [
                    'uri' => '/ldsp/8-mm/',
                    'name' => '8мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ldsp/16-mm/',
                    'name' => '16мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ldsp/18-mm/',
                    'name' => '18мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ldsp/25-mm/',
                    'name' => '25мм',
                    'popular'=>1,
                ],
            ],
            'column4' => [
                [
                    'uri' => '/ldsp/dlya-kuhni/',
                    'name' => 'Для кухни',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ldsp/dlya-vannoj/',
                    'name' => 'Для ванной',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ldsp/dlya-spalni/',
                    'name' => 'Для спальни',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ldsp/dlya-sten/',
                    'name' => 'Для стен',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ldsp/dlya-pola/',
                    'name' => 'Для пола',
                    'popular'=>1,
                ],
            ],
        ],
        $dsp => [
            'column1' => [
                'uri' => '/dsp-plity/',
                'name' => 'ДСП',
                'img' => 'assets/template/pictures/menu_ico/001/dsp.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/dsp1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/egger/',
                    'name' => 'Egger',
                    'popular'=>1,
                ],
                [
                    'uri' => '/quickdeck/',
                    'name' => 'QuickDeck',
                    'popular'=>1,
                ],
                [
                    'uri' => '/kronostar/',
                    'name' => 'Kronostar',
                    'popular'=>1,
                ],
                [
                    'uri' => '/kronospan/',
                    'name' => 'Kronospan',
                    'popular'=>1,
                ],
            ],
            'column3' => [
                [
                    'uri' => '/10-mm/',
                    'name' => '10мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/12-mm/',
                    'name' => '12мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/16-mm/',
                    'name' => '16мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/18-mm/',
                    'name' => '18мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/22-mm/',
                    'name' => '22мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/25-mm/',
                    'name' => '25мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/38-mm/',
                    'name' => '38мм',
                    'popular'=>1,
                ],
            ],
            'column4' => [
                [
                    'uri' => '/dlya-mebeli/',
                    'name' => 'Для мебели',
                    'popular'=>1,
                ],
                [
                    'uri' => '/dlya-interera/',
                    'name' => 'Для интерьера',
                    'popular'=>1,
                ],
                [
                    'uri' => '/dlya-stellazhei/',
                    'name' => 'Для стеллажей',
                    'popular'=>1,
                ],
                [
                    'uri' => '/dlya-taryi/',
                    'name' => 'Для тары',
                    'popular'=>1,
                ],
            ],
        ],
        $osb => [
            'column1' => [
                'uri' => '/osb-plity/',
                'name' => 'ОСБ',
                'img' => 'assets/template/pictures/menu_ico/001/osb.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/osb1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/osb-plity/kalevala-ehkodom/',
                    'name' => 'Калевала ЭкоДом',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/kronoshpan/',
                    'name' => 'Кроношпан',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/murom/',
                    'name' => 'Муром',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/talion-ultralam/',
                    'name' => 'Талион (Ультралам)',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/shpuntovannaya/',
                    'name' => 'Шпунтованные ОСБ',
                    'popular'=>1,
                ],
            ],
            'column3' => [
                [
                    'uri' => '/osb-plity/6-mm/',
                    'name' => '6мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/8-mm/',
                    'name' => '8мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/9-mm/',
                    'name' => '9мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/10-mm/',
                    'name' => '10мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/11-mm/',
                    'name' => '11мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/12-mm/',
                    'name' => '12мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/15-mm/',
                    'name' => '15мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/18-mm/',
                    'name' => '18мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/20-mm/',
                    'name' => '20мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/22-mm/',
                    'name' => '22мм',
                    'popular'=>1,
                ],
            ],
            'column4' => [
                [
                    'uri' => '/osb-plity/dlya-vneshnej-obshivki/',
                    'name' => 'Для внешней обшивки',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/dlya-vnutrennej-obshivki/',
                    'name' => 'Для внутренней обшивки',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/dlya-krovli/',
                    'name' => 'Для кровли',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/dlya-pola/',
                    'name' => 'Для пола',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/dlya-opalubki/',
                    'name' => 'Для опалубки',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/dlya-taryi/',
                    'name' => 'Для тары',
                    'popular'=>1,
                ],
                [
                    'uri' => '/osb-plity/dlya-mebeli/',
                    'name' => 'Для мебели',
                    'popular'=>1,
                ],
                
            ],
        ],
        $csp => [
            'column1' => [
                'uri' => '/csp-plity/',
                'name' => 'ЦСП',
                'img' => 'assets/template/pictures/menu_ico/001/csp.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/csp1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/csp-plity/pod-kirpich/',
                    'name' => 'ЦСП под кирпич',
                    'popular'=>1,
                ],
            ],
            'column3' => [
                [
                    'uri' => '/csp-plity/8-mm/',
                    'name' => '8мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/10-mm/',
                    'name' => '10мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/12-mm/',
                    'name' => '12мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/16-mm/',
                    'name' => '16мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/20-mm/',
                    'name' => '20мм',
                    'popular'=>1,
                ],
                
            ],
            'column4' => [
                [
                    'uri' => '/csp-plity/dlya-vneshnej-obshivki/',
                    'name' => 'Для внешней обшивки',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/dlya-vnutrennej-obshivki/',
                    'name' => 'Для внутренней обшивки',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/dlya-opalubki/',
                    'name' => 'Для опалубки',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/dlya-krovli/',
                    'name' => 'Для кровли',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/dlya-pola/',
                    'name' => 'Для пола',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/dlya-podokonnika/',
                    'name' => 'Для подоконника',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/dlya-potolka/',
                    'name' => 'Для потолка',
                    'popular'=>1,
                ],
                [
                    'uri' => '/csp-plity/dlya-ventilyaczionnogo-koroba/',
                    'name' => 'Для вентиляционного короба',
                    'popular'=>1,
                ],
            ],
        ],
        $gidrovolokno => [
            'column1' => [
                'uri' => '/gvl-gipsovoloknistye-plity/',
                'name' => 'Гипсоволокнистые плиты',
                'img' => 'assets/template/pictures/menu_ico/001/gvl.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/gvl1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/gvl-gipsovoloknistye-plity/knauf/',
                    'name' => 'Knauf',
                    'popular'=>1,
                ],
            ],
            'column3' => [
                [
                    'uri' => '/gvl-gipsovoloknistye-plity/10-mm/',
                    'name' => '10мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/gvl-gipsovoloknistye-plity/12.5-mm/',
                    'name' => '12.5мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/gvl-gipsovoloknistye-plity/20-mm/',
                    'name' => '20мм',
                    'popular'=>1,
                ],
            ],
            'column4' => [
                [
                    'uri' => '/gvl-gipsovoloknistye-plity/dlya-sten/',
                    'name' => 'Для стен',
                    'popular'=>1,
                ],
                [
                    'uri' => '/gvl-gipsovoloknistye-plity/dlya-peregorodok/',
                    'name' => 'Для перегородок',
                    'popular'=>1,
                ],
                [
                    'uri' => '/gvl-gipsovoloknistye-plity/dlya-potolka/',
                    'name' => 'Для потолка',
                    'popular'=>1,
                ],
                [
                    'uri' => '/gvl-gipsovoloknistye-plity/dlya-shumoizolyaczii/',
                    'name' => 'Для шумоизоляции',
                    'popular'=>1,
                ],
            ],
        ],
        $fibrolit => [
            'column1' => [
                'uri' => '/fibrolitovye-plity/',
                'name' => 'Фибролитовые плиты',
                'img' => 'assets/template/pictures/menu_ico/001/fibrolit.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/fibrolit1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/fibrolitovye-plity/nordeco/',
                    'name' => 'Nordeco',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/green-board/',
                    'name' => 'Green Board',
                    'popular'=>1,
                ],
            ],
            'column3' => [
                [
                    'uri' => '/fibrolitovye-plity/10-mm/',
                    'name' => '10мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/12-mm/',
                    'name' => '12мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/14-mm/',
                    'name' => '14мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/15-mm/',
                    'name' => '15мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/18-mm/',
                    'name' => '18мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/22-mm/',
                    'name' => '22мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/25-mm/',
                    'name' => '25мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/35-mm/',
                    'name' => '35мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/50-mm/',
                    'name' => '50мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/100-mm/',
                    'name' => '100мм',
                    'popular'=>1,
                ],
                
            ],
            'column4' => [
                [
                    'uri' => '/fibrolitovye-plity/dlya-akusticheskix-potolkov/',
                    'name' => 'Для акустических потолков',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/dlya-obliczovki-sten/',
                    'name' => 'Для облицовки стен',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/dlya-shumoizolyaczii/',
                    'name' => 'Для шумоизоляции',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/dlya-krovli/',
                    'name' => 'Для кровли',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/dlya-utepleniya/',
                    'name' => 'Для утепления',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/dlya-fundamenta/',
                    'name' => 'Для фундамента/цоколя',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/dlya-karkasnyix-sten-i-peregorodok/',
                    'name' => 'Для каркасных стен и перегородок',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/dlya-ploskix-krovel/',
                    'name' => 'Для плоских кровель',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/sip-texnologiya/',
                    'name' => 'SIP технология',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/dlya-podvesnyix-potolkov/',
                    'name' => 'Для подвесных потолков',
                    'popular'=>1,
                ],
                [
                    'uri' => '/fibrolitovye-plity/dlya-finishnoj-otdelki/',
                    'name' => 'Для финишной отделки',
                    'popular'=>1,
                ],
                
            ],
        ],
        $mdvp => [
            'column1' => [
                'uri' => '/plity-mdvp/',
                'name' => 'МДВП',
                'img' => 'assets/template/pictures/menu_ico/001/mdvp.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/mdvp1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/plity-mdvp/beltermo/',
                    'name' => 'Beltermo',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/isoplaat/',
                    'name' => 'Isoplaat',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/steico/',
                    'name' => 'Steico',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/knauf/',
                    'name' => 'Knauf',
                    'popular'=>1,
                ],
            ],
            'column3' => [
                [
                    'uri' => '/plity-mdvp/10-mm/',
                    'name' => '10мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/12-mm/',
                    'name' => '12мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/15-mm/',
                    'name' => '15мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/19-mm/',
                    'name' => '19мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/20-mm/',
                    'name' => '20мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/22-mm/',
                    'name' => '22мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/24-mm/',
                    'name' => '24мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/25-mm/',
                    'name' => '25мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/30-mm/',
                    'name' => '30мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/35-mm/',
                    'name' => '35мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/40-mm/',
                    'name' => '40мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/50-mm/',
                    'name' => '50мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/60-mm/',
                    'name' => '60мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/80-mm/',
                    'name' => '80мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/100-mm/',
                    'name' => '100мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/120-mm/',
                    'name' => '120мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/140-mm/',
                    'name' => '140мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/150-mm/',
                    'name' => '150мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/160-mm/',
                    'name' => '160мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/180-mm/',
                    'name' => '180мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/200-mm/',
                    'name' => '200мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/220-mm/',
                    'name' => '220мм',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/240-mm/',
                    'name' => '240мм',
                    'popular'=>1,
                ],
               
            ],
            'column4' => [
                [
                    'uri' => '/plity-mdvp/dlya-fasada/',
                    'name' => 'Для фасада',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/dlya-perekryitij/',
                    'name' => 'Для перекрытий',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/dlya-vnutrennix-sten/',
                    'name' => 'Для внутренних стен',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/dlya-vneshnix-sten/',
                    'name' => 'Для внешних стен',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/dlya-pola/',
                    'name' => 'Для пола',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/dlya-potolka/',
                    'name' => 'Для потолка',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/dlya-krovli/',
                    'name' => 'Для кровли',
                    'popular'=>1,
                ],
                [
                    'uri' => '/plity-mdvp/dlya-peregorodok/',
                    'name' => 'Для перегородок',
                    'popular'=>1,
                ],
            ],
        ],
        $mdf => [
            'column1' => [
                'uri' => '/mdf-plity/',
                'name' => 'МДФ',
                'img' => 'assets/template/pictures/menu_ico/001/mdf.webp',
                'img2' => 'assets/template/pictures/menu_ico/001/mdf1.webp'
            ],
            'column2' => [
                [
                    'uri' => '/mdf-plity/kastamonu/',
                    'name' => 'Kastamonu',
                    'popular'=>1,
                ],
                [
                    'uri' => '/mdf-plity/zheshart-upg/',
                    'name' => 'Жешарт (UPG)',
                    'popular'=>1,
                ],
            ],
            'column3' => [
               
                // [
                //     'uri' => '/plity-mdvp/240-mm/',
                //     'name' => '240мм',
                //     'popular'=>1,
                // ],
               
            ],
            'column4' => [
               
                // [
                //     'uri' => '/plity-mdvp/dlya-peregorodok/',
                //     'name' => 'Для перегородок',
                //     'popular'=>1,
                // ],
            ],
        ],
        
        
    ];


    //==========сортировка продуктовой линейки по популярности и алфавиту НАЧАЛО=====================
    
    //правило сортировки по популярности и алфавиту
    function cmp_function2($a, $b){
        
        //если есть популярность ставим вперед непопулярных
        if(isset($a['popular'])&&!isset($b['popular'])){
            return false;
        }
        if(!isset($a['popular'])&&isset($b['popular'])){
            return true;
        }
        //если есть популярность у обоих сравниваем популрности (чем меньше число тем раньше выводит)
        if(isset($a['popular'])&&isset($b['popular'])){
            return ($a['popular'] > $b['popular']);
        }
        //если нет популярности у обоих сравниваем имена по алфавиту
        if(!isset($a['popular'])&&!isset($b['popular'])){
            //стоит задача: чтобы русские названия по алфавиту были вначале, и только потом английские по алфавиту 
            //сделаем через получение кода первого символа имени
            //в таблице ASCII есть разрывы в ряду номеров по алфавиту, но индексы заглавных идут попорядку, поднимем регистр при сравнении
            // RU 128-159
            // EN 65-90


            //возьмем первый сивол имени, поднимаем регистр, получим его код
            $a1=ord(strtoupper($a['name'][0]));
            $b1=ord(strtoupper($b['name'][0]));
            
            //0 unknown, 1 en, 2ru
            $a_lang=0; 
            $b_lang=0;

            if(($a1>=128)&&($a1<=159)){$a_lang=2;}
            elseif(($a1>=65)&&($a1<=90)){$a_lang=1;}

            if(($b1>=128)&&($b1<=159)){$b_lang=2;}
            elseif(($b1>=65)&&($b1<=90)){$b_lang=1;}


            if($a_lang==$b_lang){
                return ($a['name'] > $b['name']);
            }elseif($a_lang<$b_lang){
                return false;
            }elseif($a_lang>$b_lang){
                return true;
            }
        }
    }

    foreach ($data as $key => $values){
        uasort($data[$key]['column2'], 'cmp_function2');//сортируем по популярности
    }
    //==========сортировка продуктовой линейки по популярности и алфавиту КОНЕЦ=====================

    foreach ($data as $key => $values) {
        $data[$key]['column2'] = array_chunk($values['column2'], 12);
        $data[$key]['column3'] = array_chunk($values['column3'], 6);
        $data[$key]['column4'] = array_chunk($values['column4'], 7);
    }

    return $data;
}
