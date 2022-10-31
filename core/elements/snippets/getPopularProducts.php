<?php

if (!function_exists('getSqlQuery')) {
    function getSqlQuery($where, $prodId) {
        return "SELECT `msProduct`.id, `Options`.`value` as format
                FROM `modx_site_content` AS `msProduct`
                -- Присоединяем опции
                JOIN `modx_ms2_product_options` `Options` ON `msProduct`.`id` =  `Options`.`product_id`
                -- Присоединяем поля товара
                LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` =  `Data`.`id`
                
                -- Выбираем только товары
                WHERE `msProduct`.`class_key` = 'msProduct'
                -- И не просто товары, а определенные...
                -- Товары с таким же форматом и родителем 'Строительный кирпич'. Или с форматом 2.1НФ и родителем 'Поризованный кирпич'
                AND " . $where . "

                -- А еще, чтобы они были опубликованы. И не удалены
                AND `msProduct`.`published` = 1
                AND `msProduct`.`deleted` = 0
                AND `msProduct`.`id` <> $prodId
                
                GROUP BY msProduct.id
                ORDER BY `msProduct`.menuindex
                
                -- 40, а не 42, потому что потом в самое начало добаляются 2 товара из кладочных смесей
                LIMIT 40";
    }
}

function getPopularProductsParams() {
    // Определение основных переменных
    global $scriptProperties;
    global $debug;
    global $modx;
    $product = $modx->resource;

    // Получение / установка $prodId
    $prodIdText = 'id товара, для которого будут выводиться популярные товары';
    if (empty($scriptProperties['prodId'])) {
        $debug[] = 'В $scriptProperties отсутствует параметр prodId (' . $prodIdText . '). Взят id текущего товара (' . $modx->resource->id . ').';
        $prodId = $modx->resource->id;
    } else {
        $debug[] = 'Получен параметр prodId (' . $prodIdText . ') из $scriptProperties (' . $scriptProperties['prodId'] . ').';
        $prodId = $scriptProperties['prodId'];
    }

    // Параметры по умолчанию
    $defaultParams = [
        'resources' => '-' . $prodId,
        'parents' => 0,
        'depth' => 50,
        'limit' => 42,
        'tpl' => '@FILE sections/popular/pop-slide.tpl',
        'includeTVs' => 'isFractional',
        'context' => $modx->resource->context_key,
        'tplWrapper' => '@FILE sections/popular/sect-pop-wrapper.tpl',
        'wrapIfEmpty' => 0
    ];

    // Объявление двух переменных: $resultStd - возвращаемое значение в стандартных случаях или в случае ошибки. $resultSpecial - возвращаемое значение в особых случаях
    $resultStd = $resultSpecial = $defaultParams;

    // Текстовые переменные - пригодятся для заполнения $debug
    $textStd = 'значение для стандартных случаев';
    $textSpecial = 'значение для особых случаев';


    // -------------------------------------
    // Популярные товары по умолчанию
    // -------------------------------------
    if (!empty($scriptProperties['resources'])) {
        $resultStd['resources'] = $scriptProperties['resources'];
        $debug[] = 'Получен параметр resources из $scriptProperties.';
    } else {
        $debug[] = 'В $scriptProperties отсутствует параметр resources.';

        // Если в сниппет не отправили строку с id популярных товаров (resources), то попробуем получить это значение из настроек контекста
        $popularIds = $modx->getOption('popular_ids');
        if (empty($popularIds)) {
            $debug[] = 'Не удалось получить значение popular_ids из настроек контекста (или оно пустое).';
        } else {
            $resultStd['resources'] = $popularIds;
            $debug[] = "Получено значение popular_ids из настроек контекста ($popularIds).";
        }
    }

    // Если это не kirpich-m, то возвращаем $resultStd
    if ($modx->resource->context_key != 'kirpich-m') {
        $debug[] = "Контекст не kirpich-m. Возвращено $textStd.";
        return $resultStd;
    }

    // -------------------------------------
    // Популярные товары для кирпичей
    // -------------------------------------
    // Определение, в какой группе кирпичей находится товар. От группы зависит алгоритм выборки популярных товаров
    $group = null;

    // Облицовочный кирпич
    $catIdsGroup1 = [37609, 19851, 19852, 37610];
    // Строительный кирпич
    $catIdsGroup2 = [37608];
    // Поризованный кирпич
    $catIdsGroup3 = [19848];

    // Сначала проверим 2 и 3 группы, т.к. это сделать проще (и быстрее с точки зрения производительности), чем 1 группу
    foreach ([2 => $catIdsGroup2, 3 => $catIdsGroup3] as $key => $val) {
        if (in_array($modx->resource->parent, $val)) {
            $group = $key;
            break;
        }
    }

    // Теперь проверим $catIdsGroup1 (если в этом есть необходимость - если $group все еще пустой)
    if (empty($group)) {
        // Возможно, РОДИТЕЛЬ явлется одной из тех категорий, которая нам нужна
        if (in_array($modx->resource->parent, $catIdsGroup1)) {
            $group = 1;
        } else {
            // Нет, РОДИТЕЛЬ не является ни одной из тех категорий, которая нам нужна. Проверяем доп. категории
            $table = $modx->getOption('table_prefix') . 'ms2_product_categories';
            $query = "SELECT *
                  FROM $table
                  WHERE product_id = $prodId AND category_id IN (" . implode(',', $catIdsGroup1) . ")";

            $items = $modx->query($query);
            $items = $items->fetchAll(PDO::FETCH_ASSOC);

            if (!empty($items)) {
                $group = 1;
            }
        }
    }

    // Проверка заполненности $group. Переменная должна быть заполнена. Если она не заполнена, то случилась какая-то ошибка - товар не находится ни в одной из 3 групп
    if (empty($group)) {
        $debug[] = "Не получилось определить группу кирпичей. Возвращено $textStd.";
        return $resultStd;
    }

    $debug[] = "Группа кирпичей определена как: $group.";

    // Одинаковые действия для групп 2 и 3
    if (in_array($group, [2, 3])) {
        $format = $modx->resource->get('format');

        if (!empty($format)) {
            $debug[] = 'Получено значение опции format: ' . implode(', ', $format) . '.';
        } else {
            $debug[] = 'Не удалось получить значение опции format (или оно пустое).';
        }
    }

    // Определение параметров в зависимости от группы
    switch ($group) {
        case 1:
            // Группа 1 - товары с таким же цветом, оттенком, поверхностью. Если какая-либо опция у текущего товара не задана, то она выпадет из условия "И". Сортировка - чем больше полей заполнено, тем выше приоритет
            $cvet = $product->get('cvet');
            $ottenok = $product->get('ottenok');
            $surface = $product->get('surface');

            $optionFilters = [];

            if (!empty($cvet)) {
                $optionFilters['cvet:IN'] = $cvet;
            }
            if (!empty($ottenok)) {
                $optionFilters['ottenok:IN'] = $ottenok;
            }
            if (!empty($factura)) {
                $optionFilters['surface:IN'] = $surface;
            }

            if (!empty($optionFilters)) {
                $optionFilters = json_encode($optionFilters, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
                $resultSpecial['optionFilters'] = $optionFilters;

                $debug[] = "Возвращено $textSpecial.";
                return $resultSpecial;
            } else {
                $debug[] = "Не удалось составить optionFilters, возвращено $textStd.";
                return $resultStd;
            }

            break;
        case 2:
            // Группа 2 - два товара из кладочных смесей; товары с таким же форматом и товары с форматом "2.1 НФ", но из категорий для группы 3 (т.к. в группе 4 нет товаров с таким форматом)
            if (!empty($format)) {
                $where = "(
                          (`Options`.`key` = 'format' AND `Options`.`value` = '$format[0]' AND `msProduct`.parent = 37608)
                          OR
                          (`Options`.`key` = 'format' AND `Options`.`value` = '2.1НФ' AND `msProduct`.parent = 19848)
                          )";
            } else {
                $where = "(`Options`.`key` = 'format' AND `Options`.`value` = '2.1НФ' AND `msProduct`.parent = 19848)";
            }

            break;
        case 3:
            // Группа 3 - два товара из кладочных смесей; товары с таким же форматом, товары с форматом "2.1 НФ" и товары с форматом, который отличается на 1 от формата текущего товара
            if (!empty($format)) {
                // Вся работа будет с самым первым элементом format
                $formatString = $format[0];
                // Заменяем запятые на точки, если запятые есть
                $formatString = str_replace(',', '.', $formatString);

                // Получаем число из текстового значения опции format
                //preg_match('/[0-9]+((\.[0-9])?[0-9]*)?/', $formatString, $formatNum);
                $formatNum = floatval($formatString);

                if (empty($formatNum)) {
                    $debug[] = "Не удалось получить число из текстового значения опции format ($formatString), чтобы найти товары, которые отличаются на 1 от format текущего товара. Либо это число равно 0.";

                    $where = "(`Options`.`key` = 'format' AND `Options`.`value` = '$format[0]') AND `msProduct`.parent = 19848)";
                } else {
                    //$formatNum = $formatNum[0];
                    $debug[] = "Удалось получить число ($formatNum) из текстового значения опции format ($formatString).";

                    $formatNumPlus = str_replace(',', '.', $formatNum + 1);
                    $formatNumMinus = str_replace(',', '.', $formatNum - 1);

                    $where = "(`Options`.`key` = 'format' AND ((`Options`.`value` = '2.1НФ') OR ((CAST(`Options`.`value` AS DECIMAL(4,2)) >= $formatNumMinus)) AND (CAST(`Options`.`value` AS DECIMAL(4,2)) <= $formatNumPlus))) AND `msProduct`.parent = 19848";
                }
            }

            break;
    }

    if (in_array($group, [2, 3])) {
        $query = getSqlQuery($where, $prodId);

        // Запуск SQL запроса и обработка результатов
        $resources = $modx->query($query);
        if ($resources === false) {
            $debug[] = "Во время SQL запроса произошла ошибка, возвращено $textStd.";
            return $resultStd;
        }
        $resources = $resources->fetchAll(PDO::FETCH_ASSOC);

        // Сортировка
        // Сначала - с таким же форматом
        $resourcesWithSameFormat = [];
        foreach ($resources as $key => $val) {
            if ($val['format'] === $format[0]) {
                $resourcesWithSameFormat[] = $val;
                unset($resources[$key]);
            }
        }

        // Потом - с форматом 2.1 НФ
        $resources2_1NF = [];
        foreach ($resources as $key => $val) {
            if ($val['format'] == '2.1НФ') {
                $resources2_1NF[] = $val;
                unset($resources[$key]);
            }
        }

        // Далее - зависит от группы
        switch ($group) {
            case 2:
                // Для группы 2 сортировка больше не нужна. Добавляем $resources2_1NF в конец массива $resourcesWithSameFormat
                $resources = array_merge($resourcesWithSameFormat, $resources2_1NF);

                break;
            case 3:
                // Далее - с наиболее близким форматом
                // Получаем разницу по модулю
                $resourcesAbs = [];
                foreach ($resources as $key => $val) {
                    $resourcesAbs[$key] = $val;
                    $resourcesAbs[$key]['abs'] = abs($formatNum - floatval($val['format']));
                }
                // Сортируем по разнице по модулю
                usort($resourcesAbs, function ($a, $b) {
                    return strcmp($a['abs'], $b['abs']);
                });

                // Объединяем массивы
                $resources = array_merge($resourcesWithSameFormat, $resources2_1NF, $resourcesAbs);

                break;
        }

        $resources = array_column($resources, 'id');
        // Добавление к отсортированным товарам двух товаров из кладочных смесей
        $resources = array_merge(['68082', '68083'], $resources);
        // Объединение массива в строку
        $resources = implode(',', $resources);

        // Добавление в параметры строки с ресурсами
        $resultSpecial['resources'] = $resources;
        // Добавление в параметры сортировки - как в строке с ресурсами
        $resultSpecial['sortby'] = "FIELD(msProduct.id, $resources)";

        return $resultSpecial;
    }
}

$debug = [];
$params = getPopularProductsParams();

$result = $modx->runSnippet('msProducts', $params);
echo $result;
