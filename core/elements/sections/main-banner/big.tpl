<div class="main-banner__big">
  <div class="main-banner__big-title fs-36 fw-700">
    Закажите {$_modx->getPlaceholder('images.materials')[0]} сейчас и получите
    <span class="color-red">скидку 20%</span> на доставку манипулятором
  </div>
  <div class="main-banner__big-text">Акция до конца месяца</div>

  <picture class="main-banner__big-image">
    <source
      srcset="/assets/template/images/sections/main-banner/{$_modx->context.key}/big-mobile.jpg"
      media="(max-width: 480px)"
    />
    <img src="/assets/template/images/sections/main-banner/{$_modx->context.key}/big-desktop.jpg" />
  </picture>

  <button class="btn btn-beauty" onclick="modals.events.open('modal-callback')">
    Заказать со скидкой
  </button>
</div>
