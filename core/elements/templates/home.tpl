{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    
    {if $_modx->context.key === 'web'}
      {include "file:sections/main-banner-slider/wrapper.tpl" path="/assets/template/json/main-banner-slider/"~$_modx->context.key~".json"}
    {else}
      {include "file:sections/main-banner/wrapper.tpl"}
    {/if}

    {include "file:sections/advantages/horizontal/wrapper.tpl"}
    {include "file:modules/slider-categories/wrapper.tpl"}
    
    <div class="section-padding bg-light-gray-2">
      <div class="container">
        <h2 class="section-title">Акции и скидки</h2>
        {include "file:sections/promotions/wrapper.tpl"}
      </div>
    </div>
    
    {include "file:sections/bestseller/wrapper.tpl"}
    {include "file:sections/delivery-material/wrapper.tpl"}
    {if $_modx->context.key !== 'gbi-zavod78'}
    {include "file:sections/toggle-content/wrapper.tpl"}
    {/if}
    {include "file:sections/faqs/wrapper.tpl"}
    {include "file:sections/address-map/wrapper.tpl"}
{/block}