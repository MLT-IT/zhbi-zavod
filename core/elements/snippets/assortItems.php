<?php

$cacheName = 'assortItems';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    switch ($modx->resource->context_key) {
        case 'kirpich-m':
            $result = [
                'Строительный (рядовой) кирпич' => [
                    'id' => 'assort-kirpich',
                    'items' => [
                        'Рядовой кирпич' => [
                            'uri' => '/stroitelnye/',
                            'img' => '/assets/template/img/assort/kirpich.jpg',
                            'links' => [
                                'Полнотелый' => '/stroitelnye/?msoption|voidness=%D0%9F%D0%BE%D0%BB%D0%BD%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                                'Пустотелый' => '/stroitelnye/?msoption|voidness=%D0%9F%D1%83%D1%81%D1%82%D0%BE%D1%82%D0%B5%D0%BB%D1%8B%D0%B9',
                            ]
                        ],
                    ]
                ],
                'Облицовочный (лицевой) кирпич' => [
                    'id' => 'assort-brickwall',
                    'items' => [
                        'Облицовочные кирпичи' => [
                            'uri' => '/oblicovochnye/',
                            'fullwidth' => true,
                        ],
                        'Керамический лицевой кирпич' => [
                            'uri' => '/keramicheskie/',
                            'img' => '/assets/template/img/assort/kirpich-m/licevoj-kirpich-keramicheskij.jpg',
                        ],
                        'Клинкерный лицевой кирпич' => [
                            'uri' => '/klinkernye/',
                            'img' => '/assets/template/img/assort/kirpich-m/klinkernyj-licevoj-kirpich.jpg',
                        ],
                        'Кирпич ручной формовки' => [
                            'uri' => '/ruchnoj-formovki',
                            'img' => '/assets/template/img/assort/kirpich-m/oblichovochnye-kirpichi-ruchnoj-formovki.jpg',
                        ],
                    ]
                ],
                'Керамический широкоформатный блок' => [
                    'id' => 'assort-brick',
                    'items' => [
                        'Крупноформатные блоки' => [
                            'uri' => '/keramobloki/',
                            'img' => '/assets/template/img/assort/kirpich-m/krupnoformatnye-bloki.jpg',
                            'links' => [
                                'Керамоблоки ЛСР' => '/keramobloki/?msoption|proizvoditel=%D0%9B%D0%A1%D0%A0',
                                'Радошковичи (Ceglar)' => '/keramobloki/?msoption|proizvoditel=Радошковичи%20(Ceglar)',
                                'Керамоблоки Porotherm (Wienerberger)' => '/keramobloki/?msoption|proizvoditel=Porotherm%20(Wienerberger)',
                                'Керамоблоки ВКЗ' => '/keramobloki/?msoption|proizvoditel=%D0%92%D0%9A%D0%97',
                                'Керамоблоки BRAER' => '/keramobloki/?msoption|proizvoditel=BRAER',
                                'Керамоблоки Гжельск' => '/keramobloki/?msoption|proizvoditel=%D0%93%D0%B6%D0%B5%D0%BB%D1%8C%D1%81%D0%BA%D0%B8%D0%B9%20%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87%D0%BD%D1%8B%D0%B9%20%D0%B7%D0%B0%D0%B2%D0%BE%D0%B4',
                            ]
                        ],
                    ]
                ],
                'Фасадная плитка, камень, декор' => [
                    'id' => 'assort-plitka',
                    'items' => [
                        'Фасадная плитка' => [
                            'uri' => '/fasadnaya-plitka/',
                            'fullwidth' => true,
                        ],
                        'Плитка под кирпич' => [
                            'uri' => '/plitka-pod-kirpich/',
                            'img' => '/assets/template/img/assort/kirpich-m/plitka-pod-kirpich.jpg',
                            'links' => [
                                'Клинкерная плитка' => '/klinkernaya-plitka/',
                                'Керамическая плитка' => '/keramicheskaya-plitka/',
                                'Декоративный кирпич' => '/dekorativnyj-kirpich/'
                            ]
                        ],
                        'Плитка для печей и каминов' => [
                            'uri' => '/plitka-dlya-pechej-i-kaminov/',
                            'img' => '/assets/template/img/assort/kirpich-m/plitka-dlya-pechej-i-kaminov.jpg',
                        ],
                        'Искусственный камень для фасада' => [
                            'uri' => '/iskusstvennyj-kamen-dlya-fasada/',
                            'img' => '/assets/template/img/assort/kirpich-m/is-kamen-fasad.jpg',
                        ],
                        'Декоративный камень для внутренней отделки' => [
                            'uri' => '/dekorativnyij-kamen-dlya-vnutrennej-otdelki/',
                            'img' => '/assets/template/img/assort/kirpich-m/dek-kamen-vn-otdelka.jpg',
                        ],
                        'Плитка для навесных фасадов' => [
                            'uri' => '/plitka-dlya-navesnyh-fasadov/',
                            'img' => '/assets/template/img/assort/kirpich-m/plita-dlya-navesnyh-fasadov.jpg',
                        ],
                        'Фасадный декор' => [
                            'uri' => '/fasadnyj-dekor/',
                            'img' => '/assets/template/img/assort/kirpich-m/fasadnyj-dekor.jpg',
                            'links' => [
                                'Архитектурные элементы фасада' => '/arhitekturnye-elementy-fasada/',
                                'Клинкерные подоконники и водоотливы' => '/klinkernye-podokonniki-i-vodootlivy/',
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
                        ],
                        'Керамический кирпич для печей' => [
                            'uri' => '/keramicheskie-kirpichi-dlya-pechej/',
                            'img' => '/assets/template/img/assort/kirpich-m/keramich-kirpich-dlya-pechej.jpg',
                        ]
                    ]
                ],
                'Брусчатка и мощение' => [
                    'id' => 'assort-paving',
                    'items' => [
                        'Брусчатка' => [
                            'uri' => '/bruschatka-i-plitka-dlya-mosheniya/',
                            'img' => '/assets/template/img/assort/kirpich-m/trotyarniy-kliner.jpg',
                            'links' => [
                                'Клинкерная брусчатка' => '/klinkernaya-bruschatka/',
                                'Бетонная тротуарная плитка' => '/betonnaya-trotuarnaya-plitka/'
                            ],
                        ],
                        'Бордюры' => [
                            'uri' => '/bordury/',
                            'img' => '/assets/template/img/assort/kirpich-m/bordury.jpg',
                            'links' => [
                                'Дорожные' => '/bordury-dorozhnyie/',
                                'Тротуарные' => '/bordury-trotuarnyie/',
                                'Садовые' => '/bordury-sadovyie/'
                            ],
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
                                'Клей для газобетона' => '/klej-dlya-gazobetona/',
                                'Цветные кладочные растворы' => '/cvetnye-kladochnye-rastvory/',
                                'Легкие, теплые растворы' => '/legkie-teplye-rastvory/',
                                'Огнеупорные смеси' => '/ogneupornye-smesi/',
                                'Нецветные смеси' => '/necvetnye-smesi/',
                            ]
                        ]
                    ]
                ],
            ];
            break;

        case 'krovlya':
            $result = [
                'Ондулин и шифер' => [
                    'id' => 'assort-ondulin',
                    'items' => [
                        'Ондулин' => [
                            'uri' => '/ondulin/',
                            'fullwidth' => true,
                        ],
                        'Черепица Ондулин' => [
                            'uri' => '/cherepica-ondulin/',
                            'img' => '/assets/template/img/assort/krovlya/ondulin-cerepica.jpg',
                            'links' => [
                            ]
                        ],
                        'Ондулин Смарт' => [
                            'uri' => '/cherepica-ondulin-smart/',
                            'img' => '/assets/template/img/assort/krovlya/ondulin-smart.jpg',
                            'links' => [
                            ]
                        ],
                        'Ондутисс' => [
                            'uri' => '/ondutiss/',
                            'img' => '/assets/template/img/assort/krovlya/ondutis.jpg',
                            'links' => [
                            ]
                        ],
                        'Комплектующие для Ондулина' => [
                            'uri' => '/komplektuyushhie-dlya-ondulina/',
                            'img' => '/assets/template/img/assort/krovlya/komplektujushie-ondulin.jpg',
                            'links' => [
                            ]
                        ],
                        'Шифер' => [
                            'uri' => '/shifer/',
                            'img' => '/assets/template/img/assort/krovlya/shifer.jpg',
                            'links' => [
                            ]
                        ],
                    ]
                ],
                'Металлочерепица' => [
                    'id' => 'assort-cerepica',
                    'items' => [
                        'Металлочерепица' => [
                            'uri' => '/metallocherepica/',
                            'fullwidth' => true,
                        ],
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
                        'Рулонная кровля' => [
                            'uri' => '/rulonnaya-krovlya/',
                            'fullwidth' => true,
                        ],
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
                'Цементно-песчаная черепица' => [
                    'id' => 'assort-natur-cerepica',
                    'items' => [
                        'Цементно-песчаная черепица' => [
                            'uri' => '/cementno-peschanaya-cherepica/',
                            'img' => '/assets/template/img/assort/krovlya/cementpesccerepica.jpg',
                            'links' => [
                                'Цементно-песчаная черепица Kriastak' => '/cementno-peschanaya-cherepica-kriastak/',
                                'Цементно-песчаная черепица Braas' => '/cementno-peschanaya-cherepica-braas/',
                                'Комплектующие для ЦПЧ' => 'komplektuyushhie-dlya-cpch',
                            ]
                        ]
                    ]
                ],
                'Натуральная керамическая черепица' => [
                    'id' => 'assort-ceramocherepica',
                    'items' => [
                        'Керамическая черепица' => [
                            'uri' => '/keramicheskaya-cherepica/',
                            'img' => '/assets/template/img/assort/krovlya/kermaicheskaya-cerepica.jpg',
                            'links' => [
                                'Керамическая черепица Braas' => '/keramicheskaya-cherepica-braas/',
                                'Комплектующие для керамической черепицы Braas' => '/komplektuyushhie-dlya-keramicheskoj-cherepicy-braas/'
                            ]
                        ],
                    ]
                ],
                'Фальцевая кровля' => [
                    'id' => 'assort-falc-krovlya',
                    'items' => [
                        'Фальцевая кровля' => [
                            'uri' => '/falcevaya-krovlya/',
                            'img' => '/assets/template/img/assort/krovlya/falcevaya-krovlya.jpg',
                            'links' => [
                                'Кликфальц' => '/falcevaya-krovlya/?msoption|collection=%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86',
                                'Кликфальц Line' => '/falcevaya-krovlya/?msoption|collection=%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20Line',
                                'Кликфальц mini' => '/falcevaya-krovlya/?msoption|collection=%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20mini',
                                'Кликфальц Pro' => '/falcevaya-krovlya/?msoption|collection=%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20Pro',
                                'Кликфальц Pro Gofr' => '/falcevaya-krovlya/?msoption|collection=%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20Pro%20Gofr',
                                'Кликфальц Pro Line' => '/falcevaya-krovlya/?msoption|collection=%D0%9A%D0%BB%D0%B8%D0%BA%D1%84%D0%B0%D0%BB%D1%8C%D1%86%20Pro%20Line',
                                'Фальц двойной стоячий' => '/falcevaya-krovlya/?msoption|collection=%D0%A4%D0%B0%D0%BB%D1%8C%D1%86%20%D0%B4%D0%B2%D0%BE%D0%B9%D0%BD%D0%BE%D0%B9%20%D1%81%D1%82%D0%BE%D1%8F%D1%87%D0%B8%D0%B9',
                                'Фальц двойной стоячий Line' => '/falcevaya-krovlya/?msoption|collection=%D0%A4%D0%B0%D0%BB%D1%8C%D1%86%20%D0%B4%D0%B2%D0%BE%D0%B9%D0%BD%D0%BE%D0%B9%20%D1%81%D1%82%D0%BE%D1%8F%D1%87%D0%B8%D0%B9%20Line',
                            ]
                        ],
                    ]
                ],
                'Профнастил и штакетник' => [
                    'id' => 'assort-proflist',
                    'items' => [
                        'Профнастил' => [
                            'uri' => '/proflist/',
                            'fullwidth' => true,
                        ],
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
                        'Водостоки' => [
                            'uri' => '/vodostochnaya-sistema/',
                            'fullwidth' => true,
                        ],
                        'ПВХ водосточные системы' => [
                            'uri' => '/pvh-plastikovye-vodostochnye-sistemy/',
                            'img' => '/assets/template/img/assort/krovlya/plastikovye-truby.jpg',
                            'links' => [
                                'Braas' => '/vodostochnaya-sistema/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA&msoption|proizvoditel=Braas',
                                'Docke' => '/vodostochnaya-sistema/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA&msoption|proizvoditel=Docke',
                                'Grand Line' => '/vodostochnaya-sistema/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA&msoption|proizvoditel=Grand%20Line',
                                'Альта-Профиль' => '/vodostochnaya-sistema/?msoption|material=%D0%9F%D0%BB%D0%B0%D1%81%D1%82%D0%B8%D0%BA&msoption|proizvoditel=%D0%90%D0%BB%D1%8C%D1%82%D0%B0-%D0%9F%D1%80%D0%BE%D1%84%D0%B8%D0%BB%D1%8C',
                            ]
                        ],
                        'Металлические водосточные системы' => [
                            'uri' => '/metallicheskie-vodostoki/',
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
                        'Софиты' => [
                            'uri' => '/sofity/',
                            'fullwidth' => true,
                        ],
                        'ПВХ софиты' => [
                            'uri' => '/pvh-sofity/',
                            'img' => '/assets/template/img/assort/krovlya/sofity-plastikovye.jpg',
                            'links' => [
                            ]
                        ],
                        'Металлические софиты' => [
                            'uri' => '/metallicheskie-sofity/',
                            'img' => '/assets/template/img/assort/krovlya/sofity-metallicheskie.jpg',
                            'links' => [
                            ]
                        ],
                    ]
                ],
                'Доборные элементы' => [
                    'id' => 'assort-dobor',
                    'style' => 'columns-css',
                    'items' => [
                        'Доборные элементы' => [
                            'uri' => '/dobornye-elementy/',
                            'fullwidth' => true,
                        ],
                        'J-Профиль' => [
                            'uri' => '/j-profil/',
                        ],
                        'Доборные элементы для мягкой кровли' => [
                            'uri' => '/dobornye-elementy-dlya-myagkoy-krovli/',
                        ],
                        'Доборные элементы фальц' => [
                            'uri' => '/dobornyie-elementyi-falc/',
                        ],
                        'Ендовы для кровли' => [
                            'uri' => '/endova/',
                        ],
                        'Заглушки' => [
                            'uri' => '/zaglushki/',
                        ],
                        'Карнизные планки' => [
                            'uri' => '/karniznye-planki/',
                        ],
                        'Коньковые элементы для кровли' => [
                            'uri' => '/konkovye-elementy/',
                        ],
                        'Лобовые планки' => [
                            'uri' => '/lobovye-planki/',
                        ],
                        'Мансардные планки' => [
                            'uri' => '/mansardnye-planki/',
                        ],
                        'Планка капельник' => [
                            'uri' => '/planka-kapelnik/',
                        ],
                        'Планки примыкания' => [
                            'uri' => '/planki-primykaniya/',
                        ],
                        'Планки снегозадержания' => [
                            'uri' => '/planki-snegozaderzhaniya/',
                        ],
                        'Торцевые планки' => [
                            'uri' => '/torcevye-planki/',
                        ],
                        'Тройники' => [
                            'uri' => '/troyniki/',
                        ],
                        'Четверники' => [
                            'uri' => '/chetverniki/',
                        ],
                    ]
                ],
                'Комплектующие' => [
                    'id' => 'assort-soputtovary',
                    'style' => 'columns-css',
                    'items' => [
                        'Комплектующие' => [
                            'uri' => '/komplektuyushhie/',
                            'fullwidth' => true,
                        ],
                        'Мастики и краски' => [
                            'uri' => '/mastiki-kraski/',
                        ],
                        'Герметики' => [
                            'uri' => '/germetiki-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Геосинтетические материалы' => [
                            'uri' => '/geosinteticheskie-materialy/',
                            'links' => [
                            ]
                        ],
                        'Брусок' => [
                            'uri' => '/brusok-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Антисептик и огнебиозащита древесины' => [
                            'uri' => '/antiseptik-i-ognebiozashhita-drevesinyi/',
                            'links' => [
                            ]
                        ],
                        'Моющие средства для очистки кровли' => [
                            'uri' => '/moyushchie-sredstva-dlya-ochistki-krovli/',
                            'links' => [
                            ]
                        ],
                        'Плоский лист' => [
                            'uri' => '/ploskiy-list-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Битумный клей' => [
                            'uri' => '/bitumnyj-klej/',
                            'links' => [
                            ]
                        ],
                        'Козырьки из поликарбоната' => [
                            'uri' => '/kozyrki-iz-polikarbonata/',
                            'links' => [
                            ]
                        ],
                        'Окна' => [
                            'uri' => '/okna-v-sankt-peterburge/',
                        ],
                        'Входные двери' => [
                            'uri' => '/vhodnye-dveri-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Лестницы чердачные' => [
                            'uri' => '/lestnicy-cherdachnye-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Флюгеры' => [
                            'uri' => '/flyugery-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Строительный крепёж' => [
                            'uri' => '/stroitelnyy-krepyozh-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Проходки и вентиляция' => [
                            'uri' => '/prohodki-i-ventilyaciya-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Элементы безопасности кровли' => [
                            'uri' => '/ehlementy-bezopasnosti-krovli-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Коньковый торцевой элемент' => [
                            'uri' => '/konkovyj-torcevoj-ehlement-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Металлические доборные элементы' => [
                            'uri' => '/metallicheskie-dobornye-ehlementy-v-sankt-peterburge/',
                            'links' => [
                            ]
                        ],
                        'Устройство примыканий' => [
                            'uri' => '/ustrojstvo-primykanij/',
                            'links' => [
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
