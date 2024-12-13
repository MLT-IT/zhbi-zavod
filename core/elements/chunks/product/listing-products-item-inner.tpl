{* Данный код нужен, т.к. при подгрузке товаров через AJAX (mFilter2) плейсхолдер checkItems будет пустым, он ведь устанавливается при загрузке страницы *}
{if $_modx->getPlaceholder('checkItems') is null}
  {'!checkItems' | snippet}
{/if}

{if $_modx->resource.context_key == "suhiesmesi" && $iconProduct}
    <div class="product-card__icon" style="background-image: url({$iconProduct});" ></div>
{/if}
{if $_modx->resource.context_key != "suhiesmesi"}
    <div class="product-card__vendor-logo" data-val="{$proizvoditel[0]}"></div>
{/if}

<input type="hidden" name="id" value="{$id}">
<div class="product-card__picture">
  <a href="{$uri}" class="product-card__link">
    <img src="/assets/images/loader.svg" class="product-card__image lazy" data-src="{'site_url' | option}{$webp ?: '/assets/images/no_image.jpg'}" alt="{$pagetitle}">
  </a>
  <div class="product-card__actions{if $idx == 1 ?} active{/if}">
    <button class="product-action product-action_favorite js-product__btn-fav{if $prodValues['checkItems']['fav'][$id]?} active{/if}"></button>
    {if $_modx->context.key in list ['krovelnyjstroymarket']}
    <a href="/shourum/" rel="nofollow" class="product-action product-action_showroom"></a>
      {if $idx == 1}
      <div class="popup-mes">
          {* <p class="popup-mes__header">Снижение цены!</p> *}
          <p class="popup-mes__body">Товар можно посмотреть вживую в нашем шоу-руме!</p>
          <span class="popup-mes__close"></span>
      </div>
      {/if}
    {else}
      <button class="product-action product-action_compare js-product__btn-compare{if $checkItems['comp'][$id]?} active{/if}"></button>
    {/if}

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
    {if $_modx->resource.context_key == "suhiesmesi"}
        <div class="product-info__rating rating ">
            <ul class="rating__stars">
                <li class="rating__star active suhiesmesi"></li>
                <li class="rating__star active suhiesmesi"></li>
                <li class="rating__star active suhiesmesi"></li>
                <li class="rating__star active suhiesmesi"></li>
                <li class="rating__star active suhiesmesi"></li>
            </ul>
        </div>
    {/if}
  <a href="{$uri}" class="product-card__title">{$menutitle ?: $pagetitle}</a>

  {if $_modx->context.key in list ['web']}
    {set $data = "@FILE _modules/warehouses/snippets/remains.php" | snippet : ['id' => $id]}
    <div class="has-icon icon-checkmark product-card__body-remains">В наличии {$data['total_remains']} уп.</div>
  {/if}
  {if $_modx->context.key in list ['suhiesmesi']}
      <div class="has-icon icon-checkmark product-card__body-remains">В наличии {$_modx->runSnippet('@FILE snippets/random.php', ['id' => $id, 'begin' => 100, 'end'=> 2000])} уп.</div>
  {/if}


  {if $_modx->resource.context_key == 'kraska' && $src['vozmozhnost-kolerovki'][0] == 'да'}
    <div class="product-card__tinting">
        <div class="product-card__tinting-mes">
            <div class="product-card__tinting-mes-header">Возможна колеровка</div>
            <div class="product-card__tinting-mes-text">Данный материал можно заколеровать в выбранный вами цвет.</div>
        </div>
    </div>
  {/if}

  {if $renderChars ?}
    <span class="product-card__stats_trigger">
      <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
        <use xlink:href="/assets/template/img/svg-sprite.svg#icon-info"></use>
      </svg>
      Показать информацию
    </span>
    <ul class="product-card__stats">

        {if $_modx->resource.context_key in list ["krovelnyjstroymarket", "fibrofasad", "profnastil", "gibkaya-cherepiza", "metallocherepica", "falcevaya-krovlya", "bonolit", "plitnye","trotuarnaya-plitka","kirpich-m5"]}
            {$_modx->runSnippet("getCharacterCardProduct", [
                "product" => $id,
                "category" => $_modx->resource.id,
                "context" => $_modx->resource.context_key,
                "tpl" => "@FILE chunks/product/wizard-character-item.tpl"
            ])}
            {else}
            {include "file:chunks/product/listing-chars.tpl"}
        {/if}
    </ul>
  {/if}
    {* Если сравнение вывод всех характеристик *}
    {if $_modx->resource.template == 15}
        <div class="product-card__stats-wrap product-card__stats-wrap-source">
            {'msProductOptions' | snippet : [
            'tpl' => "@FILE chunks/product/listing-options-standate.tpl" ,
            'product' => $id
            ]}
        </div>
        <div class="product-card__stats-wrap-default"></div>
        <div class="product-card__stats-wrap-only-different"></div>
    {/if}

<div>

<div class="product-card__price-line">
  <div class="product-card__price">
    <p class="product-card__price-value"><span data-default="{$prodValues['defaultPrice']}" class="js-product__price">{$prodValues['outputPrice']}</span> ₽ {if $_modx->resource.context_key in list ["suhiesmesi"]} <span style="font-size: 14px">/ упаковка</span>{/if}</p>
  </div>

  {if $prodValues['outputOldPrice']?}
    <div class="js-product__old-price">
      <span class="js-product__old-price-val" data-default="{$prodValues['defaultOldPrice']}">
          {$prodValues['outputOldPrice']}
      </span>&nbsp;₽
    </div>
  {/if}
</div>

  {if $prodValues['condition']}
    <div class="product-card__volume">
        <span class="product-card__volume-title">Цена за</span>
        <div class="product-info__volume-tabs">
            <span class="product-card__volume-tab js-product__volume-tab active" data-val="1">{$prodValues['pricePer']}</span>
            {foreach $prodValues['itemUnits'] as $val}
                {if $prodValues['pricePer'] != $val['title']}
                    <span class="product-card__volume-tab js-product__volume-tab" data-val="{$val['id']}">{$val['title']}</span>
                {/if}
            {/foreach}
        </div>
    </div>
  {/if}
    <div class="listing__product-elems-wrap product-card__bottom">
        {include "file:chunks/product/product-elems.tpl" prodId=$id}
    </div>
</div>

  <input type="hidden" name="unit" value="1">



</div>
