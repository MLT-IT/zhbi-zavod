<?php
$parentIds = $modx->getParentIds($modx->resource->id);

foreach ($parentIds as $parentId){
    $parent = $modx->getObject('modResource', ['id' => $parentId]);

    if ($parent &&  gettype(mb_stripos(mb_strtolower($parent->get('pagetitle')), 'доборные')) == 'integer'){
        return true;
    }
}

return false;