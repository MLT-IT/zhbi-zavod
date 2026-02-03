<?php

/**
 * Скрипт отдает ресурсы переданные в переменой $ids
 * Отдает ресурсы с детьми children
 * 
 * @param $ids - массив ID которые необходимо передать
 * @param $data - массив данных
 */

if (empty($data) || empty($ids)) return;

if (gettype($ids) == 'string')
    $ids = explode(',', $ids);


if (!function_exists('filterResourcesByIds')) {
    function filterResourcesByIds(array $data, array $ids): array
    {
        $result = [];
        $items_map = [];

        foreach ($data as $item) {
            $keep = in_array($item['id'], $ids);

            // Если есть дети — фильтруем их рекурсивно
            if (!empty($item['children']) && is_array($item['children'])) {
                $filteredChildren = filterResourcesByIds($item['children'], $ids);

                if (!empty($filteredChildren)) {
                    $item['children'] = $filteredChildren;
                    $keep = true;
                } else {
                    unset($item['children']);
                }
            }

            if ($keep) {
                $items_map[$item['id']] = $item;
            }
        }

        // Формируем результат в порядке переданных $ids
        foreach ($ids as $id) {
            if (isset($items_map[$id])) {
                $result[] = $items_map[$id];
            }
        }

        return $result;
    }
}



$cache_name = md5(serialize($scriptProperties));
$cache_options = [
    xPDO::OPT_CACHE_KEY => 'default/map-resources/mapSeparateResources/' . $modx->resource->context_key . '/',
];

if (!$output = $modx->cacheManager->get($cache_name, $cache_options)) {
    $output = filterResourcesByIds($data, $ids);
    $modx->cacheManager->set($cache_name, $output, 0, $cache_options);
}

return $output;
