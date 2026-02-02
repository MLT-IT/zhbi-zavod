<article class="product section js-product not-init{if $prodValues['itemInCart']?} js-product-in-cart{/if}{if $prodValues['outputOldPrice']?} js-product_with-discount{/if}"
    {insert "file:chunks/product/get-data-attrs.tpl"}
    >
      <div class="product__container">
        <h1 class="product__title section__title">{$_modx->resource.pagetitle}</h1>
        <div class="product__body">

          <div class="product__body-left">
            {'!msGallery' | snippet : [
            'tpl' => '@FILE chunks/gallery.tpl',
            ]}

            {include 'file:chunks/product/get-ugc-gallery.tpl'}
            {* {include "file:blocks/product/linking/linking-select-other-color.tpl"} *}
          </div>

          <div class="product__info-wrap">
            <div class="product__info product-info">
            {if $_modx->resource.article}
            <div class="product-info__article article mb-2"> Арт. {$_modx->resource.article} </div>
            {/if}
              <div class="product-info__top">

                <div class="product-info__rating rating">
                  <ul class="rating__stars">
                    <li class="rating__star active"></li>
                    <li class="rating__star active"></li>
                    <li class="rating__star active"></li>
                    <li class="rating__star active"></li>
                    <li class="rating__star"></li>
                  </ul>

                  <span class="rating__reviews{if $reviewsCount > 0} rating__reviews_clickable{/if}">
                    {if !$reviewsCount}
                      {set $reviewsCount = $_modx->runSnippet('@FILE snippets/random.php', ['begin' => 1, 'end'=> 5, 'id' => $_modx->resource.id])}
                    {/if}

                    {$reviewsCount}

                    {'@FILE snippets/formOfWord.php' | snippet : [
                      'n' => $reviewsCount,
                      'f1' => 'отзыв',
                      'f2' => 'отзыва',
                      'f5' => 'отзывов'
                    ]}
                  </span>
                </div>



                <div class="product-info__relinkav">
                  {include "file:_modules/warehouses/sections/warehouse-remains.tpl"}
                  
                  {* {include "file:chunks/product/warehouse-plitnye.tpl"} *}
                  
                  {* <div class="product-info__prod-time pc-flex">
                      Срок изготовления: 2-3 дня
                  </div>
                  <div class="product-info__warranty pc-flex">
                      Гарантия на товар: 30 лет
                  </div> *}

                </div>
              </div>

              {* Перелинковка плитных по толщине *}
              <div class="product-info__top services-links">
                <div class="services-links__relinking">
                  {'@FILE snippets/getRelinkingData_Thickness-plitnye.php' | snippet}
                </div>
                <div class="services-links__buttons">
                  {* {include 'file:chunks/product/services-buttons-plitnye.tpl'} *}
                  {'@FILE snippets/migx/getRecurServicesButtons.php' | snippet : ['id' => $modx->resource.id]}
                </div>
              </div>

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

              {if $isCustomCalculator || $isShtaketnik}
                  <div class="product-info__undertext">
                    <p class="product-info__undertext-span">
                        <svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="16pt" height="16pt" class="icon" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">
                            <use xlink:href="/assets/template/img/svg-sprite.svg#icon-delivery-product"></use>
                        </svg>
                        <span class="product-info__undertext-span-header">Дата производства при заказе сегодня: </span> {'+2 days' | date : 'd.m.Y'}
                    </p>
                  </div>
              {/if}
              {switch $_modx->resource.context_key}
                {case 'gazosilikatstroy'}
                    <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
                {case 'gazoclone'}
                    <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
                {case 'krovelnyjstroymarket'}
                    {if !$isCustomCalculator && !$isShtaketnik}
                    <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
                    {/if}
                {case 'web'}
                    <p class="product-info__discount"><span class="product-info__discount-start">Льготная</span> доставка <span class="product-info__discount-end">1990 ₽</span></span></p>
              {/switch}
              </div>

            {* {if $isCustomCalculator || $isShtaketnik}
              <div class="blueprint-request">
                <a class="blueprint-request__button" data-fancybox href="#blueprint">
                  <img src="/assets/template/img/icons/blueprint.png" alt="">
                  <p class="blueprint-request__text">
                    <strong>Отправьте чертеж</strong> и получите расчет материалов бесплатно
                   </p>
                </a>
              </div>
            {/if} *}
           
          </div>
        </div>
      </div>
    </article>
    