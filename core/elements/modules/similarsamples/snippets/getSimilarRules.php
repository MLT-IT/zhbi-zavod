<?php

/**
 * Подгружает табы для переключения
 */

if (!function_exists('ssGetRules')) {
    function ssGetRules(): array|null
    {
        global $modx;

        $parent = $modx->getObject('modResource', $modx->resource->parent);
        $tv = $parent->getTVValue('similarsample');

        if (!$tv) return [];

        $rules_ids = explode(',', $tv);

        $modx->addPackage("similarsamples", $modx->getOption("core_path") . "components/similarsamples/model/");

        $q = $modx->newQuery('SSRules');
        $q->select(['id', 'name']);
        $q->where([
            'id:IN' => $rules_ids
        ]);

        $q->prepare();
        $q->stmt->execute();

        $rules = $q->stmt->fetchAll(PDO::FETCH_ASSOC);

        return $rules;
    }
}

$cache = [
    'name' => $modx->resource->parent,
    'options' => [
        xPDO::OPT_CACHE_KEY => 'default/similarsamples/rules/' . $modx->resource->context_key . '/',
    ]
];

if (!$result = $modx->cacheManager->get($cache['name'], $cache['options'])) {
    $result = ssGetRules();

    $modx->cacheManager->set($cache['name'], $result, 0, $cache['options']);
}

if (empty($result)) return null;

return $result;
