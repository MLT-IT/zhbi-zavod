{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:chunks/meta/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:chunks/meta/product/meta-description.tpl"}
{/block}

{block "page"}

  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

      <article class="best-products section comparison">
        <div class="best-products__container">
          <h2 class="section__title margin-bottom-md">{$_modx->resource.pagetitle}</h2>
            {set $resources = $_modx->getPlaceholder('checkItems')['comp'] | join : ','}
            {set $countResources = $_modx->getPlaceholder('checkItems')['comp'] | length}
            {if $resources != ''}
              <div class="best-products__products">
                {'!msProductsMy' | snippet : [
                  'tpl' => '@FILE chunks/product/listing-products-item-default.tpl',
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
