<?php

/*
TODO:
1. Зачем лишние join'ы с приоритетами?
2. SQL-инъекция в поиске категорий.
3. Не работает поиск по артикулу.
5. Сравни с поиском на Общестрое - может, там что-то поновее есть.
*/


if (!class_exists('MLTSearch')) {
    class MLTSearch {

        // Служебные константы
        const REQUEST_TYPE_AJAX = 1; // Тип запроса - AJAX
        const REQUEST_TYPE_NOT_AJAX = 2; // тип запроса - не AJAX

        // Лимиты для AJAX-поиска
        const LIMIT_CATEGORIES = 16; // Макс. кол-во категорий
        const LIMIT_PRODUCTS = 10; // Макс. кол-во товаров

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
         */
        public function __construct($tplProduct, $tplCategory, $tplWrapper, $isInit) {
            $this->tplProduct = $tplProduct;
            $this->tplCategory = $tplCategory;
            $this->tplWrapper = $tplWrapper;
            $this->isInit = $isInit;
            $this->queryPhrase = trim($_GET['query']);

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
        public function run() {
            if ((empty($this->queryPhrase)) || ($this->isInit && $this->requestType == self::REQUEST_TYPE_NOT_AJAX)) {
                return $this->returnData(null);
            }

            // Составляем и запускаем запросы
            return $this->returnData($this->getResultData());
        }


        /**
         * Возвращает данные.
         */
        protected function returnData($data) {
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
        protected function prepareData($resourcesData, $chunk) {
            global $modx;
            $result = '';

            foreach ($resourcesData as $data) {
                $menutitle = $data['menutitle'] ?: $data['pagetitle'];
                $uri = $modx->pdoTools->makeUrl($data['id']);
                $image = $data['thumb'] ?: '';

                $result .= $modx->pdoTools->getChunk($chunk, [
                    'menutitle' => $menutitle,
                    'uri' => $uri,
                    'image' => $image
                ]);
            }

            return $result;
        }


        /**
         * Составляет матрицу по габаритам. Это массив всех возможных значений.
         * @param $dimensions
         */
        private function getDimensionsMatrix($dimensions) {
            // Разбиваем габариты на отдельные числа
            $dimensions = preg_split('/[xх*]/iu', $dimensions);

            // Устанавливаем нужные для циклов переменные
            $count = count($dimensions); // кол-во
            for ($i = 0; $i < $count - 1; $i++) { // index'ы
                $indexes[$i + 1] = 0;
            }

            // Составляем $dimensionsMatrix. Это матрица. Понять код сложно, я и сам не особо понимаю его 😅, я составлял его с помощью xdebug
            $dimensionsMatrix = [];
            for ($index1 = 0; $index1 < $count; $index1++) {
                for ($k = 0; $k < $count - 1; $k++) {
                    $dimensionsMatrix[$i . $index1 . $k] = $dimensions[$index1];

                    foreach ($indexes as $indexKey => $indexVal) {
                        $indexVal = ($index1 + $k + $indexKey) % $count;
                        if ($indexVal == $index1) {
                            if ($count > 2) {
                                $indexVal = ($indexVal + 1) % $count;
                            } else {
                                continue;
                            }
                        }

                        $dimensionsMatrix[$i . $index1 . $k] .= 'x' . $dimensions[$indexVal];
                    }
                }
            }

            if ($count == 2) {
                foreach ($dimensionsMatrix as $dim) {
                    $dimensionsMatrix[] = preg_replace('/([xх*])/iu', '$1[0-9]+$1', $dim);
                }
            }
            return $dimensionsMatrix;
        }


        private function getResultProducts($where, $queryWordsArray) {
            global $modx;

            // SQL для поиска товаров (и их категорий)
            // TODO: почему LIMIT здесь закомментирован?
            $queryProducts = "SELECT `msProduct`.`id`";

            if ($this->requestType == self::REQUEST_TYPE_AJAX) {
                // Для AJAX нужно не только id, но и другие значения
                $queryProducts .= ", `msProduct`.`menutitle`, `msProduct`.`pagetitle`, `Data`.`thumb`, `Parent`.`id` AS parent_id, `Parent`.`pagetitle` AS parent_pagetitle, `Parent`.`menutitle` AS parent_menutitle ";
            }

            $queryProducts .= " FROM `modx_site_content` AS `msProduct` 
              LEFT JOIN `modx_ms2_products` `Data` ON `msProduct`.`id` =  `Data`.`id` 
              LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `msProduct`.`id` AND `TVhitspage`.`tmplvarid` = 7 
              LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `msProduct`.`id` AND `TVpriority1`.`tmplvarid` = 17";

            if ($this->requestType == self::REQUEST_TYPE_AJAX) {
                $queryProducts .= " LEFT JOIN `modx_site_content` `Parent` ON `Parent`.`id` = `msProduct`.`parent`";
            }

            $queryProducts .= " WHERE  `msProduct`.`class_key` = 'msProduct'
                    AND `msProduct`.`published` = 1
                    AND `msProduct`.`deleted` = 0
                    AND `msProduct`.`context_key` = '" . $modx->context->key . "'
                    AND ($where)
              GROUP BY msProduct.id
              ORDER BY CAST(`TVpriority1`.`value` AS DECIMAL(13,3)) ASC, CAST(`TVhitspage`.`value` AS DECIMAL(13,3)) ASC
              #LIMIT 10";

            // Запускаем запрос
            $stmt = $modx->prepare($queryProducts);
            $queryResult = $stmt->execute($queryWordsArray);
            // В запросе произошла ошибка?
            if ($queryResult === false) {
                return false;
            }

            // Получаем и обрабатываем данные
            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if (!empty($data)) {
                if ($this->requestType == self::REQUEST_TYPE_NOT_AJAX) {
                    return implode(',', array_column($data, 'id'));
                }

                $parentsValues = [];
                $productsValues = [];
                // Расфасовываем товары и категории
                foreach ($data as $itemIndex => $itemValues) {
                    if (count($parentsValues) < self::LIMIT_CATEGORIES) {
                        $parent_id = $itemValues['parent_id'];
                        $parentsValues[$parent_id]['id'] = $itemValues['parent_id'];
                        $parentsValues[$parent_id]['pagetitle'] = $itemValues['parent_pagetitle'];
                        $parentsValues[$parent_id]['menutitle'] = $itemValues['parent_menutitle'];
                    }
                    if (count($productsValues) < self::LIMIT_PRODUCTS) {
                        $productsValues[$itemIndex]['id'] = $itemValues['id'];
                        $productsValues[$itemIndex]['pagetitle'] = $itemValues['pagetitle'];
                        $productsValues[$itemIndex]['menutitle'] = $itemValues['menutitle'];
                        $productsValues[$itemIndex]['thumb'] = $itemValues['thumb'];
                    }
                }

                // Подготавливаем товары для вывода
                $products = $this->prepareData($productsValues, $this->tplProduct);
                // Подготавливаем категории для вывода
                $categories = $this->prepareData($parentsValues, $this->tplCategory);

                // Обертываем данные в чанк
                return $modx->pdoTools->getChunk($this->tplWrapper, [
                    'products' => $products,
                    'categories' => $categories,
                ]);
            }

            return false;
        }


        private function getResultCategories($whereCategories) {
            global $modx;

            // TODO: Надо исправить SQL-инъекцию
            $queryCategories = "SELECT `msProduct`.`id`, `msProduct`.`menutitle`, `msProduct`.`pagetitle`
                  FROM `modx_site_content` AS `msProduct` 
                  LEFT JOIN `modx_site_tmplvar_contentvalues` `TVhitspage` ON `TVhitspage`.`contentid` = `msProduct`.`id` AND `TVhitspage`.`tmplvarid` = 7 
                  LEFT JOIN `modx_site_tmplvar_contentvalues` `TVpriority1` ON `TVpriority1`.`contentid` = `msProduct`.`id` AND `TVpriority1`.`tmplvarid` = 17 
                  WHERE  `msProduct`.`class_key` = 'msCategory' 
                        AND `msProduct`.`published` = 1 
                        AND `msProduct`.`deleted` = 0 
                        AND `msProduct`.`context_key` = '" . $modx->context->key . "'
                        AND ($whereCategories)  
                  GROUP BY msProduct.id 
                  ORDER BY CAST(`TVpriority1`.`value` AS DECIMAL(13,3)) ASC, CAST(`TVhitspage`.`value` AS DECIMAL(13,3)) ASC
                  LIMIT " . self::LIMIT_CATEGORIES;

            $queryResult = $modx->query($queryCategories);
            $data = $queryResult->fetchAll(PDO::FETCH_ASSOC);

            if (count($data)) {
                $categories = $this->prepareData($data, $this->tplCategory);
                $result = $modx->pdoTools->getChunk($this->tplWrapper, [
                    'categories' => $categories,
                ]);
                return $result;
            }

            return false;
        }


        /**
         * Основная функция, возвращающая нужные данные.
         */
        protected function getResultData() {
            // Объявляем нужные для работы переменные
            $wherePagetitle = [];
            $wherePagetitleCategory = [];
            $queryWordsArray = []; // Массив с плейсхолдерами для SQL-запроса
            $index = 0;

            // Цикл для каждого слова в поиске
            foreach (explode(' ', $this->queryPhrase) as $queryWord) {
                // Слово содержит запятую / точку
                if (stristr($queryWord, ',') || stristr($queryWord, '.')) {

                    $queryWord = preg_replace('/[, .]/', '[,\.]', $queryWord);
                    $wherePagetitle[] = '`msProduct`.`pagetitle` REGEXP :queryWord' . $index;
                    $wherePagetitleCategory[] = "`msProduct`.`pagetitle` REGEXP '$queryWord'";

                    $queryWordsArray['queryWord' . $index] = $queryWord;
                    $index++;
                }
                //
                // Слово - это габариты, которые можно переставлять местами
                else if (preg_match('/(^|\s)([0-9]+[xх*]{1}[0-9]+([xх*][0-9]+)?)($|\s)/iu', $queryWord, $match)) {

                    // Получаем габариты
                    $dimensions = $match[2];
                    // Составляем матрицу
                    $dimensionsMatrix = $this->getDimensionsMatrix($dimensions);

                    // Заполняем массивы для SQL-запроса
                    $wherePagetitleOR = [];
                    $wherePagetitleCategoryOR = [];
                    foreach ($dimensionsMatrix as $val) {
                        $val = str_replace('x', '(х|Х|x|X|\\\\*)', $val);
                        $wherePagetitleOR[] = '`msProduct`.`pagetitle` REGEXP :queryWord' . $index;
                        $wherePagetitleCategoryOR[] = "`msProduct`.`pagetitle` REGEXP '$val'";

                        $queryWordsArray['queryWord' . $index] = $val;
                        $index++;
                    }

                    $wherePagetitle[] = '(' . implode(' OR ', $wherePagetitleOR) . ')';
                    $wherePagetitleCategory[] = '(' . implode(' OR ', $wherePagetitleCategoryOR) . ')';
                }
                //
                // Обычная обработка слова
                else {
                    $queryWord = '%' . $queryWord . '%';
                    $wherePagetitle[] = '`msProduct`.`pagetitle` LIKE :queryWord' . $index;
                    $wherePagetitleCategory[] = "`msProduct`.`pagetitle` LIKE '$queryWord'";

                    $queryWordsArray['queryWord' . $index] = $queryWord;
                    $index++;
                }
            }

            // Составляем SQL-запрос
            $queryWordsArray['queryPhrase'] = '%' . $this->queryPhrase . '%';
            $wherePagetitle = '(' . implode(' AND ', $wherePagetitle) . ')';
            $whereArticle = '(`Data`.`article` LIKE :queryPhrase)';
            $where = $wherePagetitle . ' OR ' . $whereArticle;
            $whereCategories = '(' . implode(' AND ', $wherePagetitleCategory) . ')';

            // Получаем товары
            $products = $this->getResultProducts($where, $queryWordsArray);

            if ($products !== false) {
                return $this->returnData($products);
            }

            // Если не удалось получить товары и если это AJAX, то попробуем хотя бы получить категории
            if ($this->requestType == self::REQUEST_TYPE_AJAX) {
                $categories = $this->getResultCategories($whereCategories);
                if ($categories !== false) {
                    return $this->returnData($categories);
                }
            }

            return $this->returnData(null);
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
