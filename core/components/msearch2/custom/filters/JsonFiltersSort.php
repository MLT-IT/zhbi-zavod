<?php

function formatPhpInJson($optionPath, $option_key)
{
    $nameJson = str_replace(".php", ".json", $option_key);
    if (!file_exists($optionPath . $nameJson)) {
        $data = include $optionPath . $option_key;
        $json = json_encode($data);
        file_put_contents($optionPath . $nameJson, $json);
    }
}

function getFiles($dir)
{
    $resultFiles = [];
    $files = scandir($dir);
    foreach ($files as $file) {
        if ($file != "." && $file != "..") {
            $resultFiles[] = $file;
        }
    }
    return $resultFiles;
}

function getOptionValue($optionPath, $option_key)
{

    if (strpos($option_key, ".json") !== false) {
        return json_decode(file_get_contents($optionPath . $option_key), true);
    }
}

function getOptionsFromPath($optionPath)
{
    $options = [];
    foreach (getFiles($optionPath) as $option_key) {
        formatPhpInJson($optionPath, $option_key);
        $options[] = getOptionValue($optionPath, $option_key);
    }
    return $options;
}

function getCategoriesFromPath($categoryPath)
{
    $categories = [];

    foreach (getFiles($categoryPath) as $category_id) {
        $category['category_id'] = $category_id;
        $optionPath = $categoryPath . $category_id . '/';
        $category['options'] = getOptionsFromPath($optionPath);
        $categories[] = $category;
    }
    return $categories;
}

/**
 * Выводит массив сортировки фильтров
 * теперь можно сортировать фильтры с помощью данного массива
 * структура:
 * указываем контекст
 *      указываем для какиех категорий происходит сортировка фильтров, если сортировка проихсодит для всех фильтров указываем all в category_id
 *      далее указываем опции со значениями для этих категорий
 *
 * context_key ->
 *  categories [
 *      -> options[
 *              {key, value[] сортировка}
 *          ]
 *      ]
 */
function sortFilterValue()
{
    $prefix = MODX_CORE_PATH . 'components/msearch2/custom/filters/filters/';

    $result = [];

    foreach (getFiles($prefix) as $context) {
        $result_context['context_key'] = $context;
        $categoryPath = $prefix . $context . '/';
        $result_context['categories'] = getCategoriesFromPath($categoryPath);
        $result[] = $result_context;
    }

    return $result;
}

function sortFilterValueCategory($category_id, $context_key)
{
    $prefix = MODX_CORE_PATH . 'components/msearch2/custom/filters/filters/';

    $result = [];
    $searchCategory = false;

    foreach (getFiles($prefix) as $context) {
        $categoryPath = $prefix . $context . '/';
        $categories = getCategoriesFromPath($categoryPath);
        foreach ($categories as $category) {
            $searchCategory = false;
            if ($category_id == $category['category_id']) {
                $searchCategory = true;
                return $category;
            }
        }
    }


    if (!$searchCategory) {
        foreach (getFiles($prefix) as $context) {
            {
                if ($context == $context_key) {
                    $categoryPath = $prefix . $context . '/';
                    $categories = getCategoriesFromPath($categoryPath);
                    foreach ($categories as $category) {
                        if ($category['category_id'] == 'all') {
                            return $category;
                        }
                    }
                }
            }
        }
    }

    return null;
}