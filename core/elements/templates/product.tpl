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
    <div class="wrapper sect-product" data-views="{'!HitsPage' | snippet : ['saveTv' => 'true']}">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>
        {include "file:sections/product/card.tpl"}
    </div>
    {include "file:sections/popular/sect-pop.tpl" title="Рекомендуем также"}
    {include "file:sections/recent.tpl"}
    {include "file:sections/advantages.tpl"}
{*    <div class="wrapper">*}
{*        <div class="content-block">*}
{*            {$_modx->resource.content}*}
{*        </div>*}
{*    </div>*}
    {include "file:sections/partners.tpl"}
    {include "file:sections/delivery.tpl"}
{/block}
