{* Данный код нужен, т.к. при подгрузке товаров через AJAX (mFilter2) плейсхолдер checkItems будет пустым, он ведь устанавливается при загрузке страницы *}
{if $_modx->getPlaceholder('checkItems') is null}
  {'!checkItems' | snippet}
{/if}

<div class="product-card__picture">
  <a href="{$uri}" class="product-card__link">
    <img src="/assets/images/loader.svg" class="product-card__image lazy" data-src="{'site_url' | option}{$webp ?: '/assets/images/no_image.jpg'}" alt="{$pagetitle}">
  </a>
  <div class="product-card__actions">
    <button class="product-action product-action_favorite js-product__btn-fav{if $prodValues['checkItems']['fav'][$id]?} active{/if}"></button>
    {*
    <button class="product-action product-action_compare js-product__btn-compare{if $checkItems['comp'][$id]?} active{/if}"></button>
    *}
  </div>
</div>

{if $_modx->resource.context_key == 'kraska'}
    <div class="product-card__middle">
        <div class="product-card__article">
            Арт. {$article} 
        </div>
        <div class="product-card__rating">
            <ul class="rating__stars">
              <li class="rating__star active"></li>
              <li class="rating__star active"></li>
              <li class="rating__star active"></li>
              <li class="rating__star active"></li>
              <li class="rating__star"></li>
            </ul>
        </div>
    </div>
{/if}

<div class="product-card__body">
  <a href="{$uri}" class="product-card__title">{$menutitle ?: $pagetitle}</a>

  {if $_modx->resource.context_key == 'kraska' && $src['vozmozhnost-kolerovki'][0] == 'да'}
    <div class="product-card__tinting">
        <div class="product-card__tinting-mes">
            <div class="product-card__tinting-mes-header">Возможна колеровка</div>
            <div class="product-card__tinting-mes-text">Данный материал можно заколеровать в выбранный вами цвет.</div>
        </div>
    </div>
  {/if}

  {if $renderChars ?}
    <ul class="product-card__stats">
        {include "file:chunks/product/listing-chars.tpl"}
    </ul>
  {/if}

  <div class="product-card__price">
    <p class="product-card__price-value"><span data-default="{$prodValues['defaultPrice']}" class="js-product__price">{$prodValues['outputPrice']}</span> ₽</p>
  </div>

  {if $prodValues['outputOldPrice']?}
    <div class="js-product__old-price">
      <span class="js-product__old-price-val" data-default="{$prodValues['defaultOldPrice']}">
          {$prodValues['outputOldPrice']}
      </span>
      ₽
    </div>
  {/if}

  <input type="hidden" name="unit" value="1">
  {if $prodValues['condition']}
    <div class="product-card__volume">
      <span class="product-card__volume-title">Цена за</span>
      <div class="product-info__volume-tabs">
        <span class="product-card__volume-tab js-product__volume-tab active" data-val="1">{$prodValues['pricePer']}</span>
          {foreach $prodValues['itemUnits'] as $val}
            <span class="product-card__volume-tab js-product__volume-tab" data-val="{$val['id']}">{$val['title']}</span>
          {/foreach}
      </div>
    </div>
  {/if}

  <div class="listing__product-elems-wrap product-card__bottom">
      {include "file:chunks/product/product-elems.tpl" prodId=$id}
  </div>
</div>
