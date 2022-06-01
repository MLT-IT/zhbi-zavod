{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper sect-cart">
        {include "file:blocks/topbar-search.tpl"}

        {'!msCartCustom' | snippet : [
            'tpl' => '@FILE: sections/sect-cart.tpl',
            'includeTVs' => 'isFractional'
        ]}
{*        {'!msOrder' | snippet : ['tpl' => '@FILE: chunks/msOrder.tpl']}*}
{*        {'!msGetOrder' | snippet : ['tpl' => '@FILE: chunks/msGetOrder.tpl']}*}

    </div>
    {include "file:sections/districts-map.tpl" classToWrapper='is-wide' classToMap='map_sect-cart'}
{/block}
