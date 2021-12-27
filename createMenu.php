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
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BC%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B",
                "name" => "Для мансарды",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BD%D0%B8",
                "name" => "Для бани",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%87%D0%B8%2F%D0%BA%D0%B0%D0%BC%D0%B8%D0%BD%D0%B0",
                "name" => "Для печи/камина",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1",
                "name" => "Для труб",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%9F%D0%BE%D0%B4+%D1%88%D1%82%D1%83%D0%BA%D0%B0%D1%82%D1%83%D1%80%D0%BA%D1%83",
                "name" => "Под штукатурку",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8",
                "name" => "Для вентиляции",
            ],
        ];
        $thicknessResult = [
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=20",
                "name" => "20",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=25",
                "name" => "25",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=27",
                "name" => "27",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=30",
                "name" => "30",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=35",
                "name" => "35",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=40",
                "name" => "40",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=60",
                "name" => "60",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=70",
                "name" => "70",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=75",
                "name" => "75",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=80",
                "name" => "80",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=90",
                "name" => "90",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=102",
                "name" => "102",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=105",
                "name" => "105",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=110",
                "name" => "110",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=120",
                "name" => "120",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=122",
                "name" => "122",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=130",
                "name" => "130",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=140",
                "name" => "140",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=152",
                "name" => "152",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=160",
                "name" => "160",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=170",
                "name" => "170",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=180",
                "name" => "180",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=190",
                "name" => "190",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=200",
                "name" => "200",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=210",
                "name" => "210",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=220",
                "name" => "220",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=230",
                "name" => "230",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=240",
                "name" => "240",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=250",
                "name" => "250",
            ],
        ];
        break;
    case "penoplex":
        $primenenieResult = [
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F",
                "name" => "Для фундамента/цоколя",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8",
                "name" => "Для вентиляции",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1",
                "name" => "Для труб",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
        ];
        $thicknessResult = [
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=20",
                "name" => "20",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=30",
                "name" => "30",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=30.4",
                "name" => "30.4",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=40",
                "name" => "40",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=60",
                "name" => "60",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=80",
                "name" => "80",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=120",
                "name" => "120",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
        ];
        break;
    case "tn":
        $primenenieResult = [
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BC%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B",
                "name" => "Для мансарды",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BE%D0%BA%D0%BE%D0%BD",
                "name" => "Для окон",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%9F%D0%BE%D0%B4+%D1%88%D1%82%D1%83%D0%BA%D0%B0%D1%82%D1%83%D1%80%D0%BA%D1%83",
                "name" => "Под штукатурку",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F",
                "name" => "Для фундамента/цоколя",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8",
                "name" => "Для вентиляции",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1",
                "name" => "Для труб",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BD%D0%B8",
                "name" => "Для бани",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B0%D0%BD%D0%BD%D0%BE%D0%B9+%D0%BA%D0%BE%D0%BC%D0%BD%D0%B0%D1%82%D1%8B",
                "name" => "Для ванной комнаты",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B4%D0%B2%D0%B5%D1%80%D0%B5%D0%B9+%D0%B8+%D0%B2%D0%BE%D1%80%D0%BE%D1%82",
                "name" => "Для дверей и ворот",
            ],
        ];
        $thicknessResult = [
            [
                "uri" => "/catalog/?msoption|item_thickness=5",
                "name" => "5",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=10",
                "name" => "10",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=20",
                "name" => "20",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=22",
                "name" => "22",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=30",
                "name" => "30",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=40",
                "name" => "40",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=55",
                "name" => "55",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=60",
                "name" => "60",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=70",
                "name" => "70",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=80",
                "name" => "80",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=90",
                "name" => "90",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=110",
                "name" => "110",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=120",
                "name" => "120",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=130",
                "name" => "130",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=140",
                "name" => "140",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=160",
                "name" => "160",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=170",
                "name" => "170",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=180",
                "name" => "180",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=190",
                "name" => "190",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=200",
                "name" => "200",
            ],
        ];
        break;
    case "paroc":
        $primenenieResult = [
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BC%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B",
                "name" => "Для мансарды",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F",
                "name" => "Для фундамента/цоколя",
            ],
        ];
        $thicknessResult = [
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=90",
                "name" => "90",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=117",
                "name" => "117",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=122",
                "name" => "122",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=126",
                "name" => "126",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=151",
                "name" => "151",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=350",
                "name" => "350",
            ],
        ];
        break;
    case "ursa":
        $primenenieResult = [
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8",
                "name" => "Для балкона/лоджии",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BD%D0%B8",
                "name" => "Для бани",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8",
                "name" => "Для вентиляции",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8",
                "name" => "Для кровли",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA",
                "name" => "Для перегородок",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9",
                "name" => "Для перекрытий",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0",
                "name" => "Для пола",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0",
                "name" => "Для потолка",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD",
                "name" => "Для стен",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1",
                "name" => "Для труб",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0",
                "name" => "Для фасада",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F",
                "name" => "Для фундамента/цоколя",
            ],
        ];
        $thicknessResult = [
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=20",
                "name" => "20",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=25",
                "name" => "25",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=30",
                "name" => "30",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=40",
                "name" => "40",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=60",
                "name" => "60",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=80",
                "name" => "80",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=130",
                "name" => "130",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=180",
                "name" => "180",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=200",
                "name" => "200",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=1200",
                "name" => "1200",
            ],
        ];
        break;
    case "isover":
        $thicknessResult = [
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
        ];
        break;
    case "web":
        $thicknessResult = [
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=50",
                "name" => "50",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=100",
                "name" => "100",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=150",
                "name" => "150",
            ],
        ];
        break;
    case "krovlya":
        $thicknessResult = [
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=0.4",
                "name" => "0.4",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=0.45",
                "name" => "0.45",
            ],
            [
                "uri" =>
                    "/catalog/?msoption|item_thickness=0.5",
                "name" => "0.5",
            ],
        ];
        $primenenieResult = [
            [
                "uri" =>
                    "/catalog/?msoption|cvet=Cuprum+Steel",
                "name" => "Cuprum Steel",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=NL805",
                "name" => "NL805",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+1014",
                "name" => "RAL 1014",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+1015",
                "name" => "RAL 1015",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+1018",
                "name" => "RAL 1018",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+2004",
                "name" => "RAL 2004",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+3003",
                "name" => "RAL 3003",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+3005",
                "name" => "RAL 3005",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+3009",
                "name" => "RAL 3009",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+3011",
                "name" => "RAL 3011",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+5002",
                "name" => "RAL 5002",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+5005",
                "name" => "RAL 5005",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+5018",
                "name" => "RAL 5018",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+5021",
                "name" => "RAL 5021",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+6002",
                "name" => "RAL 6002",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+6005",
                "name" => "RAL 6005",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+6019",
                "name" => "RAL 6019",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+6020",
                "name" => "RAL 6020",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+7004",
                "name" => "RAL 7004",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+7005",
                "name" => "RAL 7005",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+7016",
                "name" => "RAL 7016",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+7024",
                "name" => "RAL 7024",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+8004",
                "name" => "RAL 8004",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+8017",
                "name" => "RAL 8017",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+9003",
                "name" => "RAL 9003",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+9005",
                "name" => "RAL 9005",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RAL+9006",
                "name" => "RAL 9006",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RR+11",
                "name" => "RR 11",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RR+21",
                "name" => "RR 21",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RR+23",
                "name" => "RR 23",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RR+29",
                "name" => "RR 29",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RR+32",
                "name" => "RR 32",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RR+33",
                "name" => "RR 33",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RR+750",
                "name" => "RR 750",
            ],
            [
                "uri" => "/catalog/?msoption|cvet=RR+887",
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
