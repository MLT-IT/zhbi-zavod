{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}

  <main class="layout__main">
    {include "file:blocks/breadcrumbs.tpl"}

      <article class="best-products section favorites">
        <div class="best-products__container">
          <h2 class="section__title margin-bottom-md">{$_modx->resource.pagetitle}</h2>
            {set $resources = $_modx->getPlaceholder('checkItems')['fav'] | join : ','}
            {if $resources != ''}
              <div class="best-products__products">
                {'!msProductsMy' | snippet : [
                  'tpl' => '@FILE sections/category/listing-products-item-default.tpl',
                  'ajaxMode' => 'button',
                  'limit' => 0,
                  'context' => $_modx->resource.context_key,
                  'sortby' => 'menuindex',
                  'sortdir' => 'ASC',
                  'includeTVs' => 'priority1,HitsPage,isFractional,productNotAvailable,freeShipping',
                  'parents' => 0,
                  'depth' => 0,
                  'resources' => $resources
                ]}
              </div>
            {/if}
        </div>
      </article>

  </main>

{/block}
