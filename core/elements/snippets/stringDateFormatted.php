<?php

// Создание объекта DateTime
$date = new DateTime($dateString);

// Преобразование даты в нужный формат
$day = $date->format('d');
$month = $date->format('F');
$year = $date->format('Y');

// Преобразование месяца в родительный падеж
$months = [
    'January' => 'января',
    'February' => 'февраля',
    'March' => 'марта',
    'April' => 'апреля',
    'May' => 'мая',
    'June' => 'июня',
    'July' => 'июля',
    'August' => 'августа',
    'September' => 'сентября',
    'October' => 'октября',
    'November' => 'ноября',
    'December' => 'декабря'
];

// Замена английского месяца на русский
$month = $months[$month];

// Форматирование даты
if (isset($hiddens) && in_array("year", $hiddens)) {
    $year = "";
}
$output = "$day $month $year";

return trim($output);
