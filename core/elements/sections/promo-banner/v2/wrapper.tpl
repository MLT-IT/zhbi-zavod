{set $title = "Скидка 15% на изготовление металлочерепицы Grand line в размер"}
{set $button_text = "Заказать со скидкой"}
{set $image_mobile = "/assets/template/images/sections/promo-banners/long/{$_modx->context.key}/v2/big-mobile.jpg"}
{set $image_desktop = "/assets/template/images/sections/promo-banners/long/{$_modx->context.key}/v2/big-desktop.jpg"}

<div class="promo-banner">
  <div class="promo-banner__big promo-banner__banner">
    <div class="advertisement_note">Реклама</div>

    <div class="promo-banner__content">
      <div class="promo-banner__big-title promo-banner__title fs-36 fw-700">{$title}</div>
      <div class="promo-banner__content-text">Акция до конца месяца</div>

      <button class="btn btn-beauty promo-banner__button"
        onclick="modals.events.open('modal-callback')">{$button_text}</button>
    </div>

    <picture class="promo-banner__big-image promo-banner__image">
      <source srcset="{$image_mobile}" media="(max-width: 480px)" />
      <img src="{$image_desktop}" />
    </picture>
  </div>
</div>