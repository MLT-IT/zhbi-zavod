  <section class="section section_view_top">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
    <article class="product section js-product not-init{if $prodValues['itemInCart']?} js-product-in-cart{/if}{if $prodValues['outputOldPrice']?} js-product_with-discount{/if}"
    {include "file:chunks/product/get-data-attrs.tpl"}
    >
      <div class="product__container">
        <h1 class="product__title section__title">{$_modx->resource.pagetitle}</h1>
        <div class="product__body">

          <div class="product__body-left">
            {'!msGallery' | snippet : [
            'tpl' => '@FILE chunks/gallery.tpl',
            ]}

            {include "file:chunks/product/rating.tpl"}

            {include 'file:chunks/product/get-ugc-gallery.tpl'}

          </div>

          <div class="product__info-wrap">
            <div class="product__info product-info">
              <div class="product-info__top">
                <div class="product-info__divider">
                  <div class="width-100">

                    {if '@FILE snippets/product/isCollerovka.php' | snippet: ['id' => $_modx->resource.id]}
                        <div id="collerovka"></div>
                    {/if}

                    <div class="product-info__relinkav">

                      {set $unit = 'шт'}

{*
                      <div class="product-info__availability-title has-icon icon-checkmark pc-flex">
                          Срок доставки: {'' | date : 'd.m.Y'}
                      </div>
                      <div class="product-info__availability-title has-icon icon-checkmark pc-flex">
                          Самовывоз: {'' | date : 'd.m.Y'}
                      </div> *}

                      {include "file:modules/warehouses/sections/warehouse-remains.tpl"}
                      {* {if $relinkingData is empty}
                        <div class="product-info__availability-title has-icon icon-checkmark pc-flex">

                          В наличии {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 100, 'end'=> 2000])} шт

                        </div>
                      {/if} *}

                      </div>


                    {if ($relinkingData is not empty)}
                      <div class="product-info__avstock">
                          <div class="product-info__availability-title has-icon icon-checkmark pc-flex">
                            На складе {$_modx->resource.stockNum} {$unit}
                          </div>
                          <div class="product-info__shipped pc-flex">
                              {'@FILE snippets/shippedToday.php' | snippet}
                          </div>
                      </div>
                    {/if}
                  </div>
                </div>
              </div>


              {set $linksData = '@FILE snippets/getRelinkingData_Thickness.php' | snippet}

              {$linksData}

              <div class="product-info__bottom">
                  {* Перелинковка характеристиками *}
                  {include 'file:chunks/product/product-relinking-block.tpl' linksData=$linksData}
                  {* Конец перелинковка характеристиками *}
                  <div class="product-info__volume"><span class="product-info__volume-title">Цена за:</span>
                    <input type="hidden" name="unit" value="1">
                    <div class="product-card__volume">
                      <ul class="product-info__volume-tabs">
                        <li class="product-info__volume-tab js-product__volume-tab active" data-val="1">{$prodValues['pricePer']}</li>
                        {foreach $prodValues['itemUnits'] as $val}
                            {if $prodValues['pricePer'] != $val['title']}
                                <li class="product-info__volume-tab js-product__volume-tab" data-val="{$val['id']}">{$val['title']}</li>
                            {/if}
                        {/foreach}
                      </ul>
                    </div>
                  </div>

                  <div class="product-info__price{if $prodValues['outputOldPrice']?} active{/if}">
                    <p class="product-info__price-value">
                      <span class="js-product__price" data-default="{$prodValues['defaultPrice']}">{$prodValues['outputPrice']}</span> ₽
                    </p>
                    {if $prodValues['outputOldPrice']?}
                      <div class="js-product__old-price">
                        <span class="js-product__old-price-val" data-default="{$prodValues['defaultOldPrice']}">
                            {$prodValues['outputOldPrice']}
                        </span>
                        ₽
                      </div>

                      <div class="product-info__price-mes">
                          <p class="product-info__price-mes-header">Снижение цены!</p>
                          <p class="product-info__price-mes-body">Мы регулярно снижаем цены на наши товары, чтобы покупка у нас была еще выгоднее!</p>
                          <span class="product-info__price-mes-close"></span>
                      </div>
                    {/if}
                    </div>
                  </div>
              </div>


              <div class="product-info__actions">

                {include "file:chunks/product/product-elems.tpl" prodId=$_modx->resource.id}

              </div>

              {if !$skipOneClickButton}
                <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Купить в 1 клик</button>
              {/if}

            </div>

             {"@FILE modules/restrictions/restrictions.php" | snippet}

            <div class="product-info__undertext">
              <p class="product-info__undertext-span">
                <svg xmlns="http://www.w3.org/2000/svg" version="1.0" class="icon" preserveAspectRatio="xMidYMid meet">
                    <use xlink:href="/assets/template/img/svg-sprite.svg#icon-location-product"></use>
                </svg>
                <span class="product-info__undertext-span-header">Самовывоз: </span> сегодня
              </p>
              <p class="product-info__undertext-span">
                <svg xmlns="http://www.w3.org/2000/svg" version="1.0" class="icon" preserveAspectRatio="xMidYMid meet">
                    <use xlink:href="/assets/template/img/svg-sprite.svg#icon-delivery-product"></use>
                </svg>
                <span class="product-info__undertext-span-header">Доставка: </span> 1-2 дня
              </p>
            </div>

              {* <div class="product-info__discount big">
                <span class="product-info__discount-start"></span>
                <div>
                  <div class="product-info__discount-title">В комплекте дешевле!</div>
                  <div class="product-info__discount-text">Заказывайте утеплитель вместе с плитными материалами со скидкой до 30%</div>
                </div>
              </div> *}
          </div>
        </div>
      </div>
    </article>
  </section>
