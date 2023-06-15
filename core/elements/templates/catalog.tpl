{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {include "file:chunks/catalog-schema.tpl"}
{/block}

{block "page"}

  {if (($_modx->getPlaceholder('mspcs.option') is not empty) || ($_modx->getPlaceholder('mspcs.where') is not empty)) && ($_modx->resource.strictParent is empty)}
      {set $isSeoPage = 1}
  {else}
      {set $isSeoPage = 0}
  {/if}

  {set $tags = 'getTags' | snippet}

  <main class="layout__main">
    <section class="section {if $tags is not empty}section_view_top{else}section_view_shrink{/if}">
      {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
      <article class="catalog-screen">
        <div class="catalog-screen__container">
          <h1 class="catalog-screen__title section__title">{$_modx->resource.pagetitle ?: $_modx->resource.menutitle}</h1>

          {if $_modx->resource.content ?}
            <div class="catalog-screen__text">
              {$_modx->resource.content}
            </div>
          {/if}

          {$tags}
        </div>
      </article>
    </section>

    {* >>> Листинг товаров *}
    {'!mFilter2' | snippet : [
      'element' => 'msProducts',
      'suggestionsMaxFilters' => 2000,
      'suggestionsMaxResults' => 100000,
      'filters' => $_modx->resource.listFilters ?: "",
      'includeThumbs' => 'webp',
      'tpls' => "@FILE chunks/product/listing-products-item-catalog.tpl",
      'tplOuter' => '@FILE sections/listing.tpl',
      'ajaxMode' => 'button',
      'showEmptyFilters' => 1,
      'limit' => 42,

      'tplFilter.outer.default' => '@FILE chunks/listing/filter-checkbox.tpl',
      'tplFilter.row.default' => '@FILE chunks/listing/filter-checkbox-option.tpl',
      'tplFilter.outer.price' => '@FILE chunks/listing/filter-number.tpl',
      'tplFilter.row.price' => '@FILE chunks/listing/filter-number-inner.tpl',

      'aliases' => 'ms|price==price',
      'sort' => 'tv|priority1:asc,tv|HitsPage:asc',
      'includeTVs' => 'priority1,HitsPage,isFractional,productNotAvailable,freeShipping',

      'values_delimeter' => '~',
      'context' => $_modx->resource.context_key,

      'optionFilters' => $_modx->getPlaceholder('mspcs.option'),
      'where' => $_modx->getPlaceholder('mspcs.where'),

      'setMeta' => 0,
      'totalVar' => 'total',

      'parents' => 'excludeIds' | snippet : [
        'isSeoPage' => $isSeoPage
      ],

      'context' => $_modx->resource.context_key
    ]}
    {* <<< Листинг товаров *}

    {*
    {switch $_modx->resource.context_key}
      {case 'web'}
        {include "file:sections/uteplitel-info.tpl"}
      {case 'gazosilikatstroy'}
        {include "file:sections/gazobeton-info.tpl"}
    {/switch}
    *}

    {include "file:sections/delivery.tpl" styleClass='section_view_bg'}
    {include "file:sections/payment.tpl"}
    {include "file:sections/contacts.tpl" styleClass='section_view_bg'}
  </main>
{/block}
