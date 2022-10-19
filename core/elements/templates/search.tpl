{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper sect-search">
        {include "file:blocks/topbar-search.tpl"}

        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>

        {set $parents = '@FILE snippets/getIdByAlias.php' | snippet : [
            'alias' => 'catalog'
        ]}

        {set $mSearch2Ids = 'mSearch2' | snippet : ['returnIds' => 1]}

        {'!pdoPage' | snippet : [
            'element' => 'msProducts',
            'resources' => $mSearch2Ids,
            'tpl' => "@FILE sections/category/listing-products-item.tpl",

            'includeTVs' => 'priority1,HitsPage,isFractional',

            'pageVarKey' => 'page',
            'pageNavVar' => 'page.nav',

            'parents' => 0,
            'depth' => '10000',

            'tplPageWrapper' => '@INLINE {$first}{$prev}{$pages}{$next}{$last}',
            'tplPage' => '@INLINE <a href="{$href}" class="spag__item spag__item_type_num">{$pageNo}</a>',
            'tplPageActive' => '@INLINE <span class="active spag__item spag__item_type_num">{$pageNo}</span>',
            'tplPageFirst' => '@INLINE <a href="{$href}" class="spag__item spag__item_type_edge"><<</a>',
            'tplPageLast' => '@INLINE <a href="{$href}" class="spag__item spag__item_type_edge">>></a>',
            'tplPagePrev' => '@INLINE <a href="{$href}" class="spag__item spag__item_type_step"><</a>',
            'tplPageNext' => '@INLINE <a href="{$href}" class="spag__item spag__item_type_step">></a>',
            'tplPageFirstEmpty' => '@INLINE ',
            'tplPageLastEmpty' => '@INLINE ',
            'tplPagePrevEmpty' => '@INLINE ',
            'tplPageNextEmpty' => '@INLINE ',

            'toPlaceholder' => 'mSearchResults',
            'totalVar' => 'mSearchAmount',

            'ajaxElemLink' => '.spag__item',
            'ajaxElemPagination' => '.sect-search__pagination',
            'ajax' => '1',
            'ajaxMode' => 'default',

            'limit' => 40,
            'setMeta' => 0,

            'where' => '{"context_key:=": "'~$_modx->resource.context_key~'"}',
        ]}

        <div class="sect-search__content ajax-content">
            {if $_modx->getPlaceholder('mSearchAmount') > 0}
                <p class="sect-search__search-info">
                    {set $amount = $_modx->getPlaceholder('mSearchAmount')}

                    {'@FILE snippets/formOfWord.php' | snippet : [
                            'n' => $amount,
                            'f1' => 'Найден',
                            'f2' => 'Найдено',
                            'f5' => 'Найдено'
                        ]
                    }

                    {$amount}

                    {'@FILE snippets/formOfWord.php' | snippet : [
                            'n' => $amount,
                            'f1' => 'результат',
                            'f2' => 'результата',
                            'f5' => 'результатов'
                        ]
                    }

                    по фразе "{$.get.query}".
                </p>
            {/if}

            <div id="pdopage" class="sect-listing__content">
              <div class="listing__products-list rows grid js-catalog">
                  {$_modx->getPlaceholder('mSearchResults')}
              </div>
                {if $_modx->getPlaceholder('page.nav') ?}
                  <div class="sect-search__pagination spag">
                      {$_modx->getPlaceholder('page.nav')}
                  </div>
                {/if}
            </div>
        </div>

    </div>
{/block}
