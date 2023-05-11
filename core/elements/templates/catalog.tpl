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

  {set $categories = 'pdoResources' | snippet : [
    'parents' => $_modx->resource.id,
    'templates' => '5',
    'includeTVs' => 'mainImage',
    'tpl' => '@FILE chunks/create-menu/category-item.tpl',
    'outputSeparator' => '||',
    'context' => $_modx->resource.context_key,
    'sortby' => 'menuindex,id',
    'sortdir' => 'ASC',
    'depth' => 0,
    'limit' => 0,
  ]}
  {set $catsNotEmpty = $categories is not empty}
  {if $catsNotEmpty}
    {set $categories = $categories | split : '||'}
    {set $tagsCount = $categories | count}
    {set $maxIndex = $tagsCount > 9 ? 9 : $tagsCount}
  {/if}

  <main class="layout__main">
    <section class="section {if $catsNotEmpty}section_view_top{else}section_view_shrink{/if}">
      {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
      <article class="catalog-screen">
        <div class="catalog-screen__container">
          <h1 class="catalog-screen__title section__title">{$_modx->resource.pagetitle ?: $_modx->resource.menutitle}</h1>
          <div class="catalog-screen__text">
            {$_modx->resource.content}
          </div>

          {* Подкатегории (теги) --- *}
          {if $catsNotEmpty}
            <div class="catalog-screen__products" data-dropdown="responsive" data-dropdown-title=".catalog-screen__item_more" data-dropdown-body=".catalog-screen__other" data-disable-close="">
              <ul class="catalog-screen__items">
                {foreach 0..($maxIndex-1) as $index}
                  {$categories[$index]}
                {/foreach}

                {if $tagsCount > 9}
                  <li class="catalog-screen__item catalog-screen__item_more"></li>
                {/if}
              </ul>
              {* Если подкатегорий > 9, то прячем оставшиеся под споилер *}
              {if $tagsCount > 9}
                <div class="catalog-screen__other">
                  <ul class="catalog-screen__items">
                    {foreach 9..$tagsCount as $index}
                        {$categories[$index]}
                    {/foreach}
                  </ul>
                </div>
              {/if}
            </div>
          {/if}
          {* / Подкатегории (теги) --- *}

        </div>
      </article>
    </section>

    {* Листинг товаров --- *}
    {'!mFilter2' | snippet : [
      'element' => 'msProductsMy',
      'suggestionsMaxFilters' => 2000,
      'suggestionsMaxResults' => 100000,
      'filters' => $_modx->resource.listFilters ?: "",

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
    {* / Листинг товаров *}

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
