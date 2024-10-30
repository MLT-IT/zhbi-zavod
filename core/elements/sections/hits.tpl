{$params = [
  'parents' => 0,
  'depth' => 50,
  'limit' => 42,
  'sortby' => '{"priority1":"ASC", "HitsPage":"ASC"}',
  'where' => '{"priority1:IS NOT": null, "HitsPage:IS NOT": null}',
  'includeTVs' => 'isFractional,productNotAvailable,freeShipping,priority1,HitsPage',
  'context' => $_modx->resource.context_key,
  'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
  'includeThumbs' => 'webp',
]}

{if $_modx->context.key == 'web'}
  {set $params['resources'] = "93802, 93798, 99279, 101807, 94745, 94732, 94758, 94754, 93669, 93670, 93674, 93676, 93677, 93678, 93680, 93679"}
{/if}

{set $hits = '!msProducts' | snippet : $params}
{if $hits?}
  {set $hitsTitle = 'Хит продаж'}
  {if $_modx->resource.context_key == 'tagnerud'}
    {set $hitsTitle = 'Популярные товары'}
  {/if}
  {include "file:sections/related-products.tpl" title=$hitsTitle output=$hits}
{/if}
