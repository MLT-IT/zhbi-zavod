{extends "file:layouts/default.layout.tpl"}

{block "page"}
    {include "file:sections/main/banner.tpl"}

    <div class="wrapper">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>

        {if $_modx->resource.introtext | length > 0}
            <div class="content-block">
                {$_modx->resource.introtext}
            </div>
        {/if}
    </div>

    {include "file:sections/popular/sect-pop-main.tpl"}
    {include "file:sections/main/catalog.tpl"}
    {include "file:sections/main/promo.tpl"}
    {include "file:sections/main/stocks.tpl"}
    {include "file:sections/certs.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/payment.tpl"}
    {include "file:sections/advantages.tpl"}

    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <article class="content-block">
                {$_modx->resource.content}
            </article>
        </div>
    {/if}

    {include "file:sections/steps.tpl"}
    {include "file:sections/partners.tpl"}
    {include "file:sections/districts-map.tpl"}
{/block}
