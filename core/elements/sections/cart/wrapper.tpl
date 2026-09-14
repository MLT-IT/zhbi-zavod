{if count($products)}
    {set $hasProducts = 1}
{/if}

<article class="cart section" id="msCart">
  <div class="cart__container">
{if !$hasProducts}
  <div class="cart__top">
    <h1 class="cart__title section__title">{$_modx->resource.pagetitle}</h1>
  </div>
  <div class="cart__empty">
    <p class="cart__empty-text">
      Корзина пока пуста
    </p>
    <a class="cart__btn-back btn btn_style_base" href="/catalog/">Вернуться к покупкам</a>
  </div>
{else}
  <div class="cart__top">
    <h1 class="cart__title section__title">{$_modx->resource.pagetitle}</h1>
    <form method="post" type="submit" name="ms2_action" value="cart/clean">
      <input type="hidden" name="ctx" value="{$_modx->resource.context_key}">
      <button type="submit" name="ms2_action" value="cart/clean" class="btn cart__clear">
        Очистить корзину
      </button>
    </form>
  </div>
  <div class="cart__items">
      {foreach $products as $product}
        <div class="cart__item cart-item js-product" id="{$product.key}">
          <input name="id" value="{$product.id}" type="hidden">
          <div class="cart-item__picture">
            {var $image}
                {if $product.thumb?}
                    <img class="cart-item__image" src="{$product.thumb}" alt="{$product.pagetitle}"  title="{$product.pagetitle}"/>
                {else}
                    <img class="cart-item__image" src="{'assets_url' | option}components/minishop2/img/web/ms2_small.png" srcset="{'assets_url' | option}components/minishop2/img/web/ms2_small@2x.png 2x" alt="{$product.pagetitle}" title="{$product.pagetitle}"/>
                {/if}
            {/var}
            {$image}

            <div class="cart-item__actions">
              <button class="product-action product-action_favorite js-product__btn-fav"></button>
              {*
              <button class="product-action product-action_compare"></button>
              *}
            </div>

            <form method="post" class="ms2_form">
              <input type="hidden" name="key" value="{$product.key}">
              <button title="Удалить из корзины" class="cart-item__remove" type="submit" name="ms2_action" value="cart/remove"></button>
            </form>
          </div>
          <div class="cart-item__body">
            <a href="{$product.id | url}" class="cart-item__title">
              {$product.pagetitle}
            </a>
            {if $product.options['collerovka']}
              <div>Коллеровка: </div>
              <div class="select-colors">
                {foreach $product.options['collerovka'] as $color}
                  {set $colorData = '@FILE snippets/getCollerovkaJson.php' | snippet: [
                  'colorName' => $color
                  ]}
                  <div class="colors-item" style="{$colorData['background']}"><span>{$colorData['title']}</span></div>
                {/foreach}
              </div>
            {/if}

            <div class="cart-item__bottom">
              <div class="cart-item__price">
                <p class="cart-item__price-value">{$product.price} ₽</p>
                {if $product.old_price?}
                  <p class="cart-item__old-price-value">{$product.old_price} ₽</p>
                {/if}

                <span class="cart-item__price-notion">
                  {if ($product.unit[0] is empty) || ($product.unit[0] == 'упаковка')}
                      {set $priceUnit = 'упаковку'}
                  {elseif $product.unit[0] == 'тонна'}
                      {set $priceUnit = 'тонну'}
                  {else}
                      {set $priceUnit = $product.unit[0]}
                  {/if}
                  Стоимость за 1 {$priceUnit}
                </span>
              </div>

              <form method="post" class="ms2_form cart-item__counter-form" role="form" data-cart-product-price="{($product.price | replace : ' ' : '')}" data-cart-product-id="{$product.id}">
                <input type="hidden" name="key" value="{$product.key}"/>
                <div class="custom-counter cart-item__counter counter">
                  <span class="custom-counter__btn custom-counter__btn_dir_less counter__btn counter__btn_minus"></span>
                  <input name="count" class="counter__input custom-counter__amount{if $product.isFractional} custom-counter_type_fractional{/if}"
                         value="{$product.count}">
                  <span class="custom-counter__btn custom-counter__btn_dir_more counter__btn counter__btn_plus"></span>
                </div>
                <button class="btn btn-sm" type="submit" name="ms2_action" value="cart/change"></button>
              </form>

              <div class="cart-item__bottom-summ">
                Итого: <b><span data-cart-product-summ="{$product.id}">{($product.price | replace : ' ' : '') * $product.count}</span> ₽</b>
              </div>
            </div>
          </div>
        </div>
      {/foreach}
  </div>
  <div class="cart__total cart-total"><span class="cart-total__title">Всего товаров на сумму:</span>
    <p class="cart-total__price">
      <span class="ms2_total_cost">{$total.cost}</span> ₽
    </p>
    <p class="cart-total__old-price ms2_total_old_cost_block"{if $total.old_cost == $total.cost} style="display: none;"{/if}>
      <span class="ms2_total_old_cost">{$total.old_cost}</span> ₽
    </p>
    <span class="cart-total__notion">Без учёта менеджерской скидки</span>
    <div class="cart-total__btns">
      <button class="btn btn_style_shadow" data-fancybox href="#order">Перейти к оформлению</button><a class="btn btn_style_trans" onclick="history.back();" >Вернутся в каталог</a>
    </div>
  </div>
</div>
</article>
{insert "file:modules/contacts-block/wrapper.tpl"}
{/if}
  </div>
</article>
