{set $banners = "@FILE snippets/view-promo-sliders.php" | snippet}


<article class="catalog-side-carousel">
  <div class="swiper">
    <div class="swiper-wrapper">

      {foreach $banners as $banner}
      <div class="swiper-slide">
        <picture>
          <source media="(max-width:320px)" srcset="/assets/template/banners/combo-vombo/{$banner['320']}">
          <source media="(max-width:725px)" srcset="/assets/template/banners/combo-vombo/{$banner['725']}">
          <img data-fancybox href="#callback" src="/assets/template/banners/combo-vombo/{$banner['base']}">
        </picture>
      </div>
      {/foreach}

    </div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
  </div>
</article>

