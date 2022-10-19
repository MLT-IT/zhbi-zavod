<?php

$cacheName = 'assortItems';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    switch ($modx->resource->context_key) {
        case 'kirpich-m':
            /*
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
                                'Плитка для печей и каминов' => '/plitka-dlya-pechej-i-kaminov/',
                                'Клинкерная брусчатка' => '/klinkernaya-bruschatka/'
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
            */

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
                    'id' => 'assort-plitka',
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
                    'id' => 'assort-kamen',
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
                    'id' => 'assort-dekor',
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
                    'id' => 'assort-dekor2',
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
                    'id' => 'assort-dekor3',
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
                    'id' => 'assort-dekor5',
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
