{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {include "file:chunks/catalog-schema.tpl"}
{/block}

{block "page"}

  <main class="layout__main">
    <section class="section section_view_top">
      {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
      <article class="catalog-screen">
        <div class="catalog-screen__container">
          <h2 class="catalog-screen__title section__title">{$_modx->resource.pagetitle ?: $_modx->resource.menutitle}</h2>
          <div class="catalog-screen__text">
            {$_modx->resource.content}
          </div>

          {* --- Подкатегории --------------------- *}
          {set $categories = 'pdoResources' | snippet : [
            'parents' => $_modx->resource.id,
            'templates' => '5',
            'includeTVs' => 'mainImage',
            'tpl' => '@FILE chunks/header-menu/category-item.tpl',
            'outputSeparator' => '||',
            'context' => $_modx->resource.context_key,
            'sortby' => 'menuindex,id',
            'sortdir' => 'ASC',
            'depth' => 0,
            'limit' => 0,
          ] | split : '||'}
          {set $count = $categories | count}
          {set $maxIndex = $count > 5 ? 5 : $count}

          {if $count > 0}
            <div class="catalog-screen__products" data-dropdown="responsive" data-dropdown-title=".catalog-screen__item_more" data-dropdown-body=".catalog-screen__other" data-disable-close="">
              <ul class="catalog-screen__items">
                {foreach 0..($maxIndex-1) as $index}
                  {$categories[$index]}
                {/foreach}

                {if $count > 5}
                  <li class="catalog-screen__item catalog-screen__item_more"></li>
                {/if}
              </ul>
              {* Если подкатегорий > 5, то прячем оставшиеся под споилер *}
              {if $count > 5}
                <div class="catalog-screen__other">
                  <ul class="catalog-screen__items">
                    {foreach 5..$count as $index}
                        {$categories[$index]}
                    {/foreach}
                  </ul>
                </div>
              {/if}
            </div>
          {/if}
          {* --- / Подкатегории --------------------- *}

        </div>
      </article>
    </section>


    {* --- Листинг товаров --------------------- *}
    {'!mFilter2' | snippet : [
      'element' => 'msProductsMy',
      'suggestionsMaxFilters' => 2000,
      'suggestionsMaxResults' => 100000,
      'filters' => $_modx->resource.listFilters ?: "",

      'tpls' => "@FILE chunks/product/listing-products-item-catalog.tpl",
      'tplOuter' => '@FILE sections/listing.tpl',
      'tplFilter.outer.default' => '@FILE chunks/filter.tpl',
      'ajaxMode' => 'button',
      'showEmptyFilters' => 1,
      'limit' => 42,

      'tplFilter.row.default' => '@FILE chunks/mainListFilter.tpl',

      'aliases' => 'ms|price==price',
      'sort' => 'tv|priority1:asc,tv|HitsPage:asc',
      'includeTVs' => 'priority1,HitsPage,isFractional,productNotAvailable,freeShipping',

      'values_delimeter' => '~',
      'context' => $_modx->resource.context_key,

      'optionFilters' => $_modx->getPlaceholder('mspcs.option'),
      'where' => $_modx->getPlaceholder('mspcs.where'),

      'setMeta' => 0,
      'totalVar' => 'total',

      'context' => $_modx->resource.context_key
    ]}
    {* --- / Листинг товаров --------------------- *}


    {include "file:sections/gazobeton-info.tpl"}
    {include "file:sections/delivery.tpl" styleClass='section_view_bg'}
    {include "file:sections/payment.tpl"}
    {include "file:sections/contacts.tpl" styleClass='section_view_bg'}
  </main>
{/block}
