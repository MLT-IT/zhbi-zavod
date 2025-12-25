<?php

/**
 * Выборка похожих товаров производится по опциям, которые передаются двумя параметрами
 * 
 * components_category_id - ID категории с комплектующими
 * options [Array] - Массив опций для выборки товаров: ['collection', 'item_width']
 */

if (!class_exists('getComponents')) {
    class getComponents
    {
        static $components_category_id;
        static $options;
        static $modx;
        static $table_prefix;
        static $current_product;
        static $settings;
        static $cache;

        public function __construct($components_category_id, $options, $modx)
        {
            $this->options = $options;
            $this->components_category_id = $components_category_id;
            $this->modx = $modx;
            $this->table_prefix = $modx->getOption('table_prefix');

            $this->current_product = [
                'id' => $modx->resource->id,
                'parent' => $modx->resource->parent
            ];
            $this->settings = [
                'search_product_depth' => 10 // Глубина поиска товаров
            ];

            $this->cache = [
                'name' => $modx->resource->id,
                'options' => [
                    xPDO::OPT_CACHE_KEY => 'default/components-for-products/' . $modx->resource->context_key . '/',
                ]
            ];
        }
        public function init()
        {
            if ($output = $this->modx->cacheManager->get($this->cache['name'], $this->cache['options'])) {
                return $output;
            }

            if (!$this->options || !$this->components_category_id) return;

            $product_options = $this->getCurrentProductOptions();
            $parent_ids = $this->getParentsIds();
            $find_products = $this->findProducts($product_options, $parent_ids);

            if (!empty($find_products)) {
                $output = $this->result($find_products);
            } else {
                $output = null;
            }

            $this->modx->cacheManager->set($this->cache['name'], $output, 0, $this->cache['options']);
            return $output;
        }


        /**
         * Получить значения опций по текущему товару
         * По этим данным будут найдены похожие товары
         */
        public function getCurrentProductOptions()
        {
            $options = implode("','", $this->options);
            $sql = "SELECT * FROM {$this->table_prefix}ms2_product_options AS sc WHERE product_id = {$this->current_product['id']} AND `key` in ('$options')";
            $result = $this->modx->query($sql);
            $rows = $result->fetchAll(PDO::FETCH_ASSOC);

            // Разбили опции текущего товара на части
            $product_options = [
                'main' => [], // Основные опции
            ];

            foreach ($rows as $row) {
                if (in_array($row['key'], $this->options)) {
                    $product_options['main'][] = $row;
                }
            }
            return $product_options;
        }

        /**
         * Получить все дочерние категории по родителю комплектующих
         * Сформируем IDs parents для выборки по ним товаров
         */
        public function getParentsIds()
        {
            $parent_ids = [];
            $resources_prev_ids = []; // Родители после каждой итерации, для получения следующей вложенности
            for ($i = 1; $i <= $this->settings['search_product_depth']; $i++) {
                if ($i > 1 && empty($resources_prev_ids)) continue;
                if ($i > 1) {
                    $parents = implode(',', $resources_prev_ids);
                }

                if (isset($parents)) {
                    $where_parents = "sc.parent IN ($parents)";
                } else {
                    $where_parents = "parent = {$this->components_category_id}";
                }

                $sql = "SELECT id FROM {$this->table_prefix}site_content AS sc WHERE class_key = 'msCategory' AND $where_parents";
                $result = $this->modx->query($sql);
                $rows = $result->fetchAll(PDO::FETCH_ASSOC);

                $resources_prev_ids = array_map(function ($item) {
                    return $item['id'];
                }, $rows);

                $parent_ids = array_merge($parent_ids, $rows);
            }
            $parent_ids = array_column($parent_ids, 'id');
            $parent_ids[] = $this->components_category_id;

            return $parent_ids;
        }

        /**
         * Собираем товары по опциями текущего товара и полученным IDs parents
         */
        public function findProducts($product_options, $parent_ids)
        {
            $where_options = $this->generateWhereOptions($product_options['main']);
            $parent_ids_implode = implode(',', $parent_ids);
            $where_product_id = "(SELECT id FROM {$this->table_prefix}site_content WHERE id != {$this->current_product['id']} AND parent IN ($parent_ids_implode))";

            // Запрос на получение всех опций по полученным товарам
            $sql = "SELECT * FROM {$this->table_prefix}ms2_product_options WHERE product_id IN (SELECT product_id FROM {$this->table_prefix}ms2_product_options AS sc WHERE product_id IN $where_product_id AND ($where_options) GROUP BY product_id);";
            $result = $this->modx->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        }

        /**
         * Собираем товары по дополнительным опциям
         */
        public function findProductsReserve($product_options, $product_ids)
        {
            $where_options = $this->generateWhereOptions($product_options['reserve']);
            $where_product_id = implode(',', $product_ids);
            $sql = "SELECT * FROM {$this->table_prefix}ms2_product_options WHERE product_id IN (SELECT product_id FROM {$this->table_prefix}ms2_product_options AS sc WHERE product_id IN ($where_product_id) AND ($where_options) GROUP BY product_id);";
            $result = $this->modx->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        }

        /**
         * Получить товары по полученным ID и отдать необходимые поля массивом
         */
        // public function result($find_products)
        // {
        //     $product_ids = $this->getProductIds($find_products);
        //     $product_ids = implode(',', $product_ids);
        //     $sql = "SELECT id,pagetitle,uri FROM {$this->table_prefix}site_content WHERE id IN ($product_ids)";
        //     $result = $this->modx->query($sql);
        //     $rows = $result->fetchAll(PDO::FETCH_ASSOC);

        //     return $rows;
        // }
        public function result($find_products)
        {
            $product_ids = $this->getProductIds($find_products);
            $product_ids = implode(',', $product_ids);
            return $product_ids;
        }

        static function generateWhereOptions($items)
        {
            $where_options = [];
            foreach ($items as $item) {
                $where_options[] = "(`key` = '{$item['key']}' AND `value` = '{$item['value']}')";
            }
            return implode(' OR ', $where_options);
        }
        static function getProductIds($find_products)
        {
            $product_ids = array_column($find_products, 'product_id');
            $product_ids = array_unique($product_ids);
            $product_ids = array_values($product_ids);
            return $product_ids;
        }
    }
}

$getComponents = new getComponents($components_category_id, $options, $modx);
$result = $getComponents->init();

return $result;
