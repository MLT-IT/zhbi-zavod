{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:chunks/meta/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:chunks/meta/product/meta-description.tpl"}
{/block}

{block "page"}
{* Если фоток нет, то ставим заглушку *}
{if $files | count == 0}
  {set $files = [['small' => '/assets/images/no_image.jpg']]}
{/if}

{* Получаем кол-во товара в корзине, нахождение товара в избранном и сравнении *}
{if $_modx->getPlaceholder('checkItems') is null}
    {'!checkItems' | snippet}
{/if}

{* Получаем коэффициенты единиц измерения товара *}
{set $src = $_modx->resource}
{insert "file:chunks/product/set-values-for-prod-new.tpl"}

{* Получаем сертификаты товара *}
{if $_modx->resource.certs}
    {set $certs = $_modx->resource.certs}

    {set $certs = json_decode($certs, true)}
    {if $certs | count > 0}
        {set $renderCerts = 1}
    {/if}
{/if}

{* Получаем отзывы товара *}
{if $_modx->resource.context_key == 'web'}
  {set $reviewsCount = 0}
{else}
  {set $reviews = '@FILE snippets/getReviews.php' | snippet | fromJSON}
  {set $reviewsCount = $reviews | count}
{/if}

{* Получаем видео товара *}
{set $video = $_modx->resource.video}
{if $video | length > 0}
    {set $renderVideo = 1}
{/if}

{if $_modx->resource.recommendIds ?}
    {set $recommendProducts = 'msProducts' | snippet : [
      'resources' => $_modx->resource.recommendIds,
      'sortby' => 'FIELD(msProduct.id, ' ~ $_modx->resource.recommendIds ~ ')',
      'parents' => 0,
      'depth' => 50,
      'limit' => 42,
      'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
      'tplWrapper' => '@FILE sections/related-products.tpl',
      'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
      'context' => $_modx->resource.context_key,
      'includeThumbs' => 'webp',
    ]}
{/if}

{if $_modx->resource.context_key == 'krovelnyjstroymarket'}
    {* Сопутствующие товары из категории ондулин -> сопутствующие товары *}
    {set $recommendProducts = 'msProducts' | snippet : [
    'resources' => '-' ~ $_modx->resource.id,
    'parents' => 125617,
    'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
    'tplWrapper' => '@FILE sections/related-products.tpl',
    'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
    'context' => $_modx->resource.context_key,
    'includeThumbs' => 'webp',
    'optionFilters' => '{"cvet":"'~$_modx->resource.cvet[0]~'"}',
    ]}

    {* Получение характеристик товара в формате json за исключенимем цвет*}
    {set $optionProduct = 'msProductOptions' | snippet : [
    'tpl' => '@FILE chunks/charecter-json.tpl',
    'ignoreOptions' => 'edizm,edizm2,cvet'
    ]}


    {* Похожие товары, отображаются товары с одинаковыми характеристиками кроме цвета *}
    {set $simillarProducts = 'msProducts' | snippet : [
    'resources' => '-' ~ $_modx->resource.id,
    'parents' => 0,
    'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
    'tplWrapper' => '@FILE sections/simillar-products.tpl',
    'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
    'context' => $_modx->resource.context_key,
    'includeThumbs' => 'webp',
    'optionFilters' => $optionProduct,
    ]}

{/if}




<main class="layout__main">
  <section class="section section_view_top">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
    <article class="product section js-product not-init{if $prodValues['itemInCart']?} js-product-in-cart{/if}{if $prodValues['outputOldPrice']?} js-product_with-discount{/if}"
    {insert "file:chunks/product/get-data-attrs.tpl"}
    >
      <div class="product__container">
        <h1 class="product__title section__title">{$_modx->resource.pagetitle}</h1>
        <div class="product__body">

          {'!msGallery' | snippet : [
          'tpl' => '@FILE chunks/gallery.tpl',
          ]}

          <div class="product__info-wrap">
            <div class="product__info product-info">

              <div class="product-info__top">
              {if $_modx->resource.article}
                  <div class="product-info__article article mb-2"> Арт. {$_modx->resource.article} </div>
              {/if}
                <div class="product-info__rating rating">
                  <div class="product-info__availability-title product-info__availability-title_available mobile-flex">На складе 190 м3</div>

                  <ul class="rating__stars">
                    <li class="rating__star active"></li>
                    <li class="rating__star active"></li>
                    <li class="rating__star active"></li>
                    <li class="rating__star active"></li>
                    <li class="rating__star"></li>
                  </ul>
                  <span class="rating__reviews{if $reviewsCount > 0} rating__reviews_clickable{/if}">
                    {$reviewsCount}
                    {'@FILE snippets/formOfWord.php' | snippet : [
                      'n' => $reviewsCount,
                      'f1' => 'отзыв',
                      'f2' => 'отзыва',
                      'f5' => 'отзывов'
                    ]}
                  </span>
                </div>

                <div class="product-info__shipped mobile-flex">
                    {'@FILE snippets/shippedToday.php' | snippet}
                </div>

                <div class="product-info__relinkav">
                  {if $_modx->context.key == 'gazosilikatstroy'}
                    {set $relinkingData = '@FILE snippets/getRelinkngDataByVendor.php' | snippet}
                    {if $relinkingData is not empty}
                      <div class="product-info__euv-custom-select euv-custom-select">
                        <div class="euv-custom-select__input">
                          <span class="euv-custom-select__input-value">{$_modx->resource['proizvoditel'][0]}</span>
                        </div>
                        <span class="euv-custom-select__btn"></span>
                        <div class="euv-custom-select__options-wrap">
                          {foreach $relinkingData as $item}
                            <a href="/{$item['uri']}" class="euv-custom-select__option">
                              {$item['proizvoditel']}
                            </a>
                          {/foreach}
                        </div>
                      </div>
                    {/if}
                  {/if}

                  {switch $_modx->resource.context_key}
                    {case 'web'}
                      {set $unit = '@FILE snippets/formOfWord.php' | snippet : [
                        'n' => $_modx->resource.stockNum,
                        'f1' => 'упаковка',
                        'f2' => 'упаковки',
                        'f5' => 'упаковок'
                      ]}
                    {case 'gazosilikatstroy'}
                      {set $unit = 'м3'}
                    {case 'krovelnyjstroymarket'}
                     {set $unit = 'м2'}
                  {/switch}

                  {if $_modx->resource.context_key not in list ['kraska', 'suhiesmesi']}
                    {* При чем тут relinkingData ? *}
                    {if $relinkingData is empty}
                      <div class="product-info__availability-title product-info__availability-title_available pc-flex">На складе {$_modx->resource.stockNum} {$unit}</div>
                    {/if}
                  {/if}
                </div>

                {if $_modx->resource.context_key not in list ['suhiesmesi']}
                  {* При чем тут relinkingData ? *}
                  {if ($relinkingData is not empty) && ($_modx->resource.context_key != 'kraska')}
                    <div class="product-info__avstock">
                        <div class="product-info__availability-title product-info__availability-title_available pc-flex">
                          На складе {$_modx->resource.stockNum} {$unit}
                        </div>
                        <div class="product-info__shipped pc-flex">
                            {'@FILE snippets/shippedToday.php' | snippet}
                        </div>
                    </div>
                  {else}
                    <div class="product-info__avstock">
                    {if $_modx->resource.context_key == 'kraska'}
                        <div class="product-info__availability-title product-info__availability-title_available pc-flex">
                         В наличии {$_modx->resource.stockNum} {$unit}
                        </div>
                    {else}
                      <div class="product-info__shipped pc-flex">
                          {'@FILE snippets/shippedToday.php' | snippet}
                      </div>
                    {/if}
                    </div>
                  {/if}
                {/if}
              </div>

              <div class="product-info__bottom">
                  {* Перелинковка характеристиками *}
                  <div class="product-info__selected-characteristics">
                      {* Указаны все категории из главных категорий 125530, 125530, 125541 *}
                      {if $_modx->resource.context_key == 'krovelnyjstroymarket' && $_modx->resource.template == 17 || $_modx->resource.parent in list [125626,125627,125628,125629,125630,125631,125632,125633,126220,126221,126222,126223,126224,126225,126226125626,125627,125628,125629,125630,125631,125632,125633,126220,126221,126222,126223,126224,126225,126226126138,126139,126140,126141,126142,126143,126144,126145,126146,126147,126148,126149,126150,126151,126152,126155,126156,126157]  }
                          {set $linksData = 'getRelinkingData_ColorSurfaceThickness' | snippet}
                          {set $cvet = $_modx->resource.cvet[0]}
                      {/if}

                      {if $linksData.cvet?}
                          <div class="product-card__select-wrap{if $_modx->resource.template == 22} product-card__select-wrap_type_full{else} product-card__select-wrap_type_half{/if}">
                              <div class="product-card__select-span">
                                  {if $_modx->resource.template == 17}
                                      Цвет:
                                  {/if}
                                  {if $_modx->resource.template in list [20, 22]}
                                      Оттенок:
                                  {/if}
                              </div>
                              <div class="custom-select-wrap">
                                  <div class="colors-options euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                      <div class="euv-custom-select__input">
                                          <span data-val="{$cvet}" class="euv-custom-select__input-value">{$cvet}</span>
                                      </div>
                                      <span class="euv-custom-select__btn"></span>
                                      <div class="euv-custom-select__options-wrap">
                                          <div class="euv-custom-select__options-wrap-scroll">
                                              <div class="euv-custom-select__options-wrap-scroll-inner">
                                                  {foreach $linksData.cvet as $data}
                                                      <div class="euv-custom-select__options-col">
                                                          {foreach $data as $id => $val}
                                                              {set $v = $val}
                                                              <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option" data-val="{$v}" data-value="{$val}">
                                                                  {$val}
                                                              </a>
                                                          {/foreach}
                                                      </div>
                                                  {/foreach}
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="custom-select-mobile-link"></div>
                                  <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                              </div>
                          </div>
                      {/if}

                      {if $linksData.collection?}
                          <div class="product-card__select-wrap product-card__select-wrap_type_half">
                              <div class="product-card__select-span">Коллекция:</div>
                              <div class="custom-select-wrap">
                                  <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                      <div class="euv-custom-select__input">
                                            <span class="euv-custom-select__input-value">
                                                {$_modx->resource.collection[0]}
                                            </span>
                                      </div>
                                      <span class="euv-custom-select__btn"></span>
                                      <div class="euv-custom-select__options-wrap">
                                          <div class="euv-custom-select__options-wrap-scroll">
                                              {foreach $linksData.collection as $id => $val}
                                                  <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                      {$val}
                                                  </a>
                                              {/foreach}
                                          </div>
                                      </div>
                                  </div>
                                  <div class="custom-select-mobile-link"></div>
                                  <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                              </div>
                          </div>
                      {/if}

                      {if $linksData.item_thickness?}
                          <div class="product-card__select-wrap product-card__select-wrap_type_half{if $linksData.cvet?} product-card__select-wrap_align_right{/if}">
                              <div class="product-card__select-span">Толщина, мм:</div>
                              <div class="custom-select-wrap">
                                  <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                      <div class="euv-custom-select__input">
                                          <span class="euv-custom-select__input-value">{$_modx->resource.item_thickness[0]}</span>
                                      </div>
                                      <span class="euv-custom-select__btn"></span>
                                      <div class="euv-custom-select__options-wrap">
                                          <div class="euv-custom-select__options-wrap-scroll">
                                              {foreach $linksData.item_thickness as $id => $val}
                                                  <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                      {$val}
                                                  </a>
                                              {/foreach}
                                          </div>
                                      </div>
                                  </div>
                                  <div class="custom-select-mobile-link"></div>
                                  <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                              </div>
                          </div>
                      {/if}

                      {if $linksData.pokrytie?}
                          <div class="product-card__select-wrap product-card__select-wrap_type_full mt">
                              <div class="product-card__select-span">Покрытие:</div>
                              <div class="custom-select-wrap">
                                  <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                      <div class="euv-custom-select__input">
                                          <span class="euv-custom-select__input-value">{$_modx->resource.pokrytie[0]}<span class="euv-custom-select__small-text">{$_modx->resource['vid-poverhnosti'][0]}</span></span>
                                      </div>
                                      <span class="euv-custom-select__btn"></span>
                                      <div class="euv-custom-select__options-wrap">
                                          <div class="euv-custom-select__options-wrap-scroll">
                                              {foreach $linksData.pokrytie as $id => $val}
                                                  <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                      {$val} <span class="euv-custom-select__small-text">{$linksData['vid-poverhnosti'][$id]}</span>
                                                  </a>
                                              {/foreach}
                                          </div>
                                      </div>
                                  </div>
                                  <div class="custom-select-mobile-link"></div>
                                  <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                              </div>
                          </div>
                      {/if}

                      {if $linksData.tip?}
                          <div class="product-card__select-wrap product-card__select-wrap_type_half{if $linksData.tip?} product-card__select-wrap_align_right{/if}">
                              <div class="product-card__select-span">Тип:</div>
                              <div class="custom-select-wrap">
                                  <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                      <div class="euv-custom-select__input">
                                          <span class="euv-custom-select__input-value">{$_modx->resource.tip[0]}</span>
                                      </div>
                                      <span class="euv-custom-select__btn"></span>
                                      <div class="euv-custom-select__options-wrap">
                                          <div class="euv-custom-select__options-wrap-scroll">
                                              {foreach $linksData.tip as $id => $val}
                                                  <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                      {$val}
                                                  </a>
                                              {/foreach}
                                          </div>
                                      </div>
                                  </div>
                                  <div class="custom-select-mobile-link"></div>
                                  <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                              </div>
                          </div>
                      {/if}

                  </div>
                  {* Конец перелинковка характеристиками *}

              <div class="product-info__volume"><span class="product-info__volume-title">Цена за:</span>
                  <input type="hidden" name="unit" value="1">
                  <div class="product-card__volume">
                    <ul class="product-info__volume-tabs">
                      <li class="product-info__volume-tab js-product__volume-tab active" data-val="1">{$prodValues['pricePer']}</li>
                      {foreach $prodValues['itemUnits'] as $val}
                        <li class="product-info__volume-tab js-product__volume-tab" data-val="{$val['id']}">{$val['title']}</li>
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
                <div class="product-info__actions">
                  {include "file:chunks/product/product-elems.tpl" prodId=$_modx->resource.id}
                </div>
                <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Купить в 1 клик</button>
              </div>
              
              {if $_modx->resource.context_key == 'kraska'}
                  <div class="product-info__undertext">
                    <p class="product-info__undertext-span">
                    <svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="16pt" height="16pt" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">

                        <g transform="translate(0.000000,512.000000) scale(0.100000,-0.100000)" fill="#000000" stroke="none">
                            <path d="M2335 4944 c-408 -55 -755 -230 -1042 -526 -274 -284 -438 -636 -483 -1033 -27 -239 3 -430 104 -684 171 -424 492 -896 1065 -1563 18 -21 32 -40 30 -42 -2 -1 -69 -10 -149 -19 -489 -55 -838 -174 -937 -321 -145 -213 92 -402 637 -510 303 -59 565 -80 1005 -80 385 0 568 12 845 54 562 85 864 251 826 454 -11 57 -65 126 -135 173 -157 105 -492 195 -872 235 -65 7 -118 16 -117 20 2 4 51 62 109 130 494 575 821 1064 985 1469 102 254 131 446 104 684 -64 557 -374 1041 -850 1327 -333 200 -742 284 -1125 232z m529 -174 c731 -146 1258 -758 1293 -1500 9 -190 -30 -360 -137 -600 -207 -465 -739 -1176 -1344 -1796 l-116 -119 -116 119 c-312 320 -681 756 -914 1080 -299 416 -458 720 -547 1046 -27 98 -24 348 5 497 133 670 652 1175 1322 1282 112 18 131 19 295 15 105 -2 194 -11 259 -24z m-529 -4015 c175 -181 193 -196 225 -196 32 0 49 15 222 193 l188 193 52 -3 c29 -2 114 -10 188 -18 405 -46 720 -134 835 -235 43 -38 44 -57 3 -96 -117 -111 -503 -209 -1003 -255 -184 -17 -776 -17 -965 0 -499 45 -894 144 -1008 254 -41 41 -40 59 3 97 132 116 510 210 1020 254 22 2 42 4 45 5 3 1 91 -86 195 -193z"/>
                            <path d="M2420 4473 c-278 -30 -560 -166 -763 -370 -476 -475 -502 -1239 -60 -1743 495 -563 1356 -588 1875 -52 148 153 237 299 303 495 39 117 65 277 65 397 0 177 -54 409 -130 561 -125 248 -340 464 -588 588 -197 99 -476 148 -702 124z m315 -168 c467 -75 826 -424 927 -900 16 -77 16 -333 0 -410 -98 -461 -436 -799 -897 -897 -77 -16 -333 -16 -410 0 -348 74 -626 281 -783 580 -173 331 -175 697 -7 1032 214 427 696 672 1170 595z"/>
                            <path d="M1951 3902 c-17 -13 -33 -59 -66 -192 l-45 -175 0 -503 0 -503 25 -24 24 -25 671 0 671 0 24 25 25 24 0 503 0 503 -45 175 c-33 133 -49 179 -66 192 -20 17 -64 18 -609 18 -545 0 -589 -1 -609 -18z m369 -222 l0 -80 -149 0 -149 0 20 80 20 80 129 0 129 0 0 -80z m320 0 l0 -80 -80 0 -80 0 0 80 0 80 80 0 80 0 0 -80z m438 0 l20 -80 -149 0 -149 0 0 80 0 80 129 0 129 0 20 -80z m-758 -375 c0 -131 1 -137 25 -160 24 -25 26 -25 215 -25 189 0 191 0 215 25 24 23 25 29 25 160 l0 135 160 0 160 0 0 -400 0 -400 -560 0 -560 0 0 400 0 400 160 0 160 0 0 -135z m320 55 l0 -80 -80 0 -80 0 0 80 0 80 80 0 80 0 0 -80z"/>
                            <path d="M2665 2855 c-16 -15 -25 -36 -25 -55 0 -19 9 -40 25 -55 23 -24 28 -25 175 -25 147 0 152 1 175 25 16 15 25 36 25 55 0 19 -9 40 -25 55 -23 24 -28 25 -175 25 -147 0 -152 -1 -175 -25z"/>
                        </g>
                    </svg>
                    <span class="product-info__undertext-span-header">Самовывоз:</span> сегодня
                    </p> 
                    <p class="product-info__undertext-span">
                        <svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="16pt" height="16pt" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">

                            <g transform="translate(0.000000,512.000000) scale(0.100000,-0.100000)" fill="#000000" stroke="none">
                                <path d="M1078 3649 c-43 -22 -78 -81 -78 -129 0 -50 35 -107 80 -130 35 -18 59 -20 205 -20 l165 0 -2 -267 -3 -268 -427 -5 c-409 -5 -428 -6 -454 -25 -86 -65 -82 -181 10 -249 27 -20 41 -21 452 -24 l424 -3 -2 -267 -3 -267 -677 -5 c-665 -5 -677 -5 -705 -26 -88 -65 -79 -192 18 -249 33 -20 55 -20 976 -23 l941 -2 26 -44 c37 -63 127 -141 194 -167 44 -18 77 -23 147 -24 80 0 97 4 157 32 80 37 146 96 179 158 l24 45 407 0 408 0 0 990 0 990 -1212 0 c-1188 -1 -1214 -1 -1250 -21z m1567 -509 c73 -35 103 -118 70 -197 -8 -19 -15 -39 -15 -44 0 -5 42 -9 93 -9 82 0 97 -3 129 -25 43 -29 74 -99 63 -142 -14 -58 -128 -319 -148 -342 -47 -51 -118 -64 -177 -32 -73 38 -99 122 -65 203 l14 35 -89 5 c-127 8 -185 47 -197 134 -4 33 5 65 52 180 76 185 90 210 139 234 51 25 79 25 131 0z m-219 -1231 c30 -28 37 -62 20 -102 -36 -87 -176 -59 -176 35 1 83 96 123 156 67z"/>
                                <path d="M3840 3250 l0 -420 591 0 c394 0 588 3 584 10 -15 24 -861 797 -889 812 -24 14 -58 17 -158 18 l-128 0 0 -420z"/>
                                <path d="M3840 2110 l0 -420 98 0 97 -1 33 -54 c146 -242 516 -243 664 -1 l33 54 120 3 c131 4 168 17 209 72 20 28 21 40 24 398 l3 369 -641 0 -640 0 0 -420z m627 -202 c33 -31 32 -96 -3 -129 -57 -53 -154 -15 -154 61 0 88 93 128 157 68z"/>
                            </g>
                        </svg>
                        <span class="product-info__undertext-span-header">Доставка:</span> 1-2 дня
                    </p>
                  </div>
              {/if}
            </div>

            {switch $_modx->resource.context_key}
              {case 'gazosilikatstroy'}
                  <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
              {case 'krovelnyjstroymarket'}
                  <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
              {case 'web'}
                  <p class="product-info__discount"><span class="product-info__discount-start">Льготная</span> доставка <span class="product-info__discount-end">1990 ₽</span></span></p>
            {/switch}
          </div>
        </div>
      </div>
    </article>
  </section>

  <article class="product__infoblocks infoblocks infoblocks_style_shadow section">
    <div class="infoblocks__container" data-tabs data-tabs-hiddable="479">
      <div class="infoblocks__top">
        <div class="infoblocks__tabs">
          <a class="infoblocks__tab" href="javascript:;" data-tab="Описание">Описание</a>
          <a class="infoblocks__tab active" href="javascript:;" data-tab="Характеристики">Характеристики</a>
          <a class="infoblocks__tab" href="javascript:;" data-tab="Условия доставки">Условия доставки</a>

          {if $renderCerts ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Сертификаты">Сертификаты</a>
          {/if}

          {if $reviewsCount > 0}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Отзывы">Отзывы</a>
          {/if}

          {if $renderVideo ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Видео">Видео</a>
          {/if}

          {if $recommendProducts?}
            <a class="infoblocks__tab" href="{$_modx->resource.id | url}#other-products">Сопутствующие товары</a>
          {/if}
        </div>
      </div>

      <div class="infoblocks__content">
        <div class="infoblocks__block" data-tab-page="Описание">
          <button class="infoblocks__block-title" data-tab="Описание">Описание</button>
          <div class="infoblocks__block-dropdown custom-content">
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
                    'tpl' => '@FILE chunks/item-characters.tpl',
                    'ignoreOptions' => 'edizm,edizm2'
                  ]}
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <div class="infoblocks__block" data-tab-page="Условия доставки">
          <button class="infoblocks__block-title" data-tab="Условия доставки">Условия доставки</button>
          <div class="infoblocks__block-dropdown">
            <div class="table infoblocks__table">
              {include 'file:sections/delivery-inner.tpl'}
            </div>
            <div class="product-info__delivery-btn infoblocks__bottom"><a class="btn btn_style_shadow" data-fancybox="" href="#callback">заказать с доставкой</a></div>
          </div>
        </div>

        {if $reviewsCount > 0}
          <div class="infoblocks__block" data-tab-page="Отзывы">
            <button class="infoblocks__block-title" data-tab="Отзывы">Отзывы</button>
            <div class="infoblocks__block-dropdown">
              <div class="reviews">
                <div class="reviews__slider">
                  <div class="swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
                    <div class="swiper-wrapper">
                      {foreach $reviews as $idx => $row}
                        <div class="swiper-slide reviews__item" style="width: 802px; opacity: 1; transform: translate3d(0px, 0px, 0px);"><span class="reviews__name">{$row.author}</span>
                          <p class="reviews__text">{$row.text}</p>
                        </div>
                      {/foreach}
                    </div>
                  </div>
                  <div class="swiper-buttons">
                    <div class="swiper-button swiper-button-prev swiper-button-disabled"></div>
                    <div class="swiper-button swiper-button-next"></div>
                  </div>
                </div>
                <a class="btn btn_style_shadow reviews__btn" href="#">Оставить отзыв</a>
              </div>
            </div>
          </div>
        {/if}

        {if $renderCerts ?}
          <div class="infoblocks__block" data-tab-page="Сертификаты">
              <button class="infoblocks__block-title" data-tab="Сертификаты">Сертификаты</button>
              <div class="infoblocks__block-dropdown">
                <ul class="certs-block">
                    {foreach $certs as $ct}
                        <li class="certs-block__item">
                            {set $previewSrc = ''}
                            {set $splitted = $ct.file | split: '.'}
                            {set $count = $splitted | count}
                            {if $count > 1}
                                {set $lastElem = $splitted[$count - 1] | strtolower}

                                {if $lastElem == 'pdf'}
                                    {set $previewSrc = 'pdfToJpg' | snippet : [
                                    'src' => '/assets/template/img/import/' ~ $ct.file,
                                    ]}
                                {elseif ($lastElem in list ['jpg','jpeg','png','gif','webp'])}
                                    {set $previewSrc = '/assets/template/img/import/' ~ $ct.file}
                                {/if}

                                {if $previewSrc ?}
                                    {if $h is empty}
                                        {set $h = 138}
                                    {/if}
                                    {set $previewSrc = 'phpthumbon' | snippet : [
                                    'input' => $previewSrc,
                                    'options' => '&h='~$h~'&far=1'
                                    ]}
                                {/if}
                            {/if}

                            {if $previewSrc is empty}
                                {if $lastElem in list ['dwg','xls','doc', 'rfa', 'odt', 'zip', 'docx']}
                                    {set $previewClass = 'certs-block__preview-download'}
                                {else}
                                    {set $previewClass = 'certs-block__preview-view'}
                                    {set $fancybox = 'data-fancybox'}
                                {/if}
                                <a class="{$previewClass} certs-block__{$lastElem}-preview" {$fancybox} title="{$ct.name}"
                                   href="/assets/template/img/import/{$ct.file}"></a>
                            {else}
                                <a class="certs-block__cert-preview{if $classToPreview?} {$classToPreview}{/if}" data-fancybox title="{$ct.name}"
                                   href="/assets/template/img/import/{$ct.file}">
                                    <img class="certs-block__cert-img" src="{$previewSrc}" alt="{$ct.name}">
                                </a>
                            {/if}
                        </li>
                    {/foreach}
                </ul>
              </div>
          </div>
        {/if}

        {if $renderVideo == 1}
          <div class="infoblocks__block" data-tab-page="Видео">
            <button class="infoblocks__block-title" data-tab="Видео">Видео</button>
            <div class="infoblocks__block-dropdown">
              {$video}
            </div>
          </div>
        {/if}
      </div>

      {include "file:chunks/guarantees.tpl"}
    </div>
  </article>

  {$recommendProducts?: ''}
  {$simillarProducts ?: ''}
  {include "file:sections/payment.tpl"}
  {include "file:sections/contacts.tpl" styleClass='section_view_bg'}

{/block}
