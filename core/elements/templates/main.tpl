{extends "file:layouts/default.layout.tpl"}

{block "page"}
    {include "file:sections/main/banner.tpl"}
    {include "file:sections/main/catalog.tpl"}
    {include "file:sections/main/promo.tpl"}
    {include "file:sections/popular/popular.tpl"}
    {include "file:sections/main/stocks.tpl"}
    {include "file:sections/advantages.tpl"}
    <div class="wrapper">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>
        <div class="content-block">
            {$_modx->resource.content}
        </div>
    </div>
    {include "file:sections/partners.tpl"}
    {include "file:sections/delivery.tpl"}
{/block}