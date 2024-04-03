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
            <div class="comparison__toggle custom-toggle">
              <input class="custom-toggle__input" type="radio" id="all-toggler" name="compareType" value="all" checked>
              <label for="all-toggler" class="custom-toggle__label custom-toggle__label_all">
                  <span class="custom-toggle__text">Все</span>
              </label>
              <input class="custom-toggle__input" type="radio" id="different-toggler" name="compareType" value="different">
              <label for="different-toggler" class="custom-toggle__label custom-toggle__label_diff">
                  <span class="custom-toggle__text">Только отличающиеся</span>
              </label>
            </div>
            {* <div class="default-checkbox comparison__toggle">
              <input class="custom-toggler__input default-checkbox__input" type="checkbox" id="only-different-toggler">
              <label for="only-different-toggler" class="sect-comparison__custom-toggler custom-toggler  default-checkbox__label">
                  <span class="custom-toggler__text default-checkbox__label-text">Только отличающиеся</span>
              </label>
            </div> *}
          
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
