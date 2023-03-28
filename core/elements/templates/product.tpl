{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
{set $amountPhotos = $files | count}
{if $amountPhotos == 0}
  {set $files = [
    [
      'small' => '/assets/images/no_image.jpg'
    ]
  ]}
{/if}

{if $_modx->getPlaceholder('checkItems') is null}
    {'!checkItems' | snippet}
{/if}
{set $checkItems = $_modx->getPlaceholder('checkItems')}

{set $src = $_modx->resource}
{insert "file:blocks/set-values-for-prod.tpl"}

{* Галерея *}
{'!msGallery' | snippet : [
'tpl' => '@FILE chunks/gallery.tpl',
'product' => $id,
'toPlaceholder' => 'gallery'
]}
{set $gallery = $_modx->getPlaceholder('gallery')}

<main class="layout__main">
  <section class="section section_view_top">
    {include "file:blocks/breadcrumbs.tpl"}
    <article class="product section js-product not-init">
      <div class="product__container">
        <h2 class="product__title section__title">{$_modx->resource.pagetitle}</h2>
        <div class="product__body">
          <div class="product__pictures">
            <div class="swiper-container product__pictures-thumbs">
              <div class="swiper-wrapper">
                {foreach $files as $key => $file}
                  <div class="swiper-slide product__pictures-thumb">
                    <img class="product__pictures-image" src="{$file['small']}" alt="{$imgTitle} - фото {$key + 1}">
                  </div>
                {/foreach}
              </div>
            </div>

            <div class="product__picture">
              <div class="swiper-container product__pictures-slider">
                <div class="swiper-wrapper">
                  {foreach $files as $key => $file}
                    <div class="swiper-slide product__pictures-thumb">
                      <img class="product__pictures-image" src="{$file['small']}" alt="{$imgTitle} - фото {$key + 1}">
                    </div>
                  {/foreach}
                </div>
              </div>
              <div class="product__actions">
                <button class="product-action product-action_favorite js-product__btn-fav{if $checkItems['fav'][$_modx->resource['id']]?} active{/if}"></button>
                {*
                <button class="product-action product-action_compare js-product__btn-compare{if $checkItems['comp'][$_modx->resource['id']]?} active{/if}"></button>
                *}
              </div>
            </div>
          </div>
          <div class="product__info product-info">
            <div class="product-info__top">
              <div class="product-info__rating rating">
                <ul class="rating__stars">
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star"></li>
                  <li class="rating__star"></li>
                  <li class="rating__star"></li>
                </ul><span class="rating__reviews">12 отзывов</span>
              </div>


              <div class="product-info__availability">
                {*
                <div class="product-info__params">
                  <div class="product-info__param">
                    <div class="default-select">
                      <select class="default-select__select" data-id="ss-mgnilr5g" tabindex="-1" aria-hidden="true" style="display: none;">
                        <option data-placeholder="true">Плотность</option>
                        <option value="0">D100</option>
                        <option value="1">D200</option>
                        <option value="2">D300</option>
                      </select><div data-id="ss-mgnilr5g" id="ss-mgnilr5g" tabindex="0" class="ss-main default-select__select" role="combobox" aria-haspopup="listbox" aria-controls="ss-mgnilr5g" aria-expanded="false"><div class="ss-values"><div class="ss-placeholder">Плотность</div></div><div class="ss-deselect ss-hide"><svg viewBox="0 0 100 100"><path d="M10,10 L90,90 M10,90 L90,10"></path></svg></div><svg class="ss-arrow" viewBox="0 0 100 100"><path d="M10,30 L50,70 L90,30"></path></svg></div>
                      <div data-id="ss-mgnilr5g" id="ss-mgnilr5g" class="ss-content default-select__select" role="listbox"><div class="ss-search ss-hide"><input readonly="" type="search" placeholder="Поиск" tabindex="-1" aria-label="Поиск" autocapitalize="off" autocomplete="off" autocorrect="off"></div><div class="ss-list"><div class="ss-option ss-hide"></div><div data-id="tn10zfl7" id="tn10zfl7" class="ss-option" role="option" aria-selected="false">D100</div><div data-id="41cmfz9d" id="41cmfz9d" class="ss-option" role="option" aria-selected="false">D200</div><div data-id="ijgk3t6m" id="ijgk3t6m" class="ss-option" role="option" aria-selected="false">D300</div></div></div>
                    </div>
                  </div>
                  <div class="product-info__param">
                    <div class="default-select">
                      <select class="default-select__select" data-id="ss-g9de1fkx" tabindex="-1" aria-hidden="true" style="display: none;">
                        <option data-placeholder="true">размер</option>
                        <option value="0">1000</option>
                        <option value="1">2000</option>
                        <option value="2">3000</option>
                      </select><div data-id="ss-g9de1fkx" id="ss-g9de1fkx" tabindex="0" class="ss-main default-select__select" role="combobox" aria-haspopup="listbox" aria-controls="ss-g9de1fkx" aria-expanded="false"><div class="ss-values"><div class="ss-placeholder">размер</div></div><div class="ss-deselect ss-hide"><svg viewBox="0 0 100 100"><path d="M10,10 L90,90 M10,90 L90,10"></path></svg></div><svg class="ss-arrow" viewBox="0 0 100 100"><path d="M10,30 L50,70 L90,30"></path></svg></div>
                      <div data-id="ss-g9de1fkx" id="ss-g9de1fkx" class="ss-content default-select__select" role="listbox"><div class="ss-search ss-hide"><input readonly="" type="search" placeholder="Поиск" tabindex="-1" aria-label="Поиск" autocapitalize="off" autocomplete="off" autocorrect="off"></div><div class="ss-list"><div class="ss-option ss-hide"></div><div data-id="01v02jov" id="01v02jov" class="ss-option" role="option" aria-selected="false">1000</div><div data-id="utfl66ei" id="utfl66ei" class="ss-option" role="option" aria-selected="false">2000</div><div data-id="p5n7otak" id="p5n7otak" class="ss-option" role="option" aria-selected="false">3000</div></div></div></div>
                  </div>
                </div>
                *}
                <div class="product-info__availability-title product-info__availability-title_available">На складе 190 м3</div>
              </div>


            </div>
            <div class="product-info__bottom">
              {*
              <div class="product-info__volume"><span class="product-info__volume-title">Цена за:</span>
                <ul class="product-info__volume-tabs">
                  <li class="product-info__volume-tab active">м3</li>
                  <li class="product-info__volume-tab">шт</li>
                  <li class="product-info__volume-tab">поддон</li>
                </ul>
              </div>
              *}
              <div class="product-info__price"><span class="product-info__price-notion">Продаётся кубами</span>
                <p class="product-info__price-value">{$outputPrice} ₽</p>
              </div>

              <div class="product-info__actions">
                  {include "file:chunks/productElems.tpl" prodId=$_modx->resource.id}
              </div>
              <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Купить в 1 клик</button>
            </div>
          </div>
        </div>
      </div>
    </article>
  </section>

  <article class="infoblocks infoblocks_style_shadow section">
    <div class="infoblocks__container" data-tabs="">
      <div class="infoblocks__top">
        <div class="infoblocks__tabs"><a class="infoblocks__tab" href="javascript:;" data-tab="Описание">Описание</a><a class="infoblocks__tab active" href="javascript:;" data-tab="Характеристики">Характеристики</a><a class="infoblocks__tab" href="javascript:;" data-tab="Условия доставки товара">Условия доставки товара</a><a class="infoblocks__tab" href="javascript:;" data-tab="Отзывы">Отзывы</a><a class="infoblocks__tab" href="{$_modx->resource.id | url}#other-products">Сопутствующие товары</a>
        </div>
      </div>
      <div class="infoblocks__content">
        <div class="infoblocks__block" data-tab-page="Описание">
          <button class="infoblocks__block-title" data-tab="Описание">Описание</button>
          <div class="infoblocks__block-dropdown infoblocks__text">
            {$_modx->resource.content}
          </div>
        </div>

        <div class="infoblocks__block active" data-tab-page="Характеристики">
          <button class="infoblocks__block-title" data-tab="Характеристики">Характеристики</button>
          <div class="infoblocks__block-dropdown">
            <div class="table infoblocks__table">
              <table class="table__table">
                <tbody>
                  {'msProductOptions' | snippet : [
                    'tpl' => '@FILE blocks/item-characters.tpl',
                    'ignoreOptions' => 'edizm,edizm2'
                  ]}
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <div class="infoblocks__block" data-tab-page="Условия доставки товара">
          <button class="infoblocks__block-title" data-tab="Условия доставки товара"> Условия доставки товара</button>
          <div class="infoblocks__block-dropdown">
            <p class="infoblocks__text infoblocks__text_uppercase">Стоимость доставки</p>
            <div class="table infoblocks__table">
              {include 'file:sections/delivery-inner.tpl'}
            </div>
          </div>
        </div>
        <div class="infoblocks__block" data-tab-page="Отзывы">
          <button class="infoblocks__block-title" data-tab="Отзывы">Отзывы</button>
          <div class="infoblocks__block-dropdown">
            <div class="reviews">
              <div class="reviews__slider">
                <div class="swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
                  <div class="swiper-wrapper">
                    <div class="swiper-slide reviews__item swiper-slide-active" style="width: 802px; opacity: 1; transform: translate3d(0px, 0px, 0px);"><span class="reviews__name">Кирилл Жохов</span>
                      <p class="reviews__text">Хороший газобетон, прекрасно подходит под цвет моей кожи, легко наноситься и смывается. Доставка быстрая, менеджер добрый. Советую с апельсиновым вкусом.</p>
                    </div>
                    <div class="swiper-slide reviews__item swiper-slide-next" style="width: 802px; opacity: 0; transform: translate3d(-802px, 0px, 0px);"><span class="reviews__name">Олег</span>
                      <p class="reviews__text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magni molestiae necessitatibus nemo vitae voluptatem? Dignissimos illo, laudantium molestiae mollitia qui soluta sunt totam vero voluptatem voluptatum? Aliquam assumenda ipsa ullam.</p>
                    </div>
                    <div class="swiper-slide reviews__item" style="width: 802px; opacity: 0; transform: translate3d(-1604px, 0px, 0px);"><span class="reviews__name">Марат</span>
                      <p class="reviews__text">Хороший газобетон, прекрасно подходит под цвет моей кожи, легко наноситься и смывается. Доставка быстрая, менеджер добрый. Советую с апельсиновым вкусом.</p>
                    </div>
                  </div>
                </div>
                <div class="swiper-buttons">
                  <div class="swiper-button swiper-button-prev swiper-button-disabled"></div>
                  <div class="swiper-button swiper-button-next"></div>
                </div>
              </div><a class="btn btn_style_shadow reviews__btn" href="#">Оставить отзыв</a>
            </div>
          </div>
        </div>
      </div>
      <div class="infoblocks__advantages">
        <div class="infoblocks__advantage">
          <div class="advantage advantage">
            <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-5.png" alt="advantage"></div>
            <p class="advantage__title">Гарантия качества</p>
            <p class="advantage__text">Заменим дефектный материал или вернём деньги</p><a class="advantage__link link" href="#">Условия возврата</a>
          </div>
        </div>
        <div class="infoblocks__advantage">
          <div class="advantage">
            <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-6.png" alt="advantage"></div>
            <p class="advantage__title">Доставка и самовывоз</p>
            <p class="advantage__text">Вы можете заказать доставку по России (ПЭК, СДЭК, Энергия, Возовоз и Деловые линии) или оформить самовывоз с нашего склада в Санкт-Петербурге</p><a class="advantage__link link" href="#">Условия доставки и самовывоза</a>
          </div>
        </div>
        <div class="infoblocks__advantage">
          <div class="advantage">
            <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-7.png" alt="advantage"></div>
            <p class="advantage__title">Оптово и розничная продажа</p>
            <p class="advantage__text">Мы продаём товары как в розницу, так и оптом. В зависимости от объёмов заказа мы предоставляем клиентам персональные скидки</p>
          </div>
        </div>
      </div>
      <div class="infoblocks__bottom infoblocks__bottom_tab-view" data-tab-page="Условия доставки товара">
        <div class="infoblocks__callback">
          <p class="infoblocks__callback-text">ТОЧНУЮ СТОИМОСТЬ И СРОКИ УТОЧНЯЙТЕ ПО НОМЕРУ:</p><a class="infoblocks__callback-phone" href="tel:+78120000000">
            <svg class="infoblocks__callback-icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
            </svg>+7 (812) 000-00-00</a>
        </div>
      </div>
    </div>
  </article>

  {include "file:sections/related-products.tpl"}
  {include "file:sections/payment.tpl"}
  {include "file:sections/contacts.tpl" styleClass='section_view_bg'}

{/block}
