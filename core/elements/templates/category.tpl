{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>

    <div class="wrapper category-header">
        <h1 class="title-1 category-header__title">{$_modx->resource.pagetitle}</h1>
    </div>

    {include "file:sections/category/listing.tpl"}
    {include "file:sections/certs.tpl"}
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
