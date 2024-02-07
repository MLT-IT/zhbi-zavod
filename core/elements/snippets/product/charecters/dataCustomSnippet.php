<?php

$dataCustom["custom"] =  rand(1, 5);
$dataCustom["nalichie"] = "В наличии " . rand(1, 5) . " шт";

date_default_timezone_set("Europe/Moscow");
if(date("H") > 7 and date("H") < 17){
    $samovivoz = "сегодня";
}else{
    $samovivoz = "завтра";
}
$dataCustom["samovivoz"] = $samovivoz;

return $dataCustom;