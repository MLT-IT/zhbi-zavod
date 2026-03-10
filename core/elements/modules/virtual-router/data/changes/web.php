<?php

return function ($global_data) {
    return [
        "Санкт-Петербург" => $global_data["toponim"]["base"]["standart"],
        "в Санкт-Петербурге" => $global_data["toponim"]["where"]["standart"],
        "по Санкт-Петербургу" => $global_data["toponim"]["on"]["standart"],
        "Санкт-Петербурге" => $global_data["toponim"]["what"]["standart"],

        "по ЛО" => $global_data["region"]["toponim"]["where"]["standart"],
        "в ЛО" => $global_data["region"]["toponim"]["on"]["standart"],
    ];
};
