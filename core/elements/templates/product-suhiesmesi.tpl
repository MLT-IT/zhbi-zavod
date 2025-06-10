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
    {set $certs = $_modx->resource.certs | fromJSON}

    {if $certs | count > 0}
        {set $renderCerts = 1}
    {/if}
{/if}

{* Получаем отзывы товара *}

{set $reviews = '@FILE snippets/getReviews.php' | snippet | fromJSON}
{set $reviewsCount = $reviews | count}


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

<main class="layout__main" xmlns="http://www.w3.org/1999/html">
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

                      {include "file:_modules/warehouses/sections/warehouse-remains.tpl"}
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
                
             {"@FILE _modules/restrictions/restrictions.php" | snippet}
             
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

          {if $_modx->resource.recommendForUse != "" && $_modx->context.key in list ['suhiesmesi']}
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
                    'ignoreOptions' => 'edizm,edizm2,grandlineid'
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

               {include 'file:_modules/mltreviews/chunks/product-page.tpl'}

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
{* 
    {if $_modx->context.key == "kraska" && $_modx->resource.parent in list $_modx->runSnippet("@FILE snippets/getCategoriesListIds.php", ['parent' => '125345,117397']) }
        <div class="infoblocks__container calculator-kraski">
            {include "file:chunks/calculator-kraski.tpl"}
        </div>
    {/if} *}

  </article>

  {$recommendProducts ?: ''}
  {$simillarProducts ?: ''}

  

  {$similarsamples}
  {* {include "file:sections/product-advantages/wrapper.tpl"} *}
  {include "file:sections/faq.tpl"}

  {include "file:sections/payment.tpl"}

  {* <section style="padding-bottom: 0;">
    {include "file:sections/calculator-banner/wrapper.tpl"}
  </section> *}

  {include "file:sections/contacts.tpl" styleClass='section_view_bg'}

{/block}
