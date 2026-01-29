<?php

if (!$pdoTools = $modx->getService('pdoTools')) {
    $modx->log(xPDO::LOG_LEVEL_ERROR, 'Ошибка загрузки pdoTools');
    return;
}

if (!class_exists('SimilarProductsFinder')) {
    class SimilarProductsFinder
    {
        private $modx;
        private $tablePrefix;
        private $currentProductId;
        private $searchDepth = 3;

        public function __construct(modX &$modx)
        {
            $this->modx = $modx;
            $this->tablePrefix = $modx->getOption('table_prefix');
            $this->currentProductId = $modx->resource->id;
        }

        public function run()
        {
            $rules = $this->getRules();

            $result = [
                'rules' => [],
                'data' => []
            ];
            
            foreach ($rules as $rule) {
                $options = $this->getProductOptions($rule);
                //if (empty($options)) return;
                //$this->modx->log(1, "Here 2!");
                
                $parentIds = $this->getAllNestedParentIds($rule);
                
                $product_ids = $this->findSimilarProducts($options, $parentIds);
                //$this->modx->log(1, print_r($product_ids, true));
                /*$product_ids = [];
                $prev_id = -1;
                if($products_stmt instanceof PDOStatement) {
                    while($product = $products_stmt->fetch(PDO::FETCH_OBJ)) {
                        if($product->product_id == $prev_id)continue;
                        $product_ids[] = (int)$product->product_id;
                        $prev_id = (int)$product->product_id;
                    }
                }*/
                
                $result['rules'][] = [
                    'name' => $rule->name,
                ];
                //$this->modx->log(1, "Product ids:");
                //$this->modx->log(1, print_r($product_ids, true));
                if(!empty($product_ids)) {
                    $result['data'][] = [
                        'products' => $product_ids,
                        'parents' => $parentIds
                    ];
                }
            }
            
            //$this->modx->log(1, "Result:");
            //$this->modx->log(1, print_r($result, true));
            return $result;
        }

        public function getRules()
        {
            $parent = $this->modx->getObject('modResource', $this->modx->resource->parent);
            $tv = $parent->getTVValue('similarsample');
            //$this->modx->log(1, "TV:".$tv);
            if (!$tv) return [];

            $this->modx->addPackage("similarsamples", $this->modx->getOption("core_path") . "components/similarsamples/model/");

            $rules_ids = explode(',', $tv);
            $rules = $this->modx->getCollection('SSRules', ['id:in' => $rules_ids]);
            return $rules;
        }

        private function getProductOptions($rule)
        {
            $options = explode(",", $rule->options);
            $escapedKeys = array_map(function ($key) {
                return $this->modx->quote($key);
            }, $options);
            $keysStr = implode(',', $escapedKeys);

            $sql = "SELECT `key`, `value` FROM {$this->tablePrefix}ms2_product_options 
                    WHERE product_id = {$this->currentProductId} 
                    AND `key` IN ($keysStr)";
            $stmt = $this->modx->query($sql);
            return $stmt ? $stmt->fetchAll(PDO::FETCH_ASSOC) : [];
        }

        private function getAllNestedParentIds($rule)
        {
            $parents = explode(",", $rule->categories);
            
            
            $parentsStr = implode(',', array_map('intval', $parents));
            $sql = "WITH RECURSIVE cats AS (
                SELECT id FROM {$this->tablePrefix}site_content WHERE parent IN ($parentsStr) and class_key = 'msCategory'
                UNION all
                SELECT c.id FROM {$this->tablePrefix}site_content c INNER JOIN cats ON cats.id = c.parent
                WHERE c.class_key = 'msCategory'
            )
            SELECT id FROM cats;";
            //$this->modx->log(1, "SQL: ".$sql);
            $stmt = $this->modx->query($sql);
            //$this->modx->log(1, "queryStr: ".$stmt->queryString);
            $rows = $stmt ? $stmt->fetchAll(PDO::FETCH_COLUMN) : [];
            $res = array_merge($parents, array_map('intval', $rows));
            //$this->modx->log(1, print_r($res, true));
            
            return $res;
            
            /*
            $allParentIds = $parents;
            $currentLevel = $parents;

            for ($depth = 1; $depth <= $this->searchDepth; $depth++) {
                if (empty($currentLevel)) break;
                $parentsStr = implode(',', array_map('intval', $currentLevel));

                $sql = "SELECT id FROM {$this->tablePrefix}site_content 
                        WHERE class_key = 'msCategory' 
                        AND parent IN ($parentsStr)";
                $stmt = $this->modx->query($sql);
                $rows = $stmt ? $stmt->fetchAll(PDO::FETCH_COLUMN) : [];

                $allParentIds = array_merge($allParentIds, $rows);
                $currentLevel = $rows;
            }

            $res = array_unique(array_map('intval', $allParentIds));
            $this->modx->log(1, "Nested parents:");
            $this->modx->log(1, print_r($res, true));
            $this->modx->log(1, print_r($allParentIds, true));
            
            return array_unique(array_map('intval', $allParentIds));
            */
        }

        private function &findSimilarProducts(array $productOptions, array &$parentIds)
        {
            $parentIdsStr = implode(',', $parentIds);
            /*
            $productSubQuery = "SELECT id FROM {$this->tablePrefix}site_content 
                                WHERE parent IN ($parentIdsStr) 
                                AND id != {$this->currentProductId}";
            */
            $whereOptions = $this->buildOptionWhereClause($productOptions);
            if($whereOptions)$whereOptions = 'where '.$whereOptions;
            /*
            $sql = "SELECT * FROM {$this->tablePrefix}ms2_product_options 
                    WHERE product_id IN (
                        SELECT product_id FROM {$this->tablePrefix}ms2_product_options 
                        WHERE product_id IN ($productSubQuery) 
                        $whereOptions
                        GROUP BY product_id
                    )";
            */
            $sql = "SELECT distinct o.product_id FROM (SELECT c.id from {$this->tablePrefix}site_content c where c.parent IN ($parentIdsStr) AND c.id != {$this->currentProductId}) q
            inner join modx_ms2_product_options o on q.id = o.product_id $whereOptions";
            //$this->modx->log(1, "Query before: ".$sql);
            //$start = microtime(true);
            $stmt = $this->modx->query($sql);
            //$this->modx->log(1, "Work time: ".(microtime(true) - $start));
            //$this->modx->log(1, "Query: ".$stmt->queryString);
            
            return $stmt ? $stmt->fetchAll(PDO::FETCH_COLUMN) : [];
        }

        private function buildOptionWhereClause(array $options)
        {
            $clauses = [];
            foreach ($options as $opt) {
                $key = $this->modx->quote($opt['key']);
                $value = $this->modx->quote($opt['value']);
                $clauses[] = "(o.`key` = $key AND o.`value` = $value)";
            }
            return empty($clauses) ? '' : '(' . implode(' OR ', $clauses) . ')';
        }
    }
}

$cache = [
    'name' => $modx->resource->id,
    'options' => [
        xPDO::OPT_CACHE_KEY => 'default/similarsamples/' . $modx->resource->context_key . '/',
    ]
];

if (!$result = $modx->cacheManager->get($cache['name'], $cache['options'])) {
    $finder = new SimilarProductsFinder($modx);
    $result = $finder->run();
    $modx->cacheManager->set($cache['name'], $result, 0, $cache['options']);
}

if (empty($result['data'])) return null;

return $pdoTools->getChunk("@FILE _modules/similarsamples/chunks/wrapper.tpl", ["data" => $result]);
