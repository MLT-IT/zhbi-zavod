<?php

/**
 * Скрипт необходимо расположить в начале страницы для инициализации необходимых данных
 * Подгружает по переданному ID правила ssRules необходимые товары 
 * 1. Получает выборки
 * 2. Кэширует найденные ID товаров и их родителей
 * 3. По ID подгружает msProducts
 * 
 * Не кэшировать результат msProducts! В чанках много динамики!
 */


if ($_SERVER['REQUEST_METHOD'] !== 'POST') return;

$input = file_get_contents('php://input');
$postData = json_decode($input, true);

if (empty($postData['action']) || $postData['action'] !== "similarsamples") return;

if (!$pdoTools = $modx->getService('pdoTools')) exit(json_encode([
    'status' => false,
    'message' => 'pdoTools not found'
]));

if (!class_exists('SimilarProductsFinder')) {
    class SimilarProductsFinder
    {
        private $modx;
        private $tablePrefix;
        private $currentProductId;
        private $ruleId;

        public function __construct(modX $modx, $postData)
        {
            $this->modx = $modx;
            $this->tablePrefix = $modx->getOption('table_prefix');
            $this->currentProductId = $modx->resource->id;
            $this->ruleId = $postData['rule_id'];
        }

        public function getData()
        {
            $this->modx->addPackage("similarsamples", $this->modx->getOption("core_path") . "components/similarsamples/model/");

            $rule = $this->modx->getObject('SSRules', ['id' => $this->ruleId]);
            if (!$rule) exit(json_encode([
                'status' => false,
                'message' => 'Rule not found'
            ]));

            $options = $this->getProductOptions($rule);
            $parentIds = $this->getAllNestedParentIds($rule);
            $productIds = $this->findSimilarProducts($options, $parentIds);

            return ['productIds' => $productIds, 'parentIds' => $parentIds];
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
            $stmt = $this->modx->query($sql);
            $rows = $stmt ? $stmt->fetchAll(PDO::FETCH_COLUMN) : [];
            $res = array_merge($parents, array_map('intval', $rows));

            return $res;
        }

        private function findSimilarProducts(array $productOptions, array $parentIds)
        {
            $parentIdsStr = implode(',', $parentIds);
            $whereOptions = $this->buildOptionWhereClause($productOptions);
            if ($whereOptions) $whereOptions = 'where ' . $whereOptions;

            $sql = "SELECT distinct o.product_id FROM (SELECT c.id from {$this->tablePrefix}site_content c where c.parent IN ($parentIdsStr) AND c.id != {$this->currentProductId}) q
            inner join modx_ms2_product_options o on q.id = o.product_id $whereOptions";

            $stmt = $this->modx->query($sql);

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
    'name' => $modx->resource->id . '_' . $postData['rule_id'],
    'options' => [
        xPDO::OPT_CACHE_KEY => 'default/similarsamples/result_ids/' . $modx->context->key . '/',
    ]
];

// КЭшируем только ID полученных ресов, так как вывод msPorduct кэшировать нельзя, там много динамики 
if (!$resultIds = $modx->cacheManager->get($cache['name'], $cache['options'])) {
    $finder = new SimilarProductsFinder($modx, $postData);

    // return ['parentIds'=>[],'productIds'=>[]]
    $resultIds = $finder->getData();

    $modx->cacheManager->set($cache['name'], $resultIds, 0, $cache['options']);
}

if (empty($resultIds) || empty($resultIds['productIds'])) exit(json_encode([
    'status' => false,
    'message' => 'not results'
]));

$result = $pdoTools->runSnippet('msProducts', [
    'parents' => implode(',', $resultIds['parentIds']),
    'resources' => implode(',', $resultIds['productIds']),
    'tpl' => '@FILE modules/product-cards/chunks/v2/wrapper.tpl',
    'tplWrapper' => '@INLINE {$output}',
    'includeThumbs' => 'webp'
]);

exit(json_encode([
    'status' => true,
    'data' => $result
], JSON_UNESCAPED_UNICODE));
