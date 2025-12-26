{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    
    {if $_modx->context.key === 'web'}
      {include "file:sections/main-banner-slider/wrapper.tpl"}
    {else}
      {include "file:sections/main-banner/wrapper.tpl"}
    {/if}

    {include "file:sections/advantages/horizontal/wrapper.tpl"}
    {include "file:modules/slider-categories/wrapper.tpl"}
    {include "file:sections/bestseller/wrapper.tpl"}
    {include "file:sections/delivery-material/wrapper.tpl"}
    {include "file:sections/toggle-content/wrapper.tpl"}
    {include "file:sections/faqs/wrapper.tpl"}
    {include "file:sections/address-map/wrapper.tpl"}
{/block}