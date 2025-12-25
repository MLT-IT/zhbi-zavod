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

    <div class="section-margin">
        {include "file:sections/products-used/wrapper.tpl"}
    </div>
    <div class="section-margin">
        {include "file:sections/company-profit/wrapper.tpl"}
    </div>
{/block}