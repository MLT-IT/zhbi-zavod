{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:chunks/meta/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:chunks/meta/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
    </div>
    <div class="wrapper sect-htmlmap">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>
        <div class="sect-htmlmap__content">

            {'@FILE snippets/htmlMap.php' | snippet}

        </div>
    </div>
{/block}
