<?php

function getMenuData() {
    $knauf = 93185;
    $rockwool = 93190;
    $tn = 93191;
    $penoplex = 93189;
    $isover = 93187;
    $paroc = 93188;
    $ursa = 93192;
    $isoroc = 93186;

    $data = [
        $rockwool => [
            'column2' => [
                [
                    'uri' => '/rockwool/light-batts-scandic/',
                    'name' => 'Скандик Лайт Баттс',
                ],
                [
                    'uri' => '/rockwool/light-batts-optima/',
                    'name' => 'Лайт Баттс Оптима',
                ],
                [
                    'uri' => '/rockwool/acoustic-batts/',
                    'name' => 'Акустик Баттс',
                ],
                [
                    'uri' => '/rockwool/acoustic-standart/',
                    'name' => 'Акустик Стандарт',
                ],
                [
                    'uri' => '/rockwool/arktic/',
                    'name' => 'Арктик',
                ],
                [
                    'uri' => '/rockwool/beton-element-batts/',
                    'name' => 'Бетон Элемент Баттс',
                ],
                [
                    'uri' => '/rockwool/venti-batts/',
                    'name' => 'Венти Баттс',
                ],
                [
                    'uri' => '/rockwool/kaviti-batts/',
                    'name' => 'Кавити Баттс',
                ],
                [
                    'uri' => '/rockwool/kamin-batts/',
                    'name' => 'Камин Баттс',
                ],
                [
                    'uri' => '/rockwool/karkas-batts/',
                    'name' => 'Каркас Баттс',
                ],
                [
                    'uri' => '/rockwool/light-batts/',
                    'name' => 'Лайт Баттс',
                ],
                [
                    'uri' => '/rockwool/plaster-batts/',
                    'name' => 'Пластер Баттс',
                ],
                [
                    'uri' => '/rockwool/standart/',
                    'name' => 'Роквул Стандарт',
                ],
                [
                    'uri' => '/rockwool/rokvul-tekh-batts/',
                    'name' => 'Роквул Тех Баттс',
                ],
                [
                    'uri' => '/rockwool/rockfacade/',
                    'name' => 'Рокфасад',
                ],
                [
                    'uri' => '/rockwool/roof-batts/',
                    'name' => 'Руф Баттс',
                ],
                [
                    'uri' => '/rockwool/sauna-batts/',
                    'name' => 'Сауна Баттс',
                ],
                [
                    'uri' => '/rockwool/soput-tovary/',
                    'name' => 'Сопутствующие товары',
                ],
                [
                    'uri' => '/rockwool/sendvich-batts/',
                    'name' => 'Сэндвич Баттс',
                ],
                [
                    'uri' => '/rockwool/teh-mat/',
                    'name' => 'ТЕХ МАТ',
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
                    'uri' => '/rockwool/cilindry-navivnye/',
                    'name' => 'Цилиндры навивные',
                ],
                [
                    'uri' => '/rockwool/econom/',
                    'name' => 'Эконом',
                ],
                [
                    'uri' => '/rockwool/conlit-sl-150/',
                    'name' => 'CONLIT SL 150',
                ],
                [
                    'uri' => '/rockwool/fire-batts/',
                    'name' => 'Fire Batts',
                ],
                [
                    'uri' => '/rockwool/ft-barrier/',
                    'name' => 'FT BARRIER',
                ],
                [
                    'uri' => '/rockwool/industrial-batts-80/',
                    'name' => 'Industrial Batts 80',
                ],
                [
                    'uri' => '/rockwool/klimafix/',
                    'name' => 'Klimafix',
                ],
                [
                    'uri' => '/rockwool/lamella-mat-l/',
                    'name' => 'Lamella Mat',
                ],
                [
                    'uri' => '/rockwool/prorox/',
                    'name' => 'ProRox',
                ],
                [
                    'uri' => '/rockwool/searox/',
                    'name' => 'SeaRox',
                ],
                [
                    'uri' => '/rockwool/wired-mat/',
                    'name' => 'WIRED MAT',
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
                    "uri" => "/rockwool/?msoption|item_thickness=35",
                    "name" => "35",
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
                    "uri" => "/rockwool/?msoption|item_thickness=80",
                    "name" => "80",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=90",
                    "name" => "90",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=102",
                    "name" => "102",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=105",
                    "name" => "105",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=110",
                    "name" => "110",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=122",
                    "name" => "122",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=130",
                    "name" => "130",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=140",
                    "name" => "140",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=150",
                    "name" => "150",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=152",
                    "name" => "152",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=160",
                    "name" => "160",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=170",
                    "name" => "170",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=180",
                    "name" => "180",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=190",
                    "name" => "190",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=200",
                    "name" => "200",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=210",
                    "name" => "210",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=220",
                    "name" => "220",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=230",
                    "name" => "230",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=240",
                    "name" => "240",
                ],
                [
                    "uri" => "/rockwool/?msoption|item_thickness=250",
                    "name" => "250",
                ],
            ]
        ],

        $tn => [
            'column2' => [
                [
                    'uri' => '/tn/tekhnonikol-tekhnopleks/',
                    'name' => 'XPS Техноплекс'
                ],
                [
                    'uri' => '/tn/mat-tekhno/',
                    'name' => 'Мат Техно'
                ],
                [
                    'uri' => '/tn/plita-tekhno-ozb/',
                    'name' => 'Плита Техно ОЗБ'
                ],
                [
                    'uri' => '/tn/plita-tekhno-ozd/',
                    'name' => 'Плита Техно ОЗД'
                ],
                [
                    'uri' => '/tn/plita-tekhno-ozm/',
                    'name' => 'Плита Техно ОЗМ'
                ],
                [
                    'uri' => '/tn/plita-tekhno-t/',
                    'name' => 'Плита Техно Т'
                ],
                [
                    'uri' => '/tn/polimernye-gidroizolyacionnye-membrany/',
                    'name' => 'Полимерные гидроизоляционные мембраны'
                ],
                [
                    'uri' => '/tn/rulonnaya-zvukoizolyaciya/',
                    'name' => 'Рулонная звукоизоляция'
                ],
                [
                    'uri' => '/tn/soputstvuyushchie-tovary/',
                    'name' => 'Сопутствующие товары Технониколь'
                ],
                [
                    'uri' => '/tn/carbon/',
                    'name' => 'Технониколь Carbon'
                ],
                [
                    'uri' => '/tn/tekhnonikol-greenguard/',
                    'name' => 'Технониколь GreenGuard'
                ],
                [
                    'uri' => '/tn/tekhnonikol-logicpir/',
                    'name' => 'Технониколь LOGICPIR'
                ],
                [
                    'uri' => '/tn/bazalit/',
                    'name' => 'Технониколь Базалит'
                ],
                [
                    'uri' => '/tn/tekhnonikol-izoboks/',
                    'name' => 'Технониколь Изобокс'
                ],
                [
                    'uri' => '/tn/plity-pir/',
                    'name' => 'Технониколь Плиты PIR'
                ],
                [
                    'uri' => '/tn/tekhnonikol-roklajt/',
                    'name' => 'Технониколь Роклайт'
                ],
                [
                    'uri' => '/tn/tekhnonikol-segmenty-i-polucilindry-xps/',
                    'name' => 'Технониколь Сегменты и Полуцилиндры XPS'
                ],
                [
                    'uri' => '/tn/tekhnonikol-sendvich-tekhnonikol-c-xps/',
                    'name' => 'Технониколь Сэндвич Ц-XPS'
                ],
                [
                    'uri' => '/tn/tekhnonikol-teploroll/',
                    'name' => 'Технониколь Теплоролл'
                ],
                [
                    'uri' => '/tn/zvukoizolyaciya-tekhnonikol-tekhnoakustik/',
                    'name' => 'Технониколь Техноакустик'
                ],
                [
                    'uri' => '/tn/tekhnoblok/',
                    'name' => 'Технониколь Техноблок'
                ],
                [
                    'uri' => '/tn/tekhnovent/',
                    'name' => 'Технониколь Техновент'
                ],
                [
                    'uri' => '/tn/tekhnolajt/',
                    'name' => 'Технониколь Технолайт'
                ],
                [
                    'uri' => '/tn/tekhnoruf/',
                    'name' => 'Технониколь Техноруф'
                ],
                [
                    'uri' => '/tn/tekhnosendvich/',
                    'name' => 'Технониколь Техносэндвич'
                ],
                [
                    'uri' => '/tn/tekhnofas/',
                    'name' => 'Технониколь Технофас'
                ],
                [
                    'uri' => '/tn/uteplitel-tekhnonikol-tekhnoflor/',
                    'name' => 'Технониколь Технофлор'
                ],
                [
                    'uri' => '/tn/tekhnonikol-shtukaturnyj-fasad/',
                    'name' => 'Технониколь Штукатурный фасад'
                ],
                [
                    'uri' => '/tn/tekhnonikol-master-zvukozashchita/',
                    'name' => 'Технониколь Шумоизоляция'
                ],
                [
                    'uri' => '/tn/cilindr-tekhno/',
                    'name' => 'Цилиндр Техно'
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
                    "uri" => "/tn/?msoption|item_thickness=5",
                    "name" => "5",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=10",
                    "name" => "10",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=20",
                    "name" => "20",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=22",
                    "name" => "22",
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
                    "uri" => "/tn/?msoption|item_thickness=55",
                    "name" => "55",
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
                    "uri" => "/tn/?msoption|item_thickness=80",
                    "name" => "80",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=90",
                    "name" => "90",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=110",
                    "name" => "110",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=130",
                    "name" => "130",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=140",
                    "name" => "140",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=150",
                    "name" => "150",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=160",
                    "name" => "160",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=170",
                    "name" => "170",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=180",
                    "name" => "180",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=190",
                    "name" => "190",
                ],
                [
                    "uri" => "/tn/?msoption|item_thickness=200",
                    "name" => "200",
                ],
            ]
        ],

        $penoplex => [
            'column2' => [
                [
                    'uri' => '/45/',
                    'name' => 'Пеноплэкс 45',
                ],
                [
                    'uri' => '/geo/',
                    'name' => 'Пеноплэкс ГЕО',
                ],
                [
                    'uri' => '/komfort/',
                    'name' => 'Пеноплэкс Комфорт',
                ],
                [
                    'uri' => '/krovlya/',
                    'name' => 'Пеноплэкс Кровля',
                ],
                [
                    'uri' => '/osnova/',
                    'name' => 'Пеноплэкс Основа',
                ],
                [
                    'uri' => '/segmenty/',
                    'name' => 'Пеноплэкс Сегменты',
                ],
                [
                    'uri' => '/stena/',
                    'name' => 'Пеноплэкс Стена',
                ],
                [
                    'uri' => '/uklon/',
                    'name' => 'Пеноплэкс Уклон',
                ],
                [
                    'uri' => '/fasad/',
                    'name' => 'Пеноплэкс Фасад',
                ],
                [
                    'uri' => '/fundament/',
                    'name' => 'Пеноплэкс Фундамент',
                ],
                [
                    'uri' => '/extream/',
                    'name' => 'Пеноплэкс Экстрим',
                ],
                [
                    'uri' => '/sop-tovary/',
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
                    "uri" => "/penoplex/?msoption|item_thickness=200",
                    "name" => "200",
                ],
                [
                    "uri" => "/penoplex/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/penoplex/?msoption|item_thickness=30.4",
                    "name" => "30.4",
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
                    "uri" => "/penoplex/?msoption|item_thickness=80",
                    "name" => "80",
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
            'column2' => [
                [
                    'uri' => '/knauf/greenterm/',
                    'name' => 'GreenTERM',
                ],
                [
                    'uri' => '/knauf/professionalniy-segment-knauf-insuleyshn/',
                    'name' => 'Knauf Insulation',
                ],
                [
                    'uri' => '/knauf/knauf-ekoroll/',
                    'name' => 'Knauf Экоролл',
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
                    'uri' => '/knauf/therm/',
                    'name' => 'Кнауф Терм',
                ],
                [
                    'uri' => '/knauf/knauf-tisma/',
                    'name' => 'Кнауф Тисма',
                ],
                [
                    'uri' => '/knauf/teploknauf/',
                    'name' => 'ТеплоКНАУФ',
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
                    "uri" => "/knauf/?msoption|item_thickness=45",
                    "name" => "45",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=47",
                    "name" => "47",
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
                    "uri" => "/knauf/?msoption|item_thickness=80",
                    "name" => "80",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=90",
                    "name" => "90",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=110",
                    "name" => "110",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=150",
                    "name" => "150",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=180",
                    "name" => "180",
                ],
                [
                    "uri" => "/knauf/?msoption|item_thickness=200",
                    "name" => "200",
                ],
            ]
        ],

        $paroc => [
            'column2' => [
                [
                    'uri' => '/paroc/oem-plityi/',
                    'name' => 'OEM плиты',
                ],
                [
                    'uri' => '/paroc/zvukozashhitnaya-stroitelnaya-izolyacziya/',
                    'name' => 'Звукозащитная строительная изоляция',
                ],
                [
                    'uri' => '/paroc/lamelnyie-matyi/',
                    'name' => 'Ламельные маты',
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
                    "uri" => "/paroc/?msoption|item_thickness=30",
                    "name" => "30",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=50",
                    "name" => "50",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=90",
                    "name" => "90",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=117",
                    "name" => "117",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=122",
                    "name" => "122",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=126",
                    "name" => "126",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=150",
                    "name" => "150",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=151",
                    "name" => "151",
                ],
                [
                    "uri" => "/paroc/?msoption|item_thickness=350",
                    "name" => "350",
                ],
            ]
        ],

        $ursa => [
            'column2' => [
                [
                    'uri' => '/ursa/geo/',
                    'name' => 'Ursa GEO',
                ],
                [
                    'uri' => '/ursa/pureone/',
                    'name' => 'Ursa Pureone',
                ],
                [
                    'uri' => '/ursa/ursa-seco/',
                    'name' => 'Ursa Seco',
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
                    "uri" => "/ursa/?msoption|item_thickness=80",
                    "name" => "80",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=130",
                    "name" => "130",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=150",
                    "name" => "150",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=180",
                    "name" => "180",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=200",
                    "name" => "200",
                ],
                [
                    "uri" => "/ursa/?msoption|item_thickness=1200",
                    "name" => "1200",
                ],
            ]
        ],

        $isover => [
            'column2' => [
                [
                    'uri' => '/isover/kim-al/',
                    'name' => 'Изовер KIM-AL'
                ],
                [
                    'uri' => '/isover/kv-050/',
                    'name' => 'Изовер KV-050'
                ],
                [
                    'uri' => '/isover/ol/',
                    'name' => 'Изовер OL'
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
                    "uri" => "/isover/?msoption|item_thickness=65",
                    "name" => "65",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=75",
                    "name" => "75",
                ],
                [
                    "uri" => "/isover/?msoption|item_thickness=80",
                    "name" => "80",
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
            'column2' => [
                [
                    "uri" => "/isoroc/izolait/",
                    "name" => "Изолайт"
                ],
                [
                    "uri" => "/isoroc/izovent/",
                    "name" => "Изовент"
                ],
                [
                    "uri" => "/isoroc/izokor-s/",
                    "name" => "Изокор-С"
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
                    "uri" => "/isoroc/?msoption|item_thickness=1.2",
                    "name" => "1.2",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=1.5",
                    "name" => "1.5",
                ],
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
                    "uri" => "/isoroc/?msoption|item_thickness=80",
                    "name" => "80",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=90",
                    "name" => "90",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=100",
                    "name" => "100",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=110",
                    "name" => "110",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=120",
                    "name" => "120",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=130",
                    "name" => "130",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=140",
                    "name" => "140",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=150",
                    "name" => "150",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=160",
                    "name" => "160",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=170",
                    "name" => "170",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=180",
                    "name" => "180",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=190",
                    "name" => "190",
                ],
                [
                    "uri" => "/isoroc/?msoption|item_thickness=200",
                    "name" => "200",
                ],
            ]
        ]
    ];

    foreach ($data as $key => $values) {
        $data[$key]['column2'] = array_chunk($values['column2'], 12);
        $data[$key]['column4'] = array_chunk($values['column4'], 7);
    }

    return $data;
}
