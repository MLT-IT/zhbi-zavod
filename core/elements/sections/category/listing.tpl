<section class="listing">
    <div class="wrapper">
        <div class="listing__content" id="mse2_mfilter">

            {if $_modx->getPlaceholder('mspcs.option') ? || $_modx->getPlaceholder('mspcs.where') ?}
                {set $isSeoPage = 1}
            {else}
                {set $isSeoPage = 0}
            {/if}

            {set $params = [
                'element' => 'msProducts',
                'suggestionsMaxFilters' => 2000,
                'suggestionsMaxResults' => 100000,
                'filters' => $_modx->resource.listFilters ?: "",
                'tpls' => "@FILE sections/category/listing-products-item.tpl",
                'tplOuter' => '@FILE sections/category/listing-outer.tpl',
                'tplFilter.outer.default' => '@FILE sections/category/filter/tpl.filter.outer.tpl',
                'ajaxMode' => 'button',
                'showEmptyFilters' => 1,
                'limit' => 44,

                'tplFilter.row.price' => '@FILE chunks/filterNumberInner.tpl',
                'tplFilter.outer.price' => '@FILE chunks/filterNumber.tpl',
                'tplFilter.row.default' => '@FILE chunks/filterCheckboxNew.tpl',

                'aliases' => 'ms|price==price',
                'sort' => 'tv|priority1:asc,tv|HitsPage:asc',
                'includeTVs' => 'priority1,HitsPage,isFractional',

                'values_delimeter' => '~',
                'context' => $_modx->resource.context_key,

                'optionFilters' => $_modx->getPlaceholder('mspcs.option'),
                'where' => $_modx->getPlaceholder('mspcs.where'),

                'setMeta' => 0,

                'parents' => 'excludeIds' | snippet : [
                                'isSeoPage' => $isSeoPage,
                              ],

                'totalVar' => 'total'
            ]}

            {*
            Это для отладки
            <div class="hidden parents">
                {$params['parents']}
            </div>
            *}

            {* На определенных контекстах сортировка по умолчанию должна быть другой *}
            {if $_modx->resource.context_key in list ['pro-fanera', 'kirpich-m', 'plitaosb', 'plity-mdvp']}
                {set $params['sort'] = 'ms|price:asc'}
            {/if}

            {* Страница "Продажа досок" на Пиломатериалах *}
            {if $_modx->resource.id == 80986}
                {if $params['parents'] ?}
                    {set $params['parents'] = $params['parents'] ~ ','}
                {else}
                    {set $params['parents'] = ''}
                {/if}
                {set $params['parents'] = $params['parents'] ~ '-48823,-56923,-48824,-80318'}
            {/if}

            {'!mFilter2' | snippet : $params}
        </div>
    </div>
</section>
