{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
            <div class="page-content">
                {$_modx->resource.content}
            </div>
        </div>
    </div>

    {include "file:sections/delivery-material/wrapper.tpl"}
    {include "file:sections/faqs/wrapper.tpl"}
    {include "file:sections/payments/wrapper.tpl"}
    {include "file:sections/address-map/wrapper.tpl" bg=true}
{/block}