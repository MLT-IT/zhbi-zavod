<?php
/**
 * Снипет вывода древовидного меню в виде строки со всеми подкатегориями (123123,122414)
 * @param $parent родитель по которому требуется получить категории
 * @return array idsCategory список id категорий
 */

$result = [];

if(strpos($parent, ',') ){
    $parents = explode(',', $parent);
    $result = array_merge($result, $parents);
}else{
    $result[] = $parent;
}

if(!isset($parent)) return;

function getCategories($parent)
{
    global $modx;
    $result = [];
    $categories = $modx->getCollection('msCategory', [
        'parent' => $parent
    ]);

    if($categories){
        $result = array_map(function($item){
            return $item->id;
        }, $categories);
    }


    foreach($categories as $category){
        $result = array_merge(getCategories($category->id), $result);
    }

    return $result;
}



if(!empty($parents)){

    foreach($parents as $parent){
        $result = array_merge($result, getCategories($parent));
    }
}else{
    $result = getCategories($parent);
}

return $result;
