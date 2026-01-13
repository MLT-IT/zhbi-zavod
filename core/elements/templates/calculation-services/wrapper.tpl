{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}
    
    <div class="certificates-page section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>

            <ul class="sect-calc-list">
                {$_modx->runSnippet('pdoResources', [
                    'tpl'=>'@FILE templates/calculation-services/item.tpl',
                    'tplWrapper'=>'@INLINE {$output}',
                    'limit'=>'0',
                    'includeTVs'=>'main_image',
                    'tvPrefix' => ''
                ])}
            </ul>
        </div>
    </div>
    
    <div class="section-margin">
        {include "file:sections/products-used/wrapper.tpl"}
    </div>
    <div class="section-margin">
        {include "file:sections/company-profit/wrapper.tpl"}
    </div>
{/block}