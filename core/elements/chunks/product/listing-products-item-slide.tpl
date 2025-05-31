{* Устанавливаем переменные для чанка *}
{set $src = $_pls}
{insert "file:chunks/product/set-values-for-prod-new.tpl"}

<div data-product-card class="swiper-slide product-card product-card_catalog js-product not-init{if $prodValues['itemInCart']?} js-product-in-cart{/if}{if $prodValues['outputOldPrice']?} js-product_with-discount{/if}"
{* Выводим data-атрибуты *}
{insert "file:chunks/product/get-data-attrs.tpl"}
>
  {insert 'file:chunks/product/listing-products-item-inner.tpl'}
</div>
