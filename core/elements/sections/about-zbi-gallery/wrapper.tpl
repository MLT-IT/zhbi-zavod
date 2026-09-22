<div class="about-zbi-gallery section-margin">
  <div class="container">
    <div class="about-zbi-gallery__row">
      <div class="about-zbi-gallery__text">
        <h2 class="section-title">{$title}</h2>
        <p>{$text}</p>
      </div>
      <div class="about-zbi-gallery__slider">
        <div class="swiper" data-slider="{$slider_id}">
          <div class="swiper-wrapper">
            {foreach $images as $image}
            <div class="swiper-slide">
              <a class="glightbox" data-gallery="{$slider_id}" href="{$image}">
                <img src="{$image}" loading="lazy" />
              </a>
            </div>
            {/foreach}
          </div>
          <div class="swiper-button-prev base-box-shadow"></div>
          <div class="swiper-button-next base-box-shadow"></div>
        </div>
      </div>
    </div>
  </div>
</div>
