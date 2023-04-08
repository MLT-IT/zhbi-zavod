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

    {set $parents = '@FILE snippets/getIdByAlias.php' | snippet : [
      'alias' => 'catalog'
    ]}
    {set $data = '@FILE snippets/fastSearch.php' | snippet}

    {'!pdoPage' | snippet : [
      'element' => 'msProductsMy',
      'resources' => $data['ids'],
      'tpl' => "@FILE sections/listing-products-item-default.tpl",

      'includeTVs' => 'priority1,HitsPage,isFractional,productNotAvailable,freeShipping',

      'pageVarKey' => 'page',
      'pageNavVar' => 'page.nav',

      'parents' => 0,
      'depth' => '10000',

      'tplPageWrapper' => '@INLINE {$first}{$prev}{$pages}{$next}{$last}',
      'tplPage' => '@INLINE <a href="{$href}" class="sect-search__pagination-item sect-search__pagination-item_type_num">{$pageNo}</a>',
      'tplPageActive' => '@INLINE <span class="active sect-search__pagination-item sect-search__pagination-item_type_num">{$pageNo}</span>',
      'tplPageFirst' => '@INLINE <a href="{$href}" class="sect-search__pagination-item sect-search__pagination-item_type_edge"><<</a>',
      'tplPageLast' => '@INLINE <a href="{$href}" class="sect-search__pagination-item sect-search__pagination-item_type_edge">>></a>',
      'tplPagePrev' => '@INLINE <a href="{$href}" class="sect-search__pagination-item sect-search__pagination-item_type_step"><</a>',
      'tplPageNext' => '@INLINE <a href="{$href}" class="sect-search__pagination-item sect-search__pagination-item_type_step">></a>',
      'tplPageFirstEmpty' => '@INLINE ',
      'tplPageLastEmpty' => '@INLINE ',
      'tplPagePrevEmpty' => '@INLINE ',
      'tplPageNextEmpty' => '@INLINE ',

      'toPlaceholder' => 'mSearchResults',
      'totalVar' => 'mSearchAmount',

      'ajaxElemLink' => '.sect-search__pagination-item',
      'ajaxElemPagination' => '.sect-search__pagination',
      'ajax' => '1',
      'ajaxMode' => 'default',

      'limit' => 2,
      'setMeta' => 0,

      'sortby' => 'ids'
    ]}

    <article class="best-products section search">
      <div class="best-products__container">
        <h1 class="section__title margin-bottom-md">{$_modx->resource.pagetitle}</h1>
          <p class="infoblocks__subtitle margin-bottom-md">
            {if $data['amount'] > 0}
              {set $amount = $_modx->getPlaceholder('mSearchAmount')}
              {set $text1 = '@FILE snippets/formOfWord.php' | snippet : [
                'n' => $data['amount'],
                'f1' => 'Найден',
                'f2' => 'Найдено',
                'f5' => 'Найдено'
              ]}
              {set $text2 = '@FILE snippets/formOfWord.php' | snippet : [
                'n' => $data['amount'],
                'f1' => 'результат',
                'f2' => 'результата',
                'f5' => 'результатов'
              ]}
              {$text1} {$amount} {$text2} по фразе "{$.get.query}".
            {else}
              Ничего не найдено.
            {/if}
          </p>

          {if $data['ids'] ?}
            <div id="pdopage" class="js-catalog js-catalog-top">
              <div class="best-products__products rows">
                {$_modx->getPlaceholder('mSearchResults')}
              </div>

              {if $_modx->getPlaceholder('page.nav') ?}
                <div class="sect-search__pagination">
                    {$_modx->getPlaceholder('page.nav')}
                </div>
              {/if}
            </div>
          {/if}
      </div>
    </article>
  </main>

{/block}
