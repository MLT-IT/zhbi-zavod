{set $title = "Посмотрите товары в нашем Шоу-руме онлайн"}
{set $button_text = "Отправить заявку"}
{set $image_desktop =
"/assets/template/images/sections/promo-banners/showroom/{$_modx->context.key}/big-desktop.jpg"}

<div class="showroom-banner">
  <div class="showroom-banner__big showroom-banner__banner">
    <div class="advertisement_note">Реклама</div>

    <div class="showroom-banner__content">
      <div class="showroom-banner__big-title showroom-banner__title fs-20 fw-700">{$title}</div>
      <div class="showroom-banner__content-text">Наши специалисты ознакомят Вас с нашим ассортиментом и проведут
        бесплатную консультацию.</div>

      <button class="btn btn-primary showroom-banner__button"
        onclick="modals.events.open('modal-callback')">{$button_text}</button>
    </div>

    <picture class="showroom-banner__big-image showroom-banner__image">
      <img src="{$image_desktop}" />
    </picture>
  </div>
</div>