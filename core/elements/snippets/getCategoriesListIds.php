<?php
/**
 * Снипет вывода древовидного меню в виде строки со всеми подкатегориями (123123,122414)
 * @param $parent родитель по которому требуется получить категории
 * @return array idsCategory список id категорий
 */

/*
ob_start();
$start_time = hrtime(true);
*/

if(!function_exists('cacheCategories'))
{
    function cacheCategories($parent){
        global $modx;

        $cacheFolder = 'getCategoriesListIds';
        $cacheName = $parent;

        $cacheOptions = [
            xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder,
        ];

        if(!$result = $modx->cacheManager->get($cacheName, $cacheOptions))
        {
            $q = $modx->newQuery("msCategory", ["parent" => $parent, "class_key" => "msCategory"]);
            $q->select("id");
             
            $st = $q->prepare();
            //echo $q->toSQL();
            $result = getCategories($parent, $st, "msCategory");
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
    
    function getCategories($parent, $st)
    {
        $result = [];
        $st->execute([$parent, "msCategory"]);
        $r = $st->fetchAll(PDO::FETCH_COLUMN);
        $st->closeCursor();
        $result = array_merge($result, $r);
        foreach($r as $cat){
            $result = array_merge(getCategories($cat, $st), $result);
        }
        $result[] = $parent;
        return $result;
    }
}

if(!empty($parents)){
    foreach($parents as $parent){
        $result = array_merge($result, cacheCategories($parent));
    }
}else{
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
