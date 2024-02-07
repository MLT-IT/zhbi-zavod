<?php

/* Класс Linking  используется для создания и управления ссылками между ресурсами на основе указанных параметров и
зависимостей. */

if(!class_exists("Linking"))
{
    class Linking
    {
        // опции по которым хотим получить перелинковку
        protected $dependence = [];
        // опции которые будут срогими, т.е. четкое соответствие как у текущего ресурса
        protected $coincide = [];
        // родительский каталог
        protected $parentId = 74115; // тестовые значения если использовать в консоли, остальное обьявляется через конструктор
        // текущий ресурс
        protected $resourceId = 76502; // тестовые значения если использовать в консоли, остальное обьявляется через конструктор
        // параметры для поиска товаров в msProducts
        protected $params = [];
        // ограничения
        protected $limit = 0;
        // текущий ресурс
        public $resourceModx;


        /**
         * @param array $dependence список опций для перелинковки
         * @param array $coincide список опций строгой перелинковки т.е. у текущего товара берутся характеристики и ищутся такие же товары в каталоге
         * @param $limit ограничения выборки
         */
        public function __construct(array $dependence, array $coincide = [], $limit = 0)
        {
            global $modx;
            $this->dependence = $dependence;
            $this->modx = $modx;
            $this->coincide = $coincide;

            $this->parentId = $this->modx->resource->parent ? $this->modx->resource->parent : $this->parentId;
            $this->resourceId = $this->modx->resource->id ? $this->modx->resource->id : $this->resourceId;
            $this->resourceModx = $this->modx->getObject('msProduct', $this->resourceId);

            $this->setLimit($limit);

            $this->params = [
                'parents' => $this->parentId,
                'depth' => 100,
                'limit' => 0,
                'sortby' => 'id',
                'sortdir' => 'ASC',
                'resources' => '-' . $this->resourceId,
                'returnIds' => '1',
            ];
        }

        /**
         * Составить optionFilters для msProducts.
         *
         * @param $options - массив с опциями.
         * @return false|string - json с условиями.
         */
        function composeOptionFilters($options)
        {
            $values = [];
            $optionsResource = $this->resourceModx->getMany('Options');

            foreach ($options as $option) {
                foreach ($optionsResource as $v) {
                    $optionItem = $v->toArray();
                    if ($optionItem['key'] == $option) {
                        if (!array_key_exists($optionItem['key'] . ':=', $values)) {
                            $values[$optionItem['key'] . ':='] = $optionItem['value'];
                        }
                    }
                }
            }
            return json_encode($values, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        }

        /**
         * Содерждит вывод товаров в строку через запятую через снипет msProduct с определенными условиями указанными в конструкторе
         * если указан $this->coincide формирует доп условие
         * @return string
         */
        public function getParentIds(): string
        {
            if ($this->composeOptionFilters($this->coincide)) {
                $this->params = array_merge($this->params, ['optionFilters' => $this->composeOptionFilters($this->coincide)]);
            }

            $idsInParent = $this->modx->runSnippet('msProducts', $this->params);

            return $idsInParent;
        }


        /**
         * Функция извлекает отдельные строки из таблицы базы данных на основе заданного ключа и списка идентификаторов продуктов.
         *
         * @param string key Параметр «key» — это строка, представляющая ключ опции, которую вы хотите найти в
         * таблица базы данных. Он используется в запросе SQL для фильтрации результатов.
         * @param string productIds Параметр ProductIds — это строка, представляющая список продуктов, разделенных запятыми.
         * Идентификаторы.
         *
         * @return array — массив данных, полученных из базы данных.
         */
        public function getIdsForOptionKey(string $key, string $productIds): array
        {
            $query = "SELECT DISTINCT * 
                  FROM " . $this->modx->getOption('table_prefix') . "ms2_product_options
                  WHERE `product_id` IN(" . $productIds . ") AND `key` = '" . $key . "' AND `value` <> ''";
            $data = $this->modx->query($query);
            $data = $data->fetchAll(PDO::FETCH_ASSOC);
            return $data;
        }

        /**
         * Функция «counterLinking» подсчитывает количество вхождений каждого id товара в массив.
         *
         * @return array массив счетчиков. Каждый счетчик показывает, сколько раз идентификатор продукта появляется в
         * Массив `$idsProduct`.
         */
        public function counterLinking(): array
        {
            $idsProduct = [];
            // получение товаров
            $products = $this->getParentIds();
            foreach ($this->dependence as $key) {
                // получение товаров по у которых есть не пустая опция, из выборки товаров
                $idsProductsForOption = $this->getIdsForOptionKey($key, $products);
                $idsProduct[$key] = [];

                if (!empty($idsProductsForOption)) {
                    foreach ($idsProductsForOption as $elem) {
                        if(!in_array($elem['product_id'], $idsProduct[$key]))
                        {
                            $idsProduct[$key][] = $elem['product_id'];
                        }
                    }
                }
            }
            $counters = [];

            foreach ($this->dependence as $key) {
                if (isset($idsProduct[$key])) {
                    foreach ($idsProduct[$key] as $key => $elem) {
                        if (isset($counters[$elem])) {
                            $counters[$elem] += 1;
                        } else {
                            $counters[$elem] = 1;
                        }
                    }
                }
            }

            return $counters;
        }

        /**
         * Функция формирует массив идентификаторов продуктов и соответствующих им опций на основе определенных условий и
         * зависимости.
         *
         * @return array — массив с именем $result.
         */
        public function build(): array
        {
            $ids = [];
            foreach ($this->counterLinking() as $key => $value) {
                if ($value >= $this->limit) {
                    $ids[] = $key;
                }
            }

            $result = [];
            $duplicate = [];
            if (!empty($ids)) {
                foreach ($this->dependence as $key) {
                    foreach ($this->getIdsForOptionKey($key, implode(",", $ids)) as $item) {
                        if (!in_array($item['value'], $duplicate[$key])) {
                            $duplicate[$key][] = $item['value'];
                            $result[$key][$item['product_id']] = $item['value'];
                        }
                    }
                }
            }

            return $result;
        }

        /**
         * Функция getParamsMsProduct возвращает значение свойства params.
         *
         * @return $this->params.
         */
        public function getParamsMsProduct()
        {
            return $this->params;
        }

        /**
         * Функция устанавливает ограничение на количество учитываемых зависимостей со значением по умолчанию общего количества.
         * количество зависимостей.
         *
         * @param limit Параметр «limit» используется для установки максимального ограничения количества зависимостей, которые могут быть сохранены.
         * в объекте.
         */
        public function setLimit($limit)
        {
            if ($limit == 0) {
                $this->limit = count($this->dependence);
            } else {
                $this->limit = $limit;
            }
        }

        public function getResourceModx()
        {
            return $this->resourceModx;
        }

        public function getResourceId()
        {
            return $this->resourceId;
        }

        public function getDependence()
        {
            return $this->dependence;
        }

        public function getOptionName($key)
        {
            $nameOption = $this->modx->getObject('msOption', ['key' => $key])->get('caption');
            if(!empty($nameOption))
            {
                return $nameOption;
            }else{
                return $key;
            }
        }

    }
}

if(!class_exists("LinkingRender"))
{
    class LinkingRender
    {

        protected $linking;

        public function __construct($linking, $tpl = '', $tplFilter = [])
        {
            global $modx;
            if(empty($tpl))
            {
                $this->tpl = "@FILE blocks/product/linking/linking-select.tpl";
            }else{
                $this->tpl = $tpl;
            }

            $this->tplFilter = $tplFilter;
            $this->modx = $modx;
            $this->linking = $linking;
        }

        public function collectConfig(): array
        {
            $linksData = $this->linking->build();
            $keys = $this->linking->getDependence();
            $resourceId = $this->linking->getResourceId();
            return compact('linksData', 'keys', 'resourceId');
        }

        /**
         * Функция рендеринга собирает данные конфигурации, перебирает массив linkData, присваивает значения keyName и
         * ключевые переменные и добавляет результат метода pdoTools getChunk к строке, которая затем возвращается.
         *
         * @return string, является выводом шаблона select в, обработанных с помощью pdoTools.
         */
        public function render()
        {

            $data = $this->collectConfig();
            $result = "";
            foreach($data['linksData'] as $key => $value)
            {
                $data['keyName'] = $this->linking->getOptionName($key);
                $data['key'] = $key;

                $this->renderChank($result, $data, $key);

            }
            return $result;
        }

        private function renderChank(string &$result, array $data, string $key)
        {
            $pdoTools = $this->modx->getService("pdoTools");
            if(!empty($this->tplFilter))
            {
                if(array_key_exists($key, $this->tplFilter))
                {
                    $result .= $pdoTools->getChunk($this->tplFilter[$key], $data);
                }
                else{
                    $result .= $pdoTools->getChunk($this->tpl, $data);
                }
            }
            else{
                $result .= $pdoTools->getChunk($this->tpl, $data);
            }
            return $result;
        }

    }
}

if(isset($dependence)){
    if(!is_array($dependence)){
        return "Неверный параметр dependence";
    }
}

if(!isset($coincide)){
    $coincide = [];
}

if(!isset($limit)){
    $limit = 0;
}

if(!isset($tpl)){
    $tpl = '';
}

if(!isset($tplFilter)){
    $tplFilter = [];
}

$link = new Linking($dependence, $coincide, $limit);
$render = new LinkingRender($link, $tpl, $tplFilter);

return $render->render();