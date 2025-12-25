{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="favorites-page section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>

            <div class="favorites-page__row">
                {set $product_ids = $_modx->getPlaceholder('favorite-products')} 

                {if $product_ids && $product_ids | count}
                    {'!msProducts' | snippet : [
                        'parents' => 0
                        'resources' => $product_ids | join : ','
                        'limit' => 0,
                        'includeThumbs' => 'webp'
                        'context' => $_modx->resource.context_key,
                        'tpl' => '@FILE modules/product-cards/chunks/v2/wrapper.tpl',
                    ]}
                {else}
                    Пусто
                {/if}
            </div>
        </div>
    </div>
{/block}