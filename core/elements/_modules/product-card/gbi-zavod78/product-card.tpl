{set $relinkingStandart = '@FILE _modules/product-card/getGostTuOption.php' | snippet}
<section class="section section_view_top">
  {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
  <article class="product section js-product not-init{if $prodValues['itemInCart']?} js-product-in-cart{/if}{if $prodValues['outputOldPrice']?} js-product_with-discount{/if}"
  {include "file:chunks/product/get-data-attrs.tpl"}
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
            {* {if $_modx->resource.article}
                <div class="product-info__article article mb-2"> Арт. {$_modx->resource.article} </div>
            {/if} *}
              <div class="product-info__rating rating mb-2 pc-flex">
                <a href="/otzyvy/" class="yandex-rating"><img src="/assets/images/zhbi500/yandex-badge.png" alt=""></a>
              </div>

              <div class="product-info__rating rating mb-2">
                <a href="/otzyvy/" class="yandex-rating mobile-flex"><img src="/assets/images/zhbi500/yandex-badge.png" alt=""></a>
                <div class="product-info__availability-title product-info__availability-title_zbi mobile-flex">
                  В наличии {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 100, 'end'=> 200])} шт.
                </div>
                <div class="product-info__availability-title product-info__availability-title_guard mobile-flex">
                  Контроль качества на каждом этапе
                </div>
                <div class="product-info__availability-title product-info__availability-title_fast mobile-flex">
                  Производство от&nbsp;<a href="/dostavka-i-oplata/">1 дня</a>
                </div>
              </div>

              <div class="product-info__relinkav show-tooltip">
                <div class="product-info__availability-title product-info__availability-title_zbi pc-flex">
                  В наличии {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 100, 'end'=> 200])} шт.
                  <div class="tooltip-white">
                    В среднем на нашем предприятии производится от 100 до 500 ЖБИ изделий в день.
                  </div>
                </div>
              </div>
              <div class="product-info__relinkav show-tooltip">
                <div class="product-info__availability-title product-info__availability-title_guard pc-flex">
                  Контроль качества на каждом этапе
                  <div class="tooltip-white">
                  Строгое соблюдение пропорций ЖБИ изделий на предприятии является для нас очень важным аспектом.
                  </div>
                </div>
              </div>
              <div class="product-info__relinkav">
                <div class="product-info__availability-title product-info__availability-title_fast pc-flex">
                  Производство от&nbsp;<a href="/dostavka-i-oplata/">1 дня</a>
                </div>
              </div>

              {* <div class="product-info__avstock">
                  <div class="product-info__availability-title product-info__availability-title_available pc-flex">
                    На складе {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 100, 'end'=> 200])} {$unit}
                  </div>
                  <div class="product-info__shipped pc-flex">
                      {'@FILE snippets/shippedToday.php' | snippet}
                  </div>
              </div> *}
            </div>
            
          
            <div class="product-info__bottom">
                {* Перелинковка характеристиками *}
                <div class="product-info__relinking relinking">

                    {if $relinkingStandart | length}

                      {set $standart = $_modx->resource.standart[0]}

                      <div class="relinking__title">
                          Стандарт:
                      </div>
                      <div class="relinking__wrapper">
                        <span class="relinking__item relinking__item_current">
                          {$standart}
                        </span>
                        {foreach $relinkingStandart as $peer}
                          <a class="relinking__item" href="{$_modx->makeUrl($peer['id'])}" title="{$peer['standart']}">
                            {$peer['standart']}
                          </a>
                        {/foreach}
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
                <div class="product-info__price-tooltip-wrapper">
                  <div class="tooltip">
                    <p class="tooltip__header">Снижение цены!</p>
                    <p class="tooltip__body">Мы регулярно снижаем цены на наши товары, чтобы покупка у нас была еще выгоднее!</p>
                    <span class="tooltip__close"></span>
                  </div>
                </div>
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

                {/if}
              </div>

              <div class="product-info__actions">
                {include "file:chunks/product/product-elems.tpl" prodId=$_modx->resource.id}
              </div>
              <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Купить в 1 клик</button>
            </div>
          </div>

          {* <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p> *}
        
        </div>
      </div>
      <div class="product__body product-subbody">
          <div class="product-subbody__left">
            {if $certs | length}
              <h3 class="title">Сертификаты</h3>
              <div class="certs-wrapper">
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
                                    'src' => '/assets/' ~ $ct.file,
                                    ]}
                                {elseif ($lastElem in list ['jpg','jpeg','png','gif','webp'])}
                                    {set $previewSrc = '/assets/' ~ $ct.file}
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
                                    href="/assets/{$ct.file}"></a>
                            {else}
                                <a class="certs-block__cert-preview{if $classToPreview?} {$classToPreview}{/if}" data-fancybox title="{$ct.name}"
                                    href="/assets/{$ct.file}">
                                    <img class="certs-block__cert-img" src="{$previewSrc}" alt="{$ct.name}">
                                </a>
                            {/if}
                        </li>
                    {/foreach}
                </ul>
              </div>
            {/if}
          </div>
          <div class="product-subbody__right">
            {include 'file:blocks/product/gbi-zavod78/action-banner.tpl'}
          </div>
      </div>

      
      </div>
    </div>
  </article>
</section>
