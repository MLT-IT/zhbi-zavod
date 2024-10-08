<?php

/**
 * Снипет вывода древовидного меню в виде строки со всеми подкатегориями (123123,122414)
 * @param $parent родитель по которому требуется получить категории
 * @return array idsCategory список id категорий
 */

if (!function_exists('cacheCategories')) {
    function cacheCategories($parent)
    {
        global $modx;

        $cacheFolder = 'getCategoriesListIds';
        $cacheName = $parent;

        $cacheOptions = [
            xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder,
        ];

        if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
            $result = getCategories([$parent]);
            $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
        }

        return $result;
    }
}


$result = [];

if (strpos($parent, ',')) {
    $parents = explode(',', $parent);
}

if (!isset($parent)) return;

if (!function_exists('getCategories')) {
    function getCategories($parents)
    {
        global $table_prefix, $modx;

        $parents_string = implode(',', $parents);
        $query = $modx->query("SELECT id FROM {$table_prefix}site_content WHERE parent IN ($parents_string) AND class_key = 'msCategory'");
        $ids = $query->fetchAll(PDO::FETCH_COLUMN);

        $result = [];
        if (!empty($ids)) {
            $result = array_merge(getCategories($ids), $result);
        }

        $result = array_merge($parents, $ids, $result);

        return $result;
    }
}


if (!empty($parents)) {
    foreach ($parents as $parent) {
        $result = array_merge($result, cacheCategories($parent));
    }
} else {
    $result = array_merge($result, cacheCategories($parent));
}

/*
$end_time = hrtime(true);
echo "hrtime:".($end_time - $start_time);
print_r($result);
$output = ob_get_clean();
file_put_contents(MODX_BASE_PATH."/output.txt", $output);
*/
return $result;
