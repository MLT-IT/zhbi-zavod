<?php

// TODO: Напиши кеширование.
// TODO: напиши "показывать в категориях"

class getPopularProductsClass {

    protected static $debug = []; // Массив, в котором хранятся сообщения о поиске популярных (рекомендуемых) товаров

    // Текстовые переменные для заполнения $debug
    protected static $textStd = 'значение для стандартных случаев';
    protected static $textSpecial = 'значение для особых случаев';

    protected static $prod; // Товар, к которому подбираются популярные (рекомендуемые) товары

    protected static $resultStd = []; // Возвращаемое значение в стандартных случаях или в случае ошибки
    protected static $resultSpecial = []; // Возвращаемое значение в особых случаях (которые описаны в этом классе)


    /**
     * Установка основных полей класса.
     */
    protected static function init() {
        global $modx;
        global $scriptProperties;

        $prodId = null;
        $prodIdText = 'id товара, для которого будут выводиться популярные товары';

        if (empty($scriptProperties['prodId'])) {
            self::$debug[] = 'В $scriptProperties отсутствует параметр prodId (' . $prodIdText . '). Поэтому взят id текущего товара (' . $modx->resource->id . ').';
            $prodId = $modx->resource->id;
        } else {
            self::$debug[] = 'Получен параметр prodId (' . $prodIdText . ') из $scriptProperties (' . $scriptProperties['prodId'] . ').';
            $prodId = $scriptProperties['prodId'];
        }

        // TODO: здесь нужен exception - вдруг не получилось найти товар с таким id
        self::$prod = $modx->getObject('modResource', $prodId);

        $defaultParams = [
            'resources' => '-' . $prodId,
            'parents' => 0,
            'depth' => 50,
            'limit' => 42,
            'tpl' => '@FILE sections/popular/pop-slide.tpl',
            'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
            'context' => self::$prod->context_key,
            'tplWrapper' => '@FILE sections/popular/sect-pop-wrapper.tpl',
            'wrapIfEmpty' => 0
        ];
        self::$resultStd = self::$resultSpecial = $defaultParams;
    }


    /**
     * Попытка получить строку с id ресурсов извне (из $scriptProperties или из настроек контекста).
     */
    protected static function tryGetResourcesFromOutside() {
        global $scriptProperties;
        global $modx;

        // Попробуем получить значение из $scriptProperties
        if (!empty($scriptProperties['resources'])) {
            self::$resultStd = self::addResourcesAndSort(self::$resultStd, $scriptProperties['resources']);
            self::$debug[] = 'Получен параметр resources из $scriptProperties: ' . $scriptProperties['resources'] . '.';
        } else {
            self::$debug[] = 'В $scriptProperties отсутствует параметр resources.';

            // Попробуем получить значение из настроек контекста
            $resources = $modx->context->getOption('popular_ids');
            if (empty($resources)) {
                self::$debug[] = 'Не удалось получить значение popular_ids из настроек контекста (или оно пустое).';
            } else {
                self::$resultStd = self::addResourcesAndSort(self::$resultStd, $resources);
                self::$debug[] = "Получено значение popular_ids из настроек контекста: $resources.";
            }
        }
    }


    /**
     * Удобная обертка для return.
     */
    protected static function rtn($params) {
        return [
            'params' => $params,
            'debug' => self::$debug
        ];
    }


    /**
     * Добавляет в массив $params ключи "resources" и "sortby" со значениями на основе параметра $resources.
     */
    protected static function addResourcesAndSort($params, $resources) {
        return array_merge($params, [
            'resources' => $resources,
            'sortby' => "FIELD(msProduct.id, $resources)"
        ]);
    }


    /**
     * Главная открытая функция класса.
     * @return array
     */
    public static function getPopularProductsParams() {
        // Устанавливаем основные поля класса
        self::init();

        // Возможно, популярные (рекомендуемые) товары есть у ресурса в tv и ничего вычислять не надо
        $recommendIds = self::$prod->getTVValue('recommendIds');
        if ($recommendIds) {
            self::$debug[] = 'Популярные (рекомендуемые) товары получены из tv recommendIds: ' . $recommendIds;
            self::$resultStd = self::addResourcesAndSort(self::$resultStd, $recommendIds);
            return self::rtn(self::$resultStd);
        }

        // Попробуем получить строку с id ресурсов извне и записать в $resultStd
        self::tryGetResourcesFromOutside();

        // Определение специфичных контекстов
        $specificCtxs = ['kirpich-m', 'krovlya'];

        // Вывод для неспецифичных контекстов
        // Если для текущего контекста нет логики в этом скрипте, то возвращаем значение для стандартных случаев
        if (!in_array(self::$prod->context_key, $specificCtxs)) {
            self::$debug[] = "Контекст не является специфичным (специфичные: " . implode(', ', $specificCtxs) . "). Возвращено self::$textStd.";
            return self::rtn(self::$resultStd);
        }

        // Получение ресурсов для специфичных контекстов
        switch (self::$prod->context_key) {
            case 'kirpich-m':
                $resources = self::kirpich();
                break;

            case 'krovlya':
                $resources = self::krovlya();
                break;
        }

        if ($resources === false) {
            return self::rtn(self::$resultStd);
        }

        self::$resultSpecial = self::addResourcesAndSort(self::$resultSpecial, $resources);

        self::$debug[] = "Возвращено " . self::$textSpecial . ".";
        return self::rtn(self::$resultSpecial);
    }


    /**
     * Получение популярных товаров для кровли.
     */
    static protected function krovlya() {
        global $modx;

        $group = null;
        $optValsToFind = []; // Если передать в этот массив значение для какой-либо опции из $relatedOpts, то сопутствующие товары будут искаться не по значению текущего ресурса, а по переданному значению
        $relatedOpts = []; // Сопутствующие товары ищутся по опциям из этого массива


        // Определяем группу, от нее зависит алгоритм выбора соответствующих товаров
        switch (true) {
            // -------------------------------
            // Группа 1
            // -------------------------------
            case in_array(self::$prod->parent, [
                // Металлочерепица и потомки
                16788,
                11760, 12069, 12070, 12071, 12073, 12074, 16789, 37621, 44676, 44677, 44678, 44679, 44680, 44681, 76923
            ]):
                $group = 1;
                $relatedOpts = ['proizvoditel', 'item_thickness', 'cvet', 'pokrytie'];
                break;

            // -------------------------------
            // Группа 2
            // -------------------------------
            case in_array(self::$prod->parent, [
                // Доборные элементы фальц и потомки
                49196,
                49197, 49198, 49199, 49200, 49201, 49202, 49203, 49204, 49205, 49206, 49207, 49208, 49209,

                // Ендовы для кровли
                15439,
                // Ендовы для кровли -> Grand Line и потомки
                18441,
                49227, 49228, 49229, 49230, 49231, 49232,
                // Ендовы для кровли -> Металл Профиль и потомки
                64101,
                64114, 64125, 64128,

                // Заглушки и потомки
                49233,
                49234, 49235, 49236, 49237, 49238, 60143, 60146, 60149, 60152,

                // Карнизные планки и потомки
                18442,
                18443, 49195, 49239, 64133, 64142, 64146,

                // Коньковые элементы для кровли и потомки
                15437,
                49255, 64173, 64166, 64163, 64156, 49264, 49262, 49261, 49260, 49259, 49258, 49257, 49256, 15496, 49254, 49253, 49252, 49251, 25909, 22293, 18445, 18440, 15566, 15541, 15540,

                // Лобовые планки и потомки
                49265,
                49266, 49267,

                // Планки примыкания
                49274,

                // Планки снегозадержания и потомки
                49268,
                49269, 49270, 49271,

                // Торцевые планки
                18447,

                // Тройники
                49288,

                // Четверники
                49292,
            ]):
                $group = 2;
                $relatedOpts = ['proizvoditel', 'cvet', 'pokrytie'];

                // У товаров с производителем "Металл Профиль" выборка сопутствующих товаров происходит из другого родителя
                $vendor = self::$prod->get('proizvoditel');
                if (!empty($vendor)) {
                    $vendor = mb_strtolower(preg_replace('/[\s-]/', '', self::$prod->get('proizvoditel')[0]));
                    if ($vendor == 'металлпрофиль') {
                        $parents = [
                            16788
                        ];
                        $optValsToFind['proizvoditel'] = ['Монтерей'];
                    }
                }

                // У товаров с покрытием "Цинк" к опциям для поиска сопутствующих товаров добавляется "item_thickness"
                $pokrytie = self::$prod->get('pokrytie');
                if (!empty($pokrytie) && $pokrytie[0] == 'Цинк') {
                    $relatedOpts[] = 'item_thickness';
                }

                break;
        }

        if (empty($group)) {
            self::$debug[] = "Не получилось определить группу. Возвращено " . self::$textStd . ".";
            return false;
        }

        // Определяем и заполняем нужные для работы переменные
        $sqlWhere = []; // where для SQL-запроса
        $resourceValues = []; // значения опций текущего ресурса
        $sqlJoins = []; // join'ы для SQL-запроса
        $sqlSelect = []; // select для SQL-запроса
        $resourcesSorted = []; // Многомерный массив с отсортированными ресурсами

        foreach ($relatedOpts as $opt) {
            $optVal = $optValsToFind[$opt] ?: self::$prod->get($opt);

            if (empty($optVal)) {
                continue;
            }

            // Заполняем $resourcesSorted
            $resourcesSorted[] = [];

            // Заполняем $resourceValues
            $resourceValues[$opt] = $optVal;

            // Заполняем $sqlWhere
            $optValWithQuotes = array_map(function ($v) {
                return "'$v'";
            }, $optVal);
            $sqlWhere[] = "(`$opt`.`value` IN (" . implode(',', $optValWithQuotes) . "))";

            // Заполняем $sqlJoins
            $sqlJoins[] = "LEFT JOIN `modx_ms2_product_options` `$opt` ON `$opt`.product_id = Data.id AND `$opt`.key = '$opt'";

            // Заполняем $sqlSelect
            $sqlSelect[] = "`$opt`.`value` as $opt";
        }

        if (!empty($resourceValues)) {
            // Работа с $sqlWhere
            $sqlWhere = implode(' OR ', $sqlWhere);
            $sqlWhere = "AND ($sqlWhere)";
            self::$debug[] = "Составлено дополнительное where: \"$sqlWhere\".";

            // Работа с $sqlSelect
            $sqlSelect = ' , ' . implode(', ', $sqlSelect);

            // Работа с $sqlJoins
            $sqlJoins = implode(' ', $sqlJoins);

        } else {
            $sqlWhere = $sqlJoins = $sqlSelect = '';
            self::$debug[] = "У товара не заполнены нужные для поиска соответствующих товаров опции, дополнительное where не составлено.";
        }

        // Определяем родителей в зависимости от группы
        switch ($group) {
            case 1:
                $parents = [
                    // Доборные элементы
                    15436, 15437, 15438, 15439, 15449, 15492, 15493, 15494, 15495, 15496, 15497, 15498, 15499, 15500, 15540, 15541, 15564, 15566, 18323, 18324, 18325, 18326, 18327, 18328, 18330, 18331, 18440, 18441, 18442, 18443, 18445, 18447, 18448, 18449, 22290, 22291, 22293, 22593, 25909, 26246, 26247, 26249, 26250, 26251, 26252, 26253, 26254, 26255, 26256, 26257, 49195, 49196, 49197, 49198, 49199, 49200, 49201, 49202, 49203, 49204, 49205, 49206, 49207, 49208, 49209, 49210, 49211, 49212, 49213, 49214, 49215, 49216, 49217, 49218, 49219, 49220, 49221, 49222, 49223, 49224, 49225, 49226, 49227, 49228, 49229, 49230, 49231, 49232, 49233, 49234, 49235, 49236, 49237, 49238, 49239, 49240, 49241, 49242, 49243, 49244, 49245, 49246, 49247, 49248, 49249, 49250, 49251, 49252, 49253, 49254, 49255, 49256, 49257, 49258, 49259, 49260, 49261, 49262, 49264, 49265, 49266, 49267, 49268, 49269, 49270, 49271, 49272, 49273, 49274, 49275, 49276, 49277, 49278, 49279, 49280, 49281, 49282, 49283, 49284, 49285, 49286, 49287, 49288, 49289, 49290, 49291, 49292, 49293, 49294, 49295, 49296, 49297, 49298, 49299, 60143, 60146, 60149, 60152, 64101, 64114, 64125, 64128, 64133, 64142, 64146, 64156, 64163, 64166, 64173, 64182, 64185, 64188, 64201, 64204, 64209, 64211, 64221, 64234, 64238,

                    // Комплектующие
                    56941, 57437, 56971, 56987, 56991, 57006, 57010, 57013, 57016, 57019, 57028, 57034, 57038, 57045, 57392, 57393, 57394, 57395, 57396, 57397, 57398, 57399, 57400, 57401, 57402, 57403, 57404, 57405, 57406, 57407, 57408, 57409, 57410, 57411, 57412, 57413, 57414, 57415, 57416, 57417, 57418, 57419, 57420, 57421, 57422, 57423, 57424, 57425, 57426, 57427, 57428, 57429, 57430, 57431, 57432, 57433, 57434, 57435, 57436, 57438, 57439, 57440, 57497, 57499, 57576, 57581, 57582, 57583, 57584, 57586, 57587, 57588, 57589, 57590, 57591, 57592, 57593, 57594, 57595, 57596, 57597, 57598, 57600, 57602, 57603, 57604, 57605, 57606, 57608, 57609, 57610, 57611, 57612, 57613, 57614, 57615, 57616, 57617, 57618, 57619, 57620, 57621, 57622, 57623, 57624, 57625, 57626, 57627, 57628, 57629, 57630, 57631, 57632, 57633, 57634, 57635, 57636, 57637, 57638, 57639, 57641, 57642, 57643, 57645, 57646, 57655, 57659, 57663, 57667, 57675, 57679, 57692, 57697, 57701, 57704, 57708, 57711, 57715, 57718, 57728, 57731, 57736, 57742, 57748, 57759, 57764, 57768, 57772, 57876, 57878, 57879, 57880, 57881, 57882, 57883, 57884, 57885, 57886, 57887, 57888, 57889, 57890, 57891, 57892, 57893, 57894, 57895, 57896, 57897, 57898, 57899, 57900, 57901, 57902, 57903, 57904, 57905, 57906, 57907, 57908, 57909, 57910, 57911, 57912, 57913, 57914, 57915, 57916, 57917, 57918, 57919, 57920, 57921, 57922, 57923, 57924, 57925, 57926, 57927, 57928, 57929, 57930, 57931, 57932, 57933, 57934, 57935, 57936, 57937, 57938, 57939, 57940, 57941, 57942, 57943, 57944, 57945, 57946, 57947, 57948, 57949, 57950, 57951, 57952, 57953, 57954, 57955, 57956, 57957, 57958, 57959, 57960, 57961, 57962, 57963, 57964, 57965, 57966, 57967, 57968, 57969, 57970, 57971, 57972, 57973, 57974, 57975, 57976, 57977, 57982, 57985, 57995, 57998, 58004, 58010, 58013, 58018, 58020, 58024, 58028, 58032, 58035, 58042, 58046, 58051, 58055, 58070, 58071, 58076, 58081, 58084, 58089, 58091, 58099, 58102, 58105, 58108, 58109, 58112, 58118, 58122, 58129, 58132, 58134, 58141, 58156, 58158, 58162, 58166, 58171, 58173, 58182, 58184, 58192, 58194, 58224, 58228, 58229, 58230, 58231, 58234, 58238, 58243, 58248, 58269, 58273, 58283, 58295, 58300, 58308, 58313, 58316, 58322, 58333, 58334, 58335, 58336, 58337, 58338, 58340, 58341, 58342, 58343, 58344, 58345, 58346, 58347, 58348, 58349, 58351, 58352, 58353, 58354, 58356, 58357, 58358, 58359, 58360, 58361, 58362, 58363, 58364, 58365, 58366, 58368, 58369, 58370, 58371, 58372, 58373, 58374, 58375, 58376, 58377, 58380, 58381, 58382, 58524, 58537, 58543, 58548, 58552, 58555, 58559, 58570, 58573, 58576, 58580, 59568, 59571, 59574, 59577, 59582, 59587, 59597, 59600, 59612, 59617, 59620, 59625, 59630, 59633, 66863, 66864, 66866, 66868, 66874, 66875
                ];

                break;

            case 2:
                $parents = [
                    // Металлочерепица и потомки
                    16788,
                    11760, 12069, 12070, 12071, 12073, 12074, 16789, 37621, 44676, 44677, 44678, 44679, 44680, 44681, 76923,

                    // Фальцевая кровля и потомки
                    22594,
                    22595, 26835, 26846, 26856, 26868, 26875, 26922, 26948, 26957,

                    // Профилированный лист и потомки
                    86214,
                    43711, 81055, 81054, 81053, 81056, 81057, 81047, 43790, 43775, 43760, 43748, 43730, 43720, 43536, 81058, 86224, 86215, 86225, 86217, 86218, 86219, 86220, 86221, 86222, 86223, 86226, 86227, 41715, 41709, 41706, 41701, 41699, 41690, 41684, 41628, 86229, 37728, 81052, 86216, 26581, 81051, 26582
                ];

                break;
        }

        // Делаем SQL запрос
        $query = "SELECT `msProduct`.`id` $sqlSelect

                  FROM `modx_site_content` AS `msProduct`
                  
                  -- Присоединяем поля товара
                  LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` = `Data`.`id`
                  -- Присоединяем опции
                  $sqlJoins
                  
                  -- Выбираем только товары
                  WHERE `msProduct`.`class_key` = 'msProduct'
                  -- И не просто товары, а определенные...
                  $sqlWhere
                  -- И в определенных родителях
                  AND parent IN(" . implode(',', $parents) . ")
                  
                  -- Проверяем, чтобы товары были опубликованы, не удалены, чтобы не было выбора текущего товара
                  AND `msProduct`.`published` = 1
                  AND `msProduct`.`deleted` = 0
                  AND `msProduct`.`id` <> " . self::$prod->id . "
                                    
                  GROUP BY msProduct.id
                  ORDER BY `msProduct`.menuindex
    
                  LIMIT 42";

        // Запуск SQL запроса и обработка результатов
        $resources = $modx->query($query);

        if ($resources === false) {
            self::$debug[] = "Во время SQL запроса произошла ошибка, возвращено " . self::$textStd . ".";
            return false;
        }

        $resources = $resources->fetchAll(PDO::FETCH_ASSOC);
        if (empty($resources)) {
            self::$debug[] = "Не найдено ни одного товара, возвращено " . self::$textStd . ".";
            return false;
        }

        // Цикл для сортировки ресурсов
        foreach ($resources as $resValues) {
            // Приоритет. Чем ниже значение, тем ближе к началу будет ресурс
            $priorityCounter = count($relatedOpts);

            // Определяем приоритет по кол-ву соответствий в опциях
            foreach ($resourceValues as $key => $val) {
                // Конвертируем все в нижний регистр
                $tmpVal = mb_strtolower($resValues[$key]);
                $tmpArr = array_map(function ($val) {
                    return mb_strtolower($val);
                }, $resourceValues[$key]);

                // Проверяем
                if (in_array($tmpVal, $tmpArr)) {
                    $priorityCounter--;
                }
            }

            // Заносим в массив с соответствующим приоритетом
            $resourcesSorted[$priorityCounter][] = $resValues;
        }

        // Объединяем массив с приоритетами в один
        $resources = [];
        foreach ($resourcesSorted as $arr) {
            $resources = array_merge($resources, $arr);
        }

        // Получаем только id
        $resources = array_column($resources, 'id');

        return implode(',', $resources);
    }


    /**
     * Получение популярных товаров для кирпича.
     */
    static protected function kirpich() {
        global $modx;

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
            if (in_array(self::$prod->parent, $val)) {
                $group = $key;
                break;
            }
        }

        // Теперь проверим $catIdsGroup1 (если в этом есть необходимость - если $group все еще пустой)
        if (empty($group)) {
            // Возможно, РОДИТЕЛЬ явлется одной из тех категорий, которая нам нужна
            if (in_array(self::$prod->parent, $catIdsGroup1)) {
                $group = 1;
            } else {
                // Нет, РОДИТЕЛЬ не является ни одной из тех категорий, которая нам нужна. Проверяем доп. категории
                $table = $modx->getOption('table_prefix') . 'ms2_product_categories';
                $query = "SELECT *
                  FROM $table
                  WHERE product_id = " . self::$prod->id . " AND category_id IN (" . implode(',', $catIdsGroup1) . ")";

                $items = $modx->query($query);
                $items = $items->fetchAll(PDO::FETCH_ASSOC);

                if (!empty($items)) {
                    $group = 1;
                }
            }
        }

        // Проверка заполненности $group. Переменная должна быть заполнена. Если она не заполнена, то случилась какая-то ошибка - товар не находится ни в одной из 3 групп
        if (empty($group)) {
            self::$debug[] = "Не получилось определить группу кирпичей. Возвращено " . self::$textStd . ".";
            return false;
        }

        self::$debug[] = "Группа кирпичей определена как: $group.";

        // Одинаковые действия для групп 2 и 3
        if (in_array($group, [2, 3])) {
            $format = self::$prod->get('format');

            if (!empty($format)) {
                self::$debug[] = 'Получено значение опции format: ' . implode(', ', $format) . '.';
            } else {
                self::$debug[] = 'Не удалось получить значение опции format (или оно пустое).';
            }
        }

        // Определение параметров в зависимости от группы
        switch ($group) {
            case 1:
                // Группа 1 - товары с таким же цветом, оттенком, поверхностью. Сортировка - чем больше полей заполнено, тем выше приоритет
                $where = [];
                $optionsValues = ['cvet' => self::$prod->get('cvet'), 'ottenok' => self::$prod->get('ottenok'), 'surface' => self::$prod->get('surface')];
                foreach ($optionsValues as $key => $val) {
                    if (!empty($val)) {
                        // Добавляем кавычки в каждый элемент конкретной опции
                        $tmpValue = array_map(function ($v) {
                            return "'$v'";
                        }, $val);

                        // Добавляем элементы в where
                        $where[] = "(`$key`.`value` IN (" . implode(',', $tmpValue) . "))";
                    }
                }

                if (!empty($where)) {
                    $where = implode(' OR ', $where);
                    $where = "AND ($where)";
                    self::$debug[] = "У товара заполнена хотя бы одна из этих опций: цвет, оттенок, поверхность, составлено where: \"$where\".";
                } else {
                    self::$debug[] = "У товара не заполнен ни цвет, ни оттенок, ни поверхность, дополнительное where не составлено.";
                }

                $query = "SELECT `msProduct`.`id`, `cvet`.`value` as cvet, `ottenok`.`value` as ottenok, `surface`.`value` as surface

                                  FROM `modx_site_content` AS `msProduct`
                                      
                                  -- Присоединяем поля товара
                                  LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` = `Data`.`id`
                                  -- Присоединяем опции
                                  LEFT JOIN `modx_ms2_product_options` `cvet` ON `cvet`.product_id = Data.id AND `cvet`.key = 'cvet'
                                  LEFT JOIN `modx_ms2_product_options` `ottenok` ON `ottenok`.product_id = Data.id AND `ottenok`.key = 'ottenok'
                                  LEFT JOIN `modx_ms2_product_options` `surface` ON `surface`.product_id = Data.id AND `surface`.key = 'surface'
                                  
                                  -- Выбираем только товары
                                  WHERE `msProduct`.`class_key` = 'msProduct'
                                  -- И не просто товары, а определенные...
                                  $where";

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
                        self::$debug[] = "Не удалось получить число из текстового значения опции format ($formatString), чтобы найти товары, которые отличаются на 1 от format текущего товара. Либо это число равно 0.";

                        $where = "(`Options`.`key` = 'format' AND (`Options`.`value` = '$format[0]' OR `Options`.`value` = '2.1НФ') AND `msProduct`.parent = 19848)";
                    } else {
                        //$formatNum = $formatNum[0];
                        self::$debug[] = "Удалось получить число ($formatNum) из текстового значения опции format ($formatString).";

                        $formatNumPlus = str_replace(',', '.', $formatNum + 1);
                        $formatNumMinus = str_replace(',', '.', $formatNum - 1);

                        $where = "(`Options`.`key` = 'format' AND (`Options`.`value` = '2.1НФ' OR `Options`.`value` = '$format[0]' OR ((CAST(`Options`.`value` AS DECIMAL(4,2)) >= $formatNumMinus) AND (CAST(`Options`.`value` AS DECIMAL(4,2)) <= $formatNumPlus)))) AND `msProduct`.parent = 19848";
                    }
                }

                break;
        }

        if (in_array($group, [2, 3])) {
            $query = "SELECT `msProduct`.id, `Options`.`value` as format

                              FROM `modx_site_content` AS `msProduct`
                                
                              -- Присоединяем опции
                              JOIN `modx_ms2_product_options` `Options` ON `msProduct`.`id` =  `Options`.`product_id`
                              -- Присоединяем поля товара
                              LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` =  `Data`.`id`
                            
                              -- Выбираем только товары
                              WHERE `msProduct`.`class_key` = 'msProduct'
                              -- И не просто товары, а определенные...
                              -- Товары с таким же форматом и родителем 'Строительный кирпич'. Или с форматом 2.1НФ и родителем 'Поризованный кирпич'
                              AND " . $where;
        }

        $query .= "-- Проверяем, чтобы товары были опубликованы, не удалены, чтобы не было выбора текущего товара
                AND `msProduct`.`published` = 1
                AND `msProduct`.`deleted` = 0
                AND `msProduct`.`id` <> " . self::$prod->id . "
                
                GROUP BY msProduct.id
                ORDER BY `msProduct`.menuindex
                
                -- 40, а не 42, потому что потом в самое начало добаляются 2 товара из кладочных смесей
                LIMIT 40";

        // Запуск SQL запроса и обработка результатов
        $resources = $modx->query($query);
        if ($resources === false) {
            self::$debug[] = "Во время SQL запроса произошла ошибка, возвращено " . self::$textStd . ".";
            return false;
        }
        $resources = $resources->fetchAll(PDO::FETCH_ASSOC);

        // Сортировка
        if ($group == 1) {
            // Выше всего идут товары с тремя одинаковыми опциями. Далее идут товары с двумя одинаковыми опциями. В конце идут товары с одной одинаковой опцией. Товаров без одинаковых опций здесь не может быть (они бы не выбрались из БД)

            // Многомерный массив с отсортированными ресурсами
            $resourcesSorted = [1 => [], 2 => [], 3 => []];

            // Цикл для сортировки ресурсов
            // TODO: Опции текущего товара выбираются из БД все. А вот опции популярных товаров - не все. Но пока можно и без всех обойтись
            foreach ($resources as $resValues) {
                // Приоритет. Чем ниже значение, тем ближе к началу будет ресурс
                $priorityCounter = 4;

                // Определяем приоритет по кол-ву соответствий в опциях
                foreach ($optionsValues as $key => $val) {
                    // Конвертируем все в нижний регистр
                    $tmpVal = mb_strtolower($resValues[$key]);
                    $tmpArr = array_map(function ($val) {
                        return mb_strtolower($val);
                    }, $optionsValues[$key]);

                    // Проверяем
                    if (in_array($tmpVal, $tmpArr)) {
                        $priorityCounter--;
                    }
                }

                // Заносим в массив с соответствующим приоритетом
                $resourcesSorted[$priorityCounter][] = $resValues;
            }

            // Объединяем массив с приоритетами в один
            $resources = array_merge($resourcesSorted[1], $resourcesSorted[2], $resourcesSorted[3]);
        } else {
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
                if ($val['format'] === '2.1НФ') {
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
        }

        $resources = array_column($resources, 'id');

        if (in_array($group, [2, 3])) {
            // Добавление к отсортированным товарам двух товаров из кладочных смесей
            $resources = array_merge(['68082', '68083'], $resources);
        }

        return implode(',', $resources);
    }

}

$cacheName = 'getPopularProductsClass';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/' . $modx->resource->id,
];

if (!$cache = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $data = getPopularProductsClass::getPopularProductsParams();
    $cache = json_encode($data['params'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    $modx->cacheManager->set($cacheName, $cache, 0, $cacheOptions);
}

$params = json_decode($cache, true);
$result = $modx->runSnippet('msProductsMy', $params);
echo $result;
