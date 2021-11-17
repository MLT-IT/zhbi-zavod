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
    <div class="wrapper product-card" data-views="{'!HitsPage' | snippet : ['saveTv' => 'true']}" itemscope itemtype="http://schema.org/Product">
        <h1 class="title-1" itemprop="name">{$_modx->resource.pagetitle}</h1>
        {include "file:sections/product/card.tpl"}
    </div>
    {include "file:sections/popular/sect-pop.tpl" title="Рекомендуем также"}
    {include "file:sections/recent.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/partners.tpl"}
    {include "file:sections/delivery.tpl"}
{/block}
