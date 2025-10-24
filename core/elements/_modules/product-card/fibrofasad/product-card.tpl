{set $relinkingStandart = '@FILE _modules/product-card/snippets/getGostTuOption.php' | snippet}
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
          <div class="product__info product-info custom">
            <div class="product-info__top">

              {set $flist = '@FILE _modules/product-card/snippets/getFeaturesList.php' | snippet: ['ctx' => $_modx->resource->context_key
               'delivery_date' => '+1 days' | date : 'd.m']}
              {if $flist}
              <ul class="product-info__features-list">
                {foreach $flist as $item}
                <li class="product-info__features-list-item">
                  <div class="product-info__features-list-icon-wrap">{$item.ico}</div> 
                  <div class="product-info__features-list-title-wrap">{$item.title}</div>
                </li>
                {/foreach}
              </ul>
              {/if}
            </div>
            <div class="product-info__bottom">
                {insert 'file:modules/color-list/blocks/color-list.tpl'}
                
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
