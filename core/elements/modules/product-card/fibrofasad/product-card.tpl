{set $relinkingStandart = '@FILE modules/product-card/snippets/getGostTuOption.php' | snippet}
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
          <div class="product__info product-info custom">
            <div class="product-info__top">

              <div class="product-info__rating rating product-info__rating--mobile">
                <ul class="rating__stars">
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                </ul>
                <span class="rating__reviews{if $reviewsCount > 0} rating__reviews_clickable{/if}">
                  {set $reviewsCount = $_modx->runSnippet('@FILE snippets/random.php', ['begin' => 1, 'end'=> 5, 'id' => $_modx->resource.id])}
                  {$reviewsCount}
                  {'@FILE snippets/formOfWord.php' | snippet : [
                    'n' => $reviewsCount,
                    'f1' => 'отзыв',
                    'f2' => 'отзыва',
                    'f5' => 'отзывов'
                  ]}
                </span>
              </div>

              {set $flist = '@FILE modules/product-card/snippets/getFeaturesList.php' | snippet: ['ctx' => $_modx->resource->context_key
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
              <hr class="product-info__splitter">

              <div class="product-info__pricevol-group">
                {insert 'file:modules/product-card/fibrofasad/chunks/product-info-volume.tpl'}
                {insert 'file:modules/product-card/fibrofasad/chunks/product-info-price.tpl'}
              </div>
              <hr class="product-info__splitter">
              <div class="product-info__actions">
                {include "file:chunks/product/product-elems.tpl" prodId=$_modx->resource.id}
              </div>
              <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Получить бесплатный расчет</button>
            </div>
          </div>
        
        </div>
      </div>
      
      </div>
    </div>
 </article>
