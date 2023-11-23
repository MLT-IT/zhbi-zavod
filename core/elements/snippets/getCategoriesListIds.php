<?php
/**
 * Снипет вывода древовидного меню в виде строки со всеми подкатегориями (123123,122414)
 * @param $parent родитель по которому требуется получить категории
 * @return array idsCategory список id категорий
 */

if(!function_exists('cacheCategories'))
{
    function cacheCategories($parent ){
        global $modx;
        $cacheFolder = 'getCategoriesListIds';
        $cacheName = $parent;

        $cacheOptions = [
            xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder,
        ];

        if(!$result = $modx->cacheManager->get($cacheName, $cacheOptions))
        {
            $result = getCategories($parent);
            $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
        }

        return $result;
    }
}


$result = [];

if(strpos($parent, ',') ){
    $parents = explode(',', $parent);
}

if(!isset($parent)) return;

if(!function_exists('getCategories'))
{
    function getCategories($parent)
    {
        global $modx;
        $resultCategories = [];
        $categories = $modx->getCollection('msCategory', [
            'parent' => $parent
        ]);

        if($categories){
            $resultCategories = array_map(function($item){
                return $item->id;
            }, $categories);
        }


        foreach($categories as $category){
            $resultCategories = array_merge(getCategories($category->id), $resultCategories);
        }
        $resultCategories[] = $parent;
        return $resultCategories;
    }
}




if(!empty($parents)){
    foreach($parents as $parent){
        $result = array_merge($result, cacheCategories($parent));
    }
}else{
    $result = array_merge($result, cacheCategories($parent));
}

return $result;
