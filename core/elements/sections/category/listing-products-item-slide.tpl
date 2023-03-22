{* Устанавливаем переменные для чанка *}
{set $src = $_pls}
{insert "file:blocks/set-values-for-prod.tpl"}

<div class="swiper-slide product-card js-product not-init{if $itemInCart?} js-product-in-cart{/if}">
  {insert 'file:sections/category/listing-products-item-inner.tpl'}
</div>
