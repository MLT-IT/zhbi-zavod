{* Данный код нужен, т.к. при подгрузке товаров через AJAX (mFilter2) плейсхолдер checkItems будет пустым, он ведь устанавливается при загрузке страницы *}
{if $_modx->getPlaceholder('checkItems') is null}
    {'!checkItems' | snippet}
{/if}

{* Устанавливаем переменные для чанка *}
{set $src = $_pls}
{insert "file:blocks/set-values-for-prod.tpl"}

<div class="product-card product-card_catalog">
  <div class="product-card__picture">
    <a href="{$uri}">
      <img src="/assets/images/loader.svg" class="product-card__image lazy" data-src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="{$pagetitle}">
    </a>
    <div class="product-card__actions">
      <button class="product-action product-action_favorite"></button>
      <button class="product-action product-action_compare"></button>
    </div>
  </div>
  <div class="product-card__body">
    <a href="{$uri}" class="product-card__title">{$menutitle}</a>
    <div class="product-card__price">
      <p class="product-card__price-value">{$outputPrice} ₽</p><span class="product-card__price-notion">Стоимость за 1 м3</span>
    </div>
    <ul class="product-card__stats">
        {include "file:blocks/listing-product-chars.tpl"}
    </ul>
    <div class="product-card__bottom">
      <button class="product-card__add btn btn_style_shadow"><span class="product-card__add-text">в корзину</span></button>
      <div class="product-card__counter counter">
        <button class="counter__btn counter__btn_minus"></button>
        <input class="counter__input" type="number" placeholder="0" min="0">
        <button class="counter__btn counter__btn_plus"></button>
      </div>
    </div>
  </div>
</div>
