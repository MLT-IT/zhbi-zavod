{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>

    {include "file:sections/main/banner.tpl" dataBtnKey='banner-delivery'}

    <div class="wrapper">
        <h1 class="title-1 rm-vert-mgs">{$_modx->resource.pagetitle}</h1>
    </div>

    {*
    Старый баннер
    {include "file:sections/delivery/banner.tpl"}
    *}

    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <article class="content-block">
                {if $_modx->getPlaceholder('utm_city')['dcase'] ?}
                    {$_modx->resource.content | replace : 'Санкт-Петербургу и Ленинградской области' : $_modx->getPlaceholder('utm_city')['dcase']}
                {else}
                    {$_modx->resource.content}
                {/if}
            </article>
        </div>
    {/if}

    {include "file:sections/payment.tpl"}
    {include "file:sections/certs.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/steps.tpl"}
    {include "file:sections/partners.tpl"}
    {include "file:sections/districts-map.tpl"}
{/block}
