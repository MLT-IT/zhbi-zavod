<?php

!empty($modxStart) or die('No direct script access.');

/*
    @from - с какой страницы происходит редирект?
    @to - на какую страницу происходит редирект?
    @host - на каком хосте это будет работать? Пример: knauf.local. Если не указано, то будет работать НА ВСЕХ хостах.
    @case_sensitive - редирект должен быть чувствителен к регистру? Если не указано или указано "0" / "false", то редирект будет нечувствителен.
*/


return [
    [
        'from' => '%EA%E8%F0%EF%E8%F7/%EA%F0%F3%EF%ED%EE%F4%EE%F0%EC%E0%F2%ED%FB%E5_%E1%EB%EE%EA%E8',
        'to' => 'https://www.kirpich-m.ru/oblicovochnye/',
    ],
    [
        'from' => 'some_from_2x',
        'to' => 'some_to_2',
        'host' => 'knauf.local',
    ],
    [
        'from' => '%EA%E8%F0%EF%E8%F7/%EA%F0%F3%EF%ED%EE%F4%EE%F0%EC%E0%F2%ED%FB%E5_%E1%EB%EE%EA%E8',
        'to' => 'https://www.kirpich-m.ru/oblicovochnye/',
        'case_sensitive' => 1
    ],
    [
        'from' => 'some_from_2x',
        'to' => 'some_to_2',
        'case_sensitive' => 1,
        'host' => 'kirpich-m.ru'
    ],
    [
        'from' => 'some_from_2x',
        'to' => 'some_to_2',
        'case_sensitive' => 1
    ]
];
