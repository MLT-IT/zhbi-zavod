{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    {include 'file:modules/mltreviews/chunks/reviews-page.tpl'}

    <div class="section-margin">
        {include "file:sections/products-used/wrapper.tpl"}
    </div>
    <div class="section-margin">
        {include "file:sections/company-profit/wrapper.tpl"}
    </div>
{/block}