<?php

$cacheName = 'assortItems';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    switch ($modx->resource->context_key) {
        case 'kirpich-m':
            $result = [
                'Кирпич' => [
                    'id' => 'assort-kirpich',
                    'items' => [
                        'Кирпич' => [
                            'uri' => '',
                            'img' => '/assets/template/img/assort/kirpich.jpg',
                            'links' => [
                                'Строительный кирпич' => '/stroitelnye/',
                                'Керамический кирпич' => '/keramicheskie/',
                                'Поризованные камни' => '/porizovannye/',
                                'Силикатный кирпич' => '/silikatnyj/',
                                'Кирпичи ЛСР' => '/lsr/',
                            ]
                        ],
                        'Облицовочные кирпичи' => [
                            'uri' => '/oblicovochnye/',
                            'img' => '/assets/template/img/assort/oblic-kirpich.jpg',
                            'links' => [
                                'Керамический кирпич' => '/keramicheskie/',
                                'Клинкерный кирпич' => '/klinkernye/',
                                'Кирпич ручной формовки' => '/ruchnoj-formovki/'
                            ]
                        ],
                        'Кирпич для печи' => [
                            'uri' => '/dlya-pechi/',
                            'img' => '/assets/template/img/assort/pechnoy.jpg',
                            'links' => [
                                'Шамотный кирпич' => '/shamotnye/',
                                'Керамический кирпич для печей' => '/keramicheskie-kirpichi-dlya-pechej/'
                            ]
                        ]
                    ]
                ],
                'Фасадная плитка, отделка' => [
                    'id' => 'assort-plitka',
                    'items' => [
                        'Фасадная плитка, отделка' => [
                            'uri' => '',
                            'img' => '/assets/template/img/assort/fasadnaya-plitka-otdelka.jpg',
                            'links' => [
                                'Керамогранит' => '/keramogranit/',
                                'Плитка для навесных фасадов' => '/fasadnaya-plitka/',
                                'Плитка для печей и каминов' => '/plitka-dlya-pechej-i-kaminov/'
                            ]
                        ],
                        'Плитка под кирпич' => [
                            'uri' => '/plitka-pod-kirpich/',
                            'img' => '/assets/template/img/assort/plitka.jpg',
                            'links' => [
                                'Клинкерная плитка' => '/klinkernaya-plitka/',
                                'Декоративный кирпич' => '/dekorativnyj-kirpich/',
                                'Керамическая плитка' => '/keramicheskaya-plitka/'
                            ]
                        ],
                    ]
                ],
                'Искусственный и натуральный камень' => [
                    'id' => 'assort-kamen',
                    'items' => [
                        'Искусственный и натуральный камень' => [
                            'uri' => '',
                            'img' => '/assets/template/img/assort/kamen.jpg',
                            'links' => [
                                'Искусственный камень для фасада' => '/iskusstvennyj-kamen-dlya-fasada/',
                                'Декоративный камень для внутренней отделки' => '/dekorativnyij-kamen-dlya-vnutrennej-otdelki/'
                            ]
                        ]
                    ]
                ],
                'Фасадный декор' => [
                    'id' => 'assort-dekor',
                    'items' => [
                        'Фасадный декор' => [
                            'uri' => '/fasadnyj-dekor/',
                            'img' => '/assets/template/img/assort/dekor.jpg',
                            'links' => [
                                'Архитектурные элементы фасада' => '/arhitekturnye-elementy-fasada/',
                                'Клинкерные подоконники и водоотливы' => '/klinkernye-podokonniki-i-vodootlivy/'
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
            ];
            break;

        case 'krovlya':
            $result = [
                'Черепица' => [
                    'id' => 'assort-cerepica',
                    'items' => [
                        'Ондулин' => [
                            'uri' => '/ondulin/',
                            'img' => '/assets/template/img/assort/ondulin.jpg',
                            'links' => [
                                'Черепица Ондулин' => '/cherepica-ondulin/',
                                'Ондутисс' => '/ondutiss/',
                                'Аксессуары Ондулин' => '/komplektuyushhie-dlya-ondulina/',
                            ]
                        ],
                        'Металлочерепица' => [
                            'uri' => '/metallocherepica/',
                            'img' => '/assets/template/img/assort/metallocerepica.jpg',
                            'links' => [
                                'Металлочерепица Grand Line' => '/metallocherepitsya-grand-line/',
                                'Металлочерепица Металл-Профиль' => '/metallocherepica-metall-profil/',
                            ]
                        ],
                        'Гибкая черепица' => [
                            'uri' => '/myagkaya-cherepica/',
                            'img' => '/assets/template/img/assort/gibkaya-cerepica.jpg',
                            'links' => [
                                'CertainTeed' => '/myagkaya-cherepica-certainteed/',
                                'Docke' => '/docke-pie-gibkaya-cherepica/',
                                'Катепал' => '/myagkaya-cherepica-katepal/',
                                'Икопал' => '/myagkaya-cherepica-icopal/',
                                'Tegola' => '/myagkaya-cherepica-tegola/',
                                'Технониколь Шинглас' => '/myagkaya-cherepica-tehnonikol-shinglas/',
                            ]
                        ]
                    ]
                ],
                'Натуральная черепица' => [
                    'id' => 'assort-natur-cerepica',
                    'items' => [
                        'Цементно-песчаная черепица' => [
                            'uri' => '/cementno-peschanaya-cherepica/',
                            'img' => '/assets/template/img/assort/cementpesccerepica.jpg',
                            'links' => [
                                'Цементно-песчаная черепица Kriastak' => '/cementno-peschanaya-cherepica-kriastak/',
                                'Цементно-песчаная черепица Braas' => '/cementno-peschanaya-cherepica-braas/',
                                'Комплектующие Braas' => '/komplektuyushchie-braas/',
                            ]
                        ],
                        'Керамическая черепица' => [
                            'uri' => '/keramicheskaya-cherepica/',
                            'img' => '/assets/template/img/assort/kermaicheskaya-cerepica.jpg',
                            'links' => [
                                'Керамическая черепица Braas' => '/keramicheskaya-cherepica-braas/',
                            ]
                        ],
                    ]
                ],
                'Кровельное покрытие' => [
                    'id' => 'assort-krovelnoepokrytie',
                    'items' => [
                        'Фальцевая кровля' => [
                            'uri' => '/falcevaya-krovlya/',
                            'img' => '/assets/template/img/assort/falcevaya-krovlya.jpg',
                            'links' => [
                                'Фальцевая кровля Гранд Лайн' => '/falcevaya-krovlya-grand-line/',
                            ]
                        ],
                        'Рулонная кровля' => [
                            'uri' => '/rulonnaya-krovlya/',
                            'img' => '/assets/template/img/assort/rulonnayakrovlya.jpg',
                            'links' => [
                                'Наплавляемая кровля' => '/rulonnaya-krovlya-tehnonikol/',
                                'ПВХ мембраны' => '/pvh-membrany/',
                            ]
                        ]
                    ]
                ],
                'Профнастил' => [
                    'id' => 'assort-proflist',
                    'items' => [
                        'Профилированный лист' => [
                            'uri' => '/proflist/',
                            'img' => '/assets/template/img/assort/profnastil.jpg',
                            'links' => [
                                'Профилированный лист Гранд Лайн' => '/proflist-grand-line/',
                                'Профилированный лист Металл профиль' => '/proflist-metall-profil/',
                            ]
                        ],
                    ]
                ],
                'Водосточная система' => [
                    'id' => 'assort-vodostoch',
                    'items' => [
                        'Водосточная система' => [
                            'uri' => '/vodostochnaya-sistema/',
                            'img' => '/assets/template/img/assort/vodostochnayasistema.jpg',
                            'links' => [
                                'Аквасистем' => '/vodostochnaya-sistema-aquasystem/',
                                'Docke' => '/vodostochnaya-sistema-docke/',
                                'Braas' => '/vodostochnaya-sistema-braas/',
                                'Альта-Профиль' => '/vodostochnaya-sistema-alta-profil/',
                                'Гранд-Лайн' => '/vodostochnaya-sistema-grand-line/',
                            ]
                        ],
                    ]
                ],
                'Сопутствующие товары' => [
                    'id' => 'assort-soputtovary',
                    'items' => [
                        'Сопутствующие товары' => [
                            'img' => '/assets/template/img/assort/soputtovary.jpg',
                            'links' => [
                                'Доборные элементы для кровли' => '/dobornye-elementy/',
                                'Комплектующие' => '/komplektuyushhie/',
                            ]
                        ],
                    ]
                ],
            ];
            break;
    }

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
