<?php

return function ($global_data) {
    return [
        "Ленинградская область" => $global_data["region"]["toponim"]["where"]["standart"],
        "Ленинградской области" => $global_data["region"]["toponim"]["on"]["standart"],

        "по ЛО" => $global_data["region"]["toponim"]["where"]["standart"],
        "в ЛО" => $global_data["region"]["toponim"]["on"]["standart"],

        "Санкт-Петербурга" => $global_data["toponim"]["what"]["standart"],
        "Санкт-Петербурге" => $global_data["toponim"]["what"]["standart"],
        "Санкт-Петербург" => $global_data["toponim"]["base"]["standart"],
        "в Санкт-Петербурге" => $global_data["toponim"]["where"]["standart"],
        "по Санкт-Петербургу" => $global_data["toponim"]["on"]["standart"],
    ];
};
