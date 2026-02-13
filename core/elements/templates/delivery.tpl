{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    <div class="bg-light-gray-2">
        {include "file:sections/breadcrumbs/wrapper.tpl"}
        <div class="container">
            {include "file:sections/main-banner-slider/wrapper.tpl" path="/assets/template/json/delivery-banner-slider/"~$_modx->context.key~".json"}
        </div>
    </div>

    {insert "file:modules/deliveryCalculatorServiceAreas/sections/wrapper.tpl"}
    {include "file:sections/delivery-material/wrapper.tpl"}
    {include "file:sections/faqs/wrapper.tpl"}
    {include "file:sections/payments/wrapper.tpl"}
    {include "file:sections/address-map/wrapper.tpl" bg=true}
{/block}