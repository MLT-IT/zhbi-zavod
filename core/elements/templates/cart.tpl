{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper sect-cart">
        {'!msCart' | snippet : ['tpl' => '@FILE: sections/sect-cart.tpl']}
{*        {'!msOrder' | snippet : ['tpl' => '@FILE: chunks/msOrder.tpl']}*}
{*        {'!msGetOrder' | snippet : ['tpl' => '@FILE: chunks/msGetOrder.tpl']}*}

    </div>
    {include "file:sections/delivery.tpl" classToWrapper=' is-wide' classToMap=' map_sect-cart'}
{/block}
