<?php

// Толщина, мм: 0.5
// Покрытие: VikingMP® E
// Цвет: RAL 8017
// Коллекция: Ламонтерра X, Супермонтеррей
// Вид поверхности: Матовая
// Профиль: C8

$options = [
    "default" => [
        ["key" => "item_thickness", "title" => "Толщина, мм",],
        ["key" => "pokrytie", "title" => "Покрытие",],
        ["key" => "cvet", "title" => "Цвет",],
        ["key" => "collection", "title" => "Коллекция",],
        ["key" => "vid-poverhnosti", "title" => "Вид поверхности",],
        ["key" => "profil", "title" => "Профиль",],
    ],
    "detailed" => [
        ["key" => "item_thickness", "title" => "Толщина, мм",],
        ["key" => "pokrytie", "title" => "Покрытие",],
        ["key" => "cvet", "title" => "Цвет",],
        ["key" => "collection", "title" => "Коллекция",],
        ["key" => "vid-poverhnosti", "title" => "Вид поверхности",],
        ["key" => "profil", "title" => "Профиль",],
    ]
];

if ($key && $options[$key]) {
    return $options[$key];
} else {
    return $options["default"];
}
