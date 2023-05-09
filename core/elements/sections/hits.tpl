{set $hits = '!msProductsMy' | snippet : [
  'parents' => 0,
  'depth' => 50,
  'limit' => 42,
  'sortby' => '{"priority1":"ASC", "HitsPage":"ASC"}',
  'where' => '{"priority1:IS NOT": null, "HitsPage:IS NOT": null}',
  'includeTVs' => 'isFractional,productNotAvailable,freeShipping,priority1,HitsPage',
  'context' => $_modx->resource.context_key,
  'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
]}
{if $hits?}
  {include "file:sections/related-products.tpl" title='Хит продаж' output=$hits}
{/if}
