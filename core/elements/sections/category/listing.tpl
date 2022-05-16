<section class="listing">
    <div class="wrapper">
        <div class="listing__content" id="mse2_mfilter">

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
                                'optionVal' => $_modx->getPlaceholder('mspcs.option'),
                                'whereVal' => $_modx->getPlaceholder('mspcs.where')
                              ]
            ]}

            <div class="hidden parents">
                {$params['parents']}
            </div>

            {'!mFilter2' | snippet : $params}
        </div>
    </div>
</section>
