<?php

function getMenuData() {
    $lsr = 101938;
    $sk = 101936;
    $eab = 101934;
    $aeroc = 101932;
    $mogilksi = 101937;
    $bck = 101929;
    $hh = 101930;
    $bonolit = 101933;
    $zabudova = 101935;
    $ytong = 101931;
    $sls = 103191;
    $mogilgaz = 103192;

    $data = [
        $lsr => [
            'column1' => [
                'uri' => '/gazobeton-lsr/',
                'name' => 'Газобетон ЛСР',
                'img' => '/assets/template/pictures/lsr.png'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-lsr/?plotnost-ob=D200",
                    "name" => "D200",
                ],
                [
                    "uri" => "/gazobeton-lsr/?plotnost-ob=D300",
                    "name" => "D300",
                ],
                [
                    "uri" => "/gazobeton-lsr/?plotnost-ob=D400",
                    "name" => "D400",
                ],
                [
                    "uri" => "/gazobeton-lsr/?plotnost-ob=D500",
                    "name" => "D500",
                ],
                [
                    "uri" => "/gazobeton-lsr/?plotnost-ob=D600",
                    "name" => "D600",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-lsr/?razmer-mm=100х250х625",
                    "name" => "100х250х625",
                ],
                [
                    "uri" => "/gazobeton-lsr/?razmer-mm=150х250х625",
                    "name" => "150х250х625",
                ],
                [
                    "uri" => "/gazobeton-lsr/?razmer-mm=200х250х625",
                    "name" => "200х250х625",
                ],
                [
                    "uri" => "/gazobeton-lsr/?razmer-mm=250х250х625",
                    "name" => "250х250х625",
                ],
                [
                    "uri" => "/gazobeton-lsr/?razmer-mm=300х250х625",
                    "name" => "300х250х625",
                ],
                [
                    "uri" => "/gazobeton-lsr/?razmer-mm=375х250х625",
                    "name" => "375х250х625",
                ],
                [
                    "uri" => "/gazobeton-lsr/?razmer-mm=400х250х625",
                    "name" => "400х250х625",
                ],
                [
                    "uri" => "/gazobeton-lsr/?razmer-mm=85х250х625",
                    "name" => "85х250х625",
                ],
            ]
        ],
        $sk => [
            'column1' => [
                'uri' => '/gazobeton-sk/',
                'name' => 'Газобетон СК',
                'img' => '/assets/template/pictures/sk.png'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-sk/?plotnost-ob=D400",
                    "name" => "D400",
                ],
                [
                    "uri" => "/gazobeton-sk/?plotnost-ob=D500",
                    "name" => "D500",
                ],
                [
                    "uri" => "/gazobeton-sk/?plotnost-ob=D600",
                    "name" => "D600",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=100х250х625",
                    "name" => "100х250х625",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=150х250х625",
                    "name" => "150х250х625",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=200х250х600",
                    "name" => "200х250х600",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=200х250х625",
                    "name" => "200х250х625",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=250х250х600",
                    "name" => "250х250х600",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=250х250х625",
                    "name" => "250х250х625",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=300х250х600",
                    "name" => "300х250х600",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=300х250х625",
                    "name" => "300х250х625",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=375х250х600",
                    "name" => "375х250х600",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=375х250х625",
                    "name" => "375х250х625",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=400х250х600",
                    "name" => "400х250х600",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=400х250х625",
                    "name" => "400х250х625",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=100х250х600",
                    "name" => "100х250х600",
                ],
                [
                    "uri" => "/gazobeton-sk/?razmer-mm=150х250х600",
                    "name" => "150х250х600",
                ],
            ]
        ],
        $eab => [
            'column1' => [
                'uri' => '/gazobeton-eab/',
                'name' => 'Газобетон (ЕвроАэроБетон)',
                'img' => '/assets/template/pictures/eab.png'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-eab/?plotnost-ob=D400",
                    "name" => "D400"
                ],

                [
                    "uri" => "/gazobeton-eab/?plotnost-ob=D500",
                    "name" => "D500"
                ],

                [
                    "uri" => "/gazobeton-eab/?plotnost-ob=D600",
                    "name" => "D600"
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-eab/?razmer-mm=100х250х625",
                    "name" => "100х250х625"
                ],
                [
                    "uri" => "/gazobeton-eab/?razmer-mm=150х250х625",
                    "name" => "150х250х625"
                ],
                [
                    "uri" => "/gazobeton-eab/?razmer-mm=200х250х625",
                    "name" => "200х250х625"
                ],
                [
                    "uri" => "/gazobeton-eab/?razmer-mm=250х250х625",
                    "name" => "250х250х625"
                ],
                [
                    "uri" => "/gazobeton-eab/?razmer-mm=300х250х625",
                    "name" => "300х250х625"
                ],
                [
                    "uri" => "/gazobeton-eab/?razmer-mm=375х250х625",
                    "name" => "375х250х625"
                ],
                [
                    "uri" => "/gazobeton-eab/?razmer-mm=400х250х625",
                    "name" => "400х250х625"
                ],
            ]
        ],
        $sls => [
            'column1' => [
                'uri' => '/gazobeton-belorusskij-sls/',
                'name' => 'Газобетон Белорусский SLS',
                'img' => '/assets/template/pictures/sls.png'
            ],
            'column2' => [
                [
                    'uri' => '/gazobeton-belorusskij-sls/?plotnost-ob=D400',
                    'name' => 'D400'
                ],
                [
                    'uri' => '/gazobeton-belorusskij-sls/?plotnost-ob=D500',
                    'name' => 'D500'
                ],
                [
                    'uri' => '/gazobeton-belorusskij-sls/?plotnost-ob=D600',
                    'name' => 'D600'
                ],
            ],
            'column3' => [
                [
                    'uri' => '/gazobeton-belorusskij-sls/?razmer-mm=100х250х625',
                    'name' => '100х250х625'
                ],
                [
                    'uri' => '/gazobeton-belorusskij-sls/?razmer-mm=150х250х625',
                    'name' => '150х250х625'
                ],
                [
                    'uri' => '/gazobeton-belorusskij-sls/?razmer-mm=200х250х625',
                    'name' => '200х250х625'
                ],
                [
                    'uri' => '/gazobeton-belorusskij-sls/?razmer-mm=250х250х625',
                    'name' => '250х250х625'
                ],
                [
                    'uri' => '/gazobeton-belorusskij-sls/?razmer-mm=300х250х625',
                    'name' => '300х250х625'
                ],
                [
                    'uri' => '/gazobeton-belorusskij-sls/?razmer-mm=375х250х625',
                    'name' => '375х250х625'
                ],
                [
                    'uri' => '/gazobeton-belorusskij-sls/?razmer-mm=400х250х625',
                    'name' => '400х250х625'
                ],
            ],
        ],
        $mogilgaz => [
            'column1' => [
                'uri' => '/gazobeton-mogilevskij-gazosilikat/',
                'name' => 'Газобетон Могилевский Газосиликат',
                'img' => '/assets/template/pictures/mogil.png'
            ],
            'column2' => [
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?plotnost-ob=D400',
                    'name' => 'D400'
                ],
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?plotnost-ob=D500',
                    'name' => 'D500'
                ],
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?plotnost-ob=D600',
                    'name' => 'D600'
                ],
            ],
            'column3' => [
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?razmer-mm=100х250х600',
                    'name' => '100х250х600'
                ],
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?razmer-mm=150х250х600',
                    'name' => '150х250х600'
                ],
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?razmer-mm=200х250х600',
                    'name' => '200х250х600'
                ],
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?razmer-mm=250х250х600',
                    'name' => '250х250х600'
                ],
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?razmer-mm=300х250х600',
                    'name' => '300х250х600'
                ],
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?razmer-mm=375х250х600',
                    'name' => '375х250х600'
                ],
                [
                    'uri' => '/gazobeton-mogilevskij-gazosilikat/?razmer-mm=400х250х600',
                    'name' => '400х250х600'
                ],
            ],
        ],
        $aeroc => [
            'column1' => [
                'uri' => '/gazobeton-aerok/',
                'name' => 'Газобетон Аэрок',
                'img' => '/assets/template/pictures/aeroc.png'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-aerok/?plotnost-ob=D300",
                    "name" => "D300"
                ],
                [
                    "uri" => "/gazobeton-aerok/?plotnost-ob=D400",
                    "name" => "D400"
                ],
                [
                    "uri" => "/gazobeton-aerok/?plotnost-ob=D500",
                    "name" => "D500"
                ],
                [
                    "uri" => "/gazobeton-aerok/?plotnost-ob=D600",
                    "name" => "D600"
                ]
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-aerok/?razmer-mm=300х250х625",
                    "name" => "300х250х625"
                ],
                [
                    "uri" => "/gazobeton-aerok/?razmer-mm=100х250х625",
                    "name" => "100х250х625"
                ],
                [
                    "uri" => "/gazobeton-aerok/?razmer-mm=150х250х625",
                    "name" => "150х250х625"
                ],
                [
                    "uri" => "/gazobeton-aerok/?razmer-mm=200х250х625",
                    "name" => "200х250х625"
                ],
                [
                    "uri" => "/gazobeton-aerok/?razmer-mm=250х250х625",
                    "name" => "250х250х625"
                ],
                [
                    "uri" => "/gazobeton-aerok/?razmer-mm=375х250х625",
                    "name" => "375х250х625"
                ],
                [
                    "uri" => "/gazobeton-aerok/?razmer-mm=400х250х625",
                    "name" => "400х250х625"
                ],
            ]
        ],
        $mogilksi => [
            'column1' => [
                'uri' => '/mogilevskiy-gazobeton-ksi/',
                'name' => 'Газобетон Могилевский КСИ',
                'img' => '/assets/template/pictures/mogilksi.png'
            ],
            'column2' => [
                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?plotnost-ob=D300",
                    "name" => "D300"
                ],
                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?plotnost-ob=D400",
                    "name" => "D400"
                ],
                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?plotnost-ob=D500",
                    "name" => "D500"
                ],
                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?plotnost-ob=D600",
                    "name" => "D600"
                ],
            ],
            'column3' => [
                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?razmer-mm=300х250х625",
                    "name" => "300х250х625"
                ],

                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?razmer-mm=100х250х625",
                    "name" => "100х250х625"
                ],

                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?razmer-mm=150х250х625",
                    "name" => "150х250х625"
                ],

                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?razmer-mm=200х250х625",
                    "name" => "200х250х625"
                ],

                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?razmer-mm=250х250х625",
                    "name" => "250х250х625"
                ],
                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?razmer-mm=375х250х625",
                    "name" => "375х250х625"
                ],
                [
                    "uri" => "/mogilevskiy-gazobeton-ksi/?razmer-mm=400х250х625",
                    "name" => "400х250х625"
                ],
            ],
        ],
        $bck => [
            'column1' => [
                'uri' => '/bck-belorusskiy/',
                'name' => 'Газобетон Белорусский (БЦК)',
                'img' => '/assets/template/pictures/bck.png'
            ],
            'column2' => [
                [
                    "uri" => "/bck-belorusskiy/?plotnost-ob=D300",
                    "name" => "D300"
                ],
                [
                    "uri" => "/bck-belorusskiy/?plotnost-ob=D400",
                    "name" => "D400"
                ],
                [
                    "uri" => "/bck-belorusskiy/?plotnost-ob=D500",
                    "name" => "D500"
                ],
                [
                    "uri" => "/bck-belorusskiy/?plotnost-ob=D600",
                    "name" => "D600"
                ],
            ],
            'column3' => [
                [
                    "uri" => "/bck-belorusskiy/?razmer-mm=300х250х625",
                    "name" => "300х250х625"
                ],
                [
                    "uri" => "/bck-belorusskiy/?razmer-mm=100х250х625",
                    "name" => "100х250х625"
                ],
                [
                    "uri" => "/bck-belorusskiy/?razmer-mm=150х250х625",
                    "name" => "150х250х625"
                ],
                [
                    "uri" => "/bck-belorusskiy/?razmer-mm=200х250х625",
                    "name" => "200х250х625"
                ],
                [
                    "uri" => "/bck-belorusskiy/?razmer-mm=250х250х625",
                    "name" => "250х250х625"
                ],
                [
                    "uri" => "/bck-belorusskiy/?razmer-mm=375х250х625",
                    "name" => "375х250х625"
                ],
                [
                    "uri" => "/bck-belorusskiy/?razmer-mm=400х250х625",
                    "name" => "400х250х625"
                ],
            ]
        ],
        $hh => [
            'column1' => [
                'uri' => '/gazobeton-hh/',
                'name' => 'Газобетон H+H',
                'img' => '/assets/template/pictures/h-h.png'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-hh/?plotnost-ob=D300",
                    "name" => "D300"
                ],
                [
                    "uri" => "/gazobeton-hh/?plotnost-ob=D400",
                    "name" => "D400"
                ],
                [
                    "uri" => "/gazobeton-hh/?plotnost-ob=D500",
                    "name" => "D500"
                ],
                [
                    "uri" => "/gazobeton-hh/?plotnost-ob=D600",
                    "name" => "D600"
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-hh/?razmer-mm=300х250х625",
                    "name" => "300х250х625"
                ],
                [
                    "uri" => "/gazobeton-hh/?razmer-mm=100х250х625",
                    "name" => "100х250х625"
                ],
                [
                    "uri" => "/gazobeton-hh/?razmer-mm=150х250х625",
                    "name" => "150х250х625"
                ],
                [
                    "uri" => "/gazobeton-hh/?razmer-mm=200х250х625",
                    "name" => "200х250х625"
                ],
                [
                    "uri" => "/gazobeton-hh/?razmer-mm=250х250х625",
                    "name" => "250х250х625"
                ],
                [
                    "uri" => "/gazobeton-hh/?razmer-mm=375х250х625",
                    "name" => "375х250х625"
                ],
                [
                    "uri" => "/gazobeton-hh/?razmer-mm=400х250х625",
                    "name" => "400х250х625"
                ],
            ]
        ],
        $bonolit => [
            'column1' => [
                'uri' => '/gazobeton-bonolit/',
                'name' => 'Газобетон Бонолит',
                'img' => '/assets/template/pictures/bono.png'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-bonolit/?plotnost-ob=D400",
                    "name" => "D400"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?plotnost-ob=D500",
                    "name" => "D500"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?plotnost-ob=D600",
                    "name" => "D600"
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=200х250х600",
                    "name" => "200х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=250х250х600",
                    "name" => "250х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=300х200х600",
                    "name" => "300х200х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=300х250х600",
                    "name" => "300х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=350х250х600",
                    "name" => "350х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=375х250х600",
                    "name" => "375х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=400х200х600",
                    "name" => "400х200х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=400х250х600",
                    "name" => "400х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=500х250х600",
                    "name" => "500х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=100х250х600",
                    "name" => "100х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=500х200х600",
                    "name" => "500х200х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=50х250х600",
                    "name" => "50х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=75х250х600",
                    "name" => "75х250х600"
                ],
                [
                    "uri" => "/gazobeton-bonolit/?razmer-mm=200х200х600",
                    "name" => "200х200х600"
                ],
            ]
        ],
        $zabudova => [
            'column1' => [
                'uri' => '/gazobeton-zabudova/',
                'name' => 'Газобетон Забудова',
                'img' => '/assets/template/pictures/zabud.png'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-zabudova/?plotnost-ob=D400",
                    "name" => "D400"
                ],
                [
                    "uri" => "/gazobeton-zabudova/?plotnost-ob=D500",
                    "name" => "D500"
                ],
                [
                    "uri" => "/gazobeton-zabudova/?plotnost-ob=D600",
                    "name" => "D600"
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-zabudova/?razmer-mm=100х250х625",
                    "name" => "100х250х625"
                ],
                [
                    "uri" => "/gazobeton-zabudova/?razmer-mm=150х250х625",
                    "name" => "150х250х625"
                ],
                [
                    "uri" => "/gazobeton-zabudova/?razmer-mm=200х250х625",
                    "name" => "200х250х625"
                ],
                [
                    "uri" => "/gazobeton-zabudova/?razmer-mm=250х250х625",
                    "name" => "250х250х625"
                ],
                [
                    "uri" => "/gazobeton-zabudova/?razmer-mm=300х250х625",
                    "name" => "300х250х625"
                ],
                [
                    "uri" => "/gazobeton-zabudova/?razmer-mm=375х250х625",
                    "name" => "375х250х625"
                ],
                [
                    "uri" => "/gazobeton-zabudova/?razmer-mm=400х250х625",
                    "name" => "400х250х625"
                ],
            ]
        ],
        $ytong => [
            'column1' => [
                'uri' => '/gazobeton-ytong/',
                'name' => 'Газобетон Ytong (Ютонг)',
                'img' => '/assets/template/pictures/ytong.png'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-ytong/?plotnost-ob=D300",
                    "name" => "D300"
                ],
                [
                    "uri" => "/gazobeton-ytong/?plotnost-ob=D400",
                    "name" => "D400"
                ],
                [
                    "uri" => "/gazobeton-ytong/?plotnost-ob=D500",
                    "name" => "D500"
                ],
                [
                    "uri" => "/gazobeton-ytong/?plotnost-ob=D600",
                    "name" => "D600"
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=300х250х625",
                    "name" => "300х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=100х250х625",
                    "name" => "100х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=150х250х625",
                    "name" => "150х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=200х250х625",
                    "name" => "200х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=250х250х625",
                    "name" => "250х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=375х250х625",
                    "name" => "375х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=400х250х625",
                    "name" => "400х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=500х250х625",
                    "name" => "500х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=50х250х625",
                    "name" => "50х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=75х250х625",
                    "name" => "75х250х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=100х750х625",
                    "name" => "100х750х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=75х750х625",
                    "name" => "75х750х625"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=300х250х500",
                    "name" => "300х250х500"
                ],
                [
                    "uri" => "/gazobeton-ytong/?razmer-mm=375х250х500",
                    "name" => "375х250х500"
                ],
            ]
        ]
    ];

    foreach ($data as $key => $values) {
        $data[$key]['column3'] = array_chunk($values['column3'], 7);
    }

    return $data;
}
