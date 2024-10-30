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

  {if $_modx->resource.groupingTags}
    {set $tags = "@FILE snippets/groupingTags.php" | snippet : [
    'tplItem' => '@INLINE<li class="catalog-screen__tag">
                            <a href="{$uri}" class="catalog-screen__tag-link">
                              <div class="catalog-screen__tag-picture">
                                {if $image}
                                <img class="catalog-screen__tag-image" src="{$image}" />
                                {/if}
                              </div>
                              <div class="catalog-screen__tag-name">
                                {$name ?: $menutitle ?: $pagetitle}
                              </div>
                            </a>
                          </li>'
    'tplFirstItems' => '@INLINE <ul class="catalog-screen__items items-hidden">{$items}<li class="catalog-screen__tag_type_more" onclick="grouping_tags_outer.style.display=\'block\'; grouping_tags_first_outer.remove()" style="display: flex;align-items: center;"></li></ul>'
    'tplItems' => '@INLINE <h2 class="section__title">{$group_title}</h2>
                           <ul class="catalog-screen__items">
                             {$items}
                           </ul>'
    'tplOuter' => '@INLINE <div class="catalog-screen__products" id="grouping_tags_first_outer">{$output_first}</div> <div class="catalog-screen__products" id="grouping_tags_outer" style="display:none;">{$output}</div>'
    ]}
  {else}
    {set $tags = '@FILE snippets/getTags.php' | snippet :[
      'tpl' => '@FILE chunks/create-menu/tags-item.tpl',
      'tplWrapper' => '@INLINE
                      {if $output}
                      <div class="catalog-screen__products">
                          <ul class="catalog-screen__items">
                              {$output}
                              <li class="catalog-screen__tag catalog-screen__tag_type_more" data-tag-show-more-btn></li>
                          </ul>
                      </div>
                      {/if}',
      'idTagsBlock' => 'block-1',
      'onlyCustomTags' => true
    ]}
  {/if}

  <main class="layout__main">
    <section class="section {if $tags is not empty}section_view_top{else}section_view_shrink{/if}">
      {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
      <article class="catalog-screen">
        <div class="catalog-screen__container">
          <h1 class="catalog-screen__title section__title">{$_modx->resource.pagetitle ?: $_modx->resource.menutitle} {if $.get.page > 1}(Страница {$.get.page}){/if}</h1>

          {if $_modx->resource.content && $_modx->resource.context_key not in list ['tagnerud'] }
            <div class="catalog-screen__text">
              {$_modx->resource.content}
            </div>
          {/if}

          {$tags}
        </div>
      </article>
    </section>

    {set $params = [
      'element' => 'msProducts',

      'suggestions' => 0,

      'filters' => $_modx->resource.listFilters ?: "",
      'includeThumbs' => 'webp',
      'tpls' => "@FILE chunks/product/listing-products-item-catalog.tpl",
      'tplOuter' => '@FILE sections/listing.tpl',
      'ajaxMode' => 'button',
      'showEmptyFilters' => 0,
      'limit' => 42,

      'tplFilter.outer.default' => '@FILE chunks/listing/filter-checkbox.tpl',
      'tplFilter.row.default' => '@FILE chunks/listing/filter-checkbox-option.tpl',
      'tplFilter.outer.price' => '@FILE chunks/listing/filter-number.tpl',
      'tplFilter.row.price' => '@FILE chunks/listing/filter-number-inner.tpl',

      'aliases' => '@FILE snippets/getAliasesFromFilters.php' | snippet,
      'sort' => 'tv|priority1:asc,tv|HitsPage:asc',
      'includeTVs' => 'priority1,HitsPage,isFractional,productNotAvailable,freeShipping,stockNum',

      'values_delimeter' => '~',
      'context' => $_modx->resource.context_key,

      'optionFilters' => $_modx->getPlaceholder('mspcs.option'),
      'where' => $_modx->getPlaceholder('mspcs.where'),

      'setMeta' => 0,
      'totalVar' => 'total',

      'parents' => 'excludeIds' | snippet : [
          'isSeoPage' => $isSeoPage
      ],

      'context' => $_modx->resource.context_key,
      'suggestionsMaxFilters' => 0,
      'suggestionsMaxResults' => 0
    ]}

    {* >>> Листинг товаров *}
    {'!mFilter2' | snippet : $params}
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
    {if $_modx->resource.context_key == 'tagnerud'}
          {include "file:sections/tagnerud-info.tpl"}
    {/if}
    {include "file:sections/payment.tpl"}
    {include "file:sections/contacts.tpl" styleClass='section_view_bg'}
  </main>
{/block}
