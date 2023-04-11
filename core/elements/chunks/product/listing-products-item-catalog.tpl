{* Устанавливаем переменные для чанка *}
{set $src = $_pls}
{insert "file:chunks/product/set-values-for-prod-new.tpl"}

<div class="product-card product-card_catalog js-product not-init{if $itemInCart?} js-product-in-cart{/if}">
  {insert 'file:chunks/product/listing-products-item-inner.tpl'}
</div>
