<?php

$context = $modx->resource->get('context_key');
$primenenieResult = [];
$thicknessResult = [];
$categories = [];

// --------------------------------------
// Категории
// --------------------------------------
$catalog = $modx->getObject('modResource', [
    'alias' => 'catalog',
    'context_key' => $context
]);

if (!empty($catalog)) {
    $categories = $modx->runSnippet('pdoResources', [
        'parents' => $catalog->id,
        'depth' => 0,
        'where' => '{"template:=": "5"}',
        'limit' => 0,
        'sortby' => 'menuindex',
        'sortdir' => 'ASC',
        'context' => $context,
        'tpl' => '@FILE: chunks/jsonMenuItem.tpl',
        'includeTVs' => 'menutitleTV',
        'tplWrapper' => '@INLINE [ {$output} ]',
        'outputSeparator' => ','
    ]);
}

$categories = json_decode($categories, 1);

if (is_null($categories)) {
    $categories = [];
}

// --------------------------------------
// Товары
// --------------------------------------
switch ($context) {
    case "rockwool":
        $primenenieResult = [
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BC%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B",
                "name" => "Для мансарды",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BD%D0%B8",
                "name" => "Для бани",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%87%D0%B8%2F%D0%BA%D0%B0%D0%BC%D0%B8%D0%BD%D0%B0",
                "name" => "Для печи/камина",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1",
                "name" => "Для труб",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%9F%D0%BE%D0%B4+%D1%88%D1%82%D1%83%D0%BA%D0%B0%D1%82%D1%83%D1%80%D0%BA%D1%83",
                "name" => "Под штукатурку",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8",
                "name" => "Для вентиляции",
            ],
        ];
        $thicknessResult = [
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=20",
                "name" => "20",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=25",
                "name" => "25",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=27",
                "name" => "27",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=30",
                "name" => "30",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=35",
                "name" => "35",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=40",
                "name" => "40",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=60",
                "name" => "60",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=70",
                "name" => "70",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=75",
                "name" => "75",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=80",
                "name" => "80",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=90",
                "name" => "90",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=102",
                "name" => "102",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=105",
                "name" => "105",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=110",
                "name" => "110",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=120",
                "name" => "120",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=122",
                "name" => "122",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=130",
                "name" => "130",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=140",
                "name" => "140",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=152",
                "name" => "152",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=160",
                "name" => "160",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=170",
                "name" => "170",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=180",
                "name" => "180",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=190",
                "name" => "190",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=200",
                "name" => "200",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=210",
                "name" => "210",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=220",
                "name" => "220",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=230",
                "name" => "230",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=240",
                "name" => "240",
            ],
            [
                "uri" =>
                    "https://www-rockwool.ru/catalog/?msoption|item_thickness=250",
                "name" => "250",
            ],
        ];
        break;
    case "penoplex":
        $primenenieResult = [
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F",
                "name" => "Для фундамента/цоколя",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8",
                "name" => "Для вентиляции",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1",
                "name" => "Для труб",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
        ];
        $thicknessResult = [
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=20",
                "name" => "20",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=30",
                "name" => "30",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=30.4",
                "name" => "30.4",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=40",
                "name" => "40",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=60",
                "name" => "60",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=80",
                "name" => "80",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=120",
                "name" => "120",
            ],
            [
                "uri" =>
                    "https://www-penoplex.ru/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
        ];
        break;
    case "tn":
        $primenenieResult = [
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BC%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B",
                "name" => "Для мансарды",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BE%D0%BA%D0%BE%D0%BD",
                "name" => "Для окон",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%9F%D0%BE%D0%B4+%D1%88%D1%82%D1%83%D0%BA%D0%B0%D1%82%D1%83%D1%80%D0%BA%D1%83",
                "name" => "Под штукатурку",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F",
                "name" => "Для фундамента/цоколя",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8",
                "name" => "Для вентиляции",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1",
                "name" => "Для труб",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BD%D0%B8",
                "name" => "Для бани",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B0%D0%BD%D0%BD%D0%BE%D0%B9+%D0%BA%D0%BE%D0%BC%D0%BD%D0%B0%D1%82%D1%8B",
                "name" => "Для ванной комнаты",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B4%D0%B2%D0%B5%D1%80%D0%B5%D0%B9+%D0%B8+%D0%B2%D0%BE%D1%80%D0%BE%D1%82",
                "name" => "Для дверей и ворот",
            ],
        ];
        $thicknessResult = [
            [
                "uri" => "https://www-tn.ru/catalog/?msoption|item_thickness=5",
                "name" => "5",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=10",
                "name" => "10",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=20",
                "name" => "20",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=22",
                "name" => "22",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=30",
                "name" => "30",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=40",
                "name" => "40",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=55",
                "name" => "55",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=60",
                "name" => "60",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=70",
                "name" => "70",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=80",
                "name" => "80",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=90",
                "name" => "90",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=110",
                "name" => "110",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=120",
                "name" => "120",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=130",
                "name" => "130",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=140",
                "name" => "140",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=160",
                "name" => "160",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=170",
                "name" => "170",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=180",
                "name" => "180",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=190",
                "name" => "190",
            ],
            [
                "uri" =>
                    "https://www-tn.ru/catalog/?msoption|item_thickness=200",
                "name" => "200",
            ],
        ];
        break;
    case "paroc":
        $primenenieResult = [
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BC%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B",
                "name" => "Для мансарды",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F",
                "name" => "Для фундамента/цоколя",
            ],
        ];
        $thicknessResult = [
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|item_thickness=90",
                "name" => "90",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|item_thickness=117",
                "name" => "117",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|item_thickness=122",
                "name" => "122",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|item_thickness=126",
                "name" => "126",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|item_thickness=151",
                "name" => "151",
            ],
            [
                "uri" =>
                    "https://www-paroc.ru/catalog/?msoption|item_thickness=350",
                "name" => "350",
            ],
        ];
        break;
    case "ursa":
        $primenenieResult = [
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BD%D0%B8",
                "name" => "Для бани",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8",
                "name" => "Для вентиляции",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1",
                "name" => "Для труб",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F",
                "name" => "Для фундамента/цоколя",
            ],
        ];
        $thicknessResult = [
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=20",
                "name" => "20",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=25",
                "name" => "25",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=30",
                "name" => "30",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=40",
                "name" => "40",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=60",
                "name" => "60",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=80",
                "name" => "80",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=130",
                "name" => "130",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=180",
                "name" => "180",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=200",
                "name" => "200",
            ],
            [
                "uri" =>
                    "https://www-ursa.ru/catalog/?msoption|item_thickness=1200",
                "name" => "1200",
            ],
        ];
        break;
    case "isover":
        $thicknessResult = [
            [
                "uri" =>
                    "https://www-isover.ru/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "https://www-isover.ru/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "https://www-isover.ru/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
        ];
        break;
    case "web":
        $thicknessResult = [
            [
                "uri" =>
                    "https://www-knauf.ru/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "https://www-knauf.ru/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "https://www-knauf.ru/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
        ];
        break;
    case "krovlya":
        $thicknessResult = [
            [
                "uri" =>
                    "https://krovlyasp.ru/catalog/?msoption|item_thickness=0.4",
                "name" => "0.4",
            ],
            [
                "uri" =>
                    "https://krovlyasp.ru/catalog/?msoption|item_thickness=0.45",
                "name" => "0.45",
            ],
            [
                "uri" =>
                    "https://krovlyasp.ru/catalog/?msoption|item_thickness=0.5",
                "name" => "0.5",
            ],
        ];
        $primenenieResult = [
            [
                "uri" =>
                    "https://krovlyasp.ru/catalog/?msoption|cvet=Cuprum+Steel",
                "name" => "Cuprum Steel",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=NL805",
                "name" => "NL805",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+1014",
                "name" => "RAL 1014",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+1015",
                "name" => "RAL 1015",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+1018",
                "name" => "RAL 1018",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+2004",
                "name" => "RAL 2004",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+3003",
                "name" => "RAL 3003",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+3005",
                "name" => "RAL 3005",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+3009",
                "name" => "RAL 3009",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+3011",
                "name" => "RAL 3011",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+5002",
                "name" => "RAL 5002",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+5005",
                "name" => "RAL 5005",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+5018",
                "name" => "RAL 5018",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+5021",
                "name" => "RAL 5021",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+6002",
                "name" => "RAL 6002",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+6005",
                "name" => "RAL 6005",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+6019",
                "name" => "RAL 6019",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+6020",
                "name" => "RAL 6020",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+7004",
                "name" => "RAL 7004",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+7005",
                "name" => "RAL 7005",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+7016",
                "name" => "RAL 7016",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+7024",
                "name" => "RAL 7024",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+8004",
                "name" => "RAL 8004",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+8017",
                "name" => "RAL 8017",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+9003",
                "name" => "RAL 9003",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+9005",
                "name" => "RAL 9005",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RAL+9006",
                "name" => "RAL 9006",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RR+11",
                "name" => "RR 11",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RR+21",
                "name" => "RR 21",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RR+23",
                "name" => "RR 23",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RR+29",
                "name" => "RR 29",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RR+32",
                "name" => "RR 32",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RR+33",
                "name" => "RR 33",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RR+750",
                "name" => "RR 750",
            ],
            [
                "uri" => "https://krovlyasp.ru/catalog/?msoption|cvet=RR+887",
                "name" => "RR 887",
            ],
        ];
        break;
}

$result = [];
if (!empty($categories)) {
    $key = 'Продуктовые линейки';
    $count = count($categories);

    switch (true) {
        case $count < 10:
            $result[$key][] = $categories;
            break;
        case $count >= 10 && $count <= 15:
            $amount = ceil($count / 2);
            $result[$key][] = array_slice($categories, 0, $amount);
            $result[$key][] = array_slice($categories, $amount, $count - 1);
            break;
        case $count > 15:
            $amount = ceil($count / 3);
            $twiceAmount = $amount + $amount;
            $result[$key][] = array_slice($categories, 0, $amount);
            $result[$key][] = array_slice($categories, $amount, $amount);
            $result[$key][] = array_slice($categories, $twiceAmount, $count - 1);
            break;
    }
}
if (!empty($primenenieResult)) {
    if ($modx->resource->context_key !== 'krovlya') {
        $key = 'Применение';
    } else {
        $key = 'Цвет';
    }

    $count = count($primenenieResult);

    switch (true) {
        case $count < 10:
            $result[$key][] = $primenenieResult;
            break;
        case $count >= 10 && $count <= 15:
            $amount = ceil($count / 2);
            $result[$key][] = array_slice($primenenieResult, 0, $amount);
            $result[$key][] = array_slice($primenenieResult, $amount, $count - 1);
            break;
        case $count > 15:
            $amount = ceil($count / 3);
            $twiceAmount = $amount + $amount;
            $result[$key][] = array_slice($primenenieResult, 0, $amount);
            $result[$key][] = array_slice($primenenieResult, $amount, $amount);
            $result[$key][] = array_slice($primenenieResult, $twiceAmount, $count - 1);
            break;
    }
}
if (!empty($thicknessResult)) {
    $key = 'Толщина, мм';
    $count = count($thicknessResult);

    switch (true) {
        case $count < 10:
            $result[$key][] = $thicknessResult;
            break;
        case $count >= 10 && $count <= 15:
            $amount = ceil($count / 2);
            $result[$key][] = array_slice($thicknessResult, 0, $amount);
            $result[$key][] = array_slice($thicknessResult, $amount, $count - 1);
            break;
        case $count > 15:
            $amount = ceil($count / 3);
            $twiceAmount = $amount + $amount;
            $result[$key][] = array_slice($thicknessResult, 0, $amount);
            $result[$key][] = array_slice($thicknessResult, $amount, $amount);
            $result[$key][] = array_slice($thicknessResult, $twiceAmount, $count - 1);
            break;
    }
}

return $result;
