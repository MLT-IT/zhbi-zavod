{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {include "file:blocks/catalog-schema.tpl"}
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    <div class="wrapper">
        <h1 class="title-1 category-header asfs">
            {$_modx->resource.pagetitle}

            <span class="category-header__small-text">
                {'@FILE snippets/echoItemsOnSite.php' | snippet}
            </span>
        </h1>
    </div>

    {include "file:sections/main/assort.tpl" skipHeader=1}

    {include "file:sections/popular/sect-pop-main.tpl"}
    {set $resources = '!msProducts' | snippet : [
        'parents' => 0,
        'depth' => 1000,
        'limit' => 12,
        'sortby' => 'RAND()',
        'returnIds' => '1',
        'includeTVs' => 'isFractional',
        'context' => $_modx->resource.context_key
    ]}
    {include "file:sections/popular/sect-pop-main.tpl" title="Распродажа" resources=$resources jsClass="product-slider-3"}

    {include "file:sections/category/simple-listing.tpl"}
    {include "file:sections/districts-map.tpl"}
    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <article class="content-block">
                {$_modx->resource.content}
            </article>
        </div>
    {/if}
    {include "file:sections/faq.tpl"}
    {include "file:sections/payment.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/steps.tpl"}
    {include "file:sections/partners.tpl"}
{/block}
