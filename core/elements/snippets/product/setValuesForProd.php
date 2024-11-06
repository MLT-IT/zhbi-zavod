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
    preg_match('/\d(?:\s?\d)*/', $src['old_price'], $matches);
    $src['old_price'] = str_replace(' ', '', $matches[0]);
    $src['old_price'] = round($src['old_price']);
    
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
} else if (in_array($unit, ['Мешок, шт'])) {
    $result['pricePer'] = 'мешок';
} else if (in_array($unit, ['1 м3'])) {
    $result['pricePer'] = 'м3';
} else {
    $result['pricePer'] = $unit;
}

// Выводить ли возможность выбирать единицу измерения для добавления товара в корзину
$result['condition'] = !in_array($src['parent'], [
    93450, 93452, 93199, 93232, 93551, 93554, 93555, 93291, 93336, 

    // osnova.spb штакетник, профлист
    125541, 125537,

    // baswool
    168218,168219,168220,168221,168222,168223,168224,168225,168226,168227,168228,  

    // isoroc
    93247, 93260, 93259, 93258, 93257, 93256, 93255, 93254, 93253, 93252, 93251, 93250, 93249, 93248, 93233, 93246, 93245, 93244, 93243, 93242, 93241, 93240, 93239, 93238, 93237, 93236, 93235, 93234,

    // tagnerud
    // 196940, 196937,

    // plitnye
    178116,177263,177282,177289,177299,177264,177042,177296,
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
    // die('src: '.var_dump($src).'thing: '.$thing.', upk: '.$upk);
    // Отдельные расчеты для пеноплекса
    if (!empty($src['v_upakovke'][0]) && in_array($src['parent'], [93441, 93442, 93443, 93444, 93445, 93446, 93447, 93448, 93449, 93450, 93451, 93452, 93453, 93454, 93455])) {
        if (!in_array($src['parent'], [93452, 93450, 93453, 93454, 93455])) {
            $upk = 1 / $src['v_upakovke'][0];
            $pm = 1 / ($src['v_upakovke'][0] * (1 / $pm));
            $m2 = 1 / ($src['v_upakovke'][0] * (1 / $m2));
            $m3 = 1 / ($src['v_upakovke'][0] * (1 / $m3));
        } else {
            $list = $src['v_upakovke'][0];
        }
    }
    
    // Отдельные расчеты для tn
    if (
        // Это tn
        in_array($src['parent'], [93525, 93526, 93527, 93528, 93529, 93530, 93531, 93532, 93533, 93534, 93535, 93536, 93537, 93538, 93539, 93540, 93541, 93542, 93543, 93544, 93545, 93546, 93547, 93548, 93549, 93550, 93551, 93552, 93553, 93554, 93555, 93556, 93557, 93558, 93559, 93560, 93561, 93562, 93563, 93564, 93565, 93566, 93567, 93568, 93569, 93570, 93571, 93572, 93573, 93574, 93575, 93576, 93577, 93578, 93579, 93580, 93581, 93582, 93583, 93584, 93585, 93586, 93587, 93588, 93589, 93590, 93591, 93592, 93593, 93594, 93595, 93596, 93597, 93598, 93599, 93600, 93601, 93602, 93603, 93604, 93605, 93606, 93607, 93608, 93609, 93610, 93611, 93612, 93613, 93614, 93615, 93616, 93617, 93618, 93619, 93620, 93621, 93622, 93623, 93624, 93625, 93626, 93627, 93628, 93629, 93630]) &&
        // Совпадает тип
        in_array($src['tip'][0], ['Экструдированный пенополистирол', 'Пенополистирол']) &&
        // В упаковке > 0
        $src['v_upakovke'][0] > 0) {

        $upk = 1 / $src['v_upakovke'][0];
        if (!empty($m3)) {
            $m2 = $upk * $m2;
            $m3 = $upk * $m3;
        }
    }
    // Отдельные расчеты для baswool
    if (
        // Это baswool
        in_array($src['parent'], [168218,168259,168259,168260,168261,168262,168263,168264]) &&
        // В упаковке > 0
        $src['v_upakovke'][0] > 0
    ) {
        $thing = $src['v_upakovke'][0];
        // $upk = 1 / $src['v_upakovke'][0];
    }
}

// Единицы измерения для газобетона
if (in_array($src['context_key'], ['gazosilikatstroy'])) {
    if (!empty($src['kolvoshm3']) && !empty($src['kolvoshm3'][0])) {
        if (in_array($src['unit'][0], ['шт.', 'штука'])) {
            $m3 = 1 / ($src['kolvoshm3'][0]);
        } else {
            $thing = $src['kolvoshm3'][0];
        }

        if (!empty($src['pallet_num']) && !empty($src['pallet_num'][0])) {
            if (isset($thing)) {
                $pdn = 1 / ((1 / $thing) * $src['pallet_num'][0]);
            } else {
                $pdn_calced = $src['price'] * $src['pallet_num'][0];
            }
        }
    }
}


// Единицы измерения для trotuarnaya-plitka
if (in_array($src['context_key'], ['trotuarnaya-plitka'])) {
    $option_key = "kolichestvo-na-poddone-sht";
    if (!empty($src[$option_key]) && !empty($src[$option_key][0])) {
        // Бордюры – 250501
        if (in_array($src['parent'], [250501, 254677, 254678, 250509, 250510, 250511, 250513, 254679, 254680, 254681, 254426,])) {
            $pdn = 1 / $src[$option_key][0];
        }
    }

    $option_key = "item_length";
    if (!empty($src[$option_key]) && !empty($src[$option_key][0])) {
        // Металлические бордюры – 250514
        if (in_array($src['parent'], [250514])) {
            $thing = 1 / ($src[$option_key][0] / 1000);
        }
        // // Пластиковый бордюр - 250512
        // if (in_array($src['parent'], [250512])) {
        //     $pm = $result['defaultPrice'] / ($src[$option_key][0] / 1000);
        // }
    }

    $option_key = "pallet_num";
    if (!empty($src[$option_key]) && !empty($src[$option_key][0])) {
        // Тротуарная плитка – 250500
        if (in_array($src['parent'], [250500, 255090, 255073, 255074, 255075, 255076, 255077, 255080, 255081, 255082, 255083, 255084, 255086, 255087, 250504, 250505, 250506, 254676, 254685, 254686, 254687, 254688, 254689, 254690, 254691, 254692])) {
            $pdn = 1 / $src[$option_key][0];
        }
    }

    // $option_key = "kolvoshm2";
    // if (!empty($src[$option_key]) && !empty($src[$option_key][0])) {
    //     // Клинкерная брусчатка – 254676
    //     if (in_array($src['parent'], [254676])) {
    //         $thing = $result['defaultPrice'] / $src[$option_key][0];
    //     }
    // }

    // $option_key = "massa";
    // if (!empty($src[$option_key]) && !empty($src[$option_key][0])) {
    //     // Системы мощения – 250516
    //     if (in_array($src['parent'], [250516])) {
    //         $massa_kg = $result['defaultPrice'] / $src[$option_key][0];
    //     }
    // }

    // $option_key = "upakovka-l";
    // if (!empty($src[$option_key]) && !empty($src[$option_key][0])) {
    //     // Гидрофобизаторы и очистители – 250517
    //     if (in_array($src['parent'], [250517, 255106, 255107, 255108,])) {
    //         $upakovka_l = $result['defaultPrice'] / $src[$option_key][0];
    //     }
    // }
}

// Единицы измерения для газобетона
if (in_array($src['context_key'], ['krovelnyjstroymarket'])) {
    if (!empty($src['ploshad_m2']) && !empty($src['ploshad_m2'][0])) {
        $m2 = $src['ploshad_m2'][0];
    }
    if (!empty($src['kolvom2upak']) && !empty($src['kolvom2upak'][0])) {
        $upk = 1 / $src['kolvom2upak'][0];
    }
}

// Единицы измерения для плитных
if (in_array($src['context_key'], ['plitnye'])) {
    if (!empty($src['ploshad_m2']) && !empty($src['ploshad_m2'][0])) {
        $m2 = $src['ploshad_m2'][0];
    }
    if (!empty($src['kolvom2upak']) && !empty($src['kolvom2upak'][0])) {
        $upk = 1 / $src['kolvom2upak'][0];
    }
}
// Единицы измерения для белтермо
if (in_array($src['context_key'], ['beltermo'])) {
    if (!empty($src['ploshad_m2']) && !empty($src['ploshad_m2'][0])) {
        $m2 = $src['ploshad_m2'][0];
    }
    if (!empty($src['kolvom2upak']) && !empty($src['kolvom2upak'][0])) {
        $upk = 1 / $src['kolvom2upak'][0];
    }
}
// Единицы измерения для tagnerud
if (in_array($src['context_key'], ['tagnerud'])) {

    if(in_array($unit,['Мешок, шт'])) {
        if (!empty($src['obem'])) {
            $vol = (int)filter_var($src['obem'][0], FILTER_SANITIZE_NUMBER_INT) / 1000;
            // $result['itemUnits']['thing'] = ['val' => 1, 'title' => 'шт', 'id' => '6'];
            $result['itemUnits']['m3'] = [
                'val' => $vol, 
                'title' => 'м3', 
                'id' => '3'
            ];
        }
    }
    if(in_array($unit,['Биг-бэг, шт'])) {
        if (!empty($src['obem'])) {
            preg_match_all('#\d+.?\d?#',$src['obem'][0], $vol);
            $vol = (float) $vol[0][0];
            // $result['itemUnits']['thing'] = ['val' => 1, 'title' => 'шт', 'id' => '6'];
            $result['itemUnits']['m3'] = [
                'val' => $vol, 
                'title' => 'м3', 
                'id' => '3'
            ];
        }
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
    $result['itemUnits']['upk'] = ['val' => $upk, 'title' => 'упаковку', 'id' => '11'];
}
if (!empty($pdn) && ($pdn > 0) && ($pdn < $inf)) {
    $result['itemUnits']['pdn'] = ['val' => $pdn, 'title' => 'поддон', 'id' => '12'];
}
if (!empty($pdn_calced) && ($pdn_calced > 0) && ($pdn_calced < $inf)) {
    $result['itemUnits']['pdn_calced'] = ['val' => $pdn_calced, 'title' => 'поддон', 'id' => '13'];
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

if (count($result['itemUnits']) < 1 && !in_array($src['context_key'],['kraska','krovelnyjstroymarket', 'tagnerud'])) {
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
