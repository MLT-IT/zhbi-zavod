{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="contacts-page section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>

            {include "file:sections/address-map/wrapper.tpl" open_tabs=true}
        </div>
    </div>
{/block}