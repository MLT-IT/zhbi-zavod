<?php

function getMenuData()
{
    $vkblok = 303562;
    $masix = 303611;
    $glavstroyblok = 303597;
    $lsr = 303349;
    $sk = 303287;
    $eab = 303236;
    $aeroc = 303178;
    $mogilksi = 303533;
    $bck = 303083;
    $hh = 303106;
    $bonolit = 303201;
    $zabudova = 303256;
    $ytong = 303129;
    $sls = 303504;
    $mogilgaz = 303533;

    $data = [
        $vkblok => [
            'column1' => [
                'uri' => '/gazobeton-vkblok/',
                'name' => 'Газобетон ВКБлок',
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-vkblok/?plotnost-ob=D500",
                    "name" => "D500",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x100x250",
                    "name" => "625x100x250",
                ],
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x120x250",
                    "name" => "625x120x250",
                ],
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x150x250",
                    "name" => "625x150x250",
                ],
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x200x250",
                    "name" => "625x200x250",
                ],
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x200x300",
                    "name" => "625x200x300",
                ],
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x240x250",
                    "name" => "625x240x250",
                ],
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x250x250",
                    "name" => "625x250x250",
                ],
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x300x250",
                    "name" => "625x300x250",
                ],
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x350x250",
                    "name" => "625x350x250",
                ],
                [
                    "uri" => "/gazobeton-vkblok/?razmer-mm=625x400x250",
                    "name" => "625x400x250",
                ],
            ]
        ],
        $masix => [
            'column1' => [
                'uri' => '/gazobeton-masix/',
                'name' => 'Газобетон Masix',
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-masix/?plotnost-ob=D500",
                    "name" => "D500",
                ],
                [
                    "uri" => "/gazobeton-masix/?plotnost-ob=D600",
                    "name" => "D600",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-masix/?razmer-mm=625x75x250",
                    "name" => "625x75x250",
                ],
                [
                    "uri" => "/gazobeton-masix/?razmer-mm=625x100x250",
                    "name" => "625x100x250",
                ],
                [
                    "uri" => "/gazobeton-masix/?razmer-mm=625x125x250",
                    "name" => "625x125x250",
                ],
                [
                    "uri" => "/gazobeton-masix/?razmer-mm=625x150x250",
                    "name" => "625x150x250",
                ],
                [
                    "uri" => "/gazobeton-masix/?razmer-mm=625x200x250",
                    "name" => "625x200x250",
                ],
                [
                    "uri" => "/gazobeton-masix/?razmer-mm=625x250x250",
                    "name" => "625x250x250",
                ],
                [
                    "uri" => "/gazobeton-masix/?razmer-mm=625x300x200",
                    "name" => "625x300x200",
                ],
                [
                    "uri" => "/gazobeton-masix/?razmer-mm=625x300x250",
                    "name" => "625x300x250",
                ],
                [
                    "uri" => "/gazobeton-masix/?razmer-mm=625x375x250",
                    "name" => "625x375x250",
                ],
            ]
        ],
        $glavstroyblok => [
            'column1' => [
                'uri' => '/gazobeton-glavstroyblok/',
                'name' => 'Газобетон ГлавСтройБлок',
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
            ],
            'column2' => [
                [
                    "uri" => "/gazobeton-glavstroyblok/?plotnost-ob=D500",
                    "name" => "D500",
                ],
            ],
            'column3' => [
                [
                    "uri" => "/gazobeton-glavstroyblok/?razmer-mm=625х75х250",
                    "name" => "625х75х250",
                ],
                [
                    "uri" => "/gazobeton-glavstroyblok/?razmer-mm=625х100х250",
                    "name" => "625х100х250",
                ],
                [
                    "uri" => "/gazobeton-glavstroyblok/?razmer-mm=625х150х250",
                    "name" => "625х150х250",
                ],
                [
                    "uri" => "/gazobeton-glavstroyblok/?razmer-mm=625х200х250",
                    "name" => "625х200х250",
                ],
                [
                    "uri" => "/gazobeton-glavstroyblok/?razmer-mm=625х250х250",
                    "name" => "625х250х250",
                ],
                [
                    "uri" => "/gazobeton-glavstroyblok/?razmer-mm=625х300х200",
                    "name" => "625х300х200",
                ],
                [
                    "uri" => "/gazobeton-glavstroyblok/?razmer-mm=625х300х250",
                    "name" => "625х300х250",
                ],
                [
                    "uri" => "/gazobeton-glavstroyblok/?razmer-mm=625х400х250",
                    "name" => "625х400х250",
                ],
            ]
        ],
        $lsr => [
            'column1' => [
                'uri' => '/gazobeton-lsr/',
                'name' => 'Газобетон ЛСР',
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
                'img' => '/assets/template/pictures/gazosilikat-small.webp'
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
