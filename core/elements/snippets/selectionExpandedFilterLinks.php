<?php

/*
 * @param $tvField тв поле используемое для вывода фильтров
 * @param $tplLinkExpanded шаблон обертка ссылок
 * @param $tplItemLink
 */

if(empty($tvField))
{
   $tvField = "selectionCustomFilters";
}

if(empty($tplLinkExpanded))
{
    $tplLinkExpanded = "@FILE chunks/selectionFiltersExpanded/linksExpanded.tpl";
}

if(empty($tplItemLink)){
    $tplItemLink = "@FILE chunks/selectionFiltersExpanded/linkNoImage.tpl";
}

$pdoTools = $modx->getService("pdoTools");

$selections = json_decode($modx->resource->getTVValue($tvField), true);

$output = "";
foreach ($selections as $selectionItem)
{
    $selectionLinks = json_decode($selectionItem['links'] , true);

    $outputLinks = "";
    foreach ($selectionLinks as $selectionLink)
    {
        if(!empty($selectionLink['category_id']))
        {
            $link = $modx->makeUrl($selectionLink['category_id']);
        }else{
            $link = $selectionLink['link'];
        }

        $outputLinks .= $pdoTools->getChunk($tplItemLink, [
            "selectionLink" => $selectionLink,
            "link" => $link,
        ]);
    }

    $output .= $pdoTools->getChunk($tplLinkExpanded,
        [
            'selection' => $selectionItem,
            'outputLinks' => $outputLinks
        ]
    );
}

return $output;