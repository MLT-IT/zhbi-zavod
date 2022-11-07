<?php

$cacheName = 'assortItems';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    switch ($modx->resource->context_key) {
        case 'kirpich-m':
            $result = [
                'Строительный кирпич' => [
                    'id' => 'assort-kirpich',
                    'items' => [
                        'Рядовой' => [
                            'uri' => '/stroitelnye/',
                            'img' => '/assets/template/img/assort/kirpich.jpg',
                            'links' => [
                                'Полнотелый' => '/stroitelnye/?msoption|voidness=%D0%9F%D0%BE%D0%BB%D0%BD%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                                'Пустотелый' => '/stroitelnye/?msoption|voidness=%D0%9F%D1%83%D1%81%D1%82%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                            ]
                        ],
                        'Крупноформатные блоки' => [
                            'uri' => '/keramobloki/',
                            'img' => '/assets/template/img/assort/kirpich-m/krupnoformatnye-bloki.jpg',
                            'links' => [
                                'Керамоблоки ЛСР' => '/keramobloki/?msoption|proizvoditel=%D0%9B%D0%A1%D0%A0',
                                'Керамоблоки Porotherm' => '/keramobloki/?msoption|proizvoditel=Porotherm',
                                'Керамоблоки Wienerberger' => '/keramobloki/?msoption|proizvoditel=Wienerberger',
                                'Керамоблоки ВКЗ' => '/keramobloki/?msoption|proizvoditel=%D0%92%D0%9A%D0%97',
                                'Керамоблоки BRAER' => '/keramobloki/?msoption|proizvoditel=BRAER',
                                'Керамоблоки Гжельск' => '/keramobloki/?msoption|proizvoditel=%D0%93%D0%B6%D0%B5%D0%BB%D1%8C%D1%81%D0%BA%D0%B8%D0%B9%20%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87%D0%BD%D1%8B%D0%B9%20%D0%B7%D0%B0%D0%B2%D0%BE%D0%B4',
                                'Керамоблоки Forati' => '/keramobloki/?msoption|proizvoditel=Forati',
                            ]
                        ],
                    ]
                ],
                'Облицовочный кирпич' => [
                    'id' => 'assort-brickwall',
                    'items' => [
                        'Пустотелый' => [
                            'uri' => '/oblicovochnye/?msoption|voidness=%D0%9F%D1%83%D1%81%D1%82%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                            'img' => '/assets/template/img/assort/kirpich-m/pustotelyj.jpg',
                            'links' => [
                                'Клинкерный' => '/oblicovochnye/?msoption|tip=%D0%9A%D0%BB%D0%B8%D0%BD%D0%BA%D0%B5%D1%80%D0%BD%D1%8B%D0%B9%20%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87&msoption|voidness=%D0%9F%D1%83%D1%81%D1%82%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                                'Керамический' => '/oblicovochnye/?msoption|tip=%D0%9A%D0%B5%D1%80%D0%B0%D0%BC%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9%20%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87&msoption|voidness=%D0%9F%D1%83%D1%81%D1%82%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                            ]
                        ],
                        'Полнотелый' => [
                            'uri' => '/oblicovochnye/?msoption|voidness=%D0%9F%D0%BE%D0%BB%D0%BD%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                            'img' => '/assets/template/img/assort/kirpich-m/polnotelyj.jpg',
                            'links' => [
                                'Клинкерный' => '/oblicovochnye/?msoption|tip=%D0%9A%D0%BB%D0%B8%D0%BD%D0%BA%D0%B5%D1%80%D0%BD%D1%8B%D0%B9%20%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87&msoption|voidness=%D0%9F%D0%BE%D0%BB%D0%BD%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                                'Керамический' => '/oblicovochnye/?msoption|tip=%D0%9A%D0%B5%D1%80%D0%B0%D0%BC%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9%20%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87&msoption|voidness=%D0%9F%D0%BE%D0%BB%D0%BD%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                                'Ручной формовки' => '/oblicovochnye/?msoption|tip=%D0%9A%D0%B8%D1%80%D0%BF%D0%B8%D1%87%20%D1%80%D1%83%D1%87%D0%BD%D0%BE%D0%B9%20%D1%84%D0%BE%D1%80%D0%BC%D0%BE%D0%B2%D0%BA%D0%B8&msoption|voidness=%D0%9F%D0%BE%D0%BB%D0%BD%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                            ]
                        ],
                    ]
                ],
                'Фасадная плитка' => [
                    'id' => 'assort-plitka',
                    'items' => [
                        'Фасадная плитка' => [
                            'uri' => '/fasadnaya-plitka/',
                            'img' => '/assets/template/img/assort/kirpich-m/fasadnaya-plitka.jpg',
                            'links' => [
                                'Керамогранит' => '/keramogranit/',
                                'Плитка для навесных фасадов' => '/plitka-dlya-navesnyh-fasadov/'
                            ]
                        ],
                        'Плитка под кирпич' => [
                            'uri' => '/plitka-pod-kirpich/',
                            'img' => '/assets/template/img/assort/kirpich-m/plitka-pod-kirpich.jpg',
                            'links' => [
                                'Клинкерная плитка' => '/klinkernaya-plitka/',
                                'Керамическая плитка' => '/keramicheskaya-plitka/'
                            ]
                        ],
                    ]
                ],
                'Искусственный и натуральный камень' => [
                    'id' => 'assort-kamen',
                    'items' => [
                        'Декоративный камень для внутренней отделки' => [
                            'uri' => '/dekorativnyij-kamen-dlya-vnutrennej-otdelki/',
                            'img' => '/assets/template/img/assort/kirpich-m/dek-kamen-vn-otdelka.jpg',
                            'links' => [
                                'Redstone' => '/dekorativnyij-kamen-dlya-vnutrennej-otdelki/?msoption|proizvoditel=REDSTONE',
                                'White Hills' => '/dekorativnyij-kamen-dlya-vnutrennej-otdelki/?msoption|proizvoditel=White%20Hills',
                                'БАЛТФАСАД' => '/dekorativnyij-kamen-dlya-vnutrennej-otdelki/?msoption|proizvoditel=%D0%91%D0%90%D0%9B%D0%A2%D0%A4%D0%90%D0%A1%D0%90%D0%94',
                                'Идеальный камень' => '/dekorativnyij-kamen-dlya-vnutrennej-otdelki/?msoption|proizvoditel=%D0%98%D0%B4%D0%B5%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9%20%D0%9A%D0%B0%D0%BC%D0%B5%D0%BD%D1%8C'
                            ]
                        ],
                        'Искусственный камень для фасада' => [
                            'uri' => '/iskusstvennyj-kamen-dlya-fasada/',
                            'img' => '/assets/template/img/assort/kirpich-m/is-kamen-fasad.jpg',
                            'links' => [
                                'White Hills' => '/iskusstvennyj-kamen-dlya-fasada/?msoption|proizvoditel=White%20Hills',
                                'БАЛТФАСАД' => '/iskusstvennyj-kamen-dlya-fasada/?msoption|proizvoditel=%D0%91%D0%90%D0%9B%D0%A2%D0%A4%D0%90%D0%A1%D0%90%D0%94'
                            ]
                        ],
                    ]
                ],
                'Фасадный декор' => [
                    'id' => 'assort-dekor',
                    'items' => [
                        'Архитектурные элементы фасада' => [
                            'uri' => '/arhitekturnye-elementy-fasada/',
                            'img' => '/assets/template/img/assort/dekor.jpg',
                            'links' => [
                            ]
                        ],
                        'Клинкерные подоконники и водоотливы' => [
                            'uri' => '/arhitekturnye-elementy-fasada/',
                            'img' => '/assets/template/img/assort/kirpich-m/klinkernye-podokonniki-i-vodootlivy.jpg',
                            'links' => [
                            ]
                        ],
                    ]
                ],
                'Печной кирпич' => [
                    'id' => 'assort-stoneoven',
                    'items' => [
                        'Шамотный кирпич' => [
                            'uri' => '/shamotnye/',
                            'img' => '/assets/template/img/assort/kirpich-m/shamotniy.jpg',
                            'links' => [
                            ]
                        ],
                        'Керамический кирпич для печей' => [
                            'uri' => '/keramicheskie-kirpichi-dlya-pechej/',
                            'img' => '/assets/template/img/assort/kirpich-m/keramich-kirpich-dlya-pechej.jpg',
                            'links' => [
                            ]
                        ]
                    ]
                ],
                'Кладочные смеси' => [
                    'id' => 'assort-smesi',
                    'items' => [
                        'Кладочные смеси' => [
                            'uri' => '/kladochnye-smesi/',
                            'img' => '/assets/template/img/assort/smesi.jpg',
                            'links' => [
                                'Цветные кладочные растворы' => '/cvetnye-kladochnye-rastvory/',
                                'Нецветные смеси' => '/necvetnye-smesi/',
                                'Огнеупорные смеси' => '/ogneupornye-smesi/',
                                'Легкие, теплые растворы' => '/legkie-teplye-rastvory/',
                                'Клей для газобетона' => '/klej-dlya-gazobetona/'
                            ]
                        ]
                    ]
                ],
                'Брусчатка' => [
                    'id' => 'assort-paving',
                    'items' => [
                        'Тротуарный клинкер' => [
                            'uri' => '/klinkernaya-bruschatka/',
                            'img' => '/assets/template/img/assort/kirpich-m/trotyarniy-kliner.jpg',
                            'links' => []
                        ],
                    ]
                ],
            ];
            break;

        case 'krovlya':
            $result = [
                'Ондулин' => [
                    'id' => 'assort-ondulin',
                    'items' => [
                        'Черепица Ондулин' => [
                            'uri' => '/ondulin/',
                            'img' => '/assets/template/img/assort/krovlya/ondulin-cerepica.jpg',
                            'links' => [
                            ]
                        ],
                        'Ондулин Смарт' => [
                            'uri' => '/cherepica-ondulin-smart/',
                            'img' => '/assets/template/img/assort/krovlya/ondulin-smart.jpg',
                            'links' => [
                            ]
                        ]
                    ]
                ],
                'Металлочерепица' => [
                    'id' => 'assort-cerepica',
                    'items' => [
                        'Металлочерепица Grand Line' => [
                            'uri' => '/metallocherepitsya-grand-line/',
                            'img' => '/assets/template/img/assort/krovlya/grandline.jpg',
                            'links' => [
                                'Classic' => '/metallocherepitsya-grand-line-classic/',
                                'Kamea' => '/metallocherepitsya-grand-line-kamea/',
                                'Kredo' => '/metallocherepitsya-grand-line-kredo/',
                                'Kvinta plus' => '/metallocherepitsya-grand-line-kvinta-plus/',
                                'Kvinta Uno' => '/metallocherepitsya-grand-line-kvinta-uno/',
                                'Modern' => '/metallocherepitsya-grand-line-modern/',
                                'Монтеррей' => '/prodazha-metallocherepicy-monterrej-grand-line/',
                            ]
                        ],
                        'Металлочерепица Металл-Профиль' => [
                            'uri' => '/metallocherepica-metall-profil/',
                            'img' => '/assets/template/img/assort/krovlya/metallprofil.jpg',
                            'links' => [
                                'Ламонтерра' => '/metallocherepica-lamonterra/',
                                'Ламонтерра X' => '/metallocherepica-lamonterra-x/',
                                'Ламонтерра XL' => '/metallocherepica-lamonterra-xl/',
                                'Монтекристо' => '/metallocherepica-montekristo/',
                                'Монтерроса' => '/metallocherepica-monterrosa/',
                                'Трамонтана' => '/metallocherepica-tramontana/',
                            ]
                        ]
                    ]
                ],
                'Гибкая черепица' => [
                    'id' => 'assort-bit-krovlya',
                    'items' => [
                        'Мягкая кровля' => [
                            'uri' => '/myagkaya-cherepica/',
                            'img' => '/assets/template/img/assort/krovlya/gibkaya-cerepica.jpg',
                            'links' => [
                                'CertainTeed' => '/myagkaya-cherepica-certainteed/',
                                'Docke' => '/docke-pie-gibkaya-cherepica/',
                                'Катепал' => '/myagkaya-cherepica-katepal/',
                                'Икопал' => '/myagkaya-cherepica-icopal/',
                                'Tegola' => '/myagkaya-cherepica-tegola/',
                                'Технониколь Шинглас' => '/myagkaya-cherepica-tehnonikol-shinglas/',
                            ]
                        ],
                    ]
                ],
                'Рулонная кровля' => [
                    'id' => 'assort-rulon-krovlya',
                    'items' => [
                        'Наплавляемая кровля' => [
                            'uri' => '/rulonnaya-krovlya-tehnonikol/',
                            'img' => '/assets/template/img/assort/rulonnayakrovlya.jpg',
                            'links' => [
                            ]
                        ],
                        'ПВХ мембраны' => [
                            'uri' => '/pvh-membrany/',
                            'img' => '/assets/template/img/assort/krovlya/pvh-membrany.jpg',
                            'links' => [
                            ]
                        ]
                    ]
                ],
                'ЦПЧ и натуральная черепица' => [
                    'id' => 'assort-natur-cerepica',
                    'items' => [
                        'Цементно-песчаная черепица' => [
                            'uri' => '/cementno-peschanaya-cherepica/',
                            'img' => '/assets/template/img/assort/krovlya/cementpesccerepica.jpg',
                            'links' => [
                                'Цементно-песчаная черепица Kriastak' => '/cementno-peschanaya-cherepica-kriastak/',
                                'Цементно-песчаная черепица Braas' => '/cementno-peschanaya-cherepica-braas/',
                                'Комплектующие Braas' => '/komplektuyushchie-braas/',
                            ]
                        ],
                        'Керамическая черепица' => [
                            'uri' => '/keramicheskaya-cherepica/',
                            'img' => '/assets/template/img/assort/krovlya/kermaicheskaya-cerepica.jpg',
                            'links' => [
                                'Керамическая черепица Braas' => '/keramicheskaya-cherepica-braas/',
                            ]
                        ],
                    ]
                ],
                'Фальцевая кровля' => [
                    'id' => 'assort-falc-krovlya',
                    'items' => [
                        'Клик-фальц' => [
                            'uri' => '/falcevaya-krovlya/?msoption|collection=%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86~%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20Line~%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20mini~%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20Pro~%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20Pro%20Gofr~%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20Pro%20Line/',
                            'img' => '/assets/template/img/assort/krovlya/klikfalc.jpg',
                            'links' => [
                            ]
                        ],
                        'Фальц двойной стоячий' => [
                            'uri' => '/falcevaya-krovlya/?msoption|collection=%D0%A4%D0%B0%D0%BB%D1%8C%D1%86%20%D0%B4%D0%B2%D0%BE%D0%B9%D0%BD%D0%BE%D0%B9%20%D1%81%D1%82%D0%BE%D1%8F%D1%87%D0%B8%D0%B9~%D0%A4%D0%B0%D0%BB%D1%8C%D1%86%20%D0%B4%D0%B2%D0%BE%D0%B9%D0%BD%D0%BE%D0%B9%20%D1%81%D1%82%D0%BE%D1%8F%D1%87%D0%B8%D0%B9%20Line/',
                            'img' => '/assets/template/img/assort/krovlya/falcevaya-krovlya.jpg',
                            'links' => [
                            ]
                        ],
                    ]
                ],
                'Профнастил и штакетник' => [
                    'id' => 'assort-proflist',
                    'items' => [
                        'Профилированный лист для кровли' => [
                            'uri' => '/proflist-dlya-krovli/',
                            'img' => '/assets/template/img/assort/krovlya/profnastil.jpg',
                            'links' => [
                                'Профнастил для кровли Grand Line' => '/proflist-grand-line/',
                                'Профнастил для кровли Металл-Профиль' => '/proflist-metall-profil/',
                            ]
                        ],
                        'Профилированный лист для забора' => [
                            'uri' => '/profilirovannyy-list-dlya-zabora/',
                            'img' => '/assets/template/img/assort/krovlya/profnastil-dlya-zabora.jpg',
                            'links' => [
                                'Профнастил для забора Grand Line' => '/profilirovannyy-list-dlya-zabora-grand-layn/',
                                'Профнастил для забора Металл-Профиль' => '/profilirovannyj-list-dlya-zabora-metall-profil/',
                            ]
                        ],
                        'Штакетник' => [
                            'uri' => '/shtaketnik/',
                            'img' => '/assets/template/img/assort/krovlya/shtaketnik.jpg',
                            'links' => [
                                'Штакетник Grand Line' => '/shtaketnik-grand-line/',
                                'Штакетник Металл-Профиль' => '/shtaketnik-metall-profil/',
                            ]
                        ],
                    ]
                ],
                'Водосточные системы' => [
                    'id' => 'assort-vodostoch',
                    'items' => [
                        'ПВХ водосточные системы' => [
                            'uri' => '/vodostochnaya-sistema/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA',
                            'img' => '/assets/template/img/assort/krovlya/plastikovye-truby.jpg',
                            'links' => [
                                'Braas' => '/vodostochnaya-sistema/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA&msoption|proizvoditel=Braas',
                                'Docke' => '/vodostochnaya-sistema/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA&msoption|proizvoditel=Docke',
                                'Grand Line' => '/vodostochnaya-sistema/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA&msoption|proizvoditel=Grand%20Line',
                                'Альта-Профиль' => '/vodostochnaya-sistema/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA&msoption|proizvoditel=%D0%90%D0%BB%D1%8C%D1%82%D0%B0-%D0%9F%D1%80%D0%BE%D1%84%D0%B8%D0%BB%D1%8C',
                            ]
                        ],
                        'Металлические водосточные системы' => [
                            'uri' => '/vodostochnaya-sistema/?msoption|material=%D0%9C%D0%B5%D1%82%D0%B0%D0%BB%D0%BB',
                            'img' => '/assets/template/img/assort/krovlya/vodostochnayasistema.jpg',
                            'links' => [
                                'Aquasystem' => '/vodostochnaya-sistema/?msoption|material=%D0%9C%D0%B5%D1%82%D0%B0%D0%BB%D0%BB&msoption|proizvoditel=Aquasystem',
                                'Braas' => '/vodostochnaya-sistema/?msoption|material=%D0%9C%D0%B5%D1%82%D0%B0%D0%BB%D0%BB&msoption|proizvoditel=Braas',
                                'Docke' => '/vodostochnaya-sistema/?msoption|material=%D0%9C%D0%B5%D1%82%D0%B0%D0%BB%D0%BB&msoption|proizvoditel=Docke',
                                'Grand Line' => '/vodostochnaya-sistema/?msoption|material=%D0%9C%D0%B5%D1%82%D0%B0%D0%BB%D0%BB&msoption|proizvoditel=Grand%20Line',
                                'Альта-Профиль' => '/vodostochnaya-sistema/?msoption|material=%D0%9C%D0%B5%D1%82%D0%B0%D0%BB%D0%BB&msoption|proizvoditel=%D0%90%D0%BB%D1%8C%D1%82%D0%B0-%D0%9F%D1%80%D0%BE%D1%84%D0%B8%D0%BB%D1%8C'
                            ]
                        ],
                    ]
                ],
                'Софиты' => [
                    'id' => 'assort-sofity',
                    'items' => [
                        'ПВХ софиты' => [
                            'uri' => '/sofity-v-sankt-peterburge/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA',
                            'img' => '/assets/template/img/assort/krovlya/sofity-plastikovye.jpg',
                            'links' => [
                            ]
                        ],
                        'Металлические софиты' => [
                            'uri' => '/sofity-v-sankt-peterburge/?msoption|material=%D0%9C%D0%B5%D1%82%D0%B0%D0%BB%D0%BB',
                            'img' => '/assets/template/img/assort/krovlya/sofity-metallicheskie.jpg',
                            'links' => [
                            ]
                        ],
                    ]
                ],
                'Сопутствующие товары' => [
                    'id' => 'assort-soputtovary',
                    'items' => [
                        'Комплектующие для кровли' => [
                            'uri' => '/komplektuyushhie/',
                            'img' => '/assets/images/products/65536/small/3df873b3018cca70330c984108f948af.jpg',
                            'links' => [
                                'Дымоходы' => '/dymohody-v-sankt-peterburge/',
                                'Корректор для ремонта царапин' => '/korrektor-dlya-remonta-carapin-v-sankt-peterburge/',
                                'Аэроэлементы и вентиляционные ленты' => '/aehroehlementy-i-ventilyacionnye-lenty-v-sankt-peterburge/',
                                'Брусок' => '/brusok-v-sankt-peterburge/',
                                'Лента примыкания' => '/lenta-primykaniya-v-sankt-peterburge/',
                                'Плита OSB' => '/plita-osb/',
                                'Строительный крепёж' => '/stroitelnyy-krepyozh-v-sankt-peterburge/',
                                'Уплотнитель' => '/uplotnitel-v-sankt-peterburge/',
                                'Шумоизолирующая лента под фальц' => '/shumoizoliruyushchaya-lenta-pod-falc-v-sankt-peterburge/',
                                'Отмотка' => '/otmotka-v-sankt-peterburge/',
                                'Плоский лист' => '/ploskiy-list-v-sankt-peterburge/',
                            ]
                        ],
                        'Саморезы' => [
                            'uri' => '/samorezyi-grand-line-v-sankt-peterburge/',
                            'img' => '/assets/images/products/58387/small/1e171498dc0619851e4d8d45ed3d9711.jpg',
                            'links' => [
                            ]
                        ],
                        'Доборные элементы' => [
                            'uri' => '/metallicheskie-dobornye-ehlementy-v-sankt-peterburge/',
                            'img' => '/assets/images/products/58386/small/f9b858e208bab99b98588745a0f1a670.jpg',
                            'links' => [
                            ]
                        ],
                        'Элементы безопасности кровли' => [
                            'uri' => '/ehlementy-bezopasnosti-krovli-v-sankt-peterburge/',
                            'img' => '/assets/images/products/66075/small/270a21edc6d1c19e822252c295a16a70.jpg',
                            'links' => [
                            ]
                        ],
                        'Кожух на трубу' => [
                            'uri' => '/kozhuh-na-trubu-v-sankt-peterburge/',
                            'img' => '/assets/images/products/59982/small/71b31bd229d16cfb1d2055fcc54e96f5.jpg',
                            'links' => [
                            ]
                        ],
                        'Дымники (флюгарка)' => [
                            'uri' => '/dyimniki-flyugarka-v-sankt-peterburge/',
                            'img' => '/assets/images/products/58927/small/1f5dbb9457863b3a49ebd41a933c31e3.jpg',
                            'links' => [
                            ]
                        ],
                        'Софиты' => [
                            'uri' => '/sofity-v-sankt-peterburge/',
                            'img' => '/assets/images/products/58479/small/e5d77003d8487e484bb300f40c300d19.jpg',
                            'links' => [
                            ]
                        ],
                        'Окна' => [
                            'uri' => '/okna-v-sankt-peterburge/',
                            'img' => '/assets/images/products/58755/small/0bd368ace23ae89283137faabb0d6f5a.jpg',
                            'links' => [
                            ]
                        ],
                        'Антисептик и огнебиозащита древесины' => [
                            'uri' => '/antiseptik-i-ognebiozashhita-drevesinyi/',
                            'img' => '/assets/images/products/58821/small/117a70a48d0bdf186ee2f00de68dca5a.jpg',
                            'links' => [
                            ]
                        ],
                        'Входные двери' => [
                            'uri' => '/vhodnye-dveri-v-sankt-peterburge/',
                            'img' => '/assets/images/products/58837/small/4f0c3cad6b68f81ca2ba2ad3e8c6bf4a.jpg',
                            'links' => [
                            ]
                        ],
                        'Лестницы чердачные' => [
                            'uri' => '/lestnicy-cherdachnye-v-sankt-peterburge/',
                            'img' => '/assets/images/products/61660/small/0181db1486eac483deae4b5d60ec1e49.jpg',
                            'links' => [
                                'Деревянные лестницы' => '/derevyannye-lestnicy-fakro/',
                                'Металлические лестницы' => '/metallicheskie-lestnicy-fakro/',
                                'Лестницы Termo' => '/lestnicy-termo-fakro/',
                                'Ножничные лестницы' => '/nozhnichnye-lestnicy-fakro/',
                                'Аксессуары' => '/aksessuary-fakro/',
                                'Монтажный комплект' => '/montazhnyy-komplekt-fakro/'
                            ]
                        ],
                        'Козырьки Krovent из поликарбоната' => [
                            'uri' => '/kozyrki-iz-polikarbonata-krovent/',
                            'img' => '/assets/template/tpl-imgs/krovent.jpg',
                            'links' => [
                            ]
                        ],
                        'Флюгеры DUCK & DOG' => [
                            'uri' => '/flyugery-duck-dog/',
                            'img' => '/assets/template/tpl-imgs/DuckDog.png',
                            'links' => [
                            ]
                        ]
                    ]
                ],
            ];
            break;
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
