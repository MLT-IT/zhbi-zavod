<?php

$banners = [
    "banner-rockwool" => [
        "base" => "баннер-роквул-десктоп.svg",
        "725" => "роквул-785.svg",
        "320" => "роквул-320.svg",
    ],
    "banner-tn" => [
        "base" => "баннер-технониколь-десктоп.svg",
        "725" => "технониколь-785.svg",
        "320" => "технониколь-320.svg",
    ],
    "banner-penoplex" => [
        "base" => "баннер-пеноплекс-десктоп.svg",
        "720" => "пеноплекс-785.svg",
        "320" => "пеноплекс-320.svg",
    ],
    "banner-knauf" => [
        "base" => "баннер-кнауф-десктоп.svg",
        "725" => "Кнауф-785.svg",
        "320" => "кнауф-320.svg",
    ],
    "banner-ursa" => [
        "base" => "баннер-урса-десктоп.svg",
        "725" => "урса-320.svg",
        "320" => "урса-785.svg",
    ],
    "banner-comobo1" => [
        "base" => "баннер-комбо-десктоп.svg",
        "725" => "комбо-725.svg",
        "320" => "комбо-320.svg",
    ],
    "banner-comobo2" => [
        "base" => "баннер-комбо2-десктоп 4.svg",
        "725" => "комбо2-725.svg",
        "320" => "комбо2-320.svg",
    ],
    "banner-comobo3" => [
        "base" => "баннер-комбо3-десктоп 4.svg",
        "725" => "комбо3-725.svg",
        "320" => "комбо3-320.svg",
    ],

];

$data = [
    "93190" => [
        "banner-rockwool",
        "banner-comobo1",
        "banner-comobo2",
        "banner-comobo3"
    ],
    "93191" => [
        "banner-tn",
        "banner-comobo1",
        "banner-comobo2",
        "banner-comobo3"
    ],
    "93189" => [
        "banner-penoplex",
        "banner-comobo1",
        "banner-comobo2",
        "banner-comobo3"
    ],
    "93185" => [
        "banner-knauf",
        "banner-comobo1",
        "banner-comobo2",
        "banner-comobo3"
    ],
    "93192" => [
        "banner-ursa",
        "banner-comobo1",
        "banner-comobo2",
        "banner-comobo3"
    ],
    "all" => [
        "banner-comobo1",
        "banner-comobo2",
        "banner-comobo3"
    ]
];

$parentsIds = $modx->getParentIds($modx->resource->id, 10, [
    "context_key" => $modx->resource->context_key
]);



$id = 0;
foreach ($parentsIds as $parent){
    if (array_key_exists($parent, $data)){
        $id = $parent;
        break;
    }
}

$result = [];
if($id == 0){
    $id = "all";
}
if (array_key_exists($id, $data)){
    foreach ($data[$id] as $keyBanner){
        if(array_key_exists($keyBanner, $banners)){
            $result[] = $banners[$keyBanner];
        }
    }
}


return $result;
