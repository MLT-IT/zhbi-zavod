{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    <div class="wrapper">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>
    </div>
    {include "file:sections/category/listing.tpl"}
    {*{include "file:sections/faq.tpl"}*}
    {include "file:sections/advantages.tpl"}
    <div class="wrapper">
        <div class="content-block">
            {$_modx->resource.content}
        </div>
    </div>
    {include "file:sections/partners.tpl"}
    {include "file:sections/delivery.tpl"}
{/block}
