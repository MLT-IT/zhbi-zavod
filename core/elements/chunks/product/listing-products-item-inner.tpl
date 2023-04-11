{* Данный код нужен, т.к. при подгрузке товаров через AJAX (mFilter2) плейсхолдер checkItems будет пустым, он ведь устанавливается при загрузке страницы *}
{if $_modx->getPlaceholder('checkItems') is null}
  {'!checkItems' | snippet}
{/if}

<div class="product-card__picture">
  <a href="{$uri}">
    <img src="/assets/images/loader.svg" class="product-card__image lazy" data-src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="{$pagetitle}">
  </a>
  <div class="product-card__actions">
    <button class="product-action product-action_favorite js-product__btn-fav{if $prodValues['checkItems']['fav'][$id]?} active{/if}"></button>
    {*
    <button class="product-action product-action_compare js-product__btn-compare{if $checkItems['comp'][$id]?} active{/if}"></button>
    *}
  </div>
</div>
<div class="product-card__body">
  <a href="{$uri}" class="product-card__title">{$menutitle}</a>
  <div class="product-card__price">
    <p class="product-card__price-value"><span data-default="{$prodValues['defaultPrice']}" class="js-product__price">{$prodValues['outputPrice']}</span> ₽</p>
  </div>
  <ul class="product-card__stats">
      {include "file:chunks/listing-product-chars.tpl"}
  </ul>

  {include "file:chunks/product/products-item-units.tpl"}

  <div class="listing__product-elems-wrap product-card__bottom">
      {include "file:chunks/product/product-elems.tpl" prodId=$id}
  </div>
</div>
