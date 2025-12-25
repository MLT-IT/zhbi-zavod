{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="comparison-page section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>

            <div class="comparison-page__controls">
                <button class="btn btn-bordered" data-comparison-btn onclick="window.comparisonHideEqual(this)">Различающиеся</button>
                <button class="btn btn-bordered active" data-comparison-btn onclick="window.comparisonShowEqual(this)">Все</button>
            </div>

            <div class="comparison-page__row swiper" data-slider="default-product-slider">
                <div class="swiper-wrapper">
                    {set $product_ids = $_modx->getPlaceholder('comparison-products')}
                    {if $product_ids && $product_ids | count}
                        {'!msProducts' | snippet : [
                            'parents' => 0
                            'resources' => $product_ids | join : ','
                            'limit' => 0,
                            'includeThumbs' => 'webp'
                            'context' => $_modx->resource.context_key,
                            'tpl' => '@FILE modules/product-cards/chunks/v4/wrapper.tpl',
                        ]}
                    {else}
                        Пусто
                    {/if}
                </div>
            </div>
        </div>
    </div>
{/block}