{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl" bg=true}
    
    <div class="bg-light-gray-2">
        <div class="container">
            <h1 class="page-title mb-0">{$_modx->resource.pagetitle}</h1>
            {if $_modx->resource.content}
                <div class="listing-resource-content">    
                    <div class="page-content text-clamp-2 mb-16" data-opened-element="page-content">
                        {$_modx->resource.content}
                    </div>
                    <a data-opened-btn="page-content" data-active-text="Скрыть" class="link-dashed gray">Читать полностью</a>
                </div>
            {/if}
        </div>
    </div>
    
    {include "file:modules/tags-store/chunks/big-tags/wrapper.tpl"}
    {include "file:sections/category-listing/wrapper.tpl"}
    <div class="section-margin">
        {include "file:sections/delivery-material/wrapper.tpl" bg=true}
    </div>
    {include "file:sections/address-map/wrapper.tpl"}
{/block}