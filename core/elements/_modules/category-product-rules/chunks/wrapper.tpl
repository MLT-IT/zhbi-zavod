{if $rules = "@FILE _modules/category-product-rules/snippets/getRules.php" | snippet}
<div class="catprodrules section">
    <div class="catprodrules__container">
        <h2 class="other-products__title section__title">Похожие товары</h2>

            <article class="other-products" id="other-products">
                  <div class="other-products__slider">
                    <div class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
                      <div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
                        {'msProducts' | snippet : [
                            'parents' => $rules['parents'],
                            'optionFilters' => $rules['options'],
                            'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
                            'tplWrapper' => '@INLINE {$output}',
                            'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
                            'includeThumbs' => 'webp',
                        ]}
                      </div>
                    </div>
                    <div class="swiper-buttons">
                      <div class="swiper-button swiper-button-prev swiper-button-disabled"></div>
                      <div class="swiper-button swiper-button-next swiper-button-disabled"></div>
                    </div>
                  </div>
            </article>

    </div>
</div>
{/if}