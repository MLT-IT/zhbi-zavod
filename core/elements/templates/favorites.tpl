{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>

    {set $resources = '!isFavorite' | snippet | replace: "-" : ","}
        <div class="wrapper sect-inner">
            <h1 class="title-1 asfs">{$_modx->resource.pagetitle}</h1>
            {if $resources != ''}
                <section class="listing">
                    <div class="wrapper">
                        <div class="listing__content" id="mse2_mfilter">
                        {'!msProducts' | snippet : [
                            'tpls' => "@FILE sections/category/listing-products-item.tpl",
                            'tplOuter' => '@FILE sections/category/listing-outer.tpl',
                            'ajaxMode' => 'button',
                            'limit' => 42,
                            'context' => $_modx->resource.context_key,
                            'sortby' => 'menuindex',
                            'sortdir' => 'ASC',
                            'includeTVs' => 'priority1,HitsPage',
                            'parents' => 0,
                            'depth' => 0,
                            'resources' => $resources
                        ]}
                        </div>
                    </div>
                </section>
            {/if}
        </div>

{/block}
