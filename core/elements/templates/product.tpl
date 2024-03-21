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

{if $_modx->resource.context_key == 'krovelnyjstroymarket'}
    {* Сопутствующие товары из категории ондулин -> сопутствующие товары *}
    {set $recommendProducts = 'msProducts' | snippet : [
    'resources' => '-' ~ $_modx->resource.id,
    'parents' => 125617,
    'limit' => 42,
    'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
    'tplWrapper' => '@FILE sections/related-products.tpl',
    'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
    'context' => $_modx->resource.context_key,
    'includeThumbs' => 'webp',
    'optionFilters' => '{"cvet":"'~$_modx->resource.cvet[0]~'"}',
    ]}

    {set $simillarProductIds = $_modx->resource.simillarProductIds}
    {if $simillarProductIds}
        {* Похожие товары, отображаются товары с одинаковыми характеристиками кроме цвета *}
        {set $simillarProducts = 'msProducts' | snippet : [
        'resources' => $simillarProductIds,
        'parents' => 0,
        'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
        'tplWrapper' => '@FILE sections/simillar-products.tpl',
        'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
        'context' => $_modx->resource.context_key,
        'includeThumbs' => 'webp',
        ]}
    {/if}

{elseif $_modx->resource.recommendIds ?}
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


{* Указаны все категории из главных категорий 125530, 125530, 125541 *}
{if ($_modx->resource.context_key == 'krovelnyjstroymarket' && $_modx->resource.template == 17) || $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '125530,125530,125541,125537'])  }
  {set $linksData = 'getRelinkingData_ColorSurfaceThickness' | snippet}
  {set $cvet = $_modx->resource.cvet[0]}

  {if $linksData.cvet?}
    {set $colorsSorted = $_modx->runSnippet("@FILE snippets/linking/getSortedByPopColors.php", ["colorsArrays" => $linksData.cvet])}
    {if $colorsSorted?}
        {set $linksData.cvet = $_modx->runSnippet("@FILE snippets/linking/getSplitedColors.php", ["colorsArray" => $colorsSorted])}
    {/if} 
  {/if}
{/if}

{if $_modx->resource.context_key in list ['kraska']}
{set $linksData = 'getRelinking_ColorFasovkaType' | snippet}
{set $cvet = $_modx->resource.cvet[0]}
{/if}

<main class="layout__main" xmlns="http://www.w3.org/1999/html">
  <section class="section section_view_top">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
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
  
            {include "file:blocks/product/linking/linking-select-other-color.tpl"}
          </div>

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


              {if '@FILE snippets/product/isCollerovka.php' | snippet: ['id' => $_modx->resource.id]}
                  <div id="collerovka"></div>

{*                  <a href="#calculator-kraski">*}
{*                      <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-calculator-kraski"></use>*}
{*                      Калькулятор краски*}
{*                  </a>*}

              {/if}


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
                      {set $randomStock = $_modx->runSnippet('@FILE snippets/random.php', ['begin' => 500, 'end'=> 2000]) }
                      {if $_modx->resource.unit[0] == 'упаковка'}
                        {set $unit = '@FILE snippets/formOfWord.php' | snippet : [
                        'n' => $randomStock,
                        'f1' => 'упаковка',
                        'f2' => 'упаковки',
                        'f5' => 'упаковок'
                        ]}
                      {else}
                        {set $unit = $_modx->resource.unit[0]}
                      {/if}
                    {case default}
                     {set $unit = 'шт'}
                  {/switch}



                  {if $_modx->resource.context_key not in list ['kraska']}
                    {* При чем тут relinkingData ? *}
                    {if $relinkingData is empty}
                      <div class="product-info__availability-title product-info__availability-title_available pc-flex">
                          {if $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '125530,125537'])}
                              В наличии металл {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 2000, 'end'=> 4000])} м2
                            {elseif $_modx->context.key == 'krovelnyjstroymarket'}
                              На складе {$randomStock} {$unit}
                            {elseif $_modx->context.key == 'suhiesmesi'}
                                В наличии {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 35, 'end'=> 150])} шт
                            {else}
                              На складе {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 700, 'end'=> 1000])} {$unit}
                          {/if}
                      </div>
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
                        {if $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '125530,125537,125541'])}
                            Дата производства при заказе сегодня: <span class="bold"> &nbsp; {'+2 days' | date : 'd.m.Y'} </span>
                            {elseif $_modx->context.key == 'krovelnyjstroymarket'}
                            Дата доставки при заказе сегодня: <span class="bold">&nbsp; {'+1 days' | date : 'd.m.Y'} </span>
                            {else}
                            {'@FILE snippets/shippedToday.php' | snippet}
                        {/if}

                      </div>
                    {/if}
                    </div>
                  {/if}
                {/if}
              </div>
            
              {if $_modx->resource.context_key == 'web'}
              
                  {set $linksData = '@FILE snippets/getRelinkingData_Thickness.php' | snippet}
                  {$linksData}
                
              {/if}
            
              <div class="product-info__bottom">
                  {* Перелинковка характеристиками *}
                  <div class="product-info__selected-characteristics">

                      {if $_modx->context.key == 'suhiesmesi' }
                          {$_modx->runSnippet("@FILE snippets/linking/linking-select.php", [
                          'dependence' => ['cvet', 'ves-shtuki-kg'],
                          'coincide' => ['tip', 'proizvoditel'],
                          'tplFilter' => [
                              'cvet' => '@FILE blocks/product/linking/linking-select-cvet.tpl',
                              'ves-shtuki-kg' => '@FILE blocks/product/linking/linking-list-fasovka.tpl'
                          ]
                          ])}
                      {/if}

                      {if $linksData.cvet?}
                          <div class="product-card__select-wrap{if $_modx->resource.template == 22} product-card__select-wrap_type_full{else} product-card__select-wrap_type_half{/if}">
                              <div class="product-card__select-span">
                                  {if $_modx->resource.template == 17 || $_modx->context.key == "kraska"}
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
                                                              <a href="{$_modx->makeUrl($id, '', '', 'full')}" data-product="{$id}" class="euv-custom-select__option" data-val="{$v}" data-value="{$val}">
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

                      {if $linksData.fasovka?}
                          <div class="product-info__select-link mb-4"><span class="product-info__select-link-title">Фасовка:</span>
                              <input type="hidden" name="unit" value="1">
                              <div class="product-card__select-link">
                                  <ul class="product-info__select-link-tabs">

                                      {foreach $linksData.fasovka as $id => $val}
                                          {if $_modx->resource.fasovka[0] != $val}
                                              <li class="product-info__select-link-tab js-product__select-link-tab" data-val="{$val['id']}">
                                                  <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                      {$val}
                                                  </a>
                                              </li>
                                              {else}
                                              <li class="product-info__select-link-tab js-product__select-link-tab active" data-val="1">{$_modx->resource.fasovka[0]}</li>
                                          {/if}
                                      {/foreach}
                                  </ul>
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
                <div class="product-info__actions">
                  {include "file:chunks/product/product-elems.tpl" prodId=$_modx->resource.id}
                </div>
                <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Купить в 1 клик</button>
              </div>

              {if $_modx->resource.context_key in list ['kraska', 'suhiesmesi']}
                  <div class="product-info__undertext">
                    <p class="product-info__undertext-span">
                    <svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="16pt" height="16pt" class="icon" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">
                        <use xlink:href="/assets/template/img/svg-sprite.svg#icon-location-product"></use>
                    </svg>
                    <span class="product-info__undertext-span-header">Самовывоз:</span> сегодня
                    </p>
                    <p class="product-info__undertext-span">
                        <svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="16pt" height="16pt" class="icon" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">
                            <use xlink:href="/assets/template/img/svg-sprite.svg#icon-delivery-product"></use>
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


            <a class="infoblocks__tab" href="javascript:;" data-tab="Отзывы">Отзывы</a>

          {if $renderVideo ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Видео">Видео</a>
          {/if}

            {if $_modx->resource.recommendForUse != "" && $_modx->context.key in list ['suhiesmesi', 'kraska']}
                <a class="infoblocks__tab" href="javascript:;" data-tab="Рекомендации по применению">Рекомендации по применению</a>
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
        <div class="infoblocks__block" data-tab-page="Отзывы">
            <button class="infoblocks__block-title" data-tab="Отзывы">Отзывы</button>
            <div class="infoblocks__block-dropdown">
              <div class="reviews">
              {foreach $reviews as $idx => $row}
                  {if $row.status == 1}
                      {set $statusPublishedReviews = true}
                  {/if}
              {/foreach}

              {if $reviewsCount > 0 && $statusPublishedReviews}
                <div class="reviews__slider">
                  <div class="swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
                    <div class="swiper-wrapper">

                      {foreach $reviews as $idx => $row}
                          {if $row.status == 1}
                            <div class="swiper-slide reviews__item" style="width: 802px; opacity: 1; transform: translate3d(0px, 0px, 0px);"><span class="reviews__name">{$row.author}</span>
                              <p class="reviews__text">{$row.text}</p>
                            </div>
                          {/if}
                      {/foreach}

                    </div>
                  </div>

                    <div class="swiper-buttons">
                    <div class="swiper-button swiper-button-prev swiper-button-disabled"></div>
                    <div class="swiper-button swiper-button-next"></div>
                  </div>
                </div>
                  {else}
                  <h3 class="py-5">Еще нет отзывов</h3>
              {/if}
                <a class="btn btn_style_shadow reviews__btn"  data-fancybox href="#review">Оставить отзыв</a>
              </div>
            </div>
          </div>


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
              {set $srcs = $video | split}
              {foreach $srcs as $src}
                  <iframe width="100%" height="450" class="lazy" data-src="{$src}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
              {/foreach}
            </div>
          </div>
        {/if}

          {if $_modx->resource.recommendForUse != "" && $_modx->context.key in list ['suhiesmesi', 'kraska']}
              <div class="infoblocks__block" data-tab-page="Рекомендации по применению">
                  <button class="infoblocks__block-title" data-tab="Рекомендации по применению">Рекомендации по применению</button>
                  <div class="infoblocks__block-dropdown custom-content">
                      {$_modx->resource.recommendForUse}
                  </div>
              </div>
         {/if}

      </div>

      {include "file:chunks/guarantees.tpl"}
    </div>

    {if $_modx->context.key == "kraska" && $_modx->resource.parent in list $_modx->runSnippet("@FILE snippets/getCategoriesListIds.php", ['parent' => '125345,117397']) }
        <div class="infoblocks__container calculator-kraski">
            {include "file:chunks/calculator-kraski.tpl"}
        </div>
    {/if}

  </article>

  {$recommendProducts?: ''}
  {$simillarProducts ?: ''}

  {if $_modx->context.key == "krovelnyjstroymarket"}
    {include "file:sections/faq.tpl"}
  {/if}

  {include "file:sections/payment.tpl"}
  {include "file:sections/contacts.tpl" styleClass='section_view_bg'}

{/block}
