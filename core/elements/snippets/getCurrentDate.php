<?php

// Задаем смещение даты, например: +2 day
$modifyDate = isset($modifyDate) ? (string)$modifyDate : 'tomorrow';

$month = [
    '01' => 'января',
    '02' => 'февраля',
    '03' => 'марта',
    '04' => 'апреля',
    '05' => 'мая',
    '06' => 'июня',
    '07' => 'июля',
    '08' => 'августа',
    '09' => 'сентября',
    '10' => 'октября',
    '11' => 'ноября',
    '12' => 'декабря',
];

$datetime = new DateTime($modifyDate);
$datetime = $datetime->format('d.m');
$exploded = explode('.', $datetime);
$month = $month[$exploded[1]];


return '<b>' . $exploded[0] . ' ' . $month . '</b>';
