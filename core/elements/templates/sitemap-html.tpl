{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
            <div class="sitemap-html">
                {'pdoMenu' | snippet : [
                    'parents' => 0
                    'where' => '{"class_key:!=" : "msProduct"}'
                ]}
            </div>
        </div>
    </div>

{/block}