<?php
/**
 * Cниппет для вывода характеристик из json формата
 */


/*
 * Получение характеристик из файлов json
 * Подробнее о характеристиках
 *      name: Название характеристики
 *      value: Значение характеристики если оно статично
 *      key: Ключ характеристики берется из src
 *      custom: Это кастомное поле которое можно писать на php, за вывод этого поля отвеачает массив $dataCustom,
 *              который формируется из снипета, передается в параметре snippetDataCustom
 */
if(!function_exists('getCharecters'))
{
    function getCharecters($parent, $contextKey){
        $path = MODX_ASSETS_PATH . "template/json/charecters-catalog/";
        $pathFile = $path . $contextKey . "/" . $parent . ".json";
        $charecters = [];
        if(file_exists($pathFile))
        {
            $charecters = json_decode(file_get_contents($pathFile), true);
        }
        return $charecters;
    }
}


/*
 * Получение файлов из паки
 */
if(!function_exists('getFiles')){
    function getFiles($dir)
    {
        $resultFiles = [];
        $files = scandir($dir);
        foreach($files as $file){
            if($file != "." && $file != ".."){
                $resultFiles[] = $file;
            }
        }
        return $resultFiles;
    }
}

/*
 * Адаптирует формат опций к формату снипета getListingProductChars
 *    $charsValues = [
 *           'Толщина, мм' => ['val' => $src['item_thickness']],
 *           'Производитель' => ['val' => $src['proizvoditel']],
 *           'Покрытие' => ['val' => $src['pokrytie']],
 *           'Цвет' => ['val' => $src['cvet']],
 *           'Вид поверхности' => ['val' => $src['vid-poverhnosti']],
 *       ];
 */
if(!function_exists('getCharectersUdapter'))
{
    function getCharectersUdapter($charecters, $src, $snippetDataCustom)
    {
        global $modx;
        $pdoTools = $modx->getService('pdoTools');
        $charsValues = [];

        foreach($charecters as $charecter)
        {
            $value = "";

            $dataCustom = $pdoTools->runSnippet($snippetDataCustom);

            if(!empty($charecter['custom']))
            {
                if(array_key_exists($charecter['custom'], $dataCustom))
                {
                    $value = [$dataCustom[$charecter['custom']]];
                }else{
                    $value = "";
                }
            }
            elseif(!empty($charecter['key'])){
                $value = $src[$charecter['key']];
            }else{
                $value = [$charecter['value']];
            }

            $charsValues[$charecter['name']]["val"] =  $value;
        }
        return $charsValues;
    }
}

// Тут происходит вся магия
$pdoTools = $modx->getService('pdoTools');

// получаем папку текущего контекста
$path = MODX_ASSETS_PATH . "template/json/charecters-catalog/" . $contextKey . "/";


// из нее достаем все файлы
foreach (getFiles($path) as $categoryFile)
{
    // приводим id к формату вывода int
    $categoryId = str_replace(".json", "", $categoryFile);

    // перебераем все категории которые у нас есть в json
    $childsCategories = $pdoTools->runSnippet("@FILE snippets/getCategoriesListIds.php", ['parent' => $categoryId]);

    // если текущий родитель ресурса есть в этих категориях
    if(in_array($parent, $childsCategories))
    {
        // то выводим их
        $charecters = getCharecters($categoryId, $contextKey);
        return getCharectersUdapter($charecters, $src, $snippetDataCustom);
    }
}

