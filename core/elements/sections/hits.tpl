<article class="best-products section">
  <div class="best-products__container">
    <h2 class="best-products__title section__title">Хит продаж</h2>
    <div class="best-products__products">
        {'!msProductsMy' | snippet : [
        'parents' => 0,
        'depth' => 50,
        'limit' => 42,
        'sortby' => '',
        'sortdir' => '',
        'tpl' => '@FILE chunks/product/listing-products-item-default.tpl',
        'where' => '{"context_key:=": "'~$_modx->resource.context_key~'"}',
        'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
        ]}
    </div>
  </div>
</article>
