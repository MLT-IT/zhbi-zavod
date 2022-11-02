<section class="product-slider product-slider-1 sect-pop">
    <div class="wrapper sect-pop__wrapper">
        <h2 class="sect-pop__title title-2">{$title ?: "Рекомендуемые товары"}</h2>
        <div class="swiper-buttons sect-pop__swiper-buttons" style="display: none;">
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
        </div>
        <div class="swiper-container">
            <div class="swiper-wrapper sect-pop__slider">
            {$output}
            <div class="swiper-scrollbar"></div>
        </div>
    </div>
</section>
