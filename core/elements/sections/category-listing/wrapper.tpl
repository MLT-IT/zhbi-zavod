{set $depth = $_modx->resource.mfilter_depth ?: 3}
{set $filters = $_modx->resource.filters}

{set $params = [
    '-aliases' => '@FILE snippets/getAliasesFromFilters.php' | snippet
    'element' => 'msProducts'
    'depth' => $depth
    'limit' => 42
    '-filters' => 'ms|price:number,msoption|dlina-mm,msoption|obem-m3,msoption|shirina-mm,msoption|standart,msoption|vysota-mm'
    'filters' => $filters
    'tplOuter' => '@FILE sections/category-listing/tpl-outer.tpl'
    'tplFilter.outer.ms|price' => '@FILE sections/category-listing/filters/tpl-filter-slider.tpl'
    'tplFilter.row.ms|price' => '@FILE sections/category-listing/filters/tpl-filter-number.tpl'
    'tplFilter.outer.default' => '@FILE sections/category-listing/filters/tpl-filter-outer.tpl'
    'tplFilter.row.default' => '@FILE sections/category-listing/filters/tpl-filter-row.tpl'
    'includeTVs' => 'priority'
    'sort' => 'tv|priority:asc',
    'tpls' => '@FILE sections/category-listing/card-selection.tpl'
    '-tpls' => '@FILE modules/product-cards/chunks/v1/wrapper.tpl'
    'ajaxMode' => 'button'
    'suggestions' => 0
    'totalVar' => 'total'
    'showEmptyFilters' => 0
    'suggestionsMaxFilters' => 0
    'suggestionsMaxResults' => 0
    'suggestionsSliders' => false
    'includeThumbs' => 'webp'
    'filterOptions' => '{ 
        "more_tpl" : "<button class=\"category-listing__btn-more btn_more\" type=\"button\">Показать еще</button>"
    }'
    'setMeta' => 0
]}

{'!msPCS' | snippet}
{if $_modx->getPlaceholder('mspcs.option') || $_modx->getPlaceholder('mspcs.where')}
    {set $params['optionFilters'] = $_modx->getPlaceholder('mspcs.option')}
    {set $params['where'] = $_modx->getPlaceholder('mspcs.where')}
    {set $params['parents'] = 0}
{else}
    {set $params['parents'] = $_modx->resource.id}
{/if}

{'!mFilter2' | snippet : $params}