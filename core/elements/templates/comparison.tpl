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
            {set $countResources =  $_modx->getPlaceholder('checkItems')['comp'] | length}

            <label for="only-different-toggler" class="sect-comparison__custom-toggler custom-toggler">
                        <span class="custom-toggler__span">
                            <input class="custom-toggler__input" type="checkbox" id="only-different-toggler">
                            <span class="custom-toggler__checkmark"></span>
                        </span>
                <span class="custom-toggler__text">Только отличающиеся</span>
            </label>

            {if $resources != ''}
              <div class="best-products__products">
                {'!msProducts' | snippet : [
                  'tpl' => '@FILE chunks/product/listing-products-item-default.tpl',
                  'ajaxMode' => 'button',
                  'limit' => 0,
                  'context' => $_modx->resource.context_key,
                  'sortby' => 'menuindex',
                  'sortdir' => 'ASC',
                  'includeTVs' => 'priority1,HitsPage,isFractional,productNotAvailable,freeShipping',
                  'parents' => 0,
                  'depth' => 0,
                  'resources' => $resources,
                  'includeThumbs' => 'webp',
                ]}
              </div>
            {/if}
        </div>
      </article>

  </main>

{/block}
