<?php
$context = $modx->resource->get('context_key');
$primenenieResult = [];
$thicknessResult = [];
$categories = [];

// --------------------------------------
// Категории
// --------------------------------------
$catalog = $modx->getObject('modResource', [
    'alias' => 'catalog',
    'context_key' => $context
]);

if (!empty($catalog)) {
    $categories = $modx->runSnippet('pdoResources', [
        'parents' => $catalog->id,
        'depth' => 0,
        'where' => '{"template:=": "5"}',
        'limit' => 0,
        'sortby' => 'menuindex',
        'sortdir' => 'ASC',
        'context' => $context,
        'tpl' => '@FILE chunks/menuItemPC.tpl',
        'outputSeparator' => '___',
        'includeTVs' => 'menutitleTV',
    ]);
    $categories = explode('___', $categories);
}

// --------------------------------------
// Товары
// --------------------------------------
switch ($context) {
    case 'rockwool':
        $primenenieResult = [
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA">Для перегородок</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD">Для стен</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0">Для потолка</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0">Для пола</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9">Для перекрытий</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0">Для фасада</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BC%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B">Для мансарды</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8">Для кровли</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8">Для балкона/лоджии</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BD%D0%B8">Для бани</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%87%D0%B8%2F%D0%BA%D0%B0%D0%BC%D0%B8%D0%BD%D0%B0">Для печи/камина</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1">Для труб</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%9F%D0%BE%D0%B4+%D1%88%D1%82%D1%83%D0%BA%D0%B0%D1%82%D1%83%D1%80%D0%BA%D1%83">Под штукатурку</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8">Для вентиляции</a>'
        ];
        $thicknessResult = [
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=20">20</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=25">25</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=27">27</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=30">30</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=35">35</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=40">40</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=50">50</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=60">60</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=70">70</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=75">75</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=80">80</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=90">90</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=100">100</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=102">102</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=105">105</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=110">110</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=120">120</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=122">122</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=130">130</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=140">140</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=150">150</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=152">152</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=160">160</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=170">170</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=180">180</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=190">190</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=200">200</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=210">210</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=220">220</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=230">230</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=240">240</a>',
            '<a class="header__column-item" href="https://www-rockwool.ru/catalog/?msoption|item_thickness=250">250</a>',
        ];
        break;
    case 'penoplex':
        $primenenieResult = [
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8">Для балкона/лоджии</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0">Для пола</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0">Для потолка</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD">Для стен</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F">Для фундамента/цоколя</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA">Для перегородок</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0">Для фасада</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8">Для кровли</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8">Для вентиляции</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1">Для труб</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9">Для перекрытий</a>'
        ];
        $thicknessResult = [
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=20">20</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=30">30</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=30.4">30.4</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=40">40</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=50">50</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=60">60</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=80">80</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=100">100</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=120">120</a>',
            '<a class="header__column-item" href="https://www-penoplex.ru/catalog/?msoption|item_thickness=150">150</a>'
        ];
        break;
    case 'tn':
        $primenenieResult = [
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BA%D1%80%D0%BE%D0%B2%D0%BB%D0%B8">Для кровли</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BC%D0%B0%D0%BD%D1%81%D0%B0%D1%80%D0%B4%D1%8B">Для мансарды</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%BA">Для перегородок</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%B5%D1%80%D0%B5%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D0%B9">Для перекрытий</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D0%BB%D0%B0">Для пола</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D0%B0%D1%81%D0%B0%D0%B4%D0%B0">Для фасада</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%81%D1%82%D0%B5%D0%BD">Для стен</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BE%D0%BA%D0%BE%D0%BD">Для окон</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%9F%D0%BE%D0%B4+%D1%88%D1%82%D1%83%D0%BA%D0%B0%D1%82%D1%83%D1%80%D0%BA%D1%83">Под штукатурку</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BB%D0%BA%D0%BE%D0%BD%D0%B0%2F%D0%BB%D0%BE%D0%B4%D0%B6%D0%B8%D0%B8">Для балкона/лоджии</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%84%D1%83%D0%BD%D0%B4%D0%B0%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%2F%D1%86%D0%BE%D0%BA%D0%BE%D0%BB%D1%8F">Для фундамента/цоколя</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%BF%D0%BE%D1%82%D0%BE%D0%BB%D0%BA%D0%B0">Для потолка</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B5%D0%BD%D1%82%D0%B8%D0%BB%D1%8F%D1%86%D0%B8%D0%B8">Для вентиляции</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D1%82%D1%80%D1%83%D0%B1">Для труб</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B1%D0%B0%D0%BD%D0%B8">Для бани</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B2%D0%B0%D0%BD%D0%BD%D0%BE%D0%B9+%D0%BA%D0%BE%D0%BC%D0%BD%D0%B0%D1%82%D1%8B">Для ванной комнаты</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|primenenie=%D0%94%D0%BB%D1%8F+%D0%B4%D0%B2%D0%B5%D1%80%D0%B5%D0%B9+%D0%B8+%D0%B2%D0%BE%D1%80%D0%BE%D1%82">Для дверей и ворот</a>'
        ];
        $thicknessResult = [
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=5">5</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=10">10</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=20">20</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=22">22</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=30">30</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=40">40</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=50">50</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=55">55</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=60">60</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=70">70</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=80">80</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=90">90</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=100">100</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=110">110</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=120">120</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=130">130</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=140">140</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=150">150</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=160">160</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=170">170</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=180">180</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=190">190</a>',
            '<a class="header__column-item" href="https://www-tn.ru/catalog/?msoption|item_thickness=200">200</a>',
        ];
        break;
}


$result = [];
if (!empty($categories)) {
    $key = 'Продуктовые линейки';
    $count = count($categories);

    switch (true) {
        case $count < 10:
            $result[$key][] = $categories;
            break;
        case $count >= 10 && $count <= 15:
            $amount = ceil($count / 2);
            $result[$key][] = array_slice($categories, 0, $amount);
            $result[$key][] = array_slice($categories, $amount, $count - 1);
            break;
        case $count > 15:
            $amount = ceil($count / 3);
            $twiceAmount = $amount + $amount;
            $result[$key][] = array_slice($categories, 0, $amount);
            $result[$key][] = array_slice($categories, $amount, $amount);
            $result[$key][] = array_slice($categories, $twiceAmount, $count - 1);
            break;
    }
}
if (!empty($primenenieResult)) {
    $result['Применение'][] = $primenenieResult;
}
if (!empty($thicknessResult)) {
    $key = 'Толщина, мм';
    $count = count($thicknessResult);

    switch (true) {
        case $count < 10:
            $result[$key][] = $thicknessResult;
            break;
        case $count >= 10 && $count <= 15:
            $amount = ceil($count / 2);
            $result[$key][] = array_slice($thicknessResult, 0, $amount);
            $result[$key][] = array_slice($thicknessResult, $amount, $count - 1);
            break;
        case $count > 15:
            $amount = ceil($count / 3);
            $twiceAmount = $amount + $amount;
            $result[$key][] = array_slice($thicknessResult, 0, $amount);
            $result[$key][] = array_slice($thicknessResult, $amount, $amount);
            $result[$key][] = array_slice($thicknessResult, $twiceAmount, $count - 1);
            break;
    }
}

return $result;
