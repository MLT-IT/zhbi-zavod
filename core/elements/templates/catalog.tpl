{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {include "file:chunks/catalog-schema.tpl"}
{/block}

{block "page"}

  {if $_modx->getPlaceholder('mspcs.option') ? || $_modx->getPlaceholder('mspcs.where') ?}
      {set $isSeoPage = 1}
  {else}
      {set $isSeoPage = 0}
  {/if}

  {set $params = [
    'parents' => $_modx->resource.id,
    'templates' => '5',
    'includeTVs' => 'mainImage',
    'tpl' => '@FILE chunks/create-menu/category-item.tpl',
    'context' => $_modx->resource.context_key,
    'sortby' => 'menuindex,id',
    'sortdir' => 'ASC',
    'depth' => 0,
    'limit' => 0,
  ]}

  {if $_modx->resource.id == 4}
      {set $resources = '93190,93191,93189,93185,93188,93192,93187,93186'}
      {set $params['resources'] = $resources}
      {set $params['sortby'] = 'FIELD(modResource.id, ' ~ $resources ~ ')'}
  {/if}

  {set $tags = 'pdoResources' | snippet : $params}

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

          {if $tags is not empty}
            <div class="catalog-screen__products">
              <ul class="catalog-screen__items">
                {$tags}
                <li class="catalog-screen__item catalog-screen__item_type_more"></li>
              </ul>
            </div>
          {/if}

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
        'isSeoPage' => $isSeoPage,
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
