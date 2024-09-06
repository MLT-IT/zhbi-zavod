<?php

// Определите функцию сравнения
function compareNumeric($a, $b) {
    $aValue = is_numeric($a['name']) ? floatval($a['name']) : $a['name'];
    $bValue = is_numeric($b['name']) ? floatval($b['name']) : $b['name'];

    if (is_numeric($aValue) && is_numeric($bValue)) {
        return ($aValue < $bValue) ? 1 : -1;
    }

    return 0;
}


function getMenuData()
{
    $ondulin = 125531;
    $shifer = 125540;
    $cherepitsa = 125530;
    $gibkayacherepitsa = 125532;
    $rulonaykrovlay = 125538;
    $cementnoPesochnayCherepitsa = 125536;
    $keramichheskayCherepitsa = 125534;
    $faltsevayKrovlay = 125535;
    $proflist = 125537;
    $shtaketnik = 125541;
    $vodostochnaySystema = 125528;
    $sofiti = 125539;
    $dobornieElementiKrovly = 125533;
    $komplektuyshie = 125529;

    $data = [
        $ondulin => [
            'column1' => [
                'uri' => '/ondulin/',
                'name' => 'Ондулин',
                'svg' => 'assort-ondulin'
            ],

            'column_vid' => [
                ["uri" => "/cherepica-ondulin/", "name" => "Черепица Ондулин"],
                ["uri" => "/cherepica-ondulin-smart/", "name" => "Ондулин Смарт"],
                ["uri" => "/onduvilla/", "name" => "Ондувилла"],
                ["uri" => "/ondutiss/", "name" => "Ондутисс"],
                ["uri" => "/komplektuyushhie-dlya-ondulina/", "name" => "Комплектующие для Ондулина"],
            ],
            'column_cvet' => [
                ["uri" => "/ondulin-korichnevyij/", "name" => "Коричневый"],
                ["uri" => "/ondulin-krasnyij/", "name" => "Красный"],
                ["uri" => "/ondulin-zelenyij/", "name" => "Зеленый"],
                ["uri" => "/ondulin-chernyij/", "name" => "Черный"],
                ["uri" =>  "/ondulin-seryij/" , "name" => "Серый"],
                ["uri" => "/ondulin-skandinaviya/", "name" => "Скандинавия"],
                ["uri" => "/ondulin-toskana/", "name" => "Тоскана"],
            ]
        ],
        $shifer => [
            'column1' => [
                'uri' => '/shifer/',
                'name' => 'Шифер',
                'svg' => 'assort-proflist'
            ],
            'column_tip' => [
                ["uri" => "/volnovoj-shifer/", "name" => "Волновой"],
                ["uri" => "/ploskij-shifer/", "name" => "Плоский"],
                ["uri" => "/fibrocementnaya-cherepica/", "name" => "Фиброцементная черепица"],
            ],
            'column_cvet' => [
                ["uri" => "/seryj-shifer/", "name" => "серый"],
                ["uri" => "/krasnyij-shifer/", "name" => "красный"],
                ["uri" => "/korichnevyij-shifer/", "name" => "коричневый"],
                ["uri" => "/zelenyij-shifer/", "name" => "зеленый"],
                ["uri" => "/sinij-shifer/", "name" => "синий"],
            ],
        ],
        $cherepitsa => [
            'column1' => [
                "uri" => "/metallocherepica/",
                "name" => "Металлочерепица",
                'svg' => 'assort-cerepica'
            ],
            'column_proizvoditel' => [
                ["uri" => "/metallocherepitsya-grand-line/", "name" => "Металлочерепица Grand Line"],
                ["uri" => "/metallocherepica-metall-profil/", "name" => "Металлочерепица Металл-Профиль"],
            ],
            'column_collection' => [
                ["uri" => "/metallocherepicza-monterrej/", "name" => "Монтеррей"],
                ["uri" => "/metallocherepicza-supermonterrej/", "name" => "Супермонтеррей"],
                ["uri" => "/metallocherepica-tramontana/", "name" => "Трамонтана"],
                ["uri" => "/metallocherepica-montekristo/", "name" => "Монтекристо"],
                ["uri" => "/metallocherepica-lamonterra/", "name" => "Ламонтерра"],
                ["uri" => "/metallocherepitsya-grand-line-classic/", "name" => "Classic"],
                ["uri" => "/metallocherepica-lamonterra-x/", "name" => "Ламонтерра X"],
                ["uri" => "/metallocherepitsya-grand-line-kvinta-plus/", "name" => "Kvinta plus"],
                ["uri" => "/metallocherepitsya-grand-line-kvinta-uno/", "name" => "Kvinta Uno"],
                ["uri" => "/metallocherepica-lamonterra-xl/", "name" => "Ламонтерра XL"],
                ["uri" => "/metallocherepitsya-grand-line-modern/", "name" => "Modern"],
                ["uri" => "/metallocherepitsya-grand-line-kredo/", "name" => "Kredo"],
                ["uri" => "/metallocherepitsya-grand-line-kamea/", "name" => "Kamea"],
                ["uri" => "/metallocherepica-monterrosa/", "name" => "Монтерроса"],
            ],
            'column_cvet' => [
                ["uri" => "/metallocherepicza-ral-7024/", "name" => "RAL 7024"],
                ["uri" => "/metallocherepicza-ral-8017/", "name" => "RAL 8017"],
                ["uri" => "/metallocherepicza-ral-3005/", "name" => "RAL 3005"],
                ["uri" => "/metallocherepicza-ral-9005/", "name" => "RAL 9005"],
                ["uri" => "/metallocherepicza-ral-6005/", "name" => "RAL 6005"],
                ["uri" => "/metallocherepicza-ral-3011/", "name" => "RAL 3011"],
                ["uri" => "/metallocherepicza-ral-7004/", "name" => "RAL 7004"],
                ["uri" => "/metallocherepicza-ral-7016/", "name" => "RAL 7016"],
                ["uri" => "/metallocherepicza-ral-8019/", "name" => "RAL 8019"],
                ["uri" => "/metallocherepicza-ral-5005/", "name" => "RAL 5005"],
                ["uri" => "/metallocherepicza-ral-8004/", "name" => "RAL 8004"],
                ["uri" => "/metallocherepicza-ral-7005/", "name" => "RAL 7005"],
                ["uri" => "/metallocherepicza-ral-3009/", "name" => "RAL 3009"],
                ["uri" => "/metallocherepicza-ral-5015/", "name" => "RAL 5015"],
                ["uri" => "/metallocherepicza-ral-3003/", "name" => "RAL 3003"],
            ],
            'column_tolshina' => [
                ["uri" => "/metallocherepicza-0.4-mm/", "name" => "0.4"],
                ["uri" => "/metallocherepicza-0.45-mm/", "name" => "0.45"],
                ["uri" => "/metallocherepicza-0.5-mm/", "name" => "0.5"],
            ],
        ],
        $gibkayacherepitsa => [
            'column1' => [
                "uri" => "/myagkaya-cherepica/",
                "name" => "Гибкая черепица",
                'svg' => 'assort-bit-krovlya'
            ],
            'column_proizvoditel' => [
                ["uri" => "/docke-pie-gibkaya-cherepica/", "name" => "Docke"],
                ["uri" => "/myagkaya-cherepica-tehnonikol-shinglas/", "name" => "Технониколь Шинглас"],
                ["uri" => "/myagkaya-cherepica-katepal/", "name" => "Катепал"],
                ["uri" => "/myagkaya-cherepica-tegola/", "name" => "Tegola"],
                ["uri" => "/myagkaya-cherepica-icopal/", "name" => "Икопал"],
                ["uri" => "/myagkaya-cherepica-certainteed/", "name" => "CertainTeed"],
            ],
            'column_cvet' => [
                ['uri' => '/seraya-gibkaya-cherepicza/', 'name' => 'Серый'],
                ['uri' => '/korichnevaya-gibkaya-cherepicza/', 'name' => 'Коричневый'],
                ['uri' => '/krasnaya-gibkaya-cherepicza/', 'name' => 'Красный'],
                ['uri' => '/zelenaya-gibkaya-cherepicza/', 'name' => 'Зеленый'],
                ['uri' => '/chernaya-gibkaya-cherepica/', 'name' => 'Черный'],
                ['uri' => '/sinyaya-gibkaya-cherepica/', 'name' => 'Синий'],
                ['uri' => '/pesochnaya-myagkaya-cherepica/', 'name' => 'Песочный'],
            ],
        ],
        $rulonaykrovlay => [
            'column1' => [
                "uri" => "/rulonnaya-krovlya/",
                "name" => "Рулонная кровля",
                'svg' => 'assort-rulon-krovlya'
            ],
            'column_tip' => [
                ["uri" => "/naplavlyaemaya-krovlya/", "name" => "Наплавляемая кровля"],
                ["uri" => "/pvh-membrany/", "name" => "ПВХ мембраны"],
                ["uri" => "/rulonnaya-cherepicza/", "name" => "Рулонная черепица"],
                ["uri" => "/slanczevaya-krovlya/", "name" => "Сланцевая кровля"],
            ],
            'column_proizvoditel' => [
                ["uri" => "/rulonnaya-krovlya-tehnonikol/", "name" => "Технониколь"],
                ["uri" => "/ikopal/", "name" => "Icopal"],
                ["uri" => "/pvh-membrany-plastfoil/", "name" => "Plastfoil"],
            ],
            'column_ottenok' => [
                ["uri" => "/belaya-rulonnaya-krovlya/", "name" => "Белый"],
                ["uri" => "/zheltaya-rulonnaya-krovlya/", "name" => "Желтый"],
                ["uri" => "/zelenaya-rulonnaya-krovlya/", "name" => "Зеленый"],
                ["uri" => "/krasnaya-rulonnaya-krovlya/", "name" => "Красный"],
                ["uri" => "/seraya-rulonnaya-krovlya/", "name" => "Серый"],
                ["uri" => "/sinyaya-rulonnaya-krovlya/", "name" => "Синий"],
                ["uri" => "/chernaya-rulonnaya-krovlya/", "name" => "Черный"],
            ],
            'column_naznachenie' => [
                ["uri" => "/rulonnyij-material-dlya-krovli/", "name" => "Для кровли"],
                ["uri" => "/rulonnaya-krovlya-dlya-trub/", "name" => "Для труб"],
            ],
        ],
        $cementnoPesochnayCherepitsa => [
            'column1' => [
                "uri" => "/cementno-peschanaya-cherepica/",
                "name" => "Цементно-песчаная черепица",
                'svg' => 'assort-natur-cerepica'
            ],
            'column_tip' => [
                ["uri" => "/cementno-peschanaya-cherepica-kriastak/", "name" => "Цементно-песчаная черепица Kriastak"],
                ["uri" => "/cementno-peschanaya-cherepica-braas/", "name" => "Цементно-песчаная черепица Braas"],
                ["uri" => "/komplektuyushhie-dlya-cpch/", "name" => "Комплектующие для ЦПЧ"],
            ],
            'column_collection' => [
                ["uri" => "/czementno-peschanaya-cherepicza-frankfurtskaya/", "name" => "Франкфуртская"],
                ["uri" => "/cementno-peschanaya-cherepica-kriastak-classic/", "name" => "Classic"],
                ["uri" => "/czementno-peschanaya-cherepicza-taunus/", "name" => "Таунус"],
                ["uri" => "/cementno-peschanaya-cherepica-kriastak-lite/", "name" => "Lite"],
                ["uri" => "/czementno-peschanaya-cherepicza-teviva/", "name" => "Тевива"],
                ["uri" => "/cementno-peschanaya-cherepica-kriastak-antik/", "name" => "Antik"],
                ["uri" => "/cementno-peschanaya-cherepica-adria/", "name" => "Адриа"],
                ["uri" => "/czementno-peschanaya-cherepicza-aerloks/", "name" => "Аэрлокс"],
                ["uri" => "/czementno-peschanaya-cherepicza-doppel-s/", "name" => "Доппель-С"],
                ["uri" => "/czementno-peschanaya-cherepicza-protektor/", "name" => "Протектор"],
                ["uri" => "/czementno-peschanaya-cherepicza-reviva/", "name" => "Ревива"],
                ["uri" => "/czementno-peschanaya-cherepicza-taun/", "name" => "Таун"],
                ["uri" => "/czementno-peschanaya-cherepicza-fr/", "name" => "Фр"],
            ],
            'column_cvet' =>[
                ["uri" => "/czementno-peschanaya-cherepicza-krasnaya/", "name" => "Красный"],
                ["uri" => "/czementno-peschanaya-cherepicz-chernaya/", "name" => "Черный"],
                ["uri" => "/czementno-peschanaya-cherepicza-magma/", "name" => "Магма"],
                ["uri" => "/czementno-peschanaya-cherepicza-seryij/", "name" => "Серый"],
                ["uri" => "/czementno-peschanaya-cherepicza-korichnevaya/", "name" => "Коричневый"],
                ["uri" => "/czementno-peschanaya-cherepicz-grafit/", "name" => "Графит"],
                ["uri" => "/czementno-peschanaya-cherepicza-antik/", "name" => "Антик"],
                ["uri" => "/czementno-peschanaya-cherepicza-antik-krasnyij/", "name" => "Антик красный"],
                ["uri" => "/czementno-peschanaya-cherepicza-antik-temno-korichnevyij/", "name" => "Антик темно-коричневый"],
                ["uri" => "/czementno-peschanaya-cherepicza-antichnyij-krasnyij/", "name" => "Античный красный"],
                ["uri" => "/czementno-peschanaya-cherepicz-vishnya/", "name" => "Вишня"],
                ["uri" => "/czementno-peschanaya-cherepicza-kashtan/", "name" => "Каштан"],
                ["uri" => "/czementno-peschanaya-cherepicza-kirpichno-krasnyij/", "name" => "Кирпично-красный"],
            ]
        ],
        $keramichheskayCherepitsa => [
            'column1' => [
                "uri" => "/keramicheskaya-cherepica/",
                "name" => "Керамическая черепица",
                'svg' => 'assort-ceramocherepica'
            ],
            'column_type_tovara' => [
                ["uri" => "/keramicheskaya-cherepica-braas/", "name" => "Керамическая черепица Braas"],
                ["uri" => "/komplektuyushhie-dlya-keramicheskoj-cherepicy-braas/", "name" => "Комплектующие для керамической черепицы Braas"],
            ],
            'column_vid' => [
                ["uri" => "/keramicheskaya-cherepicza-ryadovaya/", "name" => "Рядовая"],
                ["uri" => "/keramicheskaya-cherepicza-fasonnaya/", "name" => "Фасонная"],
            ],
            'column_collection' => [
                ["uri" => "/keramicheskaya-bokovaya-cherepica-sapfir-braas/", "name" => "Сапфир"],
                ["uri" => "/keramicheskaya-cherepicza-rubin-13v/", "name" => "Рубин 13V"],
                ["uri" => "/keramicheskaya-cherepicza-agat-14/", "name" => "Агат 14"],
                ["uri" => "/keramicheskaya-cherepicza-izumrud/", "name" => "Изумруд"],
                ["uri" => "/keramicheskaya-cherepicza-opal/", "name" => "Опал"],
                ["uri" => "/keramicheskaya-cherepicza-rubin-9v/", "name" => "Рубин 9V"],
                ["uri" => "/keramicheskaya-cherepicza-rubin-11v/", "name" => "Рубин 11V"],
                ["uri" => "/keramicheskaya-cherepicza-topaz-13v/", "name" => "Топаз 13V"],
                ["uri" => "/keramicheskaya-cherepicza-turmalin/", "name" => "Турмалин"],
            ],
            'column_ottenok' => [
                ["uri" => "/keramicheskaya-cherepicza-angob-antraczit/", "name" => "Ангоб антрацит"],
                ["uri" => "/keramicheskaya-cherepicza-antraczit/", "name" => "Антрацит"],
                ["uri" => "/keramicheskaya-cherepicza-krasnaya/", "name" => "Красный"],
                ["uri" => "/keramicheskaya-cherepicza-chernaya/", "name" => "Черный"],

            ]
        ],
        $faltsevayKrovlay => [
            'column1' => [
                "uri" => "/falcevaya-krovlya/",
                "name" => "Фальцевая кровля",
                'svg' => 'assort-falc-krovlya'
            ],
            'column_type' => [
                ["uri" => "/falcevaya-krovlya-grand-line-klikfalc/", "name" => "Кликфальц"],
                ["uri" => "/falcevaya-krovlya-grand-line-klikfalc-line/", "name" => "Кликфальц Line"],
                ["uri" => "/falcevaya-krovlya-grand-line-klikfalc-mini/", "name" => "Кликфальц mini"],
                ["uri" => "/falcevaya-krovlya-grand-line-klikfalc-pro/", "name" => "Кликфальц Pro"],
                ["uri" => "/falcevaya-krovlya-grand-line-klikfalc-pro-gofr/", "name" => "Кликфальц Pro Gofr"],
                ["uri" => "/falcevaya-krovlya-grand-line-klikfalc-pro-line/", "name" => "Кликфальц Pro Line"],
                ["uri" => "/falcevaya-krovlya-grand-line-falc-dvojnoj-stoyachij/", "name" => "Фальц двойной стоячий"],
                ["uri" => "/falcevaya-krovlya-grand-line-falc-dvojnoj-stoyachij-line/", "name" => "Фальц двойной стоячий Line"],
            ],
            'column_pokritie' => [
                ["uri" => "/falcevaya-krovlya/?pokrytie=Satin", "name" => "Satin"],
                ["uri" => "/falcevaya-krovlya/?pokrytie=%D0%9F%D0%BE%D0%BB%D0%B8%D1%8D%D1%81%D1%82%D0%B5%D1%80", "name" => "Полиэстер"],
                ["uri" => "/falcevaya-krovlya/?pokrytie=Rooftop%20Matte", "name" => "Rooftop Matte"],
                ["uri" => "/falcevaya-krovlya/?pokrytie=Atlas", "name" => "Atlas"],
                ["uri" => "/falcevaya-krovlya/?pokrytie=Drap", "name" => "Drap"],
                ["uri" => "/falcevaya-krovlya/?pokrytie=GreenCoat%20Pural%20BT", "name" => "GreenCoat Pural BT"],
                ["uri" => "/falcevaya-krovlya/?pokrytie=Velur%20X", "name" => "Velur X"],
                ["uri" => "/falcevaya-krovlya/?pokrytie=Drap%20ST", "name" => "Drap ST"],
            ],
            'column_cvet' => [
                ["uri" => "/falcevaya-krovlya/?cvet=RAL%208017", "name" => "RAL 8017"],
                ["uri" => "/falcevaya-krovlya/?cvet=RAL%203005", "name" => "RAL 3005"],
                ["uri" => "/falcevaya-krovlya/?cvet=RAL%207004", "name" => "RAL 7004"],
                ["uri" => "/falcevaya-krovlya/?cvet=RAL%206005", "name" => "RAL 6005"],
                ["uri" => "/falcevaya-krovlya/?cvet=RAL%205021", "name" => "RAL 5021"],
                ["uri" => "/falczevaya-krovlya-ral-7016/", "name" => "RAL 7016"],
                ["uri" => "/falczevaya-krovlya-ral-9005/", "name" => "RAL 9005"],
                ["uri" => "/falczevaya-krovlya-ral-7024/", "name" => "RAL 7024"],
                ["uri" => "/falczevaya-krovlya-ral-9003/", "name" => "RAL 9003"],
                ["uri" => "/falczevaya-krovlya-rr-32/", "name" => "RR 32"],
                ["uri" => "/falczevaya-krovlya-rr-22/", "name" => "RR 22"],
            ],
        ],
        $proflist => [
            'column1' => [
                "uri" => "/proflist/",
                "name" => "Профлист",
                'svg' => 'assort-proflist'
            ],
            'column_naznachenie' => [
                ["uri" => "/profilirovannyy-list-dlya-zabora/", "name" => "Для забора"],
                ["uri" => "/proflist-dlya-krovli/", "name" => "Для кровли"],
                ["uri" => "/proflist-dlya-sten/", "name" => "Для стен"],
                ["uri" => "/proflist-dlya-perekryitij/", "name" => "Для перекрытий"],
                ["uri" => "/proflist-dlya-fasada/", "name" => "Для фасада"],
                ["uri" => "/proflist-dlya-garazha/", "name" => "Для гаража"],
            ],
            'column_proizvoditel' => [
                ["uri" => "/proflist-grand-line/", "name" => "Grand Line"],
                ["uri" => "/proflist-metall-profil/", "name" => "Металл Профиль"],
            ],
            'column_tolshina' => [
                ["uri" => "/proflist-1-mm/", "name" => "1"],
                ["uri" => "/proflist-0-8-mm/", "name" => "0.8"],
                ["uri" => "/proflist-0-45-mm/", "name" => "0.45"],
                ["uri" => "/proflist-0-7-mm/", "name" => "0.7"],
                ["uri" => "/proflist-0-5-mm/", "name" => "0.5"],
                ["uri" => "/proflist-0-9-mm/", "name" => "0.9"],
                ["uri" => "/proflist-0-35-mm/", "name" => "0.35"],
                ["uri" => "/proflist-0-6-mm/", "name" => "0.6"],
                ["uri" => "/proflist-0-4-mm/", "name" => "0.4"],
            ],
            'column_profil' => [
                ["uri" => "/proflist-mp-20/", "name" => "МП20"],
                ["uri" => "/profnastil-n-75/", "name" => "H75"],
                ["uri" => "/proflist-n-60/", "name" => "H60"],
                ["uri" => "/proflist-s20/", "name" => "C20"],
                ["uri" => "/proflist-n114/", "name" => "H114"],
                ["uri" => "/proflist-s10/", "name" => "C10"],
                ["uri" => "/proflist-mp18/", "name" => "МП18"],
                ["uri" => "/proflist-ns-35/", "name" => "HC35"],
                ["uri" => "/proflist-mp-35/", "name" => "МП35"],
            ]
        ],
        $shtaketnik => [
            'column1' => [
                "uri" => "/shtaketnik/",
                "name" => "Штакетник",
                'svg' => 'assort-proflist' 
            ],
            'column_proizvoditel' => [
                ["uri" => "/shtaketnik-metall-profil/", "name" => "Металл Профиль"],
                ["uri" => "/shtaketnik-grand-line/", "name" => "Grand Line"],
            ],
            'column_forma' => [
                ["uri" => "/shtaketnik-m-obraznyy-grand-line/", "name" => "Штакетник М-образный"],
                ["uri" => "/shtaketnik-p-obraznyy-grand-line/", "name" => "Штакетник П-образный"],
                ["uri" => "/shtaketnik-polukruglyy-slim-grand-line/", "name" => "Штакетник полукруглый"],
                ["uri" => "/shtaketnik-m-obraznyy-figurnyy-grand-line/", "name" => "Штакетник М-образный фигурный"],
                ["uri" => "/shtaketnik-twin-grand-line/", "name" => "Штакетник Twin"],
                ["uri" => "/shtaketnik-dvustoronnij/", "name" => "Штакетник двусторонний"],
                ["uri" => "/shtaketnik-kruglyij-grand-line/", "name" => "Штакетник круглый"],
                ["uri" => "/shtaketnik-pryamougolnyy-grand-line/", "name" => "Штакетник прямоугольный"],
                ["uri" => "/kruglyy-figurnyy-grand-line/", "name" => "Штакетник круглый фигурный"],
                ["uri" => "/shtaketnik-polukruglyy-figurnyy-slim-grand-line/", "name" => "Штакетник полукруглый фигурный"],
            ],
            'column_tolshina' => [
                ["uri" => "/shtaketnik-0-45-mm/", "name" => "0.45"],
                ["uri" => "/shtaketnik-0-4-mm/", "name" => "0.4"],
                ["uri" => "/shtaketnik-0-5-mm/", "name" => "0.5"],
                ["uri" => "/shtaketnik-0-43-mm/", "name" => "0.43"],
            ],
        ],
        $vodostochnaySystema => [
            'column1' => [
                "uri" => "/vodostochnaya-sistema/",
                "name" => "Водосточная система",
                'svg' => 'assort-vodostoch'
            ],
            'column_material' => [
                ["uri" => "/pvh-plastikovye-vodostochnye-sistemy/", "name" => "ПВХ водостоки"],
                ["uri" => "/metallicheskie-vodostoki/", "name" => "Металлические водостоки"],
            ],
            'column_proizvoditel' => [
                ["uri" => "/vodostochnaya-sistema-docke/", "name" => "Docke"],
                ["uri" => "/vodostochnaya-sistema-grand-line/", "name" => "Grand Line"],
                ["uri" => "/vodostochnaya-sistema-braas/", "name" => "Braas"],
                ["uri" => "/vodostochnaya-sistema-aquasystem/", "name" => "Aquasystem"],
                ["uri" => "/vodostochnaya-sistema-alta-profil/", "name" => "Альта-Профиль"],
            ]
        ],
        $sofiti => [
            'column1' => [
                "uri" => "/sofity/",
                "name" => "Софиты",
                'svg' => 'assort-sofity'
            ],
            'column_material' => [
                ["uri" => "/pvh-sofity/", "name" => "ПВХ софиты"],
                ["uri" => "/metallicheskie-sofity/", "name" => "Металлические софиты"],
                ["uri" => "/komplektuyushhie-k-sofitam/", "name" => "Комплектующие к софитам"],
            ],
            'column_proizvoditel' => [
                ["uri" => "/sofity-docke/", "name" => "Docke"],
                ["uri" => "/sofity-grand-line/", "name" => "Grand Line"],
            ],
            'column_cvet' => [
                ["uri" => "/sofityi-ral-8017/", "name" => "ral 8017"],
                ["uri" => "/sofityi-ral-7024/", "name" => "ral 7024"],
                ["uri" => "/sofityi-ral-9003/", "name" => "ral 9003"],
                ["uri" => "/sofityi-ral-7005/", "name" => "ral 7005"],
            ],
            'column_ottenok' => [
                ["uri" => "/sofityi-belyie/", "name" => "белый"],
                ["uri" => "/sofityi-grafit/", "name" => "графит"],
                ["uri" => "/sofityi-shokolad/", "name" => "шоколад"],
                ["uri" => "/sofityi-korichnevyie/", "name" => "коричневый"],
                ["uri" => "/sofityi-chernyie/", "name" => "черный"],
                ["uri" => "/sofityi-krasnyij/", "name" => "красный"],
            ]
        ],
        $dobornieElementiKrovly => [
            'column1' => [
                "uri" => "/dobornye-elementy/",
                "name" => "Доборные элементы для кровли",
                'svg' => 'assort-dobor'
            ],
            'column2' => [
                ["uri" => "/j-profil/", "name" => "J-Профиль"],
                ["uri" => "/dobornye-elementy-dlya-myagkoy-krovli/", "name" => "Доборные элементы для мягкой кровли"],
                ["uri" => "/dobornyie-elementyi-falc/", "name" => "Доборные элементы фальц"],
                ["uri" => "/endova/", "name" => "Ендовы для кровли"],
                ["uri" => "/zaglushki/", "name" => "Заглушки"],
                ["uri" => "/karniznye-planki/", "name" => "Карнизные планки"],
                ["uri" => "/konkovye-elementy/", "name" => "Коньковые элементы для кровли"],
                ["uri" => "/lobovye-planki/", "name" => "Лобовые планки"],
                ["uri" => "/mansardnye-planki/", "name" => "Мансардные планки"],
                ["uri" => "/planka-kapelnik/", "name" => "Планка капельник"],
                ["uri" => "/planki-primykaniya/", "name" => "Планки примыкания"],
                ["uri" => "/planki-snegozaderzhaniya/", "name" => "Планки снегозадержания"],
                ["uri" => "/torcevye-planki/", "name" => "Торцевые планки"],
                ["uri" => "/troyniki/", "name" => "Тройники"],
                ["uri" => "/chetverniki/", "name" => "Четверники"],
            ]
        ],
        $komplektuyshie => [
            'column1' => [
                "uri" => "/komplektuyushhie/",
                "name" => "Комплектующие",
                'svg' => 'assort-soputtovary'
            ],
            'column2' => [
                ["uri" => "/stroitelnyy-krepyozh-v-sankt-peterburge/", "name" => "Строительный крепеж"],
                ["uri" => "/prohodki-i-ventilyaciya-v-sankt-peterburge/", "name" => "Проходки и вентиляция"],
                ["uri" => "/konkovyj-torcevoj-ehlement-v-sankt-peterburge/", "name" => "Коньковый торцевой элемент"],
                ["uri" => "/metallicheskie-dobornye-ehlementy-v-sankt-peterburge/", "name" => "Металлические доборные элементы"],
                ["uri" => "/ustrojstvo-primykanij/", "name" => "Устройство примыкания"],
            ]
        ]
    ];

    /* Сортировка чисел в меню */
    foreach ($data as $key => &$values) {
        foreach ($values as $k => &$value) {
            if($k != 'column1')
            {
                usort($value, 'compareNumeric');
            }
        }
    }
    /* разбиваем меню на колонки*/
    foreach ($data as $key => $v) {
        if(array_key_exists('column_cvet', $data[$key]))
        {
            $data[$key]['column_cvet'] = array_chunk($v['column_cvet'], 10);
        }

        if(array_key_exists('column2', $data[$key]))
        {
            $data[$key]['column2'] = array_chunk($v['column2'], 10);
        }

        if(array_key_exists('column_forma', $data[$key]))
        {
            // $data[$key]['column_forma'] = array_chunk($v['column_forma'], 10);
        }
    }
    return $data;
}
