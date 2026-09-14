    {set $params = [
      'element' => 'msProducts',

      'suggestions' => 0,

      'filters' => $_modx->resource.listFilters ?: "",
      'includeThumbs' => 'webp',
      'tpls' => "@FILE chunks/product/listing-products-item-catalog.tpl",
      'tplOuter' => '@FILE sections/listing/wrapper.tpl',
      'ajaxMode' => 'button',
      'showEmptyFilters' => 0,
      'limit' => 42,

      'tplFilter.outer.default' => '@FILE chunks/listing/filter-checkbox.tpl',
      'tplFilter.row.default' => '@FILE chunks/listing/filter-checkbox-option.tpl',
      'tplFilter.outer.price' => '@FILE chunks/listing/filter-number.tpl',
      'tplFilter.row.price' => '@FILE chunks/listing/filter-number-inner.tpl',

      'aliases' => '@FILE snippets/getAliasesFromFilters.php' | snippet,
      'sort' => 'tv|priority1:asc,tv|HitsPage:asc',
      'includeTVs' => 'priority1,HitsPage,isFractional,productNotAvailable,freeShipping,stockNum,iconProduct',

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
