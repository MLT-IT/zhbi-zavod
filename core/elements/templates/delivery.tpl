{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    <div class="wrapper">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>
    </div>

    {include "file:sections/main/banner.tpl"}

    {* {include "file:sections/delivery/banner.tpl"} *}

    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <div class="content-block">
                {$_modx->resource.content}
            </div>
        </div>
    {/if}

    {include "file:sections/payment.tpl"}
    {include "file:sections/certs.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/partners.tpl"}
    {include "file:sections/districts-map.tpl"}
{/block}
