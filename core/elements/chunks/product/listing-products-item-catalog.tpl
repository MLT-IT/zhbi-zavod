{* Устанавливаем переменные для чанка *}
{set $src = $_pls}
{insert "file:chunks/product/set-values-for-prod-new.tpl"}

{set $renderChars = true}

<div class="product-card product-card_catalog js-product not-init{if $prodValues['itemInCart']?} js-product-in-cart{/if}{if $prodValues['outputOldPrice']?} js-product_with-discount{/if}"
{* Выводим data-атрибуты *}
{insert "file:chunks/product/get-data-attrs.tpl"}
>
{insert 'file:chunks/product/listing-products-item-inner.tpl'}
</div>

{if $_modx->resource.context_key in list ['krovelnyjstroymarket']}
  {set $total = $_modx->getPlaceholder('total')}
  {if ($_modx->resource.template in list [4, 5, 36]) && (($idx == 1 && $total == 1) || ($idx == 2 && $total >= 2))}
    <div class="product-card catalog-listing-banner block-bg">
    {insert "file:chunks/product/listing-banner-krovelnyjstroymarket.tpl"}
    </div>
  {/if}
{/if}

{if $_modx->resource.context_key in list ['plitnye']}
  {set $total = $_modx->getPlaceholder('total')}
  {if ($_modx->resource.template in list [4, 5, 36]) && (($idx == 1 && $total == 1) || ($idx == 1 && $total >= 2))}
    <div class="product-card catalog-listing-banner block-bg">
    {insert "file:chunks/product/listing-banner-krovelnyjstroymarket.tpl"}
    </div>
  {/if}
{/if}
