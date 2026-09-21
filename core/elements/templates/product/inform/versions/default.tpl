<div class="product-page__inform">
  <div class="product-page__inform-section">
    {if $_modx->context.key === 'gbi-zavod78'}
      {include "file:chunks/schema/ya-rating.tpl"}
      {include "file:templates/product/chunks/inform-list-gbi.tpl"}
    {else}
      {set $remains = '@FILE snippets/random.php' | snippet : [
        'id' => $_modx->resource.id,
        'begin' => 700
        'end'=> 1000
      ]}
      {set $items = [
        'На складе '~$remains~' '~$_modx->resource.unit[0],
      ]}
      {include "file:templates/product/chunks/rating-reviews.tpl"}
      {include "file:templates/product/chunks/inform-list.tpl" items=$items remains=$remains show_delivery=1}
    {/if}
  </div>

  <div class="product-page__inform-section">
    <div class="product-page__inform-price">
      {include "file:templates/product/chunks/price/v1.tpl"}
    </div>
  </div>

  {include "file:modules/cart/frontend/chunks/cart-controls-big.tpl"}
  {include "file:templates/product/chunks/one-click-buy.tpl"}
</div>
