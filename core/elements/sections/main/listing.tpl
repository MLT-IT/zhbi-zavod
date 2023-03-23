<section class="wrapper sect-mainlist">
    <h2 class="title-2">{$title}</h2>
    <div class="sect-mainlist__content js-catalog" id="mse2_mfilter">
    {'!mFilter2' | snippet : [
        'element' => 'msProductsMy',
        'suggestionsMaxFilters' => 2000,
        'suggestionsMaxResults' => 100000,
        'filters' => $_modx->resource.listFilters ?: "",

        'tpls' => "@FILE sections/category/listing-products-item.tpl",
        'tplOuter' => '@FILE sections/main/listing-outer.tpl',
        'tplFilter.outer.default' => '@FILE sections/main/tpl.filter.outer.tpl',
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

        'parents' => $_modx->resource.itemsParents,

        'totalVar' => 'total'
    ]}
    </div>
</section>
