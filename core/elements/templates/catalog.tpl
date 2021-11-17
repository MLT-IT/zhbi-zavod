{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>

    {include "file:sections/main/banner.tpl"}

    <div class="wrapper">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>
    </div>

    {include "file:sections/catalog/catalog.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/advantages.tpl"}

    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <div class="content-block">
                {$_modx->resource.content}
            </div>
        </div>
    {/if}

    {include "file:sections/partners.tpl"}
    {include "file:sections/delivery.tpl"}
{/block}
