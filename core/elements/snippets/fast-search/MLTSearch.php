<?php

/**
Поиск товаров и категорий.
Что умеет поиск?
1. Искать по артикулу.
2. Искать по отдельному слову.
3. Искать по габаритам, например: 600x200x50. Габариты можно переставлять местами. Подходят разделители: русская х, английская x, символ звездочка *.
4. Транслитеризация. Чтобы искать можно было по транслиту.
5. Поиск по значению опциий
6. Поиск СЕО-выборок (хотя на СтройМаркете их нет).

TODO: Что нужно добавить?
1. Строгий и НЕ строгий поиск (Через UNION. Или через SELECT, который выбирает из других SELECT, а у них уже есть дополнительный динамический столбец. Или через IF: If(name='name';1;10) as "PRIORITY").
 */


if (!class_exists('MLTSearch')) {
    class MLTSearch
    {

        // Служебные константы
        const REQUEST_TYPE_AJAX = 1; // Тип запроса - AJAX
        const REQUEST_TYPE_NOT_AJAX = 2; // Тип запроса - не AJAX

        // Лимиты для AJAX-поиска
        const LIMIT_CATEGORIES = 16; // Макс. кол-во категорий при AJAX поиске
        const LIMIT_PRODUCTS = 10; // Макс. кол-во товаров при AJAX поиске (их меньше, чем категорий, т.к. у них картинка, которая занимает высоту)

        const SEO_TEMPLATES = "27,28,38"; // ID шаблонов по сео выборкам 

        // Поля класса
        protected $requestType; // Тип запроса: ajax / не ajax
        protected $queryPhrase; // Фраза для поиска

        protected $tplProduct; // Чанк для товара при AJAX поиске
        protected $tplCategory; // Чанк для категории при AJAX поиске
        protected $tplWrapper; // Чанк-обертка при AKAX поиске
        protected $isInit; // Это инициализация сниппета?

        /**
         * MLTSearch constructor.
         * @param $tplProduct
         * @param $tplCategory
         * @param $tplWrapper
         * @param $isInit
         */
        public function __construct($tplProduct, $tplCategory, $tplWrapper, $isInit)
        {
            $this->tplProduct = $tplProduct;
            $this->tplCategory = $tplCategory;
            $this->tplWrapper = $tplWrapper;
            $this->isInit = $isInit;
            $query_preg = preg_replace('/[^\p{L}\p{N}.,]+/u', ' ', $_GET['query']); // Удаляем все символы, кроме цифр и букв
            $query_preg = preg_replace('/\s+/', ' ', $query_preg); // Удаляем двойные пробелы
            $this->queryPhrase = trim($query_preg);

            if (empty($_SERVER['HTTP_X_REQUESTED_WITH']) || strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) != 'xmlhttprequest' || $_REQUEST['action'] != 'fast-search') {
                $this->requestType = self::REQUEST_TYPE_NOT_AJAX;
            } else {
                $this->requestType = self::REQUEST_TYPE_AJAX;
            }
        }


        /**
         * Главная открытая функция класса.
         * @return bool
         */
        public function run()
        {
            global $modx;

            if ((empty($this->queryPhrase)) || ($this->isInit && $this->requestType == self::REQUEST_TYPE_NOT_AJAX)) {
                return $this->returnData(null);
            }

            $where = $this->generateWhere("`resources`.`pagetitle`");

            $categoryValues = [];
            $productsValues = [];

            /**
             *  1 
             * Получаем СЕО выборки
             */
            $seoData = $this->findSeo($where['wherePagetitle'], $where['queryWordsArray']);
            foreach ($seoData as $itemIndex => $itemValues) {
                if (count($categoryValues) < self::LIMIT_CATEGORIES) {
                    $item_id = $itemValues['id'];
                    $categoryValues[$item_id]['id'] = $itemValues['id'];
                    $categoryValues[$item_id]['pagetitle'] = $itemValues['pagetitle'];
                    $categoryValues[$item_id]['menutitle'] = $itemValues['menutitle'];
                }
            }

            /**
             *  2
             * Получаем товары по pagetitle
             */
            $products = $this->findProducts($where['main'], $where['queryWordsArray']);
            // Если товаров меньше лимита, тут же находим товары по опциям
            if (count($products) < self::LIMIT_PRODUCTS) {
                $where_options = $this->generateWhere("`msOption`.`value`");
                $search_options = true;
                $products = array_merge($products, $this->findProducts($where_options['main'], $where_options['queryWordsArray'], $search_options));
            }

            // Если это не AJAX вывести id`шники товаров
            if ($this->requestType == self::REQUEST_TYPE_NOT_AJAX) {
                if (count($products)) {
                    return $this->returnData(implode(',', $products));
                } else {
                    return $this->returnData(null);
                }
            } else {

                foreach ($products as $itemIndex => $itemValues) {
                    if (count($categoryValues) < self::LIMIT_CATEGORIES) {
                        $parent_id = $itemValues['parent_id'];
                        $categoryValues[$parent_id]['id'] = $itemValues['parent_id'];
                        $categoryValues[$parent_id]['pagetitle'] = $itemValues['parent_pagetitle'];
                        $categoryValues[$parent_id]['menutitle'] = $itemValues['parent_menutitle'];
                    }
                    if (count($productsValues) < self::LIMIT_PRODUCTS) {
                        $productsValues[$itemIndex]['id'] = $itemValues['id'];
                        $productsValues[$itemIndex]['pagetitle'] = $itemValues['pagetitle'];
                        $productsValues[$itemIndex]['menutitle'] = $itemValues['menutitle'];
                        $productsValues[$itemIndex]['thumb'] = $itemValues['thumb'];
                    }
                }

                /** 
                 * 3
                 * Если кол-во категорий меньше, находим их отделным запросом
                 */
                if (count($categoryValues) < self::LIMIT_CATEGORIES) {
                    $categories = $this->findCategories($where['wherePagetitle'], $where['queryWordsArray'], false);

                    foreach ($categories as $itemIndex => $itemValues) {
                        if (count($categoryValues) < self::LIMIT_CATEGORIES) {
                            $item_id = $itemValues['id'];
                            $categoryValues[$item_id]['id'] = $itemValues['id'];
                            $categoryValues[$item_id]['pagetitle'] = $itemValues['pagetitle'];
                            $categoryValues[$item_id]['menutitle'] = $itemValues['menutitle'];
                        }
                    }
                }


                /** 
                 * 4
                 * Формируем результат
                 */
                $output = [];

                // Подготавливаем товары для вывода
                if (count($productsValues)) {
                    $products = $this->wrapDataToChunk($productsValues, $this->tplProduct);
                    $output['products'] = $products;
                }

                // Подготавливаем категории для вывода
                if (count($categoryValues)) {
                    $categories = $this->wrapDataToChunk($categoryValues, $this->tplCategory);
                    $output['categories'] = $categories;
                }

                if (count($output)) {
                    // Обертываем данные в чанк
                    $output = $modx->pdoTools->getChunk($this->tplWrapper, $output);
                    return $this->returnData($output);
                } else {
                    return $this->returnData(null);
                }
            }
        }

        /**
         * Генерирует where для sql 
         * 
         * @param $tableField
         */
        public function generateWhere($tableField)
        {
            // Объявляем нужные для работы переменные
            $wherePagetitle = [];
            $queryWordsArray = []; // Массив с плейсхолдерами для SQL-запроса
            $index = 0;

            // Цикл для каждого слова в поиске
            foreach (explode(' ', $this->queryPhrase) as $queryWord) {
                // Слово содержит запятую / точку
                if (stristr($queryWord, ',') || stristr($queryWord, '.')) {
                    $queryWord = preg_replace('/[, .]/', '[,\.]', $queryWord);
                    $wherePagetitle[] = "$tableField REGEXP :queryWord$index";

                    $queryWordsArray['queryWord' . $index] = $queryWord;
                    $index++;
                }

                // Слово - это габариты, которые можно переставлять местами
                else if (preg_match('/(^|\s)([0-9]+[xх*]{1}[0-9]+([xх*][0-9]+)?)($|\s)/iu', $queryWord, $match)) {
                    // Получаем габариты
                    $dimensions = $match[2];
                    // Составляем перебор
                    $dimensionsEnum = $this->getDimensionsEnum($dimensions);

                    // Заполняем массивы для SQL-запроса
                    $wherePagetitleOR = [];
                    foreach ($dimensionsEnum as $val) {
                        // Я использовал круглые скобки вместо квадратных, т.к. у нас в основном MySQL 5.7. Данная версия не поддерживает кириллицу в квадратных скобках
                        $val = str_replace('x', '(х|Х|x|X|\\\\*)', $val);
                        $wherePagetitleOR[] = "$tableField REGEXP :queryWord$index";

                        $queryWordsArray['queryWord' . $index] = $val;
                        $index++;
                    }

                    $wherePagetitle[] = '(' . implode(' OR ', $wherePagetitleOR) . ')';
                }

                // Обычная обработка слова
                else {
                    $wherePagetitle[] = "($tableField LIKE :ru_queryWord$index OR $tableField LIKE :en_queryWord$index)";
                    $queryWordsArray['ru_queryWord' . $index] = '%' . $this->translit($queryWord, 'en_ru') . '%';
                    $queryWordsArray['en_queryWord' . $index] = '%' . $this->translit($queryWord, 'ru_en') . '%';

                    $index++;
                }
            }

            // Подготавливаем переменные для составления SQL-запроса
            $queryWordsArray['queryPhrase'] = '%' . $this->queryPhrase . '%';
            $wherePagetitle = '(' . implode(' AND ', $wherePagetitle) . ')';
            $where = $wherePagetitle . ' OR (`Data`.`article` LIKE :queryPhrase)';

            return [
                'main' => $where,
                'queryWordsArray' => $queryWordsArray,
                'wherePagetitle' => $wherePagetitle
            ];
        }

        /**
         * Возвращает данные.
         */
        protected function returnData($data)
        {
            switch ($this->requestType) {
                case self::REQUEST_TYPE_AJAX:
                    die($data);
                    break;
                case self::REQUEST_TYPE_NOT_AJAX:
                    return $data;
                    break;
            }
        }


        /**
         * Подготавливает данные для занесения в чанк.
         */
        protected function wrapDataToChunk($data, $chunk)
        {
            global $modx;
            $result = '';

            foreach ($data as $val) {
                $menutitle = $val['menutitle'] ?: $val['pagetitle'];
                $uri = $modx->pdoTools->makeUrl($val['id']);
                $image = $val['thumb'] ?: '';

                $result .= $modx->pdoTools->getChunk($chunk, [
                    'menutitle' => $menutitle,
                    'uri' => $uri,
                    'image' => $image
                ]);
            }

            return $result;
        }


        /**
         * Составляет перебор всех возможных значений по габаритам. Это массив всех возможных значений.
         * @param $dimensions
         * @return array
         */
        private function getDimensionsEnum($dimensions)
        {
            // Разбиваем габариты на отдельные числа
            $dimensions = preg_split('/[xх*]/iu', $dimensions);

            // Устанавливаем нужные для циклов переменные
            $count = count($dimensions); // кол-во
            for ($i = 0; $i < $count - 1; $i++) { // index'ы
                $indexes[$i + 1] = 0;
            }

            // Составляем $dimensionsEnum. Это перебор всех возможных значений
            $dimensionsEnum = [];
            for ($index1 = 0; $index1 < $count; $index1++) {
                for ($k = 0; $k < $count - 1; $k++) {
                    $dimensionsEnum[$i . $index1 . $k] = $dimensions[$index1];

                    foreach ($indexes as $indexKey => $indexVal) {
                        $indexVal = ($index1 + $k + $indexKey) % $count;
                        if ($indexVal == $index1) {
                            if ($count > 2) {
                                $indexVal = ($indexVal + 1) % $count;
                            } else {
                                continue;
                            }
                        }

                        $dimensionsEnum[$i . $index1 . $k] .= 'x' . $dimensions[$indexVal];
                    }
                }
            }

            if ($count == 2) {
                foreach ($dimensionsEnum as $dim) {
                    $dimensionsEnum[] = preg_replace('/([xх*])/iu', '$1[0-9]+$1', $dim);
                }
            }
            return $dimensionsEnum;
        }


        /**
         * Выборка товаров и их родителей (категорий)
         * @param $where
         * @param $queryWordsArray
         * @return Array
         */
        private function findProducts($where, $queryWordsArray, $search_options = false)
        {
            global $modx;

            // SQL для поиска товаров (и их категорий)
            $query = "SELECT `resources`.`id`";

            if ($this->requestType == self::REQUEST_TYPE_AJAX) {
                // Для AJAX нужно не только id, но и другие значения
                $query .= ", `resources`.`menutitle`, `resources`.`pagetitle`, `Data`.`thumb`, `Parent`.`id` AS parent_id, `Parent`.`pagetitle` AS parent_pagetitle, `Parent`.`menutitle` AS parent_menutitle ";
            }

            $query .= " FROM `modx_site_content` AS `resources` 
              LEFT JOIN `modx_ms2_products` `Data` ON `resources`.`id` =  `Data`.`id` 
              LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `resources`.`id` AND `TVhitspage`.`tmplvarid` = 7 
              LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `resources`.`id` AND `TVpriority1`.`tmplvarid` = 17";

            if ($search_options) {
                $query .= " LEFT JOIN `modx_ms2_product_options` `msOption` ON `msOption`.`product_id` = `resources`.`id`";
            }

            if ($this->requestType == self::REQUEST_TYPE_AJAX) {
                $query .= " LEFT JOIN `modx_site_content` `Parent` ON `Parent`.`id` = `resources`.`parent`";
            }

            $query .= " WHERE  `resources`.`class_key` = 'msProduct'
                    AND `resources`.`published` = 1
                    AND `resources`.`deleted` = 0
                    AND `resources`.`context_key` = '" . $modx->context->key . "'
                    AND ($where)
              GROUP BY resources.id
              ORDER BY CAST(`TVpriority1`.`value` AS DECIMAL(13,3)) ASC, CAST(`TVhitspage`.`value` AS DECIMAL(13,3)) ASC";

            if ($this->requestType == self::REQUEST_TYPE_AJAX) {
                $query .= " LIMIT " . self::LIMIT_CATEGORIES;
            }

            $data = $this->runQueryAndFetchData($query, $queryWordsArray);

            if (!empty($data)) {
                if ($this->requestType == self::REQUEST_TYPE_NOT_AJAX) {
                    // return implode(',', array_column($data, 'id'));
                    return array_column($data, 'id');
                }

                return $data;
            } else {
                return [];
            }
        }

        /**
         * Выборка СЕО выборок 
         * 
         * @param $wherePagetitle
         * @param $queryWordsArray
         * @return Array
         */
        private function findSeo($wherePagetitle, $queryWordsArray)
        {
            global $modx;

            $query = "SELECT
                `resources`.`id`,
                `resources`.`menutitle`,
                `resources`.`pagetitle`
            FROM
                `modx_site_content` AS `resources`
            WHERE
                `resources`.`class_key` = 'msCategory' AND `resources`.`published` = 1 AND `resources`.`deleted` = 0 AND `resources`.`context_key` = '" . $modx->context->key . "' AND `resources`.`template` IN(" . self::SEO_TEMPLATES . ") AND($wherePagetitle)
            GROUP BY
            resources.id
            LIMIT " . self::LIMIT_CATEGORIES;

            // Удаляем последний аргумент из $queryWordsArray, потому что он не используется, но из-за его наличия будет ошибка
            array_pop($queryWordsArray);
            $data = $this->runQueryAndFetchData($query, $queryWordsArray);

            if (!empty($data)) {
                return $data;
            }

            return false;
        }

        /**
         * Выборка категорий.
         * @param $whereCategories
         * @param $queryWordsArray
         * @return Array
         */
        private function findCategories($whereCategories, $queryWordsArray)
        {
            global $modx;

            $query = "SELECT `resources`.`id`, `resources`.`menutitle`, `resources`.`pagetitle`
                  FROM `modx_site_content` AS `resources` 
                  WHERE  `resources`.`class_key` = 'msCategory' 
                        AND `resources`.`published` = 1 
                        AND `resources`.`deleted` = 0 
                        AND `resources`.`context_key` = '" . $modx->context->key . "'
                        AND ($whereCategories)  
                  GROUP BY resources.id 
                  ORDER BY id
                  LIMIT " . self::LIMIT_CATEGORIES;

            // Удаляем последний аргумент из $queryWordsArray, потому что он не используется, но из-за его наличия будет ошибка
            array_pop($queryWordsArray);
            $data = $this->runQueryAndFetchData($query, $queryWordsArray);

            if (!empty($data)) {
                return $data;
            } else {
                return [];
            }
        }


        /**
         * Запустить SQL-запрос и получить данные.
         * @param $query
         * @param $queryWordsArray
         * @return array|false
         */
        private function runQueryAndFetchData($query, $queryWordsArray)
        {
            global $modx;

            // Запускаем запрос
            $stmt = $modx->prepare($query);
            $queryResult = $stmt->execute($queryWordsArray);
            // В запросе произошла ошибка?
            if ($queryResult === false) {
                //$error = $stmt->errorInfo();
                return false;
            }
            // Получаем и обрабатываем данные
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        }

        /**
         * Транслитеризация строки $string по ключу $key.
         * @param $string
         * @param $key
         * @return string
         */
        protected function translit($string, $key)
        {
            $translit = [
                'ru_en' => [
                    'а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'g', 'д' => 'd', 'е' => 'e', 'ё' => 'yo', 'ж' => 'zh', 'з' => 'z', 'и' => 'i', 'й' => 'j', 'к' => 'k', 'л' => 'l', 'м' => 'm', 'н' => 'n', 'о' => 'o', 'п' => 'p', 'р' => 'r', 'с' => 's', 'т' => 't', 'у' => 'u', 'ф' => 'f', 'х' => 'h', 'ц' => 'c', 'ч' => 'ch', 'ш' => 'sh', 'щ' => 'sh', 'ъ' => '``', 'ы' => 'y', 'ь' => '`', 'э' => 'e`', 'ю' => 'yu', 'я' => 'ya',
                ],
                'en_ru' => [
                    'a' => 'а', 'b' => 'б', 'v' => 'в', 'g' => 'г', 'd' => 'д', 'e' => 'е', 'yo' => 'ё', 'zh' => 'ж', 'z' => 'з', 'i' => 'и',  'j' => 'й', 'k' => 'к', 'l' => 'л', 'm' => 'м', 'n' => 'н', 'o' => 'о', 'p' => 'п', 'r' => 'р', 's' => 'с', 't' => 'т', 'u' => 'у', 'f' => 'ф', 'h' => 'х', 'c' => 'ц', 'ch' => 'ч', 'sh' => 'ш', 'sch' => 'щ', '``' => 'ъ', 'y' => 'ы', '`' => 'ь', 'e`' => 'э', 'yu' => 'ю', 'ya' => 'я',
                ]
            ];

            return strtr(mb_strtolower($string), $translit[$key]);
        }
    }
}

// Подключаем pdoTools. Он нужен для работы сниппета
if (empty($modx->services['pdoTools'])) {
    $modx->getService('pdoTools');
}
// Если не удалось подключить pdoTools, то завершаем работу
if (empty($modx->services['pdoTools'])) {
    $modx->log(MODX_LOG_LEVEL_ERROR, 'Couldn`t get pdoTools');
    return false;
}

$MLTSearch = new MLTSearch($tplProduct, $tplCategory, $tplWrapper, $isInit);
return $MLTSearch->run();
