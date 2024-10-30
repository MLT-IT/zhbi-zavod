<?php

/**
 * Отдает массив с данными для выборки товаров с остатками на странице склада
 */

$data = null;
switch ($modx->context->key) {
    case 'web':
        $data = [
            [
                'title' => 'Наличие утеплителя <b>Rockwool</b>',
                'parents' => 93190
            ],
            [
                'title' => 'Наличие утеплителя <b>Технониколь</b>',
                'parents' => 93191
            ],
            [
                'title' => 'Наличие утеплителя <b>Penoplex</b>',
                'parents' => 93189
            ],
            [
                'title' => 'Наличие утеплителя <b>Knauf</b>',
                'parents' => 93185
            ],
            [
                'title' => 'Наличие утеплителя <b>Isover</b>',
                'parents' => 93187
            ]
        ];
        break;
}

return $data;
