<?php

// ------------------------------------------
// Основные настройки
// ------------------------------------------
// id опций, которые будем привязывать к категориям
$optIds = [760, 103, 761, 762, 763, 764, 86, 423, 681, 682, 765, 766, 767, 768, 422, 769, 770, 771, 772, 773, 774, 775, 425, 776, 362, 777, 420, 507, 511, 778, 31, 780, 363, 781, 782, 128];

// id категорий, к которым будут привязаны опции
$catIds = [89370, 89371, 89372, 89373, 89374, 89375, 89376, 89377, 89378, 89379, 89380, 89381, 89383, 89384, 89385, 89387, 89389, 89393, 89395, 89396, 89397, 89398, 89400, 89402, 89406, 89407, 89408, 89409, 89410, 89411, 89412, 89414];

// Контекст
$context = 'armatura-178';


// ------------------------------------------
// Работа скрипта
// ------------------------------------------
$miniShop2 = $modx->getService('miniShop2'); // Сам MiniShop2

foreach ($catIds as $cId) {
    foreach ($optIds as $oId) {
        $values = [
            'option_id' => $oId,
            'category_id' => $cId,
        ];

        $message = '';

        // Если такая привязка уже есть, то пропускаем
        $categoryOption = $modx->getObject('msCategoryOption', $values);
        if (!empty($categoryOption)) {
            $categoryOption->active = 1;
            $res = $categoryOption->save();
            if ($res) {
                $message = 'Успех ';
            } else {
                $message = 'Неудача ';
            }
            $message .= 'при активации ';
        } else {
            $res = $miniShop2->runProcessor('mgr/category/option/add', array_merge($values, ['active' => 1]));
            if ($res->response['success']) {
                $message = 'Успех ';
            } else {
                $message = 'Неудача ';
            }
            $message .= 'при создании ';
        }
        $message .= 'привязки опции для категории с id ' . $cId . '<br>';
        echo $message;
    }
}

echo 'Конец работы скрипта';
