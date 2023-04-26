<?php

/**
 *  TODO:
 *  3. Удали ненужные str_replace (кажется, они есть, я замечал их, ненужные они, потому что в конце есть цикл для str_replace).
 *  6. Залей на тестовый и проверь параллельно с боевым - есть ли разница в коэффициентах, ценах и т.д...
 */

/**
 * Важные объснения.
 * 1. У некоторых опций тип - не число, а текст. Со значениями опций в этом скрипте производятся арифметические действия. Чтобы не было ошибок, ДО выполнения арифметики нужно убрать из значения пробелы и заменить запятые на точки.
 * 2. Если на Windows вывести float-значение из php, то оно выведется с запятой. Если на Linux, то с точкой. В этом файле вычисляются коэффициенты, которые потом будут использоваться в арифметических действиях на JS. Для арифметики запятая не подойдет, поэтому после каких-либо вычислений необходимо float-значение преобразовать в строку с точкой в качестве разделителя.
 */

$cacheName = 'setValuesForProd';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $src['context_key'] . '/' . $src['id'],
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $result = [
        // id и ключ товара
        'prodId', // id товара, нужен для добавления товара в корзину
        'productKey', // Ключ товара, нужен для изменения товара в корзине

        // Цены
        'defaultPrice', // Цена по умолчанию - нужна для расчета других цен на JS
        'outputPrice', // Цена для красивого вывода
        'defaultOldPrice', // Старая цена по умолчанию
        'outputOldPrice', // Старая цена для красивого вывода

        // Переменные с разной информацией о товаре
        'checkItems',  // Есть ли товар в избранном, в сравнении
        'itemInCart', // Кол-во товара в корзине
        'pricePer', // Цена за ...
        'condition', // Возможность выбирать единицу измерения для добавления товара в корзину

        // Переменные для дробного добавления товара в корзину
        'isFractional',
        'extraClass',
        'dataMin',

        // Коэффициенты
        'itemUnits' => []
    ];

    // Подгружаем pdoTools, чтобы запускать файловые сниппеты
    $pdoTools = $modx->getService('pdoTools');


    // ------------------------------------
    // Установка переменных с информацией о товаре
    // ------------------------------------
    // id товара, нужен для добавления товара в корзину
    $result['prodId'] = $src['id'];

    // Ключ товара, нужен для изменения товара в корзине
    $result['productKey'] = str_replace(' ', '', $src['id'] . $src['price'] . $src['weight'] . '[]');

    $decoratePriceRegex = '/\B(?=(\d{3})+(?!\d))/';
    // Цена по умолчанию - нужна для расчета других цен на JS
    $result['defaultPrice'] = str_replace([',', ' '], ['.', ''], $src['price']);
    // Цена для красивого вывода
    $result['outputPrice'] = str_replace(',', '.', preg_replace($decoratePriceRegex, ' ', $src['price']));
    // Старая цена
    if ($src['old_price']) {
        // Старая цена по умолчанию
        $result['defaultOldPrice'] = str_replace([',', ' '], ['.', ''], $src['old_price']);
        // Старая цена для красивого вывода
        $result['outputOldPrice'] = str_replace(',', '.', preg_replace($decoratePriceRegex, ' ', $src['old_price']));
    }

    // Цена за ...
    $unit = $src['unit'][0];
    if (empty($unit) || $unit == 'упаковка') {
        $result['pricePer'] = 'упаковку';
    } else if ($unit == 'тонна') {
        $result['pricePer'] = 'тонну';
    } else {
        $result['pricePer'] = $unit;
    }

    // Выводить ли возможность выбирать единицу измерения для добавления товара в корзину
    $result['condition'] = !in_array($src['parent'], [
        93450, 93452, 93199, 93232, 93551, 93554, 93555, 93291, 93336,

        // isoroc
        93247,93260,93259,93258,93257,93256,93255,93254,93253,93252,93251,93250,93249,93248,93233,93246,93245,93244,93243,93242,93241,93240,93239,93238,93237,93236,93235,93234
    ]);

    // Дробное добавление товара в корзину
    if (in_array($modx->resource->template, [17, 20, 6, 21, 22])) {
        $result['isFractional'] = $modx->resource->getTVValue('isFractional');
    } else {
        $result['isFractional'] = $src['isFractional'];
    }
    if ($isFractional == 1) {
        $result['extraClass'] = ' custom-counter_type_fractional';
        $result['dataMin'] = '0.01';
    } else {
        $result['extraClass'] = '';
        $result['dataMin'] = '1';
    }


    // ------------------------------------
    // Вычисление и установка коэффициентов
    // ------------------------------------
    // Единицы измерения для утеплителей
    if (in_array($src['context_key'], ['web'])) {
        $pm = str_replace(',', '.', $src['kolvo-pm'][0]);
        $m2 = $src['ploshad_m2'][0];
        $m3 = str_replace(',', '.', $src['obyem_m3'][0]);

        if (!empty($src['v_upakovke'][0]) && $src['context_key'] == 'penoplex') {
            if (!in_array($src['parent'], [93452, 93450, 93453, 93454, 93455])) {
                $upk = 1 / $src['v_upakovke'][0];
                $pm = 1 / ($src['v_upakovke'][0] * (1 / $src['kolvo-pm'][0]));
                $m2 = 1 / ($src['v_upakovke'][0] * (1 / $src['ploshad_m2'][0]));
                $m3 = 1 / ($src['v_upakovke'][0] * (1 / $src['obyem_m3'][0]));
            } else {
                $list = $src['v_upakovke'][0];
            }
        }
    }

    // Единицы измерения для газобетона
    if (in_array($src['context_key'], ['gazosilikatstroy'])) {
        if (!empty($src['kolvoshm3']) && !empty($src['kolvoshm3'][0])) {
            $thing = $src['kolvoshm3'][0];
        }
        if (!empty($src['pallet_num']) && !empty($src['pallet_num'][0])) {
            $pdn = $src['pallet_num'][0];
        }
    }

    // Установка itemUnits
    $inf = 999999999999999999;

    // TODO: С помощью цикла код можно упростить
    if (!empty($m2) && ($m2 > 0) && ($m2 < $inf)) {
        $result['itemUnits']['m2'] = ['val' => $m2, 'title' => 'м2', 'id' => '2'];
    }
    if (!empty($m3) && ($m3 > 0) && ($m3 < $inf)) {
        $result['itemUnits']['m3'] = ['val' => $m3, 'title' => 'м3', 'id' => '3'];
    }
    if (!empty($pm) && ($pm > 0) && ($pm < $inf)) {
        $result['itemUnits']['pm'] = ['val' => $pm, 'title' => 'п.м.', 'id' => '4'];
    }
    if (!empty($list) && ($list > 0) && ($list < $inf)) {
        $result['itemUnits']['list'] = ['val' => $list, 'title' => 'лист', 'id' => '5'];
    }
    if (!empty($thing) && ($thing > 0) && ($thing < $inf)) {
        $result['itemUnits']['thing'] = ['val' => $thing, 'title' => 'штуку', 'id' => '6'];
    }
    if (!empty($pilomat_thing) && ($pilomat_thing > 0) && ($pilomat_thing < $inf)) {
        $result['itemUnits']['pilomat_thing'] = ['val' => $pilomat_thing, 'title' => 'штуку', 'id' => '7'];
    }
    if (!empty($k_m2seam) && ($k_m2seam > 0) && ($k_m2seam < $inf)) {
        $result['itemUnits']['k_m2seam'] = ['val' => $k_m2seam, 'title' => 'м2', 'id' => '8'];
    }
    if (!empty($k_m3seam) && ($k_m3seam > 0) && ($k_m3seam < $inf)) {
        $result['itemUnits']['k_m3seam'] = ['val' => $k_m3seam, 'title' => 'м3', 'id' => '9'];
    }
    if (!empty($meter) && ($meter > 0) && ($meter < $inf)) {
        $result['itemUnits']['meter'] = ['val' => $meter, 'title' => 'метр', 'id' => '10'];
    }
    if (!empty($upk) && ($upk > 0) && ($upk < $inf)) {
        $result['itemUnits']['upk'] = ['val' => $upk, 'title' => 'упаковка', 'id' => '11'];
    }
    if (!empty($pdn) && ($pdn > 0) && ($pdn < $inf)) {
        $result['itemUnits']['pdn'] = ['val' => $pdn, 'title' => 'поддон', 'id' => '12'];
    }

    // ------------------------------------
    // Финальные вычисления
    // ------------------------------------
    if (!empty($modx->getPlaceholder('checkFloatTrouble'))) {
        foreach ($result['itemUnits'] as $key => $val) {
            // Здесь происходит неявное приведение типов - числа в строку (функция replace ведь работает со строками). И замена запятой на точку. Зачем? См. в самом начале объяснение 2
            $result['itemUnits'][$key] = str_replace(',', '.', $val);
        }
        $result['productKey'] = str_replace(',', '.', $result['productKey']);
    }

    if (count($result['itemUnits']) < 1) {
        $result['condition'] = false;
    }

    $result['productKey'] = md5($result['productKey']);


    // ------------------------------------
    // Работа с кешем
    // ------------------------------------
    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

// Есть ли товар в избранном, в сравнении
$result['checkItems'] = $modx->getPlaceholder('checkItems');
// Кол-во товара в корзине
$result['itemInCart'] = $result['checkItems']['cart'][$src['id']];

return $result;
