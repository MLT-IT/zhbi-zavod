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
        <div class="cart__item cart-item" id="{$product.key}">
          <div class="cart-item__picture">
            <img class="cart-item__image" src="assets/template/pictures/products/product-1.png" alt="product">

            {var $image}
                {if $product.thumb?}
                    <img class="cart-item__image" src="{$product.thumb}" alt="{$product.pagetitle}"  title="{$product.pagetitle}"/>
                {else}
                    <img class="cart-item__image" src="{'assets_url' | option}components/minishop2/img/web/ms2_small.png" srcset="{'assets_url' | option}components/minishop2/img/web/ms2_small@2x.png 2x" alt="{$product.pagetitle}" title="{$product.pagetitle}"/>
                {/if}
            {/var}

            <div class="cart-item__actions">
              <button class="product-action product-action_favorite"></button>
              <button class="product-action product-action_compare"></button>
            </div>

            <form method="post" class="ms2_form">
              <input type="hidden" name="key" value="{$product.key}">
              <button title="Удалить из корзины" class="cart-item__remove" type="submit" name="ms2_action" value="cart/remove"></button>
            </form>
          </div>
          <div class="cart-item__body">
            <p class="cart-item__title">
                {$product.pagetitle}
            </p>
            <div class="cart-item__bottom">
              <div class="cart-item__price">
                <p class="cart-item__price-value">{$product.price} ₽</p>
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

              <form method="post" class="ms2_form cart-item__counter-form" role="form">
                <input type="hidden" name="key" value="{$product.key}"/>
                <div class="custom-counter cart-item__counter counter">
                  <span class="custom-counter__btn custom-counter__btn_dir_less counter__btn counter__btn_minus"></span>
                  <input name="count" class="counter__input custom-counter__amount{if $product.isFractional} custom-counter_type_fractional{/if}"
                         value="{$product.count}">
                  <span class="custom-counter__btn custom-counter__btn_dir_more counter__btn counter__btn_plus"></span>
                </div>
                <button class="btn btn-sm" type="submit" name="ms2_action" value="cart/change"></button>
              </form>

            </div>
          </div>
        </div>
      {/foreach}
  </div>
  <div class="cart__total cart-total"><span class="cart-total__title">Всего товаров на сумму:</span>
    <p class="cart-total__price"><span class="ms2_total_cost">{$total.cost}</span> ₽</p><span class="cart-total__notion">Без учёта менеджерской скидки</span>
    <div class="cart-total__btns">
      <button class="btn btn_style_shadow" data-fancybox href="#order">Перейти к оформлению</button><a class="btn btn_style_trans" href="/catalog/">Вернутся в каталог</a>
    </div>
  </div>
</div>
</article>
<article class="contacts section">
<div class="contacts__container" data-tabs>
  <div class="contacts__top">
    <h2 class="contacts__title section__title">Адреса</h2>
    <div class="tabs">
      <ul class="tabs__list">
        <li class="tabs__item active" data-tab="склады">склады</li>
        <li class="tabs__item" data-tab="офис">офис</li>
      </ul>
    </div>
  </div>
  <div class="contacts__body">
    <div class="contacts__block active" data-tab-page="склады">
      <div class="contacts__info">
        <p class="contacts__text contacts__text_bold">Режим работы складов: 8:00 - 21:00</p>
        <address class="contacts__items">
          <div class="contact">
            <svg class="contact__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
            </svg>
            <div class="contact__content">
              <p class="contact__title">Телефон склада в Мурино:</p>
              <p class="contact__value">+7 (812) 220-17-90, доб 3</p>
            </div><a class="contact__link" href="tel:+78122201790"></a>
          </div>
          <div class="contact">
            <svg class="contact__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
            </svg>
            <div class="contact__content">
              <p class="contact__title">Телефон склада в Мурино:</p>
              <p class="contact__value">+7 (812) 220-17-90, доб 3</p>
            </div><a class="contact__link" href="tel:+78122201790"></a>
          </div>
          <div class="contact">
            <svg class="contact__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
            </svg>
            <div class="contact__content">
              <p class="contact__title">Телефон склада в Мурино:</p>
              <p class="contact__value">+7 (812) 220-17-90, доб 3</p>
            </div><a class="contact__link" href="tel:+78122201790"></a>
          </div>
        </address><a class="contacts__availability btn btn_style_base" data-fancybox href="#availability">Узнать наличие материала на ближайшем складе</a>
      </div>
      <div class="contacts__map"><script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3A9897d4d519ac0b96d53c1fe1657bd5a4f472e778fd55528a39aa276dbb7ce75e&amp;width=835&amp;height=450&amp;lang=ru_RU&amp;scroll=true"></script></div>
    </div>
    <div class="contacts__block" data-tab-page="офис">
      <div class="contacts__info">
        <p class="contacts__text contacts__text_bold">Режим работы складов: 8:00 - 21:00</p>
        <address class="contacts__items">
          <div class="contact">
            <svg class="contact__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-location"></use>
            </svg>
            <div class="contact__content">
              <p class="contact__title">Офис:</p>
              <p class="contact__value">Мурино, Кооперативная 20Б</p>
            </div>
          </div>
          <div class="contact">
            <svg class="contact__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-calendar"></use>
            </svg>
            <div class="contact__content">
              <p class="contact__title">График работы офиса:</p>
              <p class="contact__value">9:00 - 20:00</p>
            </div>
          </div>
          <div class="contact">
            <svg class="contact__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
            </svg>
            <div class="contact__content">
              <p class="contact__title">Номер телефона контактного центра:</p>
              <p class="contact__value">+7 (812) 220-17-90, доб 2</p>
            </div><a class="contact__link" href="tel:+78122201790"></a>
          </div>
          <div class="contact">
            <svg class="contact__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-email"></use>
            </svg>
            <div class="contact__content">
              <p class="contact__title">Почта для связи:</p>
              <p class="contact__value">zakaz@www-gazobeton.ru</p>
            </div><a class="contact__link" href="mailto::zakaz@www-gazobeton.ru"></a>
          </div>
        </address><a class="contacts__availability btn btn_style_base" data-fancybox href="#availability">Узнать наличие материала на ближайшем складе</a>
      </div>
      <div class="contacts__map"><script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3A9897d4d519ac0b96d53c1fe1657bd5a4f472e778fd55528a39aa276dbb7ce75e&amp;width=835&amp;height=450&amp;lang=ru_RU&amp;scroll=true"></script></div>
    </div>
  </div>
{/if}
  </div>
</article>
