<section class="listing">
    <div class="wrapper">
{*        <h1 class="title-1">Продажа газобетонных блоков H+H в самом лучшем городе СПБ</h1>*}
        <div class="listing__content" id="mse2_mfilter">
            {'!mFilter2' | snippet : [
                'element' => 'msProducts',
                'filters' => $_modx->resource.listFilters ?: "",
                'tpls' => "@FILE sections/category/listing-products-item.tpl",
                'tplOuter' => '@FILE sections/category/listing-outer.tpl',
                'tplFilter.outer.default' => '@FILE sections/category/filter/tpl.filter.outer.tpl',
                'values_delimeter' => "|-|",
                'ajaxMode' => 'button',
                'showEmptyFilters' => 0,

                'tplFilter.row.price' => '@FILE chunks/filterNumberInner.tpl',
                'tplFilter.outer.price' => '@FILE chunks/filterNumber.tpl',
                'tplFilter.row.price2' => '@FILE chunks/filterNumberInner.tpl',
                'tplFilter.outer.price2' => '@FILE chunks/filterNumber.tpl',

                'aliases' => 'ms|price==price,msoption|price2==price2'
            ]}
        </div>
    </div>
</section>
