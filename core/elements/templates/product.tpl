{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}

    {if $_modx->resource.template in list [17, 20]}
        {set $cardClass = 'product-card_type_relinking'}
    {elseif $_modx->resource.template == 21}
        {set $cardClass = 'product-card_type_relinking-btns'}
    {else}
        {set $cardClass = 'product-card_type_usual'}
    {/if}

    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl" class='breadcrumbs_page-product'}
    </div>
    <div class="wrapper product-card {$cardClass}{if $_modx->resource.old_price} product-card_with-discount{/if}" data-views="{'!HitsPage' | snippet : ['saveTv' => 'true']}" itemscope itemtype="http://schema.org/Product">
        <h1 class="title-1 product-card__title-1" itemprop="name">{$_modx->resource.pagetitle}</h1>
        {include "file:sections/product/card.tpl"}
    </div>

    {* В MODX проблематично получить товары с незаполненными опциями. Поэтому проверяем, заполнена ли опция *}
    {if $_modx->resource.item_thickness is empty}
        {$resources = ''}
    {else}
        {set $resources = '!msProducts' | snippet : [
            'parents' => 0,
            'depth' => 50,
            'limit' => 42,
            'returnIds' => 1,
            'innerJoin' => '{"Options":{"class":"msProductOption"}}',
            'where' => '{"Options.key":"item_thickness", "Options.value:=":"'~$_modx->resource['item_thickness'].0~'", "context_key:=": "'~$_modx->resource.context_key~'"}',
            'resources' => '-' ~ $_modx->resource.id
        ]}
    {/if}

    {include "file:sections/districts-map.tpl"}
    {include "file:sections/popular/sect-pop.tpl" title="Рекомендуем также" resources=$resources}
    {include "file:sections/recent.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/payment.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/steps.tpl"}
    {include "file:sections/partners.tpl"}
{/block}
