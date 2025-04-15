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
    {set $soput_options = [
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

    {* Сопутствующие товары гибкой черепице *}
    {if $isGibkaya}
      {set $soput_options['parents'] = '126015,125951,125554'}
      {set $soput_options['sortby'] = '{"parent":"DESC"}'}
      {set $soput_options['optionFilters'] = '{"palitra:=":"'~$_modx->resource.cvet[0]~'","proizvoditel:=":"'~$_modx->resource.proizvoditel[0]~'"}'}
    {/if}
      
    {* Сопутствующие товары профлист и профлист для забора *}
    {if $isProflist || $isMetalloCherepica}
      {set $soput_options['parents'] = '125533'}
      {set $soput_options['sortby'] = '{"parent":"DESC"}'}
      {set $soput_options['optionFilters'] = '{"cvet:=":"'~$_modx->resource.cvet[0]~'","proizvoditel:=":"'~$_modx->resource.proizvoditel[0]~'","pokrytie:=":"'~$_modx->resource.pokrytie[0]~'"}'}
    {/if}
    {* здесь вызываем *}
    {set $recommendProducts = 'msProducts' | snippet : $soput_options}
    {*  *}

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

<main class="layout__main" xmlns="http://www.w3.org/1999/html">
  <!-- custom product-plitnye.tpl -->
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
          {* {if $.get['mode'] == 'test' ?} *}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Калькулятор">Калькулятор</a>
          {* {/if} *}

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
                    'ignoreOptions' => 'edizm,edizm2,grandlineid'
                  ]}
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="infoblocks__block" data-tab-page="Калькулятор">
          <button class="infoblocks__block-title" data-tab="Калькулятор">Калькулятор</button>
          <div class="infoblocks__block-dropdown">
            <div id="wall-calc"
            data-count=".ms2_form [name='count']"
            data-key=".ms2_form [name='id']"
            data-id=".ms2_form [name='id']"
            data-add=".ms2_form [value='cart/add']"
            data-update=".ms2_form [value='cart/change']"
            data-incart={$prodValues['itemInCart']}
            ></div>
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
              {if $_modx->context.key in ['krovelnyjstroymarket']}
                {include 'file:_modules/mltreviews/chunks/product-page.tpl'}
              {else}
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
              {/if}
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
                                    {set $previewSrc = '@FILE: snippets/pdfToJpg.php' | snippet : [
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


  </article>

  {$recommendProducts?: ''}
  {$simillarProducts ?: ''}

  {include "file:sections/payment.tpl"}
  {include "file:sections/contacts.tpl" styleClass='section_view_bg'}

{/block}
