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
                'parents' => 8287
            ],
            [
                'title' => 'Наличие утеплителя <b>Технониколь</b>',
                'parents' => 10464
            ],
            [
                'title' => 'Наличие утеплителя <b>Penoplex</b>',
                'parents' => 8178
            ],
            [
                'title' => 'Наличие утеплителя <b>Knauf</b>',
                'parents' => 3724
            ],
            [
                'title' => 'Наличие утеплителя <b>Isover</b>',
                'parents' => 4241
            ]
        ];
        break;
}

return $data;
