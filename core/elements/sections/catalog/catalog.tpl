{var $items = [
    [
        'title' => 'Нерудные материалы',
        'url' => '5' | url,
        'image' => 'img/catalog/catalog8.png',
        'children' => [
            [
                'title' => 'Песок',
                'url' => '433' | url,
            ],
            [
                'title' => 'Щебень',
                'url' => '9' | url,
            ],
            [
                'title' => 'Керамзит',
                'url' => '501' | url,
            ]
        ]
    ],
    [
        'title' => 'Бетон товарный',
        'url' => '10' | url,
        'image' => 'img/catalog/catalog9.png',
        'children' => [
            [
            'title' => 'Бетон товарный',
            'url' => '74' | url,
            ],
            [
                'title' => 'Керамзитобетон',
                'url' => '46' | url,
            ],
            [
                'title' => 'Фибробетон',
                'url' => '75' | url,
            ]
        ]
    ],
    [
        'title' => 'ЖБИ изделия',
        'url' => '11' | url,
        'image' => 'img/catalog/catalog10.png',
        'children' => [
            [
                'title' => 'Дорожные плиты',
                'url' => '512' | url,
            ]
        ]
    ],
    [
        'title' => 'Металлопрокат',
        'url' => '12' | url,
        'image' => 'img/catalog/catalog11.png',
        'children' => [
            [
                'title' => 'Арматура',
                'url' => '566' | url,
            ]
        ]
    ],
    [
        'title' => 'Стеновые материалы',
        'url' => '13' | url,
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
        'url' => '14' | url,
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
        'url' => '15' | url,
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
                <div class="catalog-page__card fadeInUp">
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