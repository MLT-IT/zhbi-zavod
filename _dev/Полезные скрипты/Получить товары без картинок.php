<?php

/*
У этих товаров нет фоток:
id: 70571
id: 70592
id: 69256
В Excel тоже нет - это файл "Доборные Metall profil NEW+.xlsx"

И у этих:
id: 26197
id: 26196
id: 26195
В Excel тоже нет - это файл "Выгрузка парсинга tegola.xlsx"
*/

$ids = $modx->runSnippet('msProducts', [
    'parents' => 0,
    'depth' => 0,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'where' => '{"Data.image:IS":null , "AND:id:NOT IN": [70571, 70592, 69256, 26197, 26196, 26195]}',
    'returnIds' => 1
]);
