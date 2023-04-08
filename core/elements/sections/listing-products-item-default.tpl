{* Устанавливаем переменные для чанка *}
{set $src = $_pls}
{insert "file:chunks/set-values-for-prod.tpl"}

<div class="product-card js-product not-init{if $itemInCart?} js-product-in-cart{/if}">
  {insert 'file:sections/listing-products-item-inner.tpl'}
</div>
