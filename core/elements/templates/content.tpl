{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    {if $_modx->context.key === 'gbi-zavod78' && $_modx->resource.alias === 'nasha-komanda'}
        <div class="section-margin">
            <div class="container">
                <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
            </div>
        </div>
        {include "file:sections/our-team/wrapper.tpl"}
        {include "file:sections/our-partners/wrapper.tpl"}
        {include "file:sections/company-profit/wrapper.tpl"}
    {else}
    <div class="section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
            <div class="page-content">
                {$_modx->resource.content}
            </div>
        </div>
    </div>
    {/if}

{/block}