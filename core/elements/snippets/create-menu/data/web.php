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
    $tizol = 175241; // Утеплитель Тизол 
    $baswool = 168218; // Утеплитель Baswool 
    $ruspanel = 167836; // Утеплитель Ruspanel
    $hotrock = 167657; // Утеплитель Hotrock
    $xotpipe = 167718; // Утеплитель Xotpipe
    $ecover = 167266; // Утеплитель Эковер
    $timplex = 167264; // Утеплитель Тимплэкс
    $isovol = 167265; // Утеплитель Изовол
    $basfiber = 167263; // Утеплитель Basfiber
    $termit = 167262; // Утеплитель Термит
    $teplex = 167260; // Утеплитель Теплекс
    $isomin = 167261; // Утеплитель Изомин
    $brit = 167217; // Рулонная кровля Брит
    // $dirok = 168256; // Рулонная кровля Дирок
    // $isotec = 168257; // Рулонная кровля Isotec
    // $beltep = 168258; // Рулонная кровля Белтеп

    $data = [
        $rockwool => [
            'column1' => [
                'uri' => '/rockwool/',
                'name' => 'Утеплитель Rockwool',
                'img' => '/assets/template/img/brands-webp/rockwool.webp'
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
                    "uri" => "/rockwool/?primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20печи/камина",
                    "name" => "Для печи/камина",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Под%20штукатурку",
                    "name" => "Под штукатурку",
                ],
                [
                    "uri" => "/rockwool/?primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/rockwool/?item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=25",
                    "name" => "25",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=27",
                    "name" => "27",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/rockwool/?item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $umatex => [
            'column1' => [
                'uri' => '/yumateks-termo/',
                'name' => 'Утеплитель Юматекс',
                'img' => '/assets/template/img/brands-webp/umatex.webp',
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
                    'uri' => '/yumateks-termo/?item_thickness=20'
                ],
                [
                    'name' => '25',
                    'uri' => '/yumateks-termo/?item_thickness=25'
                ],
                [
                    'name' => '30',
                    'uri' => '/yumateks-termo/?item_thickness=30'
                ],
                [
                    'name' => '40',
                    'uri' => '/yumateks-termo/?item_thickness=40'
                ],
                [
                    'name' => '50',
                    'uri' => '/yumateks-termo/?item_thickness=50'
                ],
                [
                    'name' => '60',
                    'uri' => '/yumateks-termo/?item_thickness=60'
                ],
                [
                    'name' => '70',
                    'uri' => '/yumateks-termo/?item_thickness=70'
                ],
                [
                    'name' => '75',
                    'uri' => '/yumateks-termo/?item_thickness=75'
                ],
                [
                    'name' => '100',
                    'uri' => '/yumateks-termo/?item_thickness=100'
                ],
                [
                    'name' => '120',
                    'uri' => '/yumateks-termo/?item_thickness=120'
                ],
                [
                    'name' => '150',
                    'uri' => '/yumateks-termo/?item_thickness=150'
                ]
            ],
            'column4' => [
                [
                    'name' => 'Вентилируемые фасады',
                    'uri' => '/yumateks-termo/?primenenie=%D0%92%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D0%B8%D1%80%D1%83%D0%B5%D0%BC%D1%8B%D0%B5%20%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D1%8B',
                ],
                [
                    'name' => 'Вентилируемые фасады в двухслойных системах',
                    'uri' => '/yumateks-termo/?primenenie=%D0%92%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D0%B8%D1%80%D1%83%D0%B5%D0%BC%D1%8B%D0%B5%20%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D1%8B%20%D0%B2%20%D0%B4%D0%B2%D1%83%D1%85%D1%81%D0%BB%D0%BE%D0%B9%D0%BD%D1%8B%D1%85%20%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D0%B0%D1%85',
                ],
                [
                    'name' => 'Внутренние стены (межкомнатные перегородки)',
                    'uri' => '/yumateks-termo/?primenenie=%D0%92%D0%BD%D1%83%D1%82%D1%80%D0%B5%D0%BD%D0%BD%D0%B8%D0%B5%20%D1%81%D1%82%D0%B5%D0%BD%D1%8B%20(%D0%BC%D0%B5%D0%B6%D0%BA%D0%BE%D0%BC%D0%BD%D0%B0%D1%82%D0%BD%D1%8B%D0%B5%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BA%D0%B8)',
                ],
                [
                    'name' => 'Для дверей',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D0%B4%D0%B2%D0%B5%D1%80%D0%B5%D0%B9',
                ],
                [
                    'name' => 'Для кровли',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8',
                ],
                [
                    'name' => 'Для перегородок',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA',
                ],
                [
                    'name' => 'Для перегородок и перекрытий',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA%20%D0%B8%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9',
                ],
                [
                    'name' => 'Для перекрытий',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9',
                ],
                [
                    'name' => 'Для подвалов',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%BE%D0%B4%D0%B2%D0%B0%D0%BB%D0%BE%D0%B2',
                ],
                [
                    'name' => 'Для пола',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%BE%D0%BB%D0%B0',
                ],
                [
                    'name' => 'Для потолка',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0',
                ],
                [
                    'name' => 'Для потолков',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%BE%D0%B2',
                ],
                [
                    'name' => 'Для стен',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D1%81%D1%82%D0%B5%D0%BD',
                ],
                [
                    'name' => 'Для труб',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D1%82%D1%80%D1%83%D0%B1',
                ],
                [
                    'name' => 'Для фасада',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0',
                ],
                [
                    'name' => 'Для фундамента',
                    'uri' => '/yumateks-termo/?primenenie=%D0%94%D0%BB%D1%8F%20%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0',
                ],
                [
                    'name' => 'Звукоизоляция',
                    'uri' => '/yumateks-termo/?primenenie=%D0%97%D0%B2%D1%83%D0%BA%D0%BE%D0%B8%D0%B7%D0%BE%D0%BB%D1%8F%D1%86%D0%B8%D1%8F',
                ],
                [
                    'name' => 'Камины и печи',
                    'uri' => '/yumateks-termo/?primenenie=%D0%9A%D0%B0%D0%BC%D0%B8%D0%BD%D1%8B%20%D0%B8%20%D0%BF%D0%B5%D1%87%D0%B8',
                ],
                [
                    'name' => 'Каркасные конструкции',
                    'uri' => '/yumateks-termo/?primenenie=%D0%9A%D0%B0%D1%80%D0%BA%D0%B0%D1%81%D0%BD%D1%8B%D0%B5%20%D0%BA%D0%BE%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D0%B8',
                ],
                [
                    'name' => 'Мансарды',
                    'uri' => '/yumateks-termo/?primenenie=%D0%9C%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B',
                ],
                [
                    'name' => 'Межэтажные перекрытия',
                    'uri' => '/yumateks-termo/?primenenie=%D0%9C%D0%B5%D0%B6%D1%8D%D1%82%D0%B0%D0%B6%D0%BD%D1%8B%D0%B5%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D1%8F',
                ],
                [
                    'name' => 'Ненагружаемые конструкции',
                    'uri' => '/yumateks-termo/?primenenie=%D0%9D%D0%B5%D0%BD%D0%B0%D0%B3%D1%80%D1%83%D0%B6%D0%B0%D0%B5%D0%BC%D1%8B%D0%B5%20%D0%BA%D0%BE%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D0%B8',
                ],
                [
                    'name' => 'Скатные кровли',
                    'uri' => '/yumateks-termo/?primenenie=%D0%A1%D0%BA%D0%B0%D1%82%D0%BD%D1%8B%D0%B5%20%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8',
                ],
                [
                    'name' => 'Средний слой в кирпичной кладке',
                    'uri' => '/yumateks-termo/?primenenie=%D0%A1%D1%80%D0%B5%D0%B4%D0%BD%D0%B8%D0%B9%20%D1%81%D0%BB%D0%BE%D0%B9%20%D0%B2%20%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87%D0%BD%D0%BE%D0%B9%20%D0%BA%D0%BB%D0%B0%D0%B4%D0%BA%D0%B5',
                ],
                [
                    'name' => 'Техническая изоляция',
                    'uri' => '/yumateks-termo/?primenenie=%D0%A2%D0%B5%D1%85%D0%BD%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F%20%D0%B8%D0%B7%D0%BE%D0%BB%D1%8F%D1%86%D0%B8%D1%8F',
                ],
                [
                    'name' => 'Универсальный',
                    'uri' => '/yumateks-termo/?primenenie=%D0%A3%D0%BD%D0%B8%D0%B2%D0%B5%D1%80%D1%81%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9',
                ],
                [
                    'name' => 'Чердачные перекрытия',
                    'uri' => '/yumateks-termo/?primenenie=%D0%A7%D0%B5%D1%80%D0%B4%D0%B0%D1%87%D0%BD%D1%8B%D0%B5%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D1%8F',
                ],
                [
                    'name' => 'Штукатурные фасады',
                    'uri' => '/yumateks-termo/?primenenie=%D0%A8%D1%82%D1%83%D0%BA%D0%B0%D1%82%D1%83%D1%80%D0%BD%D1%8B%D0%B5%20%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D1%8B',
                ],
            ],
        ],
        $tn => [
            'column1' => [
                'uri' => '/tn/',
                'name' => 'Утеплитель Технониколь',
                'img' => '/assets/template/img/brands-webp/tehnonikol.webp'
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
                    "uri" => "/tn/?primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20окон",
                    "name" => "Для окон",
                ],
                [
                    "uri" => "/tn/?primenenie=Под%20штукатурку",
                    "name" => "Под штукатурку",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20ванной%20комнаты",
                    "name" => "Для ванной комнаты",
                ],
                [
                    "uri" => "/tn/?primenenie=Для%20дверей%20и%20ворот",
                    "name" => "Для дверей и ворот",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/tn/?item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/tn/?item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/tn/?item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/tn/?item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/tn/?item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/tn/?item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/tn/?item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/tn/?item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/tn/?item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/tn/?item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $penoplex => [
            'column1' => [
                'uri' => '/penoplex/',
                'name' => 'Утеплитель Penoplex',
                'img' => '/assets/template/img/brands-webp/penoplex.webp'
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
                    "uri" => "/penoplex/?primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/penoplex/?primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/penoplex/?primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/penoplex/?primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/penoplex/?primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
                [
                    "uri" => "/penoplex/?primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/penoplex/?primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/penoplex/?primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/penoplex/?primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/penoplex/?primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/penoplex/?item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/penoplex/?item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/penoplex/?item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/penoplex/?item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/penoplex/?item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/penoplex/?item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/penoplex/?item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/penoplex/?item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $knauf => [
            'column1' => [
                'uri' => '/knauf/',
                'name' => 'Утеплитель Knauf',
                'img' => '/assets/template/img/brands-webp/brand-knauf.webp'
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
                    "uri" => "/knauf/?primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20печи/камина",
                    "name" => "Для печи/камина",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/knauf/?primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
                [
                    "uri" => "/knauf/?primenenie=Под%20штукатурку",
                    "name" => "Под штукатурку",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/knauf/?item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/knauf/?item_thickness=27",
                    "name" => "27",
                ],
                [
                    "uri" => "/knauf/?item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/knauf/?item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/knauf/?item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/knauf/?item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/knauf/?item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/knauf/?item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/knauf/?item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/knauf/?item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/knauf/?item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $paroc => [
            'column1' => [
                'uri' => '/paroc/',
                'name' => 'Утеплитель Paroc',
                'img' => '/assets/template/img/brands-webp/paroc.webp'
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
                    "uri" => "/paroc/?primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/paroc/?primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/paroc/?primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/paroc/?primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/paroc/?primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/paroc/?primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/paroc/?primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/paroc/?primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/paroc/?primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/paroc/?primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/paroc/?item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/paroc/?item_thickness=25",
                    "name" => "25",
                ],
                [
                    "uri" => "/paroc/?item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/paroc/?item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/paroc/?item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/paroc/?item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/paroc/?item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/paroc/?item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/paroc/?item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/paroc/?item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/paroc/?item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $ursa => [
            'column1' => [
                'uri' => '/ursa/',
                'name' => 'Утеплитель Ursa',
                'img' => '/assets/template/img/brands-webp/ursa.webp'
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
                    "uri" => "/ursa/?primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/ursa/?primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/ursa/?item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/ursa/?item_thickness=25",
                    "name" => "25",
                ],
                [
                    "uri" => "/ursa/?item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/ursa/?item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/ursa/?item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/ursa/?item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/ursa/?item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/ursa/?item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $isover => [
            'column1' => [
                'uri' => '/isover/',
                'name' => 'Утеплитель Isover',
                'img' => '/assets/template/img/brands-webp/isover.webp'
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
                    "uri" => "/isover/?primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20бани",
                    "name" => "Для бани",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/isover/?primenenie=Для%20фундамента/цоколя",
                    "name" => "Для фундамента/цоколя",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/isover/?item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/isover/?item_thickness=25",
                    "name" => "25",
                ],
                [
                    "uri" => "/isover/?item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/isover/?item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/isover/?item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/isover/?item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/isover/?item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/isover/?item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/isover/?item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/isover/?item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $isoroc => [
            'column1' => [
                'uri' => '/isoroc/',
                'name' => 'Утеплитель Isoroc',
                'img' => '/assets/template/img/brands-webp/isoroc.webp'
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
                    "uri" => "/isoroc/?primenenie=Для%20балкона/лоджии",
                    "name" => "Для балкона/лоджии",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20вентиляции",
                    "name" => "Для вентиляции",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20кровли",
                    "name" => "Для кровли",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20мансарды",
                    "name" => "Для мансарды",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20перегородок",
                    "name" => "Для перегородок",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20перекрытий",
                    "name" => "Для перекрытий",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20печи/камина",
                    "name" => "Для печи/камина",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20пола",
                    "name" => "Для пола",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20потолка",
                    "name" => "Для потолка",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20сайдинга",
                    "name" => "Для сайдинга",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20стен",
                    "name" => "Для стен",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20труб",
                    "name" => "Для труб",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Для%20фасада",
                    "name" => "Для фасада",
                ],
                [
                    "uri" => "/isoroc/?primenenie=Крыши",
                    "name" => "Крыши",
                ]
            ],
            'column3' => [
                [
                    "uri" => "/isoroc/?item_thickness=27",
                    "name" => "27",
                ],
                [
                    "uri" => "/isoroc/?item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/isoroc/?item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/isoroc/?item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/isoroc/?item_thickness=60",
                    "name" => "60",
                ],
                [
                    "uri" => "/isoroc/?item_thickness=70",
                    "name" => "70",
                ],
                [
                    "uri" => "/isoroc/?item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/isoroc/?item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/isoroc/?item_thickness=150",
                    "name" => "150",
                ],
            ]
        ],
        $tizol => [
            'column1' => [
                'uri' => '/uteplitel-tizol/',
                'name' => 'Утеплитель Tizol',
                'img' => '/assets/template/img/brands-webp/tizol.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-lajt-25/",
                    "name" => "Euro-ЛАЙТ 25",
                    "popular" => 1
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-lajt-30/",
                    "name" => "Euro-ЛАЙТ 30"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-lajt-35/",
                    "name" => "Euro-ЛАЙТ 35"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-lajt-50/",
                    "name" => "Euro-ЛАЙТ 50"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-blok/",
                    "name" => "Euro-БЛОК"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-vent/",
                    "name" => "Euro-ВЕНТ"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-vent-v/",
                    "name" => "Euro-ВЕНТ В"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-vent-n/",
                    "name" => "Euro-ВЕНТ Н"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-ruf-n/",
                    "name" => "Euro-РУФ Н"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-ruf/",
                    "name" => "Euro-РУФ"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-ruf-v/",
                    "name" => "Euro-РУФ В"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-ruf-v-super/",
                    "name" => "Euro-РУФ В Супер"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-fasad/",
                    "name" => "Euro-ФАСАД"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-fasad-optima/",
                    "name" => "Euro-ФАСАД ОПТИМА"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-euro-fasad-universal/",
                    "name" => "Euro-ФАСАД УНИВЕРСАЛ"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-blok-50/",
                    "name" => "БЛОК 50"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-vent-v-90/",
                    "name" => "ВЕНТ В 90"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-vent-n-40/",
                    "name" => "ВЕНТ Н 40"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-ruf-n-90/",
                    "name" => "РУФ Н 90"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-ruf-n-100/",
                    "name" => "РУФ Н 100"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-ruf-n-110/",
                    "name" => "РУФ Н 110"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-ruf-n-120/",
                    "name" => "РУФ Н 120"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-ruf-135/",
                    "name" => "РУФ 135"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-ruf-150/",
                    "name" => "РУФ 150"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-ruf-v-160/",
                    "name" => "РУФ В 160"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-ruf-v-170/",
                    "name" => "РУФ В 170"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-fasad-100/",
                    "name" => "ФАСАД 100"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-fasad-110/",
                    "name" => "ФАСАД 110"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-myagkaya-pm-40/",
                    "name" => "Плита мягкая ПМ-40"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-myagkaya-pm-50/",
                    "name" => "Плита мягкая ПМ-50"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-poluzhestkaya-pp-60/",
                    "name" => "Плита полужесткая ПП-60"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-poluzhestkaya-pp-70/",
                    "name" => "Плита полужесткая ПП-70"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-poluzhestkaya-pp-80/",
                    "name" => "Плита полужесткая ПП-80"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-zhestkaya-pzh-100/",
                    "name" => "Плита жесткая ПЖ-100"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-zhestkaya-pzh-120/",
                    "name" => "Плита жесткая ПЖ-120"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-zhestkaya-pzh-140/",
                    "name" => "Плита жесткая ПЖ-140"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-povyshennoj-zhestkosti-ppzh-160/",
                    "name" => "Плита повышенной жесткости ППЖ-160"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-povyshennoj-zhestkosti-ppzh-180/",
                    "name" => "Плита повышенной жесткости ППЖ-180"
                ],
                [
                    "uri" => "/uteplitel-tizol/uteplitel-tizol-plita-povyshennoj-zhestkosti-ppzh-200/",
                    "name" => "Плита повышенной жесткости ППЖ-200"
                ],               
            ],
            'column3' => [
                [
                    "name" => "20",
                    "uri" => "/uteplitel-tizol/?item_thickness=20"
                ],
                [
                    "name" => "30",
                    "uri" => "/uteplitel-tizol/?item_thickness=30"
                ],
                [
                    "name" => "40",
                    "uri" => "/uteplitel-tizol/?item_thickness=40"
                ],
                [
                    "name" => "50",
                    "uri" => "/uteplitel-tizol/?item_thickness=50"
                ],
                [
                    "name" => "60",
                    "uri" => "/uteplitel-tizol/?item_thickness=60"
                ],
                [
                    "name" => "70",
                    "uri" => "/uteplitel-tizol/?item_thickness=70"
                ],
                [
                    "name" => "80",
                    "uri" => "/uteplitel-tizol/?item_thickness=80"
                ],
                [
                    "name" => "90",
                    "uri" => "/uteplitel-tizol/?item_thickness=90"
                ],
                [
                    "name" => "100",
                    "uri" => "/uteplitel-tizol/?item_thickness=100"
                ],
                [
                    "name" => "110",
                    "uri" => "/uteplitel-tizol/?item_thickness=110"
                ],
                [
                    "name" => "120",
                    "uri" => "/uteplitel-tizol/?item_thickness=120"
                ],
                [
                    "name" => "130",
                    "uri" => "/uteplitel-tizol/?item_thickness=130"
                ],
                [
                    "name" => "140",
                    "uri" => "/uteplitel-tizol/?item_thickness=140"
                ],
                [
                    "name" => "150",
                    "uri" => "/uteplitel-tizol/?item_thickness=150"
                ],
                [
                    "name" => "160",
                    "uri" => "/uteplitel-tizol/?item_thickness=160"
                ],
                [
                    "name" => "170",
                    "uri" => "/uteplitel-tizol/?item_thickness=170"
                ],
                [
                    "name" => "180",
                    "uri" => "/uteplitel-tizol/?item_thickness=180"
                ],
                [
                    "name" => "190",
                    "uri" => "/uteplitel-tizol/?item_thickness=190"
                ],
                [
                    "name" => "200",
                    "uri" => "/uteplitel-tizol/?item_thickness=200"
                ],
                [
                    "name" => "210",
                    "uri" => "/uteplitel-tizol/?item_thickness=210"
                ],
                [
                    "name" => "220",
                    "uri" => "/uteplitel-tizol/?item_thickness=220"
                ],
                [
                    "name" => "230",
                    "uri" => "/uteplitel-tizol/?item_thickness=230"
                ],
                [
                    "name" => "240",
                    "uri" => "/uteplitel-tizol/?item_thickness=240"
                ],
                [
                    "name" => "250",
                    "uri" => "/uteplitel-tizol/?item_thickness=250"
                ]
               
            ]
        ],
        $baswool => [
            'column1' => [
                'uri' => '/uteplitel-baswool/',
                'name' => 'Утеплитель Baswool',
                'img' => '/assets/template/img/brands-webp/baswool.webp'
            ],
            'column2' => [

                [
                    "uri" => "/uteplitel-baswool/uteplitel-baswool-ruf/",
                    "name" => "Baswool Руф",
                    "popular" => 1
                ],
                [
                    "uri" => "/uteplitel-baswool/uteplitel-baswool-lajt/",
                    "name" => "Baswool Лайт"
                ],
                [
                    "uri" => "/uteplitel-baswool/uteplitel-baswool-fasad/",
                    "name" => "Baswool Фасад"
                ],
                [
                    "uri" => "/uteplitel-baswool/uteplitel-baswool-ruf-n/",
                    "name" => "Baswool Руф Н"
                ],
                [
                    "uri" => "/uteplitel-baswool/uteplitel-baswool-vent-fasad/",
                    "name" => "Baswool Вент Фасад"
                ],
                [
                    "uri" => "/uteplitel-baswool/uteplitel-baswool/",
                    "name" => "Baswool Стандарт"
                ]
                   
                                  
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/isoroc/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [
                [
                    "uri" => "/uteplitel-baswool/?item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/uteplitel-baswool/?item_thickness=40",
                    "name" => "40",
                ],
                [
                    "uri" => "/uteplitel-baswool/?item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/uteplitel-baswool/?item_thickness=100",
                    "name" => "100",
                ],             
            ]
        ],
        $ruspanel => [
            'column1' => [
                'uri' => '/uteplitel-ruspanel/',
                'name' => 'Утеплитель Ruspanel',
                'img' => '/assets/template/img/brands-webp/ruspanel.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-ruspanel/rpg-gradient/",
                    "name" => "Ruspanel RPG Градиент"
                ],
                [
                    "uri" => "/uteplitel-ruspanel/ship-paz/",
                    "name" => "Ruspanel шип-паз"
                ],
                [
                    "uri" => "/uteplitel-ruspanel/rpg-basic/",
                    "name" => "Ruspanel RPG Basic"
                ],
                [
                    "uri" => "/uteplitel-ruspanel/rpg-optima/",
                    "name" => "Ruspanel RPG Optima"
                ],
                [
                    "uri" => "/uteplitel-ruspanel/rpg-real/",
                    "name" => "Ruspanel RPG Real"
                ],
                [
                    "uri" => "/uteplitel-ruspanel/l-kromka/",
                    "name" => "Ruspanel L кромка"
                ],
               
                   
                                  
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/isoroc/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [
                [
                    "name" => "6",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=6"
                ],
                [
                    "name" => "10",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=10"
                ],
                [
                    "name" => "12",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=12"
                ],
                [
                    "name" => "15",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=15"
                ],
                [
                    "name" => "20",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=20"
                ],
                [
                    "name" => "30",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=30"
                ],
                [
                    "name" => "40",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=40"
                ],
                [
                    "name" => "50",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=50"
                ],
                [
                    "name" => "60",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=60"
                ],
                [
                    "name" => "80",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=80"
                ],
                [
                    "name" => "100",
                    "uri" => "/uteplitel-ruspanel/?item_thickness=100"
                ], 
            ]
        ],
        $hotrock => [
            'column1' => [
                'uri' => '/uteplitel-hotrock/',
                'name' => 'Утеплитель Hotrock',
                'img' => '/assets/template/img/brands-webp/hotrock.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-hotrock/lajt-ehko/",
                    "name" => "Лайт ЭКО"
                ],
                [
                    "uri" => "/uteplitel-hotrock/lajt/",
                    "name" => "Лайт"
                ],
                [
                    "uri" => "/uteplitel-hotrock/blok/",
                    "name" => "Блок"
                ],
                [
                    "uri" => "/uteplitel-hotrock/vent/",
                    "name" => "Вент"
                ],
                [
                    "uri" => "/uteplitel-hotrock/vent-lajt/",
                    "name" => "Вент Лайт"
                ],
                [
                    "uri" => "/uteplitel-hotrock/vent-pro/",
                    "name" => "Вент ПРО"
                ],
                [
                    "uri" => "/uteplitel-hotrock/fasad/",
                    "name" => "Фасад"
                ],
                [
                    "uri" => "/uteplitel-hotrock/fasad-lajt/",
                    "name" => "Фасад Лайт"
                ],
                [
                    "uri" => "/uteplitel-hotrock/fasad-pro/",
                    "name" => "Фасад ПРО"
                ],
                [
                    "uri" => "/uteplitel-hotrock/fasad-rebel/",
                    "name" => "Фасад РЕБЕЛ"
                ],
                [
                    "uri" => "/uteplitel-hotrock/ruf-v-lajt/",
                    "name" => "Руф В ЛАЙТ"
                ],
                [
                    "uri" => "/uteplitel-hotrock/ruf-v/",
                    "name" => "Руф В"
                ],
                [
                    "uri" => "/uteplitel-hotrock/ruf-n/",
                    "name" => "Руф Н"
                ],
                [
                    "uri" => "/uteplitel-hotrock/uteplitel-hotrock-ruf-n-lajt/",
                    "name" => "Руф Н ЛАЙТ"
                ],
                [
                    "uri" => "/uteplitel-hotrock/ruf-n-pro/",
                    "name" => "Руф Н ПРО"
                ],
                [
                    "uri" => "/uteplitel-hotrock/ruf-s/",
                    "name" => "Руф С"
                ],
                [
                    "uri" => "/uteplitel-hotrock/flor/",
                    "name" => "Флор"
                ],
                [
                    "uri" => "/uteplitel-hotrock/smart/",
                    "name" => "Смарт"
                ],
                [
                    "uri" => "/uteplitel-hotrock/akustik/",
                    "name" => "Акустик"
                ],
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/uteplitel-hotrock/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [
                [
                    "name" => "40",
                    "uri" => "/uteplitel-hotrock/?item_thickness=40"
                ],
                [
                    "name" => "50",
                    "uri" => "/uteplitel-hotrock/?item_thickness=50"
                ],
                [
                    "name" => "60",
                    "uri" => "/uteplitel-hotrock/?item_thickness=60"
                ],
                [
                    "name" => "70",
                    "uri" => "/uteplitel-hotrock/?item_thickness=70"
                ],
                [
                    "name" => "80",
                    "uri" => "/uteplitel-hotrock/?item_thickness=80"
                ],
                [
                    "name" => "90",
                    "uri" => "/uteplitel-hotrock/?item_thickness=90"
                ],
                [
                    "name" => "100",
                    "uri" => "/uteplitel-hotrock/?item_thickness=100"
                ],
                [
                    "name" => "110",
                    "uri" => "/uteplitel-hotrock/?item_thickness=110"
                ],
                [
                    "name" => "120",
                    "uri" => "/uteplitel-hotrock/?item_thickness=120"
                ],
                [
                    "name" => "130",
                    "uri" => "/uteplitel-hotrock/?item_thickness=130"
                ],
                [
                    "name" => "140",
                    "uri" => "/uteplitel-hotrock/?item_thickness=140"
                ],
                [
                    "name" => "150",
                    "uri" => "/uteplitel-hotrock/?item_thickness=150"
                ],
                [
                    "name" => "160",
                    "uri" => "/uteplitel-hotrock/?item_thickness=160"
                ],
                [
                    "name" => "170",
                    "uri" => "/uteplitel-hotrock/?item_thickness=170"
                ],
                [
                    "name" => "180",
                    "uri" => "/uteplitel-hotrock/?item_thickness=180"
                ],
                [
                    "name" => "190",
                    "uri" => "/uteplitel-hotrock/?item_thickness=190"
                ],
                [
                    "name" => "200",
                    "uri" => "/uteplitel-hotrock/?item_thickness=200"
                ],
            ]
        ],
        $xotpipe => [
            'column1' => [
                'uri' => '/uteplitel-xotpipe/',
                'name' => 'Утеплитель Xotpipe',
                'img' => '/assets/template/img/brands-webp/xotpipe.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-xotpipe/mat-tekhnicheskij-tr-80/",
                    "name" => "Xotpipe TR-80"
                ],
                [
                    "uri" => "/uteplitel-xotpipe/mat-proshivnoj-mp-100-me-tr/",
                    "name" => "МП-100 Xotpipe ME-TR"
                ],
                [
                    "uri" => "/uteplitel-xotpipe/mat-proshivnoj-wm-tr-80/",
                    "name" => "Xotpipe WM-TR-80"
                ],
                [
                    "uri" => "/uteplitel-xotpipe/mat-proshivnoj-mp-100-me-tr-alu1/",
                    "name" => "МП-100 Xotpipe ME-TR Alu1"
                ],
                [
                    "uri" => "/uteplitel-xotpipe/mat-proshivnoj-mp-100-wm-tr/",
                    "name" => "МП-100 Xotpipe WM-TR"
                ],
                [
                    "uri" => "/uteplitel-xotpipe/mat-proshivnoj-mp-100-me-tr-st/",
                    "name" => "МП-100 Xotpipe ME-TR ST"
                ],
                [
                    "uri" => "/uteplitel-xotpipe/mat-vysokotemperaturnyj-me-tr-80/",
                    "name" => "Xotpipe ME-TR-80"
                ],
                [
                    "uri" => "/uteplitel-xotpipe/mat-vysokotemperaturnyj-wm-tr-80-combi/",
                    "name" => "Xotpipe WM-TR-80 Combi"
                ],
              
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/uteplitel-hotrock/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [
                [
                    "name" => "40",
                    "uri" => "/uteplitel-xotpipe/?item_thickness=40"
                ],
                [
                    "name" => "50",
                    "uri" => "/uteplitel-xotpipe/?item_thickness=50"
                ],
                [
                    "name" => "60",
                    "uri" => "/uteplitel-xotpipe/?item_thickness=60"
                ],
                [
                    "name" => "70",
                    "uri" => "/uteplitel-xotpipe/?item_thickness=70"
                ],
                [
                    "name" => "80",
                    "uri" => "/uteplitel-xotpipe/?item_thickness=80"
                ],
                [
                    "name" => "90",
                    "uri" => "/uteplitel-xotpipe/?item_thickness=90"
                ],
                [
                    "name" => "100",
                    "uri" => "/uteplitel-xotpipe/?item_thickness=100"
                ],
                [
                    "name" => "120",
                    "uri" => "/uteplitel-xotpipe/?item_thickness=120"
                ],
                [
                    "name" => "130",
                    "uri" => "/uteplitel-xotpipe/?item_thickness=130"
                ],
            ]
        ],
        $ecover => [
            'column1' => [
                'uri' => '/uteplitel-ecover/',
                'name' => 'Утеплитель Эковер',
                'img' => '/assets/template/img/brands-webp/ecover.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-ecover/lajt-universal/",
                    "name" => "Эковер Лайт Универсал"
                ],
                [
                    "uri" => "/uteplitel-ecover/lajt/",
                    "name" => "Эковер Лайт"
                ],
                [
                    "uri" => "/uteplitel-ecover/standart/",
                    "name" => "Эковер Стандарт"
                ],
                [
                    "uri" => "/uteplitel-ecover/akustik/",
                    "name" => "Эковер Акустик"
                ],
                [
                    "uri" => "/uteplitel-ecover/krovlya/",
                    "name" => "Эковер Кровля"
                ],
                [
                    "uri" => "/uteplitel-ecover/krovlya-verh/",
                    "name" => "Эковер Кровля Верх"
                ],
                [
                    "uri" => "/uteplitel-ecover/krovlya-niz/",
                    "name" => "Эковер Кровля Низ"
                ],
                [
                    "uri" => "/uteplitel-ecover/krovlya-niz-standart/",
                    "name" => "Эковер Кровля Низ Стандарт"
                ],
                [
                    "uri" => "/uteplitel-ecover/ehkofasad/",
                    "name" => "Эковер Экофасад"
                ],
                [
                    "uri" => "/uteplitel-ecover/ehkofasad-optima/",
                    "name" => "Эковер Экофасад Оптима"
                ],
                [
                    "uri" => "/uteplitel-ecover/ekofasad-standart/",
                    "name" => "Эковер Экофасад Стандарт"
                ],
                [
                    "uri" => "/uteplitel-ecover/fasad-dekor-optima/",
                    "name" => "Эковер Фасад-Декор Оптима"
                ],
                [
                    "uri" => "/uteplitel-ecover/vent-fasad/",
                    "name" => "Эковер Вент-Фасад"
                ],
                [
                    "uri" => "/uteplitel-ecover/stehp/",
                    "name" => "Эковер Стэп"
                ],
                [
                    "uri" => "/uteplitel-ecover/stehp-plyus/",
                    "name" => "Эковер Стэп Плюс"
                ],
                [
                    "uri" => "/uteplitel-ecover/glavrosteplo-lajt-2/",
                    "name" => "Эковер Главростепло Лайт 2"
                ],
                [
                    "uri" => "/uteplitel-ecover/glavrosteplo-standart-2/",
                    "name" => "Эковер Главростепло Стандарт 2"
                ],
                [
                    "uri" => "/uteplitel-ecover/krovlya-niz-optima/",
                    "name" => "Эковер Кровля Низ Оптима"
                ],
                [
                    "uri" => "/uteplitel-ecover/fasad-dekor/",
                    "name" => "Эковер Фасад-Декор"
                ],
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/uteplitel-hotrock/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [

                [
                    "name" => "20",
                    "uri" => "/uteplitel-ecover/?item_thickness=20"
                ],
                [
                    "name" => "25",
                    "uri" => "/uteplitel-ecover/?item_thickness=25"
                ],
                [
                    "name" => "30",
                    "uri" => "/uteplitel-ecover/?item_thickness=30"
                ],
                [
                    "name" => "40",
                    "uri" => "/uteplitel-ecover/?item_thickness=40"
                ],
                [
                    "name" => "50",
                    "uri" => "/uteplitel-ecover/?item_thickness=50"
                ],
                [
                    "name" => "60",
                    "uri" => "/uteplitel-ecover/?item_thickness=60"
                ],
                [
                    "name" => "70",
                    "uri" => "/uteplitel-ecover/?item_thickness=70"
                ],
                [
                    "name" => "80",
                    "uri" => "/uteplitel-ecover/?item_thickness=80"
                ],
                [
                    "name" => "100",
                    "uri" => "/uteplitel-ecover/?item_thickness=100"
                ],
                [
                    "name" => "110",
                    "uri" => "/uteplitel-ecover/?item_thickness=110"
                ],
                [
                    "name" => "120",
                    "uri" => "/uteplitel-ecover/?item_thickness=120"
                ],
                [
                    "name" => "130",
                    "uri" => "/uteplitel-ecover/?item_thickness=130"
                ],
                [
                    "name" => "140",
                    "uri" => "/uteplitel-ecover/?item_thickness=140"
                ],
                [
                    "name" => "150",
                    "uri" => "/uteplitel-ecover/?item_thickness=150"
                ],
                [
                    "name" => "160",
                    "uri" => "/uteplitel-ecover/?item_thickness=160"
                ],
                [
                    "name" => "170",
                    "uri" => "/uteplitel-ecover/?item_thickness=170"
                ],
                [
                    "name" => "180",
                    "uri" => "/uteplitel-ecover/?item_thickness=180"
                ],
                [
                    "name" => "200",
                    "uri" => "/uteplitel-ecover/?item_thickness=200"
                ],
                [
                    "name" => "230",
                    "uri" => "/uteplitel-ecover/?item_thickness=230"
                ],
            ]
        ],
        $timplex => [
            'column1' => [
                'uri' => '/uteplitel-timpleks/',
                'name' => 'Утеплитель Тимплэкс',
                'img' => '/assets/template/img/brands-webp/timplex.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-timpleks/45/",
                    "name" => "Тимплэкс 45"
                ],
                [
                    "uri" => "/uteplitel-timpleks/35/",
                    "name" => "Тимплэкс 35"
                ],
              
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/uteplitel-hotrock/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [

                [
                    "name" => "20",
                    "uri" => "/uteplitel-timpleks/?item_thickness=20"
                ],
                [
                    "name" => "30",
                    "uri" => "/uteplitel-timpleks/?item_thickness=30"
                ],
                [
                    "name" => "40",
                    "uri" => "/uteplitel-timpleks/?item_thickness=40"
                ],
                [
                    "name" => "50",
                    "uri" => "/uteplitel-timpleks/?item_thickness=50"
                ],
                [
                    "name" => "60",
                    "uri" => "/uteplitel-timpleks/?item_thickness=60"
                ],
             
            ]
        ],
        $isovol => [
            'column1' => [
                'uri' => '/uteplitel-izovol/',
                'name' => 'Утеплитель Isovol',
                'img' => '/assets/template/img/brands-webp/isovol.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-izovol/st-50/",
                    "name" => "Изовол СТ-50"
                ],
                [
                    "uri" => "/uteplitel-izovol/st-75-90/",
                    "name" => "Изовол СТ-75/90"
                ],
                [
                    "uri" => "/uteplitel-izovol/l-35/",
                    "name" => "Изовол Л-35"
                ],
                [
                    "uri" => "/uteplitel-izovol/l-25/",
                    "name" => "Изобел Л-25"
                ],
                [
                    "uri" => "/uteplitel-izovol/f-100-120-150/",
                    "name" => "Изовол Ф-100/120/150"
                ],
                [
                    "uri" => "/uteplitel-izovol/v-75-90/",
                    "name" => "Изовол В-75/90"
                ],
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/uteplitel-hotrock/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [

                [
                    "name" => "50",
                    "uri" => "/uteplitel-izovol/?item_thickness=50"
                ],
                [
                    "name" => "100",
                    "uri" => "/uteplitel-izovol/?item_thickness=100"
                ],
               
            ]
        ],
        $basfiber => [
            'column1' => [
                'uri' => '/uteplitel-basfiber/',
                'name' => 'Утеплитель Basfiber',
                'img' => '/assets/template/img/brands-webp/basfiber.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-basfiber/bazaltovaya-vata/",
                    "name" => "Базальтовая вата BASFIBER"
                ],
                [
                    "uri" => "/uteplitel-basfiber/bazaltovyij-karton/",
                    "name" => "Базальтовый картон BASFIBER"
                ],
                [
                    "uri" => "/uteplitel-basfiber/bazaltovyj-karton-s-folgoj/",
                    "name" => "Базальтовый картон с фольгой BASFIBER"
                ],
                [
                    "uri" => "/uteplitel-basfiber/bazaltovyj-mat-s-folgoj/",
                    "name" => "Базальтовый мат с фольгой BASFIBER"
                ],
                [
                    "uri" => "/uteplitel-basfiber/kopiya-bazaltovyij-mat/",
                    "name" => "Базальтовый мат BASFIBER"
                ],
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/uteplitel-hotrock/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [

                [
                    "name" => "6",
                    "uri" => "/uteplitel-basfiber/?item_thickness=6"
                ],
                [
                    "name" => "8",
                    "uri" => "/uteplitel-basfiber/?item_thickness=8"
                ],
                [
                    "name" => "10",
                    "uri" => "/uteplitel-basfiber/?item_thickness=10"
                ],
                [
                    "name" => "12",
                    "uri" => "/uteplitel-basfiber/?item_thickness=12"
                ],
              
            ]
        ],
        $termit => [
            'column1' => [
                'uri' => '/uteplitel-termit/',
                'name' => 'Утеплитель Термит',
                'img' => '/assets/template/img/brands-webp/termit.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-termit/sp/",
                    "name" => "Термит SP"
                ],
                [
                    "uri" => "/uteplitel-termit/xps/",
                    "name" => "Термит XPS"
                ],
                [
                    "uri" => "/uteplitel-termit/eps-prime/",
                    "name" => "Термит EPS Prime"
                ],
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/uteplitel-hotrock/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [

                [
                    "name" => "12.5",
                    "uri" => "/uteplitel-termit/?item_thickness=12.5"
                ],
                [
                    "name" => "20",
                    "uri" => "/uteplitel-termit/?item_thickness=20"
                ],
                [
                    "name" => "30",
                    "uri" => "/uteplitel-termit/?item_thickness=30"
                ],
                [
                    "name" => "40",
                    "uri" => "/uteplitel-termit/?item_thickness=40"
                ],
                [
                    "name" => "50",
                    "uri" => "/uteplitel-termit/?item_thickness=50"
                ],
                [
                    "name" => "100",
                    "uri" => "/uteplitel-termit/?item_thickness=100"
                ],
               
            ]
        ],
        $teplex => [
            'column1' => [
                'uri' => '/uteplitel-tepleks/',
                'name' => 'Утеплитель Теплекс',
                'img' => '/assets/template/img/brands-webp/teplex.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-tepleks/35/",
                    "name" => "Теплекс 35"
                ],
                [
                    "uri" => "/uteplitel-tepleks/45/",
                    "name" => "Теплекс 45"
                ],
               
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/uteplitel-hotrock/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [

                [
                    "name" => "30",
                    "uri" => "/uteplitel-tepleks/?item_thickness=30"
                ],
                [
                    "name" => "50",
                    "uri" => "/uteplitel-tepleks/?item_thickness=50"
                ],
               
            ]
        ],
        $isomin => [
            'column1' => [
                'uri' => '/uteplitel-izomin/',
                'name' => 'Утеплитель Изомин',
                'img' => '/assets/template/img/brands-webp/isomin.webp'
            ],
            'column2' => [
                [
                    "uri" => "/uteplitel-izomin/flor/",
                    "name" => "Изомин ФЛОР"
                ],
                [
                    "uri" => "/uteplitel-izomin/lajt/",
                    "name" => "Изомин ЛАЙТ"
                ],
                [
                    "uri" => "/uteplitel-izomin/kaviti/",
                    "name" => "Изомин КАВИТИ"
                ],
                [
                    "uri" => "/uteplitel-izomin/venti/",
                    "name" => "Изомин ВЕНТИ"
                ],
                [
                    "uri" => "/uteplitel-izomin/ruf-n/",
                    "name" => "Изомин РУФ-Н"
                ],
                [
                    "uri" => "/uteplitel-izomin/ruf/",
                    "name" => "Изомин РУФ"
                ],
                [
                    "uri" => "/uteplitel-izomin/fasad/",
                    "name" => "Изомин ФАСАД"
                ],
                [
                    "uri" => "/uteplitel-izomin/ruf-v/",
                    "name" => "Изомин РУФ-В"
                ],
            ],
            // 'column4' => [
            //     [
            //         "uri" => "/uteplitel-hotrock/?primenenie=Для%20балкона/лоджии",
            //         "name" => "Для балкона/лоджии",
            //     ],
            // ],
            'column3' => [

                [
                    "name" => "30",
                    "uri" => "/uteplitel-izomin/?item_thickness=30"
                ],
                [
                    "name" => "40",
                    "uri" => "/uteplitel-izomin/?item_thickness=40"
                ],
                [
                    "name" => "50",
                    "uri" => "/uteplitel-izomin/?item_thickness=50"
                ],
                [
                    "name" => "100",
                    "uri" => "/uteplitel-izomin/?item_thickness=100"
                ],
               
            ]
        ],
        $brit => [
            'column1' => [
                'uri' => '/rulonnaya-krovlya-brit/',
                'name' => 'Рулонная кровля Брит',
                'img' => '/assets/template/img/brands-webp/brit.webp'
            ],
            'column2' => [
                [
                    "uri" => "/rulonnaya-krovlya-brit/krovelniy-germetik-brit/",
                    "name" => "Кровельный герметик Брит"
                ],
                [
                    "uri" => "/rulonnaya-krovlya-brit/lentyi-styikovochnyie/",
                    "name" => "Ленты стыковочные"
                ],
                [
                    "uri" => "/rulonnaya-krovlya-brit/krovelnyie-mastiki/",
                    "name" => "Кровельные мастики"
                ],
                
            ],
            'column4' => [
                [
                    "uri" => "/rulonnaya-krovlya-brit/?morozostoykost=более%2050",
                    "name" => "Более -50 ℃",
                ],
                [
                    "uri" => "/rulonnaya-krovlya-brit/?morozostoykost=минус%2025",
                    "name" => "-25 ℃",
                ],
                [
                    "uri" => "/rulonnaya-krovlya-brit/?morozostoykost=минус%2035",
                    "name" => "-35 ℃",
                ],
                [
                    "uri" => "/rulonnaya-krovlya-brit/?morozostoykost=минус%2050",
                    "name" => "-50 ℃",
                ],
            ],
            'column3' => [

                [
                    "name" => "2.8",
                    "uri" => "/rulonnaya-krovlya-brit/?item_thickness=2.8"
                ],
                [
                    "name" => "3",
                    "uri" => "/rulonnaya-krovlya-brit/?item_thickness=3"
                ],
                [
                    "name" => "3.2",
                    "uri" => "/rulonnaya-krovlya-brit/?item_thickness=3.2"
                ],
                [
                    "name" => "3.8",
                    "uri" => "/rulonnaya-krovlya-brit/?item_thickness=3.8"
                ],
                [
                    "name" => "4",
                    "uri" => "/rulonnaya-krovlya-brit/?item_thickness=4"
                ],
                [
                    "name" => "4.2",
                    "uri" => "/rulonnaya-krovlya-brit/?item_thickness=4.2"
                ],
                [
                    "name" => "5",
                    "uri" => "/rulonnaya-krovlya-brit/?item_thickness=5"
                ],
                [
                    "name" => "8",
                    "uri" => "/rulonnaya-krovlya-brit/?item_thickness=8"
                ],
            ]
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
