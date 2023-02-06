<?php


/**
 *  TODO:
 *  1. запихни все нужные значения в переменную $result.
 *  2. Закешируй ее.
 *  3. Удали ненужные str_replace (кажется, они есть, я замечал их, ненужные они, потому что в конце есть цикл для str_replace).
 *  4. Замени в чанках вывод значений из переменных на вывод значений из ассоциативного массива, полученного в этом сниппете.
 *  5. Раздели экран на 2 и еще раз проверь, нигде ли ты не ошибся.
 *  6. Залей на тестовый и проверь параллельно с боевым - есть ли разница в коэффициентах, ценах и т.д...
 */

/**
 Важные объснения.
 1. У некоторых опций тип - не число, а текст. Со значениями опций в этом скрипте производятся арифметические действия. Чтобы не было ошибок, ДО выполнения арифметики нужно убрать из значения пробелы и заменить запятые на точки.
 2. Если на Windows вывести float-значение из php, то оно выведется с запятой. Если на Linux, то с точкой. В этом файле вычисляются коэффициенты, которые потом будут использоваться в арифметических действиях на JS. Для арифметики запятая не подойдет, поэтому после каких-либо вычислений необходимо float-значение преобразовать в строку с точкой в качестве разделителя.
 */

$result = [
    // id товара и ключ товара
    'productKey', // ключ товара
    'prodId', // id товара

    // цены
    'defaultPrice', // просто текущая цена
    'outputPrice', // текущая цена для красивого вывода
    'defaultOldPrice', // просто старая цена
    'outputOldPrice', // старая цена для красивого вывода

    // другие значения
    'checkItems',  // информация о нахождении товара в избранном или сравнении
    'itemInCart', // кол-во товара в корзине
    'pricePer', // тестовое значение единицы измерения, за которую измеряется цена

    // tv-значения
    'isFractional' // может ли кол-во товара быть дробным?
];

// Подгружаем pdoTools, чтобы запускать файловые сниппеты
$pdoTools = $modx->getService('pdoTools');


// ------------------------------------
// Установка переменных с информацией о товаре
// ------------------------------------
// id товара, нужен для добавления товара в корзину
$prodId = $src['id'];
// Ключ товара, нужен для изменения товара в корзине
$productKey = str_replace(' ', '', $src['id'] . $src['price'] . $src['weight'] . '[]');

// Цена по умолчанию - нужна для расчета других цен на JS
$defaultPrice = str_replace([',', ' '], ['.', ''], $src['price']);
// Цена для красивого вывода
$outputPrice = str_replace(',', '.', preg_replace('/\B(?=(\d{3})+(?!\d))/', ' ', $src['price']));

// Старая цена
if ($src['old_price']) {
    // Цена по умолчанию
    $defaultOldPrice = str_replace([',', ' '], ['.', ''], $src['old_price']);
    // Цена для красивого вывода
    $outputOldPrice = str_replace(',', '.', preg_replace('/\B(?=(\d{3})+(?!\d))/', ' ', $src['old_price']));
}

// Есть ли товар в избранном, в сравнении
$checkItems = $modx->getPlaceholder('checkItems');
// Кол-во товара в корзине
$itemInCart = $checkItems['cart'][$src['id']];

// Цена за ...
$unit = $src['unit'][0];
if (empty($unit) || $unit == 'упаковка') {
    $pricePer = 'упаковку';
} else if ($unit == 'тонна') {
    $pricePer = 'тонну';
} else {
    $pricePer = $unit;
}

/*
 Выводить ли возможность выбирать единицу измерения для добавления товара в корзину
 Условия...
 1. Должен быть правильный контекст.
 2. Родитель не должен быть сопутствующими товарами ИЛИ Родитель должен быть Ондулином или Ондулином Смарт (krovlyasp)
*/
$condition = in_array($src['context_key'], ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc', 'armatura-178', 'pilomat', 'kirpich-m', 'plitaosb', 'pro-fanera', 'fasady-pro', 'krovlya', 'plity-mdvp', 'policarbonat']) && (!in_array($src['parent'], [9052, 9125, 14193, 14269, 10998, 12018, 12819, 15201, 15202]) || in_array($src['parent'], [16805, 36871]));

// Дробное добавление товара в корзину
if (in_array($modx->resource->template, [17, 20, 6, 21, 22])) {
    $isFractional = $modx->resource->getTVValue('isFractional');
} else {
    $isFractional = $src['isFractional'];
}
if ($isFractional == 1) {
    $extraClass = ' custom-counter_type_fractional';
    $dataMin = '0.01';
} else {
    $extraClass = '';
    $dataMin = '1';
}


// ------------------------------------
// Установка единиц измерения
// ------------------------------------
// Единицы измерения для утеплителей
if (in_array($src['context_key'], ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc'])) {
    $pm = str_replace(',', '.', $src['kolvo-pm'][0]);
    $m2 = $src['ploshad_m2'][0];
    $m3 = str_replace(',', '.', $src['obyem_m3'][0]);

    if (!empty($src['v_upakovke'][0]) && $src['context_key'] == 'penoplex') {
        if (!in_array($src['parent'], [9125, 9052, 15025, 79589, 79590])) {
            $upk = 1 / $src['v_upakovke'][0];
            $pm = 1 / ($src['v_upakovke'][0] * (1 / $src['kolvo-pm'][0]));
            $m2 = 1 / ($src['v_upakovke'][0] * (1 / $src['ploshad_m2'][0]));
            $m3 = 1 / ($src['v_upakovke'][0] * (1 / $src['obyem_m3'][0]));
        } else {
            $list = $src['v_upakovke'][0];
        }
    }
}

// Единицы измерения для арматуры
if ($src['context_key'] == 'armatura-178') {
    $metrov_v_tonne = str_replace(',', '.', $src['kolichestvo-metrov-v-1-tonne'][0]);
    $dlina_m = str_replace(',', '.', $src['dlina-m'][0]);

    if ($metrov_v_tonne > 0) {
        if ($dlina_m > 0) {
            $thing = $metrov_v_tonne / $dlina_m;
        }
        $pm = $metrov_v_tonne;
    }
}

// Единицы измерения для пиломата
if ($src['context_key'] == 'pilomat') {
    $pilomat_thing = str_replace(',', '.', $src['kol-vokub-sh'][0]);
}

// Единицы измерения для кирпича
if ($src['context_key'] == 'kirpich-m') {
    $k_m3seam = str_replace(',', '.', (1 / $src['k_m3seam'][0]));
    $k_m2seam = str_replace(',', '.', (1 / $src['k_m2seam'][0]));
}

// Единицы измерения для Гибкой черепицы, которая измеряется в м2
if ($src['context_key'] == 'krovlya' && $src['unit'][0] == 'м2') {
    $additionalCategories = explode(',', $pdoTools->runSnippet('@FILE snippets/getCategories.php', ['id' => $src['id']]));

    $parentsArray = [15556, 18298, 18297, 15563, 15562, 15560, 15559, 15558, 15557, 18322, 15555, 15554, 15553, 15552, 15551, 15550, 15549, 15548, 18353, 25907, 25905, 25904, 25894, 25890, 22592, 22292, 18354, 15547, 18352, 18351, 18350, 18349, 18348, 18347, 18332, 15442, 15485, 15451, 15448, 15447, 15446, 15445, 15444, 15443, 15486, 15441, 15440, 15435, 15434, 15433, 15432, 15431, 15430, 15536, 15546, 15545, 15544, 15543, 15542, 15539, 15538, 15537, 15429, 15535, 15501, 15491, 15490, 15489, 15488, 15487];

    $checkIntersect = $pdoTools->runSnippet('@FILE snippets/checkIntersect.php', [
        'array1' => $additionalCategories,
        'array2' => $parentsArray
    ]);

    // Если родитель есть в Гибкой черепице. Или одна из доп. категорий - Гибкая черепица
    if (in_array($src['parent'], $parentsArray) || $checkIntersect) {
        $upk = 1 / $src['kolvom2upak'][0];
    }
}

// Единицы измерения для плит ОСБ и фанеры
if (in_array($src['context_key'], ['plitaosb', 'pro-fanera', 'policarbonat'])) {
    $m2 = $src['ploshad_m2'][0];
}

// Единицы измерения для Ондулина и Ондулина Смарт (krovlyasp)
if (in_array($src['parent'], [16805, 36871]) && !empty($src['ploshad_m2'][0])) {
    $list = str_replace(',', '.', (1 / $src['ploshad_m2'][0]));
}

// Единицы измерения для Уголвков (armatura-178)
if (in_array($src['parent'], [71771, 71772, 71774]) && !empty($src['metrov-v-tonne'][0])) {
    $meter = str_replace(',', '.', $src['metrov-v-tonne'][0]);
}

// Единицы измерения для Труб (armatura-178)
if (in_array($src['parent'], [79636, 71768, 79637, 79638, 79639, 71769, 71770, 71766, 71767]) && !empty($src['massa-1m-kg'][0])) {
    $pm = str_replace(',', '.', $src['massa-1m-kg'][0]) / 1000;

    if (!empty($src['dlina-m'][0])) {
        $tmp = str_replace(',', '.', $src['dlina-m'][0]);
        if ($tmp > 0) {
            $thing = str_replace(',', '.', 1 / ($pm * $tmp));
        }
    }

    $pm = str_replace(',', '.', 1 / $pm);
}

// Единицы измерения fasady-pro
if ($src['context_key'] == 'fasady-pro') {
    $m2 = str_replace([',', ' '], ['.', ''], $src['obschaya-ploshad'][0]);
    $m3 = 1 / str_replace([' ', ','], ['', '.'], $src['kol-vokub-sh'][0]);
    $upk = str_replace(' ', ',', 1 / $src['v_upakovke'][0]);
}

// Единицы измерения krovlya
// Для Цементно-песчаная черепица (22596) и Керамическая черепица (22599) нужно вывести цену за м2
if ($src['context_key'] == 'krovlya' && in_array($src['parent'], 22596, 22599, 66808, 66794, 66795, 66796, 66797, 66798, 66799, 66800, 66801, 66802, 66803, 66804, 66805, 66806, 66807, 66793, 66809, 66810, 66811, 66812, 66813, 66814, 66857, 66858, 66859, 66860, 66861, 66862, 66865, 66873, 64851, 22598, 22600, 64676, 64679, 64683, 64690, 64693, 64768, 64773, 64780, 64785, 64797, 64822, 64846, 22597, 64854, 64859, 64868, 66724, 66725, 66740, 66747, 66748, 66768, 66769, 66770, 66771, 66772, 66773)) {
    $length = $src['item_length'][0];
    $width = $src['item_width'][0];

    if (!empty($length) && !empty($width)) {
        $m2 = $length * $width / 1000000;
    }
}

// Единицы измерения для plity-mdvp
if ($src['context_key'] == 'plity-mdvp') {
    // round нужен, т.к. на странице с перелинковкой через fenom выводится (расчитывается) цена за м2. А в каталоге, например, при смене единицы измерения рассчеты происходят через JS. И результат расчета на fenom отличается от результата на JS. А если округлить, то все норм *}
    $list = str_replace(',', '.', round(1 / $src['ploshad_m2'][0]));
}

// Установка itemUnits
$inf = 999999999999999999;
$itemUnits = [];

// TODO: возможно, с помощью цикла код можно упростить
if (!empty($m2) && ($m2 > 0) && ($m2 < $inf)) {
    $itemUnits['m2'] = ['val' => $m2, 'title' => 'м2', 'id' => '2'];
}
if (!empty($m3) && ($m3 > 0) && ($m3 < $inf)) {
    $itemUnits['m3'] = ['val' => $m3, 'title' => 'м3', 'id' => '3'];
}
if (!empty($pm) && ($pm > 0) && ($pm < $inf)) {
    $itemUnits['pm'] = ['val' => $pm, 'title' => 'п.м.', 'id' => '4'];
}
if (!empty($list) && ($list > 0) && ($list < $inf)) {
    $itemUnits['list'] = ['val' => $list, 'title' => 'лист', 'id' => '5'];
}
if (!empty($thing) && ($thing > 0) && ($thing < $inf)) {
    $itemUnits['thing'] = ['val' => $thing, 'title' => 'штуку', 'id' => '6'];
}
if (!empty($pilomat_thing) && ($pilomat_thing > 0) && ($pilomat_thing < $inf)) {
    $itemUnits['pilomat_thing'] = ['val' => $pilomat_thing, 'title' => 'штуку', 'id' => '7'];
}
if (!empty($k_m2seam) && ($k_m2seam > 0) && ($k_m2seam < $inf)) {
    $itemUnits['k_m2seam'] = ['val' => $k_m2seam, 'title' => 'м2', 'id' => '8'];
}
if (!empty($k_m3seam) && ($k_m3seam > 0) && ($k_m3seam < $inf)) {
    $itemUnits['k_m3seam'] = ['val' => $k_m3seam, 'title' => 'м3', 'id' => '9'];
}
if (!empty($meter) && ($meter > 0) && ($meter < $inf)) {
    $itemUnits['meter'] = ['val' => $meter, 'title' => 'метр', 'id' => '10'];
}
if (!empty($upk) && ($upk > 0) && ($upk < $inf)) {
    $itemUnits['upk'] = ['val' => $upk, 'title' => 'упаковка', 'id' => '11'];
}

if (!empty($modx->getPlaceholder('checkFloatTrouble'))) {
    foreach ($itemUnits as $key => $val) {
        // Здесь происходит неявное приведение типов - числа в строку (функция replace ведь работает со строками). И замена запятой на точку. Зачем? См. в самом начале объяснение 2
        $itemUnits[$key] = str_replace(',', '.', $val);
    }
    $productKey = str_replace(',', '.', $productKey);
}

if (count($itemUnits) < 1) {
    $condition = false;
}

$productKey = md5($productKey);
