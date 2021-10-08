{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    <div class="wrapper sect-htmlmap">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>
        <div class="sect-htmlmap__content">
            {'pdoMenu' | snippet : [
                'resources' => '-' ~ $_modx->resource.id,
                'parents' => 0,
                'depth' => 1000,
                'limit' => 0,
                'tplOuter' => '@INLINE <ul>{$wrapper}</ul>',
                'tplInner' => '@INLINE {$wrapper}',
                'tpl' => '@FILE chunks/sitemapItem.tpl',
                'tplCategoryFolder' => '@FILE chunks/sitemapCategoryItem.tpl',
                'showUnpublished' => '1',
                'context' => $_modx->resource.context_key
            ]}
        </div>
    </div>
{/block}
