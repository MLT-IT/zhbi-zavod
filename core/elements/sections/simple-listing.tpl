<article class="products-preview section">
  <div class="products-preview__container">
    <h2 class="section__title products-preview__title">Газобетон от наших производителей</h2>
    <div class="products-preview__slider">
      <div class="swiper-container">
        <div class="swiper-wrapper">
            {if $resources is empty}
                {* Если popular_ids не заполнено, то resources будет пустой. И будут выводиться все товары подряд *}
                {set $resources = $_modx->config['popular_ids']}
            {/if}
            {'!pdoResources' | snippet : [
              'parents' => 0,
              'depth' => 50,
              'limit' => 42,
              'sortby' => '',
              'sortdir' => '',
              'tpl' => '@FILE sections/popular/pop-slide.tpl',
              'where' => '{"template:=": "5"}',
              'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
              'context' => $_modx->resource.context_key
            ]}
        </div>
      </div>
      <div class="swiper-buttons">
        <div class="swiper-button swiper-button-prev"></div>
        <div class="swiper-button swiper-button-next"></div>
      </div>
    </div>
  </div>
</article>
