{* Устанавливаем переменные для чанка *}
{set $src = $_pls}
{insert "file:blocks/set-values-for-prod.tpl"}

<div class="swiper-slide preview-card">
  <div class="preview-card__picture">
    <img src="/assets/images/loader.svg" class="preview-card__image lazy" data-src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="{$pagetitle}">
  </div>
  <p class="preview-card__name">{$menutitle}</p>
  <p class="preview-card__price">{$outputPrice} ₽</p>
  <span class="preview-card__notion">Стоимость за 1 м3</span>
  <a class="preview-card__btn btn btn_style_shadow" href="{$uri}">перейти</a>
</div>
