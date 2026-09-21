<div class="product-page__gallery">
  <div
    class="swiper product-page__gallery-thumbs"
    data-slider="product-gallery-thumbs"
  >
    <div class="swiper-wrapper">
      {foreach $files as $file}
      <div class="swiper-slide">
        <img src="{$file['small']}" loading="lazy" />
      </div>
      {/foreach}
    </div>
    <div class="swiper-button-prev base-box-shadow"></div>
    <div class="swiper-button-next base-box-shadow"></div>
  </div>

  <div
    class="swiper product-page__gallery-preview"
    data-slider="product-gallery-preview"
  >
    <div class="product-page__gallery-preview__controls">
        {include "file:modules/store-product-selection/chunks/favorites/btn.tpl" product_id=$_modx->resource.id}
    </div>
    
    <div class="swiper-wrapper">
      {foreach $files as $file}
      <div class="swiper-slide">
        <a
          class="glightbox"
          data-gallery="product-gallery"
          href="{$file['url']}"
        >
          <img src="{$file['url']}" loading="lazy" data-fetch-image-insert="true"/>
        </a>
      </div>
      {/foreach}
    </div>
  </div>
</div>
