<?php


$options = [
    "default" => [
        ["title" => "ГОСТ", "key" => "gost"],
        ["title" => "Категория", "key" => "kategoriya"],

        ["title" => "Длина, мм", "key" => "dlinna-mm"],
        ["title" => "Высота, мм", "key" => "vysota-mm"],
        ["title" => "Ширина, мм", "key" => "shirina-mm"],

        ["title" => "Длина, см", "key" => "dlina-sm"],
        ["title" => "Высота, см", "key" => "vysota-sm"],
        ["title" => "Ширина, см", "key" => "shirina-sm"],

        ["title" => "Объем, м3", "key" => "obem-m3"],

        ["title" => "Масса, т", "key" => "massa-t"],
        ["title" => "Масса, кг", "key" => "massa-kg"],
    ],
    "detailed" => [
        ["title" => "ГОСТ", "key" => "gost"],
        ["title" => "Категория", "key" => "kategoriya"],

        ["title" => "Длина, мм", "key" => "dlinna-mm"],
        ["title" => "Высота, мм", "key" => "vysota-mm"],
        ["title" => "Ширина, мм", "key" => "shirina-mm"],

        ["title" => "Длина, см", "key" => "dlina-sm"],
        ["title" => "Высота, см", "key" => "vysota-sm"],
        ["title" => "Ширина, см", "key" => "shirina-sm"],

        ["title" => "Объем, м3", "key" => "obem-m3"],

        ["title" => "Масса, т", "key" => "massa-t"],
        ["title" => "Масса, кг", "key" => "massa-kg"],
    ]
];

if ($key && $options[$key]) {
    return $options[$key];
} else {
    return $options["default"];
}
