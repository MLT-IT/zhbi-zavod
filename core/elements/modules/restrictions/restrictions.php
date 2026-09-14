<?php

try{
    $currentResource = $modx->resource;
    $context = $currentResource->context_key;

    $tpl = $modx->getOption("tpl", null, "@FILE modules/restrictions/restrictions.tpl");

    $catalog = $modx->getObject("modResource", [
        "alias" => "catalog",
        "context_key" => $context
    ]);

    if(empty($catalog)){
        $modx->log(1, "Каталог не найден");
        return;
    }

    $pdoTools = $modx->getService("pdoTools");
    $currentResourceCategories = $modx->getParentIds($currentResource->id, 10, ['context' => $context]);
    $restrictionsData = $catalog->getTVValue("restrictions");
    $restrictions = json_decode($restrictionsData, true);

    foreach ($restrictions as $restriction) {
        if(!is_array($restriction["categories"])){
            $restriction["categories"] = explode(",", $restriction["categories"]);
        }

        if (!empty(array_intersect($restriction["categories"], $currentResourceCategories))) {
            return $pdoTools->getChunk($tpl,
                ["title" => $restriction["title"]]
            );
        }
    }
}catch (Throwable $e){
    $modx->log(1, $e->getMessage());
}


