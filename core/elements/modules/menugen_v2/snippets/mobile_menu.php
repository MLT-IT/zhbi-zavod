<?php


$file_menu_top = MODX_ASSETS_PATH . "template/json/menu/" . $modx->resource->context_key . "/mobile_menu_toplevel.json";
$file_menu_catalog = MODX_ASSETS_PATH . "template/json/menu/" . $modx->resource->context_key . "/mobile_menu_catalog.json";


if(!file_exists($file_menu_top)){
    $modx->log(modX::LOG_LEVEL_ERROR, "Файл меню $file_menu_top не найден");
    return;
}
if(!file_exists($file_menu_catalog)){
    $modx->log(modX::LOG_LEVEL_ERROR, "Файл меню $file_menu_catalog не найден");
    return;
}

$fileMenuDataTop = file_get_contents($file_menu_top);
$menuDataTop = json_decode($fileMenuDataTop, true);

$fileMenuDataCatalog = file_get_contents($file_menu_catalog);
$menuDataCatalog = json_decode($fileMenuDataCatalog, true);

//----------------------Начало проверок----------------------------

//чтобы не загажиать шаблон условиями, легче отфильтровать массив на вход здесь
//Сейчас будем проверять пункты на условия видимости
//опубликован или нет, 
//и надо ли выводитьпункт на текущем шаблоне (либо список разрешенных, либо запрещенных, либо оба)

$resource_tpl_id = $modx->resource->get('template');
$newMenu = [];

foreach ($menuDataTop["menu"] as $key => $item) {
    if($item["published"]){
        if(isset($item["criteria"])){
            if(isset($item["criteria"]["template_is"]) && !in_array($resource_tpl_id, $item["criteria"]["template_is"])){
                continue;
            }
            if(isset($item["criteria"]["template_not"]) && in_array($resource_tpl_id, $item["criteria"]["template_not"])){
                continue;
            }
        }
        $newMenu[]=$item;
    }
}
$menuDataTop["menu"] = $newMenu;
//----------------------Конец проверок----------------------------
//----------------------СДЕЛАЕМ КАТАЛОГ СНОВА ПЛОСКИМ-------------
$flat_catalog = [];

function transform($unflat_array, &$flat_array, $key, $back,$title,$link, $spoiler = null){
    $result = [];
    global $modx;
    //$modx->log(xPDO::LOG_LEVEL_ERROR, print_r($unflat_array, true));

    foreach($unflat_array as $item){
        $flat_item = [
            "id" => $item['id'],
            "link" => $item["link"],
            "title" => $item["title"],
        ];
        if(isset($item['img'])){
            $flat_item['img'] = $item['img'];
        }
        if (!empty($item['children'])) {
            $flat_item['child'] = $item['id'];
            $children = transform($item['children'], $flat_array, $item['id'], $key, $item['title'],$item["link"], $item['spoiler']);
        }
        else{
            $flat_item['child'] = -100;
        }

        $result['key'] = $key;
        $result['title'] = $title;
        $result['link'] = $link;
        $result['back'] = $back;
        $result['menu'][] = $flat_item;
        
    }
    if($spoiler)$result['spoiler'] = $spoiler;
    $flat_array[$key] = $result;
}
transform($menuDataCatalog, $flat_catalog, 0, -1,'Каталог','/catalog/');
 //echo'<pre>';
 //$modx->log(xPDO::LOG_LEVEL_ERROR, print_r($flat_catalog, true));
 //print_r($flat_catalog);
 //echo'</pre>';
//----------------------КАТАЛОГ СНОВА ПЛОСКИЙ---------------------
// print_r($menuData);

$pdoTools = $modx->getService("pdoTools");
$output = $pdoTools->getChunk($tpl, ["data" => $menuDataTop, "catalog"=>$flat_catalog]);

echo $output;


