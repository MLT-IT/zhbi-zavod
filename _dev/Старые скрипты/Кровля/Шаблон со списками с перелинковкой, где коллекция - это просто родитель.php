<?php

// Самая важная характеристика - коллекция. Потом - оттенок. Потом - толщина.

// ------------------------------------
// Определение основных переменных
// ------------------------------------
// Ассоциативный массив с результатом
$result = [
    'parent' => [],
    'ottenok' => [],
    'item_thickness' => [],
    /*
    'pokrytie' => [],
    */
];

// id родителя и предка
$parent = $modx->getObject('modResource', $modx->resource->parent);
$parentId = $modx->resource->parent;
$ancestorId = $parent->parent;

// Параметры для вызова сниппета, чтобы получить получения ids для перелинковки
$params = [
    'depth' => 100,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'resources' => '-' . $modx->resource->id,
    'returnIds' => '1',
];


// ------------------------------------
// Определение функций
// ------------------------------------
if (!function_exists('composeOptionFilters')) {
    /**
     * Составить optionFilters для msProducts.
     *
     * @param $options - массив с опциями.
     * @return false|string|array - условия в нужном формате.
     */
    function composeOptionFilters($options, $returnEncodedData = true) {
        global $modx;

        $optionValues = [];

        foreach ($options as $opt) {
            $val = $modx->resource->get($opt);

            if (is_null($val)) {
                $optionValues[$opt . ':IS'] = null;
            } else {
                if (is_array($val)) {
                    if (count($val) === 1) {
                        $optionValues[$opt . ':='] = reset($val);
                    }
                }
            }
        }

        if ($returnEncodedData) {
            return json_encode($optionValues, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        } else {
            return $optionValues;
        }
    }
}

if (!function_exists('getIdsFromString')) {
    /**
     * Получить id из строки.
     *
     * @param $string - строка с id.
     * @return array - массив с id.
     */
    function getIdsFromString($string) {
        if (empty($string)) {
            return [];
        } else {
            return explode(',', $string);
        }
    }
}


// ------------------------------------
// Получение id для перелинковки
// ------------------------------------
// TODO: кол-во запросов к БД здесь можно уменьшить, если сохранять их в переменные

// Массив, где будут храниться нужные id
$idsArray = [];

// Получаем id для коллекции
$params = array_merge($params, ['parents' => $ancestorId]);
$idsGeneral = $modx->runSnippet('msProducts', $params);
/*
$idsArray['idsForCollection'][] = $modx->runSnippet('msProducts', array_merge($params, ['optionFilters' => composeOptionFilters(['ottenok', 'item_thickness', 'pokrytie'])]));
*/
$idsArray['idsForCollection'][] = $modx->runSnippet('msProducts', array_merge($params, ['optionFilters' => composeOptionFilters(['ottenok', 'item_thickness'])]));
$idsArray['idsForCollection'][] = $modx->runSnippet('msProducts', array_merge($params, ['optionFilters' => composeOptionFilters(['ottenok'])]));
$idsArray['idsForCollection'][] = $idsGeneral;

// Цикл - сначала получаем id для родителя (текущей коллекции), потом более общие - id для предка (для текущей коллекции). Затем складываем эти id.
foreach ([$parentId, $ancestorId] as $parents) {
    $params = array_merge($params, ['parents' => $parents]);

    // Получаем id для всех опций
    $idsGeneral = $modx->runSnippet('msProducts', $params);

    // id с оттенком. Нужно для получения id для толщины и покрытия
    $idsWithColor = $modx->runSnippet('msProducts', array_merge($params, [
        'optionFilters' => composeOptionFilters(['ottenok'])
    ]));

    // id для оттенка
    /*
    $idsArray['idsForColor'][] = $modx->runSnippet('msProducts', array_merge($params, ['optionFilters' => composeOptionFilters(['item_thickness', 'pokrytie'])]));
    */
    $idsArray['idsForColor'][] = $modx->runSnippet('msProducts', array_merge($params, ['optionFilters' => composeOptionFilters(['item_thickness'])
    ]));
    /*
    $idsArray['idsForColor'][] = $modx->runSnippet('msProducts', array_merge($params, ['optionFilters' => composeOptionFilters(['pokrytie'])
    ]));
    */
    $idsArray['idsForColor'][] = $idsGeneral;

    // id для толщины
    /*
    $idsArray['idsForThickness'][] = $modx->runSnippet('msProducts', array_merge($params, [
        'optionFilters' => composeOptionFilters(['ottenok', 'pokrytie'])
    ]));
    */
    $idsArray['idsForThickness'][] = $idsWithColor;
    /*
    $idsArray['idsForThickness'][] = $modx->runSnippet('msProducts', array_merge($params, [
        'optionFilters' => composeOptionFilters(['pokrytie'])
    ]));
    */
    $idsArray['idsForThickness'][] = $idsGeneral;

    /*
    // id для покрытия
    $idsArray['idsForSurface'][] = $modx->runSnippet('msProducts', array_merge($params, [
        'optionFilters' => composeOptionFilters(['ottenok', 'item_thickness'])
    ]));
    $idsArray['idsForSurface'][] = $idsWithColor;
    $idsArray['idsForSurface'][] = $modx->runSnippet('msProducts', array_merge($params, [
        'optionFilters' => composeOptionFilters(['item_thickness'])
    ]));
    $idsArray['idsForSurface'][] = $idsGeneral;
    */
}


// ------------------------------------
// Подготовка и складывание массивов
// ------------------------------------
foreach ($idsArray as $key => $idsStringsArray) {
    $newVal = [];

    // Подготавливаем массив для складывания
    foreach ($idsStringsArray as $idsString) {
        // Преобразуем в массив
        if (is_string($idsString)) {
            $v = getIdsFromString($idsString);
            // Переворачиваем, т.к. складывание происходит по ключам
            $v = array_flip($v);
            $newVal[] = $v;
        }
    }

    // Складываем массивы
    $newValTmp = [];
    foreach ($newVal as $v) {
        $newValTmp += $v;
    }
    $newVal = $newValTmp;

    // Сбрасываем значения, чтобы они стали уникальными и ничего не перезаписалось, когда мы будем переворачивать массивы обратно
    $i = 0;
    foreach ($newVal as $k => $nevermind) {
        $newVal[$k] = $i;
        $i++;
    }

    // Переворачиваем обратно
    $newVal = array_flip($newVal);

    // Устанавливаем новое значение
    $idsArray[$key] = $newVal;
}


// ------------------------------------
// Получение данных
// ------------------------------------
// Массив с id по ключам. Потом вместо id будут значения
$ids = [
    'parent' => $idsArray['idsForCollection'],
    'ottenok' => $idsArray['idsForColor'],
    'item_thickness' => $idsArray['idsForThickness'],
];
unset($idsArray);

// Массив с текущими значениями. Пригодится при заполнении массива с данными (нам понадобится исключить текущие значения)
$currentValues = [];
$keys = array_keys($ids);
foreach ($keys as $k) {
    $currentValues[$k] = $modx->resource->get($k);

    // Как правило, значение опции - это массив с одним элементом (но не всегда одним)
    if ($k !== 'parent') {
        $currentValues[$k] = $currentValues[$k][0];
    }
}

// Ключи опций. Нужно для SQL запроса
unset($keys['parent']);
$keysSql = array_map(function ($val) {
    return "'" . $val . "'";
}, $keys);
$keysSql = implode(',', $keysSql);

// Берем $ids['ottenok'] просто потому что при заполнении он в конце соединяется с $idsGeneral (как и idsForThickness)
$idsSql = implode(',', $ids['ottenok']);

// Получаем родителей и данные для опций
$query = "SELECT opts.*, resources.parent
          FROM " . $modx->getOption('table_prefix') . "ms2_product_options as opts
          INNER JOIN " . $modx->getOption('table_prefix') . "site_content as resources ON opts.product_id = resources.id
          WHERE opts.product_id IN(" . $idsSql . ") AND opts.key IN(" . $keysSql . ") AND opts.value <> '' AND opts.value IS NOT NULL";
$dataOpts = $modx->query($query);
$dataOpts = $dataOpts->fetchAll(PDO::FETCH_ASSOC);

// Получаем только уникальных родителей, чтобы сделать SQL-запрос
$parentIds = [];
foreach ($dataOpts as $val) {
    if ($val['parent'] !== $parent) {
        $parentIds[] = $val['parent'];
    }
}
$parentIds = array_unique($parentIds);
$parentIds = implode(',', $parentIds);

// Получаем данные для родителей
$query = "SELECT id, menutitle, pagetitle
          FROM " . $modx->getOption('table_prefix') . "site_content
          WHERE id IN(" . $parentIds . ")";
$dataParents = $modx->query($query);
$dataParents = $dataParents->fetchAll(PDO::FETCH_ASSOC);

// Формируем массив, где ключи - это id
$dataParentsByKey = [];
foreach ($dataParents as $val) {
    $dataParentsByKey[$val['id']] = [
        'title' => $val['menutitle'] ?: $val['pagetitle'],
        'id' => $val['id']
    ];
}
unset($dataParents);

// Устанавливаем данные родителей вместо id родителей
foreach ($dataOpts as $key => $val) {
    $dataOpts[$key]['parent'] = $dataParentsByKey[$val['parent']]['title'];
}

// Формируем массив с данными для родителей и опций
// На выходе получится такое:
// [ключ опции][id товара] = значение
// Пример:
// ["ottenok"][149] = "RAL 119"
$unsortedData = $result;
foreach ($dataOpts as $val) {
    // Опции
    // Если не пусто и не равно текущему значению, то добавляем в массив с результатом
    if (!empty($val['value']) && $val['value'] !== $currentValues[$val['key']]) {
        $unsortedData[$val['key']][$val['product_id']] = $val['value'];
    }

    // Родитель
    $unsortedData['parent'][$val['product_id']] = $val['parent'];
}

// Сортировка $unsortedData, чтобы было в том порядке, как в $ids
foreach ($ids as $key => $idsArray) {
    foreach ($idsArray as $id) {
        if (!empty($unsortedData[$key][$id])) {
            $result[$key][$id] = $unsortedData[$key][$id];
        }
    }
}

// Оставляем только уникальные
foreach ($keys as $key) {
    $result[$key] = array_unique($result[$key]);
}


// ------------------------------------
// Результат
// ------------------------------------
// Разбиваем ottenok на два массива
$result['ottenok'] = array_chunk($result['ottenok'], ceil(count($result['ottenok']) / 2), true);

return $result;
