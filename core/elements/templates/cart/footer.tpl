<div class="cart-page__footer">
  <div class="cart-page__footer-content">
    <div class="fw-700 fs-20 mb-16">Всего товаров на сумму:</div>
    <div class="fw-700 cart-page__footer-price">
      <span data-cart-total-summ>{$_modx->getPlaceholder('counters.cart-product-summ')}</span> ₽
    </div>
    {if $_modx->getPlaceholder('counters.cart-product-summ-old')}
      <div class="color-gray">
        <span data-cart-total-summ-old>{$_modx->getPlaceholder('counters.cart-product-summ-old')}</span> ₽
      </div>
    {/if}
    <div class="cart-page__footer-notion">Без учёта менеджерской скидки</div>
  </div>
  <div class="cart-page__footer-controls">
    <a class="btn btn-bordered" href="{$_modx->getPlaceholder('makeurls.catalog')}">вернуться в каталог</a>
    <button class="btn btn-primary fs-14" onclick="modals.events.open('modal-order')">Перейти к оформлению</button>
  </div>
</div>
