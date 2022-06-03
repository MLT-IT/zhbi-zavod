<?php

!empty($modxStart) or die('No direct script access.');

/*
    @from - с какой страницы происходит редирект?
    @to - на какую страницу происходит редирект?
    @host - на каком хосте это будет работать? Пример: knauf.local. Если не указано, то будет работать НА ВСЕХ хостах.
    @case_sensitive - редирект должен быть чувствителен к регистру? Если не указано или указано "0" / "false", то редирект будет нечувствителен.
*/

return [
    [
        'from' => 'instrument_dlja_kladki/product/%D0%92%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D0%BE-%D0%BE%D1%81%D1%83%D1%88%D0%B0%D1%8E%D1%89%D0%B8%D0%B5%20%D0%BA%D0%BE%D1%80%D0%BE%D0%B1%D0%BE%D1%87%D0%BA%D0%B8%20BAUT%20VAT_14763',
        'to' => 'https://kirpich-m.ru/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%d0%ba%d0%b8%d1%80%d0%bf%d0%b8%d1%87?sort=product_price.desc',
        'to' => 'https://kirpich-m.ru/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%EA%E8%F0%EF%E8%F7/%EA%F0%F3%EF%ED%EE%F4%EE%F0%EC%E0%F2%ED%FB%E5_%E1%EB%EE%EA%E8',
        'to' => 'https://kirpich-m.ru/keramobloki/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87/%D0%BF%D0%BE%D1%80%D0%B8%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%BD%D1%8B%D0%B9_%D1%82%D0%B5%D0%BF%D0%BB%D0%B0%D1%8F_%D0%BA%D0%B5%D1%80%D0%B0%D0%BC%D0%B8%D0%BA%D0%B0',
        'to' => 'https://kirpich-m.ru/keramobloki/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87/product/%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87%20%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9_13167',
        'to' => 'https://kirpich-m.ru/krasnyj/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87/%D0%BA%D1%80%D1%83%D0%BF%D0%BD%D0%BE%D1%84%D0%BE%D1%80%D0%BC%D0%B0%D1%82%D0%BD%D1%8B%D0%B5_%D0%B1%D0%BB%D0%BE%D0%BA%D0%B8',
        'to' => 'https://kirpich-m.ru/krupnoformatnyj-blok/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87',
        'to' => 'https://kirpich-m.ru/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87/blokikeram',
        'to' => 'https://kirpich-m.ru/keramobloki/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87/product/%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87_0,7%D0%BD%D1%84_%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9_13764',
        'to' => 'https://kirpich-m.ru/krasnyj/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D1%81%D1%83%D1%85%D0%B8%D0%B5_%D1%81%D0%BC%D0%B5%D1%81%D0%B8',
        'to' => 'https://kirpich-m.ru/kladochnye-smesi/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87/%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87_%D0%BF%D0%BE%D0%BB%D1%83%D1%82%D0%BE%D1%80%D0%BD%D1%8B%D0%B9',
        'to' => 'https://kirpich-m.ru/polutornye/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D0%BA%D0%B8%D1%80%D0%BF%D0%B8%D1%87/%D0%BF%D0%B0%D0%B2%D0%BB%D0%BE%D0%B2%D1%81%D0%BA%D0%B0%D1%8F_%D0%BA%D0%B5%D1%80%D0%B0%D0%BC%D0%B8%D0%BA%D0%B0',
        'to' => 'https://kirpich-m.ru/pavlovskij-zavod/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%EA%E8%F0%EF%E8%F7/%EA%E8%F0%EF%E8%F7_%E4%E2%EE%E9%ED%EE%E9',
        'to' => 'https://kirpich-m.ru/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
    [
        'from' => '%D0%BA%D1%80%D0%B0%D1%81%D0%BA%D0%B0?sort=product_price.desc',
        'to' => 'https://kirpich-m.ru/kladochnye-smesi/',
        //'host' => 'kirpich-m.ru',
        //'case_sensitive' => 1
    ],
];

