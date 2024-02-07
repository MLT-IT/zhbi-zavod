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
                ["uri" => "/ondulin/?msoption%7Ccvet=%D0%A1%D0%B5%D1%80%D1%8B%D0%B9", "name" => "Серый"],
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
                ["uri" => "/shifer/?msoption%7Ctip=%D0%92%D0%BE%D0%BB%D0%BD%D0%BE%D0%B2%D0%BE%D0%B9", "name" => "Волновой"],
                ["uri" => "/shifer/?msoption%7Ctip=%D0%9F%D0%BB%D0%BE%D1%81%D0%BA%D0%B8%D0%B9", "name" => "Плоский"],
                ["uri" => "/fibroczementnaya-cherepicza/", "name" => "Фиброцементная черепица"],
            ],
            'column_cvet' => [
                ["uri" => "/shifer/?msoption%7Ccvet=%D0%A1%D0%B5%D1%80%D1%8B%D0%B9", "name" => "серый"],
                ["uri" => "/shifer/?msoption%7Ccvet=%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9", "name" => "красный"],
                ["uri" => "/shifer/?msoption%7Ccvet=%D0%9A%D0%BE%D1%80%D0%B8%D1%87%D0%BD%D0%B5%D0%B2%D1%8B%D0%B9", "name" => "коричневый"],
                ["uri" => "/shifer/?msoption%7Ccvet=%D0%97%D0%B5%D0%BB%D0%B5%D0%BD%D1%8B%D0%B9", "name" => "зеленый"],
                ["uri" => "/shifer/?msoption%7Ccvet=%D0%A1%D0%B8%D0%BD%D0%B8%D0%B9", "name" => "синий"],
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
                ["uri" => "/metallocherepica/?msoption%7Ccollection=%D0%9C%D0%BE%D0%BD%D1%82%D0%B5%D1%80%D1%80%D0%B5%D0%B9", "name" => "Монтеррей"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=%D0%A1%D1%83%D0%BF%D0%B5%D1%80%D0%BC%D0%BE%D0%BD%D1%82%D0%B5%D1%80%D1%80%D0%B5%D0%B9", "name" => "Супермонтеррей"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=%D0%A2%D1%80%D0%B0%D0%BC%D0%BE%D0%BD%D1%82%D0%B0%D0%BD%D0%B0", "name" => "Трамонтана"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=%D0%9C%D0%BE%D0%BD%D1%82%D0%B5%D0%BA%D1%80%D0%B8%D1%81%D1%82%D0%BE", "name" => "Монтекристо"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=%D0%9B%D0%B0%D0%BC%D0%BE%D0%BD%D1%82%D0%B5%D1%80%D1%80%D0%B0", "name" => "Ламонтерра"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=Classic", "name" => "Classic"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=%D0%9B%D0%B0%D0%BC%D0%BE%D0%BD%D1%82%D0%B5%D1%80%D1%80%D0%B0%20X", "name" => "Ламонтерра X"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=Kvinta%20plus", "name" => "Kvinta plus"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=Kvinta%20Uno", "name" => "Kvinta Uno"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=%D0%9B%D0%B0%D0%BC%D0%BE%D0%BD%D1%82%D0%B5%D1%80%D1%80%D0%B0%20XL", "name" => "Ламонтерра XL"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=Modern", "name" => "Modern"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=Kredo", "name" => "Kredo"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=Kamea", "name" => "Kamea"],
                ["uri" => "/metallocherepica/?msoption%7Ccollection=%D0%9C%D0%BE%D0%BD%D1%82%D0%B5%D1%80%D1%80%D0%BE%D1%81%D0%B0", "name" => "Монтерроса"],
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
                ["uri" => "/metallocherepica/?msoption%7Ccvet=RAL%205015", "name" => "RAL 5015"],
                ["uri" => "/metallocherepicza-ral-3003/", "name" => "RAL 3003"],
            ],
            'column_tolshina' => [
                ["uri" => "/metallocherepica/?msoption%7Citem_thickness=0.4", "name" => "0.4"],
                ["uri" => "/metallocherepica/?msoption%7Citem_thickness=0.45", "name" => "0.45"],
                ["uri" => "/metallocherepica/?msoption%7Citem_thickness=0.5", "name" => "0.5"],
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
                ["uri" => "/myagkaya-cherepica/?msoption%7Cottenok=%D0%A1%D0%B5%D1%80%D1%8B%D0%B9", "name" => "серый"],
                ["uri" => "/myagkaya-cherepica/?msoption%7Cottenok=%D0%9A%D0%BE%D1%80%D0%B8%D1%87%D0%BD%D0%B5%D0%B2%D1%8B%D0%B9", "name" => "коричневый"],
                ["uri" => "/myagkaya-cherepica/?msoption%7Cottenok=%D0%A1%D0%BE%D0%BD%D0%B0%D1%82%D0%B0", "name" => "соната"],
                ["uri" => "/myagkaya-cherepica/?msoption%7Cottenok=%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9", "name" => "красный"],
                ["uri" => "/myagkaya-cherepica/?msoption%7Cottenok=%D0%97%D0%B5%D0%BB%D1%91%D0%BD%D1%8B%D0%B9", "name" => "зеленый"],
            ],
        ],
        $rulonaykrovlay => [
            'column1' => [
                "uri" => "/rulonnaya-krovlya/",
                "name" => "Рулонная кровля",
                'svg' => 'assort-rulon-krovlya'
            ],
            'column_tip' => [
                ["uri" => "/rulonnaya-krovlya/?msoption%7Ctip=%D0%9D%D0%B0%D0%BF%D0%BB%D0%B0%D0%B2%D0%BB%D1%8F%D0%B5%D0%BC%D0%B0%D1%8F%20%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D1%8F", "name" => "Наплавляемая кровля"],
                ["uri" => "/pvh-membrany/", "name" => "ПВХ мембраны"],
                ["uri" => "/slanczevaya-krovlya/", "name" => "Рулонная черепица"],
                ["uri" => "/rulonnaya-cherepicza/", "name" => "Сланцевая кровля"],
            ],
            'column_proizvoditel' => [
                ["uri" => "/rulonnaya-krovlya-tehnonikol/", "name" => "Технониколь"],
                ["uri" => "/ikopal/", "name" => "Icopal"],
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cproizvoditel=Plastfoil", "name" => "Plastfoil"],
            ],
            'column_ottenok' => [
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cottenok=%D0%91%D0%B5%D0%BB%D1%8B%D0%B9", "name" => "Белый"],
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cottenok=%D0%96%D0%B5%D0%BB%D1%82%D1%8B%D0%B9", "name" => "Желтый"],
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cottenok=%D0%97%D0%B5%D0%BB%D0%B5%D0%BD%D1%8B%D0%B9", "name" => "Зеленый"],
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cottenok=%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9", "name" => "Красный"],
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cottenok=%D0%A1%D0%B5%D1%80%D1%8B%D0%B9", "name" => "Серый"],
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cottenok=%D0%A1%D0%B8%D0%BD%D0%B8%D0%B9", "name" => "Синий"],
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cottenok=%D0%A7%D0%B5%D1%80%D0%BD%D1%8B%D0%B9", "name" => "Черный"],
            ],
            'column_naznachenie' => [
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cprimenenie=%D0%94%D0%BB%D1%8F%20%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8", "name" => "Для кровли"],
                ["uri" => "/rulonnaya-krovlya/?msoption%7Cprimenenie=%D0%94%D0%BB%D1%8F%20%D1%82%D1%80%D1%83%D0%B1", "name" => "Для труб"],
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
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%A4%D1%80%D0%B0%D0%BD%D0%BA%D1%84%D1%83%D1%80%D1%82%D1%81%D0%BA%D0%B0%D1%8F", "name" => "Франкфуртская"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=Classic", "name" => "Classic"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%A2%D0%B0%D1%83%D0%BD%D1%83%D1%81", "name" => "Таунус"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=Lite", "name" => "Lite"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%A2%D0%B5%D0%B2%D0%B8%D0%B2%D0%B0", "name" => "Тевива"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=Antik", "name" => "Antik"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%90%D0%B4%D1%80%D0%B8%D0%B0", "name" => "Адриа"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%90%D1%8D%D1%80%D0%BB%D0%BE%D0%BA%D1%81", "name" => "Аэрлокс"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%94%D0%BE%D0%BF%D0%BF%D0%B5%D0%BB%D1%8C-%D0%A1", "name" => "Доппель-С"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%9F%D1%80%D0%BE%D1%82%D0%B5%D0%BA%D1%82%D0%BE%D1%80", "name" => "Протектор"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%A0%D0%B5%D0%B2%D0%B8%D0%B2%D0%B0", "name" => "Ревива"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%A2%D0%B0%D1%83%D0%BD", "name" => "Таун"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Ccollection=%D0%A4%D1%80", "name" => "Фр"],
            ],
            'column_cvet' =>[
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9", "name" => "Красный"],
                ["uri" => "/czementno-peschanaya-cherepicz-chernaya/", "name" => "Черный"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%9C%D0%B0%D0%B3%D0%BC%D0%B0", "name" => "Магма"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%A1%D0%B5%D1%80%D1%8B%D0%B9", "name" => "Серый"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%9A%D0%BE%D1%80%D0%B8%D1%87%D0%BD%D0%B5%D0%B2%D1%8B%D0%B9", "name" => "Коричневый"],
                ["uri" => "/czementno-peschanaya-cherepicz-grafit/", "name" => "Графит"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%90%D0%BD%D1%82%D0%B8%D0%BA", "name" => "Антик"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%90%D0%BD%D1%82%D0%B8%D0%BA%20%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9", "name" => "Антик красный"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%90%D0%BD%D1%82%D0%B8%D0%BA%20%D1%82%D0%B5%D0%BC%D0%BD%D0%BE-%D0%BA%D0%BE%D1%80%D0%B8%D1%87%D0%BD%D0%B5%D0%B2%D1%8B%D0%B9", "name" => "Антик темно-коричневый"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%90%D0%BD%D1%82%D0%B8%D1%87%D0%BD%D1%8B%D0%B9%20%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9", "name" => "Античный красный"],
                ["uri" => "/czementno-peschanaya-cherepicz-vishnya/", "name" => "Вишня"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%9A%D0%B0%D1%88%D1%82%D0%B0%D0%BD", "name" => "Каштан"],
                ["uri" => "/cementno-peschanaya-cherepica/?msoption%7Cottenok=%D0%9A%D0%B8%D1%80%D0%BF%D0%B8%D1%87%D0%BD%D0%BE-%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9", "name" => "Кирпично-красный"],
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
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ctip=%D0%A0%D1%8F%D0%B4%D0%BE%D0%B2%D0%B0%D1%8F", "name" => "Рядовая"],
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ctip=%D0%A4%D0%B0%D1%81%D0%BE%D0%BD%D0%BD%D0%B0%D1%8F", "name" => "Фасонная"],
            ],
            'column_collection' => [
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ccollection=%D0%A1%D0%B0%D0%BF%D1%84%D0%B8%D1%80", "name" => "Сапфир"],
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ccollection=%D0%A0%D1%83%D0%B1%D0%B8%D0%BD%2013V", "name" => "Рубин 13V"],
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ccollection=%D0%90%D0%B3%D0%B0%D1%82%2014", "name" => "Агат 14"],
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ccollection=%D0%98%D0%B7%D1%83%D0%BC%D1%80%D1%83%D0%B4", "name" => "Изумруд"],
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ccollection=%D0%9E%D0%BF%D0%B0%D0%BB", "name" => "Опал"],
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ccollection=%D0%A0%D1%83%D0%B1%D0%B8%D0%BD%209V", "name" => "Рубин 9V"],
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ccollection=%D0%A0%D1%83%D0%B1%D0%B8%D0%BD%2011V", "name" => "Рубин 11V"],
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ccollection=%D0%A2%D0%BE%D0%BF%D0%B0%D0%B7%2013V", "name" => "Топаз 13V"],
                ["uri" => "/keramicheskaya-cherepica/?msoption%7Ccollection=%D0%A2%D1%83%D1%80%D0%BC%D0%B0%D0%BB%D0%B8%D0%BD", "name" => "Турмалин"],
            ],
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
                ["uri" => "/falcevaya-krovlya/?msoption%7Cpokrytie=Satin", "name" => "Satin"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Cpokrytie=%D0%9F%D0%BE%D0%BB%D0%B8%D1%8D%D1%81%D1%82%D0%B5%D1%80", "name" => "Полиэстер"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Cpokrytie=Rooftop%20Matte", "name" => "Rooftop Matte"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Cpokrytie=Atlas", "name" => "Atlas"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Cpokrytie=Drap", "name" => "Drap"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Cpokrytie=GreenCoat%20Pural%20BT", "name" => "GreenCoat Pural BT"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Cpokrytie=Velur%20X", "name" => "Velur X"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Cpokrytie=Drap%20ST", "name" => "Drap ST"],
            ],
            'column_cvet' => [
                ["uri" => "/falcevaya-krovlya/?msoption%7Ccvet=RAL%208017", "name" => "RAL 8017"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Ccvet=RAL%203005", "name" => "RAL 3005"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Ccvet=RAL%207004", "name" => "RAL 7004"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Ccvet=RAL%206005", "name" => "RAL 6005"],
                ["uri" => "/falcevaya-krovlya/?msoption%7Ccvet=RAL%205021", "name" => "RAL 5021"],
                ["uri" => "/falczevaya-krovlya-ral-7016/", "name" => "RAL 7016"],
                ["uri" => "/falczevaya-krovlya-ral-9005/", "name" => "RAL 9005"],
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
            'column_tolshina' => [
                ["uri" => "/proflist/?msoption%7Citem_thickness=1", "name" => "1"],
                ["uri" => "/proflist/?msoption%7Citem_thickness=0.8", "name" => "0.8"],
                ["uri" => "/proflist/?msoption%7Citem_thickness=0.45", "name" => "0.45"],
                ["uri" => "/proflist/?msoption%7Citem_thickness=0.7", "name" => "0.7"],
                ["uri" => "/proflist/?msoption%7Citem_thickness=0.5", "name" => "0.5"],
                ["uri" => "/proflist/?msoption%7Citem_thickness=0.9", "name" => "0.9"],
                ["uri" => "/proflist/?msoption%7Citem_thickness=0.35", "name" => "0.35"],
                ["uri" => "/proflist/?msoption%7Citem_thickness=0.6", "name" => "0.6"],
                ["uri" => "/proflist/?msoption%7Citem_thickness=0.4", "name" => "0.4"],
            ],
            'column_profil' => [
                ["uri" => "/proflist-mp-20/", "name" => "МП20"],
                ["uri" => "/profnastil-n-75/", "name" => "H75"],
                ["uri" => "/proflist-n-60/", "name" => "H60"],
                ["uri" => "/proflist-ns-35/", "name" => "HC35"],
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
                ["uri" => "/shtaketnik-gorizontalnyij/", "name" => "Штакетник горизонтальный"],
                ["uri" => "/shtaketnik-p-obraznyy-grand-line/", "name" => "Штакетник П-образный"],
                ["uri" => "/shtaketnik-polukruglyy-slim-grand-line/", "name" => "Штакетник полукруглый"],
                ["uri" => "/shtaketnik-m-obraznyy-figurnyy-grand-line/", "name" => "Штакетник М-образный фигурный"],
                ["uri" => "/shtaketnik-twin-grand-line/", "name" => "Штакетник Twin"],
                ["uri" => "/shtaketnik-metall-profil/?msoption%7Cpokrytie=%D0%9F%D0%BE%D0%BB%D0%B8%D1%8D%D1%81%D1%82%D0%B5%D1%80%20%D0%BC%D0%B0%D1%82%D0%BE%D0%B2%D1%8B%D0%B9%20%D0%B4%D0%B2%D1%83%D1%81%D1%82%D0%BE%D1%80%D0%BE%D0%BD%D0%BD%D0%B8%D0%B9", "name" => "Штакетник двусторонний"],
                ["uri" => "/shtaketnik-kruglyij-grand-line/", "name" => "Штакетник круглый"],
                ["uri" => "/shtaketnik-pryamougolnyy-grand-line/", "name" => "Штакетник прямоугольный"],
                ["uri" => "/kruglyy-figurnyy-grand-line/", "name" => "Штакетник круглый фигурный"],
                ["uri" => "/shtaketnik-polukruglyy-figurnyy-slim-grand-line/", "name" => "Штакетник полукруглый фигурный"],
            ],
            'column_tolshina' => [
                ["uri" => "/shtaketnik/?msoption%7Citem_thickness=0.45", "name" => "0.45"],
                ["uri" => "/shtaketnik/?msoption%7Citem_thickness=0.4", "name" => "0.4"],
                ["uri" => "/shtaketnik/?msoption%7Citem_thickness=0.5", "name" => "0.5"],
                ["uri" => "/shtaketnik/?msoption%7Citem_thickness=0.43", "name" => "0.43"],
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
                ["uri" => "/sofity/?msoption%7Ccvet=RAL%208017", "name" => "ral 8017"],
                ["uri" => "/sofity/?msoption%7Ccvet=RAL%207024", "name" => "ral 7024"],
                ["uri" => "/sofity/?msoption%7Ccvet=RAL%209003", "name" => "ral 9003"],
                ["uri" => "/sofity/?msoption%7Ccvet=RAL%207005", "name" => "ral 7005"],
            ],
            'column_ottenok' => [
                ["uri" => "/sofityi-belyie/", "name" => "белый"],
                ["uri" => "/sofity/?msoption%7Cottenok=%D0%93%D1%80%D0%B0%D1%84%D0%B8%D1%82", "name" => "графит"],
                ["uri" => "/sofityi-shokolad/", "name" => "шоколад"],
                ["uri" => "/sofityi-korichnevyie/", "name" => "коричневый"],
                ["uri" => "/sofityi-chernyie/", "name" => "черный"],
                ["uri" => "/sofity/?msoption%7Cottenok=%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9", "name" => "красный"],
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
                ["uri" => "/mastiki-kraski/", "name" => "Мастики и краски"],
                ["uri" => "/germetiki-v-sankt-peterburge/", "name" => "Герметики"],
                ["uri" => "/geosinteticheskie-materialy/", "name" => "Геосинтетические материалы"],
                ["uri" => "/brusok-v-sankt-peterburge/", "name" => "Брусок"],
                ["uri" => "/antiseptik-i-ognebiozashhita-drevesinyi/", "name" => "Антисептик и огнебиозащита древесины"],
                ["uri" => "/moyushchie-sredstva-dlya-ochistki-krovli/", "name" => "Моющие средства для очистки кровли"],
                ["uri" => "/ploskiy-list-v-sankt-peterburge/", "name" => "Плоский лист"],
                ["uri" => "/bitumnyj-klej/", "name" => "Битумный клей"],
                ["uri" => "/kozyrki-iz-polikarbonata/", "name" => "Козырьки из поликарбоната"],
                ["uri" => "/okna-v-sankt-peterburge/", "name" => "Окна"],
                ["uri" => "/lestnicy-cherdachnye-v-sankt-peterburge/", "name" => "Лестницы чердачные"],
                ["uri" => "/flyugery-v-sankt-peterburge/", "name" => "Флюгеры"],
                ["uri" => "/stroitelnyy-krepyozh-v-sankt-peterburge/", "name" => "Строительный крепеж"],
                ["uri" => "/prohodki-i-ventilyaciya-v-sankt-peterburge/", "name" => "Проходки и вентиляция"],
                ["uri" => "/ehlementy-bezopasnosti-krovli-v-sankt-peterburge/", "name" => "Элементы безопастности кровли"],
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
            $data[$key]['column_forma'] = array_chunk($v['column_forma'], 10);
        }
    }
    return $data;
}
