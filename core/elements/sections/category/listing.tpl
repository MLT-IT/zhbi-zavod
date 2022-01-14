<section class="listing">
    <div class="wrapper">
        {*        <h1 class="title-1">Продажа газобетонных блоков H+H в самом лучшем городе СПБ</h1>*}

        <div class="listing__content" id="mse2_mfilter">
            {'!msPCS' | snippet}

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
            'limit' => 42,

            'tplFilter.row.price' => '@FILE chunks/filterNumberInner.tpl',
            'tplFilter.outer.price' => '@FILE chunks/filterNumber.tpl',
            'tplFilter.row.price2' => '@FILE chunks/filterNumberInner.tpl',
            'tplFilter.outer.price2' => '@FILE chunks/filterNumber.tpl',
            'tplFilter.row.default' => '@FILE chunks/filterCheckbox.tpl',

            'aliases' => 'ms|price==price,msoption|price2==price2',
            'sort' => 'tv|priority1:asc,tv|HitsPage:asc',
            'includeTVs' => 'priority1,HitsPage',

            'values_delimeter' => '~',
            'context' => $_modx->resource.context_key,

            'optionFilters' => $_modx->getPlaceholder('mspcs.option'),
            'where' => $_modx->getPlaceholder('mspcs.where'),
            ]}

            {set $value = $_modx->getPlaceholder('mspcs.option')}
            {if $value ?}
                {set $id = '@FILE snippets/getIdByAlias.php' | snippet : ['alias' => 'catalog']}

                {if $_modx->resource.template == 4}
                    {set $params['parents'] = $id ~ ',-9125,-10594,-10998'}
                {else}
                    {set $params['parents'] = $id}
                {/if}
            {else}
                {if $_modx->resource.template == 4}
                    {set $params['parents'] = '-9125,-10594,-10998'}
                {/if}
            {/if}

            {'!mFilter2' | snippet : $params}
        </div>
    </div>
</section>
