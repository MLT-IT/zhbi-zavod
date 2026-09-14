<?php

/**
 * В отличие от mapResources.php (обход дерева "от родителя вниз" с фильтром
 * id:IN на каждом уровне — не находит ресурсы, чьи предки не входят в тот же
 * список ID), этот скрипт делает прямую выборку по конкретным ID одним
 * запросом, без привязки к положению в дереве.
 *
 * @param $ids - строка ID через запятую
 *
 * Результат отдаётся в порядке $ids (как раньше делал pdoResources
 * с sortby => 'FIELD(id, ...)').
 */

if (empty($ids)) return [];

$cache_name = md5(serialize($scriptProperties));
$cache_options = [
    xPDO::OPT_CACHE_KEY => 'default/map-resources/mapGetResourcesByIds/' . $modx->resource->context_key . '/',
];

if (!$output = $modx->cacheManager->get($cache_name, $cache_options)) {
    $fields = ["id", "pagetitle", "menutitle", "parent", "alias", "uri", "template"];
    $table_prefix = $modx->getOption('table_prefix');

    $ids_list = is_array($ids) ? $ids : explode(',', $ids);
    $ids_list = array_map('intval', $ids_list);

    $sql = "SELECT sc." . implode(',sc.', $fields) . "
            FROM {$table_prefix}site_content AS sc
            WHERE sc.deleted = 0 AND sc.hidemenu = 0 AND sc.published = 1
            AND sc.context_key = " . $modx->quote($modx->resource->context_key) . "
            AND sc.id IN (" . implode(',', $ids_list) . ")";
    $rows = $modx->query($sql)->fetchAll(PDO::FETCH_ASSOC);

    $by_id = [];
    foreach ($rows as $row) {
        $by_id[$row['id']] = $row;
    }

    $output = [];
    foreach ($ids_list as $id) {
        if (isset($by_id[$id])) {
            $output[] = $by_id[$id];
        }
    }

    $modx->cacheManager->set($cache_name, $output, 0, $cache_options);
}

return $output;
