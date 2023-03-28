{* Данный код нужен, т.к. при подгрузке товаров через AJAX (mFilter2) плейсхолдер checkItems будет пустым, он ведь устанавливается при загрузке страницы *}
{if $_modx->getPlaceholder('checkItems') is null}
  {'!checkItems' | snippet}
{/if}
{set $checkItems = $_modx->getPlaceholder('checkItems')}

<div class="product-card__picture">
  <a href="{$uri}">
    <img src="/assets/images/loader.svg" class="product-card__image lazy" data-src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="{$pagetitle}">
  </a>
  <div class="product-card__actions">
    <button class="product-action product-action_favorite js-product__btn-fav{if $checkItems['fav'][$id]?} active{/if}"></button>
    {*
    <button class="product-action product-action_compare js-product__btn-compare{if $checkItems['comp'][$id]?} active{/if}"></button>
    *}
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
  <div class="listing__product-elems-wrap product-card__bottom">
      {include "file:chunks/productElems.tpl" prodId=$id}
  </div>
</div>
