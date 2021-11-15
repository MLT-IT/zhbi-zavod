{var $items = [
    [
        'title' => 'Нерудные материалы',
        'url' => '/catalog/nerudnye-materialy/',
        'image' => 'img/catalog/catalog8.png',
        'children' => [
            [
                'title' => 'Песок',
                'url' => '/catalog/pesok-stroitelnyj/',
            ],
            [
                'title' => 'Щебень',
                'url' => '/catalog/sheben/',
            ],
            [
                'title' => 'Керамзит',
                'url' => '/catalog/keramzit/',
            ]
        ]
    ],
    [
        'title' => 'Бетон товарный',
        'url' => '/catalog/beton/',
        'image' => 'img/catalog/catalog9.png',
        'children' => [
            [
            'title' => 'Бетон товарный',
            'url' => '/catalog/beton-tovarnyj/',
            ],
            [
                'title' => 'Керамзитобетон',
                'url' => '/catalog/keramzitobeton/',
            ],
            [
                'title' => 'Фибробетон',
                'url' => '/catalog/fibrobeton/',
            ]
        ]
    ],
    [
        'title' => 'ЖБИ изделия',
        'url' => '/catalog/zhbi/',
        'image' => 'img/catalog/catalog10.png',
        'children' => [
            [
                'title' => 'Дорожные плиты',
                'url' => '/catalog/plity-dorozhnye/',
            ]
        ]
    ],
    [
        'title' => 'Металлопрокат',
        'url' => '/catalog/metalloprokat/',
        'image' => 'img/catalog/catalog11.png',
        'children' => [
            [
                'title' => 'Арматура',
                'url' => '/catalog/armatura/',
            ]
        ]
    ],
    [
        'title' => 'Стеновые материалы',
        'url' => '/catalog/stenovye-materialy/',
        'image' => 'img/catalog/catalog12.png',
        'children' => [
            [
                'title' => 'Газобетонные блоки',
                'url' => '',
            ]
        ]
    ],
    [
        'title' => 'Кровельные материалы',
        'url' => '/catalog/krovelnye-materialy/',
        'image' => 'img/catalog/catalog7.png',
        'children' => [
            [
                'title' => 'Металлочерепица',
                'url' => '',
            ]
        ]
    ],
    [
        'title' => 'Утеплитель',
        'url' => '/catalog/uteplitel/',
        'image' => 'img/catalog/catalog13.png',
        'children' => [
            [
                'title' => 'Минеральная вата',
                'url' => '',
            ]
        ]
    ]
]}
<section class="catalog-page">
    <div class="wrapper">
        {* <h1 class="title-1">Каталог всея товаров в Санкт-Петербурге и&nbsp;Ленинградской области и ещё 3 слова</h1> *}
        <div class="catalog-page__cards">
            {foreach $items as $item}
                <div class="catalog-page__card">
                    <div class="catalog-page__card-content">
                        <div class="catalog-page__card-img-container">
                            <img class="catalog-page__card-img"
                                 src="{$_modx->config['template_path']}{$item['image']}" alt=""></div>
                        <div class="catalog-page__card-title">
                            <a href="{$item['url']}">{$item['title']}</a>
                        </div>
                        <div class="catalog-page__card-list">
                            {foreach $item['children'] as $child}
                                <a href="{$child['url']}">{$child['title']}</a>
                            {/foreach   }
                        </div>
                    </div>
                </div>
            {/foreach   }
        </div>
    </div>
</section>
