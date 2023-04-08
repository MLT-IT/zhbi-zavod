<?php

$context = $modx->resource->get('context_key');
$result = [];

$cacheName = 'createMenu';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $catalogs = [
        'knauf' => 93185,
        'rockwool' => 93190,
        'tn' => 93191,
        'penoplex' => 93189,
        'isover' => 93187,
        'paroc' => 93188,
        'ursa' => 93192,
        'isorok' => 93186
    ];

    // Получаем столбцы 2 и 3
    switch ($context) {
        // -------------------------------------
        // alterteplo.ru
        // -------------------------------------
        case 'web':
            $result = [
                $catalogs['knauf'] => [
                    'column2' => [
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

                $catalogs['rockwool'] => [
                    'column2' => [
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

                $catalogs['tn'] => [
                    'column2' => [
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

                $catalogs['penoplex'] => [
                    'column2' => [
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

                $catalogs['isover'] => [
                    'column2' => [
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

                $catalogs['paroc'] => [
                    'column2' => [
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

                $catalogs['ursa'] => [
                    'column2' => [
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

                $catalogs['isorok'] => [
                    'column2' => [
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20балкона/лоджии",
                            "name" => "Для балкона/лоджии",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20вентиляции",
                            "name" => "Для вентиляции",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20кровли",
                            "name" => "Для кровли",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20мансарды",
                            "name" => "Для мансарды",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20перегородок",
                            "name" => "Для перегородок",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20перекрытий",
                            "name" => "Для перекрытий",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20печи/камина",
                            "name" => "Для печи/камина",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20пола",
                            "name" => "Для пола",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20потолка",
                            "name" => "Для потолка",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20сайдинга",
                            "name" => "Для сайдинга",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20стен",
                            "name" => "Для стен",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20труб",
                            "name" => "Для труб",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Для%20фасада",
                            "name" => "Для фасада",
                        ],
                        [
                            "uri" => "/isorok/?msoption|primenenie=Крыши",
                            "name" => "Крыши",
                        ]
                    ],
                    'column3' => [
                        [
                            "uri" => "/isorok/?msoption|item_thickness=1.2",
                            "name" => "1.2",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=1.5",
                            "name" => "1.5",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=27",
                            "name" => "27",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=30",
                            "name" => "30",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=40",
                            "name" => "40",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=50",
                            "name" => "50",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=60",
                            "name" => "60",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=70",
                            "name" => "70",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=80",
                            "name" => "80",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=90",
                            "name" => "90",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=100",
                            "name" => "100",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=110",
                            "name" => "110",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=120",
                            "name" => "120",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=130",
                            "name" => "130",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=140",
                            "name" => "140",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=150",
                            "name" => "150",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=160",
                            "name" => "160",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=170",
                            "name" => "170",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=180",
                            "name" => "180",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=190",
                            "name" => "190",
                        ],
                        [
                            "uri" => "/isorok/?msoption|item_thickness=200",
                            "name" => "200",
                        ],
                    ]
                ]
            ];

            break;
    }

    // Формируем массив
    // Столбец 1, это категории самого верхнего уровня
    $json = $modx->runSnippet('pdoResources', [
        'parents' => 4,
        'depth' => 0,
        'limit' => 0,
        'tpl' => '@FILE chunks/category-item-json.tpl',
        'tplWrapper' => '@INLINE {[[+output]]}',
        'where' => '{"template:=":"5"}',
        'includeTVs' => 'mainImage'
    ]);
    $json = str_replace([' ', ',}'], ['', ' }'], $json);
    $array = json_decode($json, 1);
    foreach ($array as $catId => $catVals) {
        $result[$catId]['column1'] = $catVals;
    }

    $result = [
        'values' => $result
    ];

    switch ($context) {
        case 'web':
            $result['column1'] = 'Товар';
            $result['column2'] = 'Применение';
            $result['column3'] = 'Толщина';
            break;
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
