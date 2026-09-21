{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="contacts-page section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
        </div>

        {include "file:sections/address-map/wrapper.tpl" open_tabs=true title_tab_2="Офис продаж"}
        {if $_modx->context.key !== 'gbi-zavod78'}
        {include "file:sections/calculator-banner/wrapper.tpl"}
        {/if}
        {include "file:sections/production-form/wrapper.tpl"}
        {if $_modx->context.key !== 'gbi-zavod78'}
        {include "file:sections/product-advantages/wrapper.tpl"}
        {/if}
    </div>
{/block}