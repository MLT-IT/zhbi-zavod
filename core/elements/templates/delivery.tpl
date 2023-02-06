{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>

    {include "file:sections/main/banner.tpl" dataBtnKey='banner-delivery'}

    <div class="wrapper">
        <h1 class="title-1{if $_modx->resource.template == 3} rm-vert-mgs{/if}">{$_modx->resource.pagetitle}</h1>




    </div>

    {*
    Старый баннер
    {include "file:sections/delivery/banner.tpl"}
    *}

    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            {include 'file:blocks/content-delivery.tpl'}
        </div>
    {/if}

    {include "file:sections/payment.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/districts-map.tpl"}
    {include "file:sections/appeal.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/steps.tpl"}
    {include "file:sections/partners.tpl"}
{/block}
