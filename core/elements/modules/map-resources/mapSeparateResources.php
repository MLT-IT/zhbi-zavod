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
    // Рекурсивно обходит дерево и параллельно складывает найденные по $ids
    // ресурсы (на любом уровне вложенности) в $items_map по их собственному id.
    // Это важно: категория из $ids может быть вложена на 2-3 уровня (например
    // "Плиты пустотные ПК" внутри "Плиты перекрытия"), и её нужно находить
    // независимо от глубины, а не только среди прямых потомков корня.
    function filterResourcesByIds(array $data, array $ids, array &$items_map): array
    {
        $result = [];

        foreach ($data as $item) {
            $keep = in_array($item['id'], $ids);

            // Если есть дети — фильтруем их рекурсивно
            if (!empty($item['children']) && is_array($item['children'])) {
                $filteredChildren = filterResourcesByIds($item['children'], $ids, $items_map);

                if (!empty($filteredChildren)) {
                    $item['children'] = $filteredChildren;
                    $keep = true;
                } else {
                    unset($item['children']);
                }
            }

            if ($keep) {
                $result[] = $item;

                if (in_array($item['id'], $ids)) {
                    $items_map[$item['id']] = $item;
                }
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
    $items_map = [];
    filterResourcesByIds($data, $ids, $items_map);

    // Формируем результат в порядке переданных $ids
    $output = [];
    foreach ($ids as $id) {
        if (isset($items_map[$id])) {
            $output[] = $items_map[$id];
        }
    }

    $modx->cacheManager->set($cache_name, $output, 0, $cache_options);
}

return $output;
