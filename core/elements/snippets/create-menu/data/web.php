<?php

function getMenuData() {
    $knauf = 93185;
    $rockwool = 93190;
    $umatex = 124718;
    $tn = 93191;
    $penoplex = 93189;
    $isover = 93187;
    $paroc = 93188;
    $ursa = 93192;
    $isoroc = 93186;

    $data = [
        $rockwool => [
            'column1' => [
                'uri' => '/rockwool/',
                'name' => 'Утеплитель Rockwool',
                'img' => '/assets/template/img/brands/rockwool.jpg'
            ],
            'column2' => [
                [
                    'uri' => '/rockwool/light-batts/',
                    'name' => 'Лайт Баттс',
                    'popular'=>1,
                ],
                [
                    'uri' => '/rockwool/light-batts/light-batts-scandic/',
                    'name' => 'Скандик Лайт Баттс',
                    'popular'=>2,
                ],
                [
                    'uri' => '/rockwool/light-batts/light-batts-optima/',
                    'name' => 'Лайт Баттс Оптима',
                    'popular'=>3,
                ],

                [
                    'uri' => '/rockwool/acoustic-batts/',
                    'name' => 'Акустик Баттс',
                ],
                [
                    'uri' => '/rockwool/karkas-batts/',
                    'name' => 'Каркас Баттс',
                ],
                [
                    'uri' => '/rockwool/fasad-batts/',
                    'name' => 'Фасад Баттс',
                ],
                [
                    'uri' => '/rockwool/floor-batts/',
                    'name' => 'Флор Баттс',
                ],
                
                [
                    'uri' => '/rockwool/roof-batts/',
                    'name' => 'Руф Баттс',
                ],
                [
                    'uri' => '/rockwool/venti-batts/',
                    'name' => 'Венти Баттс',
                ],
                [
                    'uri' => '/rockwool/standart/',
                    'name' => 'Роквул Стандарт',
                ],
                [
                    'uri' => '/rockwool/econom/',
                    'name' => 'Эконом',
                ],
                [
                    'uri' => '/rockwool/teh-mat/',
                    'name' => 'ТЕХ МАТ',
                ],
                [
                    'uri' => '/rockwool/rockfacade/',
                    'name' => 'Рокфасад',
                ],
                [
                    'uri' => '/rockwool/rokvul-tekh-batts/',
                    'name' => 'Роквул Тех Баттс',
                ],
                [
                    'uri' => '/rockwool/soput-tovary/',
                    'name' => 'Сопутствующие товары',
                ],
                [
                    'uri' => '/rockwool/wired-mat/',
                    'name' => 'WIRED MAT',
                ],
                [
                    'uri' => '/rockwool/cilindry-navivnye/',
                    'name' => 'Цилиндры навивные',
                ],
                [
                    'uri' => '/rockwool/lamella-mat-l/',
                    'name' => 'Lamella Mat',
                ],
                [
                    'uri' => '/rockwool/conlit-sl-150/',
                    'name' => 'CONLIT SL 150',
                ],
                [
                    'uri' => '/rockwool/kaviti-batts/',
                    'name' => 'Кавити Баттс',
                ],
                [
                    'uri' => '/rockwool/sauna-batts/',
                    'name' => 'Сауна Баттс',
                ],
                [
                    'uri' => '/rockwool/searox/',
                    'name' => 'SeaRox',
                ],
                [
                    'uri' => '/rockwool/ft-barrier/',
                    'name' => 'FT BARRIER',
                ],
                [
                    'uri' => '/rockwool/fire-batts/',
                    'name' => 'Fire Batts',
                ],
                [
                    'uri' => '/rockwool/kamin-batts/',
                    'name' => 'Камин Баттс',
                ],
                [
                    'uri' => '/rockwool/plaster-batts/',
                    'name' => 'Пластер Баттс',
                ],
                [
                    'uri' => '/rockwool/klimafix/',
                    'name' => 'Klimafix',
                ],
                [
                    'uri' => '/rockwool/acoustic-standart/',
                    'name' => 'Акустик Стандарт',
                ],
                [
                    'uri' => '/rockwool/sendvich-batts/',
                    'name' => 'Сэндвич Баттс',
                ],
                [
                    'uri' => '/rockwool/prorox/',
                    'name' => 'ProRox',
                ],
                [
                    'uri' => '/rockwool/industrial-batts-80/',
                    'name' => 'Industrial Batts 80',
                ],
                [
                    'uri' => '/rockwool/beton-element-batts/',
                    'name' => 'Бетон Элемент Баттс',
                ],
            ],
            'column4' => [
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20печи/камина",
                    "name" => "Для печи/камина",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Под%20штукатурку",
                    "name" => "Под штукатурку",
                ],
                [
                    "uri" => "/rockwool/?msoption|primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/rockwool/?msoption|item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=25",
                    "name" => "25",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=27",
                    "name" => "27",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $umatex => [
            'column1' => [
                'uri' => '/yumateks-termo/',
                'name' => 'Утеплитель Юматекс',
                'img' => '/assets/template/img/brands/umatex.jpg',
                'label' => true
            ],
            'column2' => [
                [
                    'uri' => '/yumateks-termo/smart-xl/',
                    'name' => 'Smart (XL)',
                    'popular'=>1,
                ],
                [
                    'uri' => '/yumateks-termo/light/',
                    'name' => 'Light',
                    'popular'=>2,
                ],
                [
                    'uri' => '/yumateks-termo/plus/',
                    'name' => 'Plus',
                    'popular'=>3,
                ],
                [
                    'uri' => '/yumateks-termo/inwall/',
                    'name' => 'InWall'
                ],
                [
                    'uri' => '/yumateks-termo/fatio/',
                    'name' => 'Fatio'
                ],
                [
                    'uri' => '/yumateks-termo/linio-10/',
                    'name' => 'Linio 10'
                ],
                [
                    'uri' => '/yumateks-termo/linio-15/',
                    'name' => 'Linio 15'
                ],
                [
                    'uri' => '/yumateks-termo/linio-18/',
                    'name' => 'Linio 18'
                ],
                [
                    'uri' => '/yumateks-termo/linio-20/',
                    'name' => 'Linio 20'
                ],
                [
                    'uri' => '/yumateks-termo/linio-80/',
                    'name' => 'Linio 80'
                ],
                [
                    'uri' => '/yumateks-termo/fps-14/',
                    'name' => 'FPS 14'
                ],
                [
                    'uri' => '/yumateks-termo/fps-17/',
                    'name' => 'FPS 17'
                ],
                [
                    'uri' => '/yumateks-termo/grs-20/',
                    'name' => 'GRS 20'
                ],
                [
                    'uri' => '/yumateks-termo/rob-60/',
                    'name' => 'ROB 60'
                ],
                [
                    'uri' => '/yumateks-termo/rob-80/',
                    'name' => 'ROB 80'
                ],
                [
                    'uri' => '/yumateks-termo/rol-40/',
                    'name' => 'ROL 40'
                ],
                [
                    'uri' => '/yumateks-termo/rol-60/',
                    'name' => 'ROL 60'
                ],
                [
                    'uri' => '/yumateks-termo/ros-30/',
                    'name' => 'ROS 30'
                ],
                [
                    'uri' => '/yumateks-termo/ros-40/',
                    'name' => 'ROS 40'
                ],
                [
                    'uri' => '/yumateks-termo/ros-50/',
                    'name' => 'ROS 50'
                ],
                [
                    'uri' => '/yumateks-termo/ros-60/',
                    'name' => 'ROS 60'
                ],
                [
                    'uri' => '/yumateks-termo/ros-80t/',
                    'name' => 'ROS 80t'
                ],
                [
                    'uri' => '/yumateks-termo/ssb-1/',
                    'name' => 'SSB 1'
                ],
                [
                    'uri' => '/yumateks-termo/ssb-4/',
                    'name' => 'SSB 4'
                ],
                [
                    'uri' => '/yumateks-termo/was-120/',
                    'name' => 'WAS 120'
                ],
                [
                    'uri' => '/yumateks-termo/was-25/',
                    'name' => 'WAS 25'
                ],
                [
                    'uri' => '/yumateks-termo/was-35/',
                    'name' => 'WAS 35'
                ],
                [
                    'uri' => '/yumateks-termo/was-50/',
                    'name' => 'WAS 50'
                ],
                [
                    'uri' => '/yumateks-termo/cgl-20/',
                    'name' => 'CGL 20'
                ],
            ],
            'column3' => [
                [
                    'name' => '20',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=20'
                ],
                [
                    'name' => '25',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=25'
                ],
                [
                    'name' => '30',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=30'
                ],
                [
                    'name' => '40',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=40'
                ],
                [
                    'name' => '50',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=50'
                ],
                [
                    'name' => '60',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=60'
                ],
                [
                    'name' => '70',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=70'
                ],
                [
                    'name' => '75',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=75'
                ],
                [
                    'name' => '100',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=100'
                ],
                [
                    'name' => '120',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=120'
                ],
                [
                    'name' => '150',
                    'uri' => '/yumateks-termo/?msoption|item_thickness=150'
                ]
            ],
            'column4' => [
                [
                    'name' => 'Вентилируемые фасады',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%92%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D0%B8%D1%80%D1%83%D0%B5%D0%BC%D1%8B%D0%B5%20%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D1%8B',
                ],
                [
                    'name' => 'Вентилируемые фасады в двухслойных системах',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%92%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D0%B8%D1%80%D1%83%D0%B5%D0%BC%D1%8B%D0%B5%20%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D1%8B%20%D0%B2%20%D0%B4%D0%B2%D1%83%D1%85%D1%81%D0%BB%D0%BE%D0%B9%D0%BD%D1%8B%D1%85%20%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D0%B0%D1%85',
                ],
                [
                    'name' => 'Внутренние стены (межкомнатные перегородки)',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%92%D0%BD%D1%83%D1%82%D1%80%D0%B5%D0%BD%D0%BD%D0%B8%D0%B5%20%D1%81%D1%82%D0%B5%D0%BD%D1%8B%20(%D0%BC%D0%B5%D0%B6%D0%BA%D0%BE%D0%BC%D0%BD%D0%B0%D1%82%D0%BD%D1%8B%D0%B5%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BA%D0%B8)',
                ],
                [
                    'name' => 'Для дверей',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D0%B4%D0%B2%D0%B5%D1%80%D0%B5%D0%B9',
                ],
                [
                    'name' => 'Для кровли',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8',
                ],
                [
                    'name' => 'Для перегородок',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA',
                ],
                [
                    'name' => 'Для перегородок и перекрытий',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA%20%D0%B8%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9',
                ],
                [
                    'name' => 'Для перекрытий',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9',
                ],
                [
                    'name' => 'Для подвалов',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%BE%D0%B4%D0%B2%D0%B0%D0%BB%D0%BE%D0%B2',
                ],
                [
                    'name' => 'Для пола',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%BE%D0%BB%D0%B0',
                ],
                [
                    'name' => 'Для потолка',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0',
                ],
                [
                    'name' => 'Для потолков',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%BE%D0%B2',
                ],
                [
                    'name' => 'Для стен',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D1%81%D1%82%D0%B5%D0%BD',
                ],
                [
                    'name' => 'Для труб',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D1%82%D1%80%D1%83%D0%B1',
                ],
                [
                    'name' => 'Для фасада',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0',
                ],
                [
                    'name' => 'Для фундамента',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%94%D0%BB%D1%8F%20%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0',
                ],
                [
                    'name' => 'Звукоизоляция',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%97%D0%B2%D1%83%D0%BA%D0%BE%D0%B8%D0%B7%D0%BE%D0%BB%D1%8F%D1%86%D0%B8%D1%8F',
                ],
                [
                    'name' => 'Камины и печи',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%9A%D0%B0%D0%BC%D0%B8%D0%BD%D1%8B%20%D0%B8%20%D0%BF%D0%B5%D1%87%D0%B8',
                ],
                [
                    'name' => 'Каркасные конструкции',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%9A%D0%B0%D1%80%D0%BA%D0%B0%D1%81%D0%BD%D1%8B%D0%B5%20%D0%BA%D0%BE%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D0%B8',
                ],
                [
                    'name' => 'Мансарды',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%9C%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B',
                ],
                [
                    'name' => 'Межэтажные перекрытия',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%9C%D0%B5%D0%B6%D1%8D%D1%82%D0%B0%D0%B6%D0%BD%D1%8B%D0%B5%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D1%8F',
                ],
                [
                    'name' => 'Ненагружаемые конструкции',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%9D%D0%B5%D0%BD%D0%B0%D0%B3%D1%80%D1%83%D0%B6%D0%B0%D0%B5%D0%BC%D1%8B%D0%B5%20%D0%BA%D0%BE%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D0%B8',
                ],
                [
                    'name' => 'Скатные кровли',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%A1%D0%BA%D0%B0%D1%82%D0%BD%D1%8B%D0%B5%20%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8',
                ],
                [
                    'name' => 'Средний слой в кирпичной кладке',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%A1%D1%80%D0%B5%D0%B4%D0%BD%D0%B8%D0%B9%20%D1%81%D0%BB%D0%BE%D0%B9%20%D0%B2%20%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87%D0%BD%D0%BE%D0%B9%20%D0%BA%D0%BB%D0%B0%D0%B4%D0%BA%D0%B5',
                ],
                [
                    'name' => 'Техническая изоляция',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%A2%D0%B5%D1%85%D0%BD%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F%20%D0%B8%D0%B7%D0%BE%D0%BB%D1%8F%D1%86%D0%B8%D1%8F',
                ],
                [
                    'name' => 'Универсальный',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%A3%D0%BD%D0%B8%D0%B2%D0%B5%D1%80%D1%81%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9',
                ],
                [
                    'name' => 'Чердачные перекрытия',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%A7%D0%B5%D1%80%D0%B4%D0%B0%D1%87%D0%BD%D1%8B%D0%B5%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D1%8F',
                ],
                [
                    'name' => 'Штукатурные фасады',
                    'uri' => '/yumateks-termo/?msoption|primenenie=%D0%A8%D1%82%D1%83%D0%BA%D0%B0%D1%82%D1%83%D1%80%D0%BD%D1%8B%D0%B5%20%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D1%8B',
                ],
            ],
        ],
        $tn => [
            'column1' => [
                'uri' => '/tn/',
                'name' => 'Утеплитель Технониколь',
                'img' => '/assets/template/img/brands/tehnonikol.jpg'
            ],
            'column2' => [
                [
                    'uri' => '/tn/carbon/',
                    'name' => 'Технониколь Carbon',
                    'popular'=>1,
                ],
                [
                    'uri' => '/tn/tekhnonikol-roklajt/',
                    'name' => 'Технониколь Роклайт',
                    'popular'=>2,
                ],
                [
                    'uri' => '/tn/tekhnoruf/',
                    'name' => 'Технониколь Техноруф',
                    'popular'=>3,
                ],
                [
                    'uri' => '/tn/tekhnonikol-tekhnopleks/',
                    'name' => 'XPS Техноплекс'
                ],
                [
                    'uri' => '/tn/tekhnonikol-logicpir/',
                    'name' => 'Технониколь LOGICPIR'
                ],
                [
                    'uri' => '/tn/tekhnofas/',
                    'name' => 'Технониколь Технофас'
                ],
                [
                    'uri' => '/tn/tekhnovent/',
                    'name' => 'Технониколь Техновент'
                ],
                [
                    'uri' => '/tn/tekhnoblok/',
                    'name' => 'Технониколь Техноблок'
                ],
                [
                    'uri' => '/tn/tekhnolajt/',
                    'name' => 'Технониколь Технолайт'
                ],
                [
                    'uri' => '/tn/tekhnonikol-izoboks/',
                    'name' => 'Технониколь Изобокс'
                ],
                [
                    'uri' => '/tn/tekhnonikol-master-zvukozashchita/',
                    'name' => 'Технониколь Шумоизоляция'
                ],
                [
                    'uri' => '/tn/plity-pir/',
                    'name' => 'Технониколь Плиты PIR'
                ],
                [
                    'uri' => '/tn/plita-tekhno-ozm/',
                    'name' => 'Плита Техно ОЗМ'
                ],
                [
                    'uri' => '/tn/zvukoizolyaciya-tekhnonikol-tekhnoakustik/',
                    'name' => 'Технониколь Техноакустик'
                ],
                [
                    'uri' => '/tn/tekhnonikol-shtukaturnyj-fasad/',
                    'name' => 'Технониколь Штукатурный фасад'
                ],
                [
                    'uri' => '/tn/tekhnonikol-sendvich-tekhnonikol-c-xps/',
                    'name' => 'Технониколь Сэндвич Ц-XPS'
                ],
                [
                    'uri' => '/tn/uteplitel-tekhnonikol-tekhnoflor/',
                    'name' => 'Технониколь Технофлор'
                ],
                [
                    'uri' => '/tn/polimernye-gidroizolyacionnye-membrany/',
                    'name' => 'Полимерные гидроизоляционные мембраны'
                ],
                [
                    'uri' => '/tn/bazalit/',
                    'name' => 'Технониколь Базалит'
                ],
                [
                    'uri' => '/tn/plita-tekhno-ozb/',
                    'name' => 'Плита Техно ОЗБ'
                ],
                [
                    'uri' => '/tn/plita-tekhno-t/',
                    'name' => 'Плита Техно Т'
                ],
                [
                    'uri' => '/tn/tekhnonikol-greenguard/',
                    'name' => 'Технониколь GreenGuard'
                ],
                [
                    'uri' => '/tn/tekhnosendvich/',
                    'name' => 'Технониколь Техносэндвич'
                ],
                [
                    'uri' => '/tn/plita-tekhno-ozd/',
                    'name' => 'Плита Техно ОЗД'
                ],
                [
                    'uri' => '/tn/cilindr-tekhno/',
                    'name' => 'Цилиндр Техно'
                ],
                [
                    'uri' => '/tn/rulonnaya-zvukoizolyaciya/',
                    'name' => 'Рулонная звукоизоляция'
                ],
                [
                    'uri' => '/tn/mat-tekhno/',
                    'name' => 'Мат Техно'
                ],
                [
                    'uri' => '/tn/soputstvuyushchie-tovary/',
                    'name' => 'Сопутствующие товары Технониколь'
                ],
                [
                    'uri' => '/tn/tekhnonikol-segmenty-i-polucilindry-xps/',
                    'name' => 'Технониколь Сегменты и Полуцилиндры XPS'
                ],
                [
                    'uri' => '/tn/tekhnonikol-teploroll/',
                    'name' => 'Технониколь Теплоролл'
                ],
            ],
            'column4' => [
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20окон",
                    "name" => "Для окон",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Под%20штукатурку",
                    "name" => "Под штукатурку",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20ванной%20комнаты",
                    "name" => "Для ванной комнаты",
                ],
                [
                    "uri" => "/tn/?msoption|primenenie=Для%20дверей%20и%20ворот",
                    "name" => "Для дверей и ворот",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/tn/?msoption|item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $penoplex => [
            'column1' => [
                'uri' => '/penoplex/',
                'name' => 'Утеплитель Penoplex',
                'img' => '/assets/template/img/brands/penoplex.jpg'
            ],
            'column2' => [
                [
                    'uri' => '/penoplex/fundament/',
                    'name' => 'Пеноплэкс Фундамент',
                    'popular'=>1,
                ],
                [
                    'uri' => '/penoplex/komfort/',
                    'name' => 'Пеноплэкс Комфорт',
                    'popular'=>2,
                ],
                [
                    'uri' => '/penoplex/osnova/',
                    'name' => 'Пеноплэкс Основа',
                    'popular'=>3,
                ],
                [
                    'uri' => '/penoplex/geo/',
                    'name' => 'Пеноплэкс ГЕО',
                ],
                [
                    'uri' => '/penoplex/45/',
                    'name' => 'Пеноплэкс 45',
                ],
                [
                    'uri' => '/penoplex/stena/',
                    'name' => 'Пеноплэкс Стена',
                ],
                [
                    'uri' => '/penoplex/uklon/',
                    'name' => 'Пеноплэкс Уклон',
                ],
                [
                    'uri' => '/penoplex/extream/',
                    'name' => 'Пеноплэкс Экстрим',
                ],
                [
                    'uri' => '/penoplex/krovlya/',
                    'name' => 'Пеноплэкс Кровля',
                ],
                [
                    'uri' => '/penoplex/segmenty/',
                    'name' => 'Пеноплэкс Сегменты',
                ],
                [
                    'uri' => '/penoplex/fasad/',
                    'name' => 'Пеноплэкс Фасад',
                ],
                [
                    'uri' => '/penoplex/sop-tovary/',
                    'name' => 'Сопутствующие товары Penoplex',
                ],
            ],
            'column4' => [
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/penoplex/?msoption|primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/penoplex/?msoption|item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/penoplex/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/penoplex/?msoption|item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/penoplex/?msoption|item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/penoplex/?msoption|item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/penoplex/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/penoplex/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/penoplex/?msoption|item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $knauf => [
            'column1' => [
                'uri' => '/knauf/',
                'name' => 'Утеплитель Knauf',
                'img' => '/assets/template/img/brands/brand-knauf.png'
            ],
            'column2' => [
                [
                    'uri' => '/knauf/teploknauf/',
                    'name' => 'ТеплоКНАУФ',
                    'popular'=>1,
                ],
                [
                    'uri' => '/knauf/professionalniy-segment-knauf-insuleyshn/',
                    'name' => 'Knauf Insulation',
                    'popular'=>2,
                ],
                [
                    'uri' => '/knauf/therm/',
                    'name' => 'Кнауф Терм',
                    'popular'=>3,
                ],
                [
                    'uri' => '/knauf/akustiknauf/',
                    'name' => 'АкустиКНАУФ',
                ],
                [
                    'uri' => '/knauf/knauf-membrany/',
                    'name' => 'Кнауф мембраны',
                ],
                [
                    'uri' => '/knauf/knauf-tisma/',
                    'name' => 'Кнауф Тисма',
                ],
                [
                    'uri' => '/knauf/greenterm/',
                    'name' => 'GreenTERM',
                ],
                [
                    'uri' => '/knauf/knauf-ekoroll/',
                    'name' => 'Knauf Экоролл',
                ],
            ],
            'column4' => [
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20печи/камина",
                    "name" => "Для печи/камина",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
                [
                    "uri" => "/knauf/?msoption|primenenie=Под%20штукатурку",
                    "name" => "Под штукатурку",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/knauf/?msoption|item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=27",
                    "name" => "27",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $paroc => [
            'column1' => [
                'uri' => '/paroc/',
                'name' => 'Утеплитель Paroc',
                'img' => '/assets/template/img/brands/paroc.jpg'
            ],
            'column2' => [
                [
                    'uri' => '/paroc/oem-plityi/',
                    'name' => 'OEM плиты',
                    'popular'=>1,
                ],
                [
                    'uri' => '/paroc/zvukozashhitnaya-stroitelnaya-izolyacziya/',
                    'name' => 'Звукозащитная строительная изоляция',
                    'popular'=>2,
                ],
                [
                    'uri' => '/paroc/lamelnyie-matyi/',
                    'name' => 'Ламельные маты',
                    'popular'=>3,
                ],
                [
                    'uri' => '/paroc/matyi-dlya-ovk-i-promyishlennosti/',
                    'name' => 'Маты для овк и промышленности',
                ],
                [
                    'uri' => '/paroc/obshhestroitelnaya-teploizolyacziya/',
                    'name' => 'Общестроительная теплоизоляция',
                ],
                [
                    'uri' => '/paroc/ovk-matyi/',
                    'name' => 'Овк маты',
                ],
                [
                    'uri' => '/paroc/ovk-plityi/',
                    'name' => 'Овк плиты',
                ],
                [
                    'uri' => '/paroc/ognezashhitnaya-stroitelnaya-izolyacziya/',
                    'name' => 'Огнезащитная строительная изоляция',
                ],
                [
                    'uri' => '/paroc/plityi/',
                    'name' => 'Плиты',
                ],
                [
                    'uri' => '/paroc/proshivnyie-matyi/',
                    'name' => 'Прошивные маты',
                ],
                [
                    'uri' => '/paroc/teploizolyacziya-dlya-sendvich-panelej/',
                    'name' => 'Теплоизоляция для сэндвич-панелей',
                ],
                [
                    'uri' => '/paroc/teploizolyacziya-ploskix-krovel/',
                    'name' => 'Теплоизоляция плоских кровель',
                ],
                [
                    'uri' => '/paroc/teploizolyacziya-sten/',
                    'name' => 'Теплоизоляция стен',
                ],
                [
                    'uri' => '/paroc/teploizolyacziya-fundamenta-i-polov-na-grunte/',
                    'name' => 'Теплоизоляция фундамента и полов на грунте',
                ],
                [
                    'uri' => '/paroc/teploizolyacziya-shtukaturnyix-fasadov/',
                    'name' => 'Теплоизоляция штукатурных фасадов',
                ],
                [
                    'uri' => '/paroc/texnicheskie-otvodyi-i-segmentyi/',
                    'name' => 'Технические отводы и сегменты',
                ],
                [
                    'uri' => '/paroc/uteplenie-i-ognezashhita-potolkov-i-perekryitij/',
                    'name' => 'Утепление и огнезащита потолков и перекрытий',
                ],
                [
                    'uri' => '/paroc/cilindry/',
                    'name' => 'Цилиндры',
                ],
            ],
            'column4' => [
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/paroc/?msoption|primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/paroc/?msoption|item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=25",
                    "name" => "25",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $ursa => [
            'column1' => [
                'uri' => '/ursa/',
                'name' => 'Утеплитель Ursa',
                'img' => '/assets/template/img/brands/ursa.png'
            ],
            'column2' => [
                [
                    'uri' => '/ursa/geo/',
                    'name' => 'Ursa GEO',
                    'popular'=>1,
                ],
                [
                    'uri' => '/ursa/pureone/',
                    'name' => 'Ursa Pureone',
                    'popular'=>2,
                ],
                [
                    'uri' => '/ursa/ursa-seco/',
                    'name' => 'Ursa Seco',
                    'popular'=>3,
                ],
                [
                    'uri' => '/ursa/xps/',
                    'name' => 'Ursa XPS',
                ],
                [
                    'uri' => '/ursa/terra/',
                    'name' => 'Ursa Терра',
                ],
            ],
            'column4' => [
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/ursa/?msoption|primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/ursa/?msoption|item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=25",
                    "name" => "25",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $isover => [
            'column1' => [
                'uri' => '/isover/',
                'name' => 'Утеплитель Isover',
                'img' => '/assets/template/img/brands/isover.jpg'
            ],
            'column2' => [
                [
                    'uri' => '/isover/kim-al/',
                    'name' => 'Изовер KIM-AL',
                    'popular'=>1,
                ],
                [
                    'uri' => '/isover/kv-050/',
                    'name' => 'Изовер KV-050',
                    'popular'=>2,
                ],
                [
                    'uri' => '/isover/ol/',
                    'name' => 'Изовер OL',
                    'popular'=>3,
                ],
                [
                    'uri' => '/isover/akustik/',
                    'name' => 'Изовер Акустик'
                ],
                [
                    'uri' => '/isover/venti/',
                    'name' => 'Изовер Венти'
                ],
                [
                    'uri' => '/isover/ventfasad/',
                    'name' => 'Изовер ВентФасад'
                ],
                [
                    'uri' => '/isover/uteplitel-zvukozaschita/',
                    'name' => 'Изовер Звукозащита'
                ],
                [
                    'uri' => '/isover/karkas/',
                    'name' => 'Изовер Каркас'
                ],
                [
                    'uri' => '/isover/karkasnyi-dom/',
                    'name' => 'Изовер Каркасный дом'
                ],
                [
                    'uri' => '/isover/izover-klassik/',
                    'name' => 'Изовер Классик'
                ],
                [
                    'uri' => '/isover/kt-special/',
                    'name' => 'Изовер КТ-Специал'
                ],
                [
                    'uri' => '/isover/lait/',
                    'name' => 'Изовер Лайт'
                ],
                [
                    'uri' => '/isover/master-akustiki/',
                    'name' => 'Изовер Мастер Акустики'
                ],
                [
                    'uri' => '/isover/master-teplyh-kryh/',
                    'name' => 'Изовер Мастер Теплых Крыш'
                ],
                [
                    'uri' => '/isover/master-teplyh-sten/',
                    'name' => 'Изовер Мастер Теплых Стен'
                ],
                [
                    'uri' => '/isover/optimal/',
                    'name' => 'Изовер Оптимал'
                ],
                [
                    'uri' => '/isover/plavayuschii-pol/',
                    'name' => 'Изовер Плавающий пол'
                ],
                [
                    'uri' => '/isover/izover-poly-i-perekrytiya/',
                    'name' => 'Изовер Полы и Перекрытия'
                ],
                [
                    'uri' => '/isover/profi/',
                    'name' => 'Изовер Профи'
                ],
                [
                    'uri' => '/isover/ruf/',
                    'name' => 'Изовер Руф'
                ],
                [
                    'uri' => '/isover/sauna/',
                    'name' => 'Изовер Сауна'
                ],
                [
                    'uri' => '/isover/skatnaya-krovlya/',
                    'name' => 'Изовер Скатная Кровля'
                ],
                [
                    'uri' => '/isover/izover-special-tvin/',
                    'name' => 'Изовер Специал Твин'
                ],
                [
                    'uri' => '/isover/standart/',
                    'name' => 'Изовер Стандарт'
                ],
                [
                    'uri' => '/isover/sendvich-life/',
                    'name' => 'Изовер Сэндвич Лайф'
                ],
                [
                    'uri' => '/isover/teplaya-krysha/',
                    'name' => 'Изовер Теплая Крыша'
                ],
                [
                    'uri' => '/isover/teplo-i-tiho/',
                    'name' => 'Изовер Тепло и Тихо'
                ],
                [
                    'uri' => '/isover/teplye-steny/',
                    'name' => 'Изовер Теплые Стены'
                ],
                [
                    'uri' => '/isover/teplyj-dom/',
                    'name' => 'Изовер Теплый Дом'
                ],
                [
                    'uri' => '/isover/tihiy-dom/',
                    'name' => 'Изовер Тихий Дом'
                ],
                [
                    'uri' => '/isover/fasad/',
                    'name' => 'Изовер Фасад'
                ],
                [
                    'uri' => '/isover/flor/',
                    'name' => 'Изовер Флор'
                ],
                [
                    'uri' => '/isover/shtukaturnyi-fasad/',
                    'name' => 'Изовер Штукатурный фасад'
                ],
                [
                    'uri' => '/isover/sop-tovary/',
                    'name' => 'Сопутствующие товары Изовер'
                ]
            ],
            'column4' => [
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/isover/?msoption|primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/isover/?msoption|item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=25",
                    "name" => "25",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $isoroc => [
            'column1' => [
                'uri' => '/isoroc/',
                'name' => 'Утеплитель Isoroc',
                'img' => '/assets/template/img/brands/isoroc.jpg'
            ],
            'column2' => [
                [
                    "uri" => "/isoroc/izolait/",
                    "name" => "Изолайт",
                    'popular'=>1,
                ],
                [
                    "uri" => "/isoroc/izovent/",
                    "name" => "Изовент",
                    'popular'=>2,
                ],
                [
                    "uri" => "/isoroc/izokor-s/",
                    "name" => "Изокор-С",
                    'popular'=>3,
                ],
                [
                    "uri" => "/isoroc/izoruf/",
                    "name" => "Изоруф"
                ],
                [
                    "uri" => "/isoroc/izofas/",
                    "name" => "Изофас"
                ],
                [
                    "uri" => "/isoroc/izoflor/",
                    "name" => "Изофлор"
                ],
                [
                    "uri" => "/isoroc/p-125/",
                    "name" => "П-125"
                ],
                [
                    "uri" => "/isoroc/p-75/",
                    "name" => "П-75"
                ],
                [
                    "uri" => "/isoroc/pp-60/",
                    "name" => "ПП-60"
                ],
                [
                    "uri" => "/isoroc/pp-75/",
                    "name" => "ПП-75"
                ],
                [
                    "uri" => "/isoroc/pp-80/",
                    "name" => "ПП-80"
                ],
                [
                    "uri" => "/isoroc/ultralajt/",
                    "name" => "УльтраЛайт"
                ],
                [
                    "uri" => "/isoroc/super-tepliy/",
                    "name" => "Супер Теплый"
                ],
                [
                    "uri" => "/isoroc/plita-po-gostu/",
                    "name" => "Плита по ГОСТу"
                ],
                [
                    "uri" => "/isoroc/termozashhita/",
                    "name" => "Термозащита"
                ],
                [
                    "uri" => "/isoroc/klin/",
                    "name" => "Клин"
                ],
                [
                    "uri" => "/isoroc/komplektuyushhie-tovary/",
                    "name" => "Комплектующие товары"
                ],
                [
                    "uri" => "/isoroc/polimernyie-gidroizolyaczionnyie-membranyi/",
                    "name" => "Полимерные гидроизоляционные мембраны"
                ]
            ],
            'column4' => [
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20печи/камина",
                    "name" => "Для печи/камина",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20сайдинга",
                    "name" => "Для сайдинга",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/isoroc/?msoption|primenenie=Крыши",
                    "name" => "Крыши",
                ]
            ],
            'column3' => [
                [
                    "uri" => "/isoroc/?msoption|item_thickness=27",
                    "name" => "27",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=150",
                    "name" => "150",
                ],
            ]
        ]
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