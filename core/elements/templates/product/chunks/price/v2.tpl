<div class="product-page__inform-top-price">
  <span class="fs-24 fw-700">
    Цена:
  </span>

  <span class="fs-30 fw-700">
    {$_modx->resource['price']} ₽/{$_modx->resource['unit'][0]}
  </span>

  {if $_modx->resource['old_price']}
  <span class="old-price color-gray fw-700">
    {$_modx->resource['old_price']} ₽
  </span>
  {/if}
</div>