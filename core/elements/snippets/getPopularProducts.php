<?php

if (!function_exists('getSqlQuery')) {
    function getSqlQuery($where) {
        return "SELECT `msProduct`.id
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
                
                GROUP BY msProduct.id
                ORDER BY `msProduct`.menuindex
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
            // Группа 1 - товары с таким же цветом, оттенком, поверхностью. Если какая-либо опция у текущего товара не задана, то она выпадет из условия "И"
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

            /*
            $count = 0;
            foreach ($optionFilters as $key => $val) {
                $count++;
                if ($count == 1) {
                    continue;
                }

                // Вроде бы "AND" не работает в optionFilters. Нужно переписывать на обычном where. Но пока это не требуется
                $optionFilters['AND:' . $key] = $val;
                unset($optionFilters[$key]);
            }
            */

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
            // Группа 2 - два товара из кладочных смесей; товары с таким же форматом и товары с форматом "2.1 НФ", но из категорий для группы 5 (т.к. в группе 4 нет товаров с таким форматом)
            if (!empty($format)) {
                $where = "(
                          (`Options`.`key` = 'format' AND `Options`.`value` IN ('$format[0]') AND `msProduct`.parent = 37608)
                          OR
                          (`Options`.`key` = 'format' AND `Options`.`value` IN ('2.1НФ') AND `msProduct`.parent = 19848)
                          )";
            } else {
                $where = "(`Options`.`key` = 'format' AND `Options`.`value` IN ('2.1НФ') AND `msProduct`.parent = 19848)";
            }

            break;
        case 3:
            // Группа 3 - два товара из кладочных смесей; товары с таким же форматом и товары с форматом, который отличается на 1 от формата текущего товара
            if (!empty($format)) {
                // Вся работа будет с самым первым элементом format
                $formatString = $format[0];
                // Заменяем запятые на точки, если запятые есть
                $formatString = str_replace(',', '.', $formatString);
                // Получаем число из текстового значения опции format
                preg_match('/[0-9]+((\.[0-9])?[0-9]*)?/', $formatString, $formatNum);
                if (empty($formatNum)) {
                    $debug[] = "Не удалось получить число из текстового значения опции format ($formatString), чтобы найти товары, которые отличаются на 1 от текущего товара.";

                    $where = "(`Options`.`key` = 'format' AND `Options`.`value` IN ('$format[0]', '$formatNumPlusText', '$formatNumMinusText') AND `msProduct`.parent = 19848)";
                } else {
                    $formatNum = $formatNum[0];
                    $debug[] = "Удалось получить число ($formatNum) из текстового значения опции format ($formatString).";
                    $formatNumPlus = $formatNum + 1;
                    $formatNumMinus = $formatNum - 1;
                    $where = "((`Options`.`key` = 'format' AND ((CAST(`Options`.`value` AS DECIMAL(4,3) >= ) >= '$formatNumMinus') AND (CAST(`Options`.`value` AS DECIMAL(4,3) <= '$formatNumPlus') AND `msProduct`.parent = 19848)";
                }
            }

            break;
    }

    if (in_array($group, [2, 3])) {
        $query = getSqlQuery($where);

        // Запуск SQL запроса и обработка результатов
        $resources = $modx->query($query);
        if ($resources === false) {
            $debug[] = "Во время SQL запроса произошла ошибка, возвращено $textStd.";
            return $resultStd;
        }
        $resources = $resources->fetchAll(PDO::FETCH_ASSOC);
        $resources = array_column($resources, 'id');

        // Добавление к полученным товарам 2 кладочные смеси
        $resources = array_merge(['68082', '68083'], $resources);
        $resources = implode(',', $resources);

        // Сортировка так, чтобы кладочные смеси были в самом начале
        $resultSpecial['resources'] = $resources . ',-' . $prodId;
        $resultSpecial['sortby'] = "FIELD(msProduct.id, $resources)";

        return $resultSpecial;
    }
}

$debug = [];
$params = getPopularProductsParams();

$result = $modx->runSnippet('msProducts', $params);
echo $result;
