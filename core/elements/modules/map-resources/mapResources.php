<?php
if (!isset($parents)) return false;

$cache_name = md5(serialize($scriptProperties));

if ($save_cache_name) {
    $modx->setPlaceholder('catalog_cache_name', $cache_name);
}

$cache_options = [
    xPDO::OPT_CACHE_KEY => 'default/map-resources/' . $modx->resource->context_key . '/',
];

if (!$output = $modx->cacheManager->get($cache_name, $cache_options)) {

    $depth = $depth ?? 0;
    $fields = ["id", "pagetitle", "menutitle", "parent", "alias", "uri", "template"];
    $table_prefix = $modx->getOption('table_prefix');

    // Подготовка where
    $where = !empty($where) ? json_decode($where, true) : [];
    $where = array_merge([
        'deleted' => 0,
        'hidemenu' => 0,
        'published' => 1,
        'context_key' => $modx->resource->context_key
    ], $where);

    if (isset($resources)) $where['id:IN'] = "($resources)";

    $where_string = '';
    foreach ($where as $key => $value) {
        [$field, $operator] = array_pad(explode(':', $key), 2, '=');
        $value_str = ($operator === 'IN') ? $value : $modx->quote($value);
        $where_string .= "sc.`$field` $operator $value_str AND ";
    }
    $where_string = rtrim($where_string, ' AND ');

    // TV
    if ($includeTVs) {
        $includeTVs = "('" . str_replace(',', "','", $includeTVs) . "')";
    }

    // Получаем все ресурсы сразу (для всех уровней глубины)
    $parents_list = [$parents];
    $all_resource_ids = [];
    $results = [];

    for ($i = 0; $i <= $depth; $i++) {
        if (empty($parents_list)) break;

        $parents_str = implode(',', $parents_list);
        $sql = "SELECT " . 'sc.' . implode(',sc.', $fields) . " 
                FROM {$table_prefix}site_content AS sc 
                WHERE $where_string AND sc.parent IN ($parents_str)";
        $rows = $modx->query($sql)->fetchAll(PDO::FETCH_ASSOC);

        $parents_list = array_column($rows, 'id');
        $all_resource_ids = array_merge($all_resource_ids, $parents_list);
        $results = array_merge($results, $rows);
    }

    // Получаем TV одним запросом
    $tvs_by_resource = [];
    if ($includeTVs && !empty($all_resource_ids)) {
        $sql = "SELECT stc.contentid, st.name, stc.value 
                FROM {$table_prefix}site_tmplvars AS st
                JOIN {$table_prefix}site_tmplvar_contentvalues AS stc
                ON st.id = stc.tmplvarid
                WHERE stc.contentid IN (" . implode(',', $all_resource_ids) . ") 
                AND st.name IN $includeTVs";
        $rows = $modx->query($sql)->fetchAll(PDO::FETCH_ASSOC);

        foreach ($rows as $tv) {
            $tvs_by_resource[$tv['contentid']][$tv['name']] = $tv['value'];
        }
    }

    // Добавляем TV к ресурсам
    foreach ($results as &$res) {
        if (isset($tvs_by_resource[$res['id']])) {
            $res = array_merge($res, $tvs_by_resource[$res['id']]);
        }
    }

    // Построение дерева ресурсов за один проход
    $tree = [];
    $items = [];
    foreach ($results as $res) {
        $res['children'] = [];
        $items[$res['id']] = $res;
    }
    foreach ($items as $id => $res) {
        if ($res['parent'] && isset($items[$res['parent']])) {
            $items[$res['parent']]['children'][] = &$items[$id];
        } else {
            $tree[] = &$items[$id];
        }
    }

    $output = $tree;
    $modx->cacheManager->set($cache_name, $output, 0, $cache_options);
}

if (isset($toPlaceholder)) {
    $modx->setPlaceholder($toPlaceholder, $output);
} else {
    return $output;
}
