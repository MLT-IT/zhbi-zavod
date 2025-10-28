<div class="product-info__price{if $prodValues['outputOldPrice']?} active{/if}">
  <div class="product-info__price-tooltip-wrapper">
    <div class="tooltip">
      <p class="tooltip__header">Снижение цены!</p>
      <p class="tooltip__body">Мы регулярно снижаем цены на наши товары, чтобы покупка у нас была еще выгоднее!</p>
      <span class="tooltip__close"></span>
    </div>
  </div>
  <p class="product-info__price-value">
    <span class="js-product__price" data-default="{$prodValues['defaultPrice']}">{$prodValues['outputPrice']}</span> ₽
  </p>
  {if $prodValues['outputOldPrice']?}
    <div class="js-product__old-price">
      <span class="js-product__old-price-val" data-default="{$prodValues['defaultOldPrice']}">
          {$prodValues['outputOldPrice']}
      </span>
      ₽
    </div>

  {/if}
</div>