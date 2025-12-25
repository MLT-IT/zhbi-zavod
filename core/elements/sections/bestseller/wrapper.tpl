<div class="section-padding bg-light-gray-2">
  <div class="container">
    <h2 class="section-title">Хит продаж</h2>

        <div class="swiper" data-slider="default-product-slider">
            <div class="swiper-wrapper">
              {'@FILE snippets/getBestsellerProducts.php' | snippet : [
                'tpl' => '@FILE modules/product-cards/chunks/v2/wrapper.tpl',
                'limit' => 42,
              ]}
            </div>

            <div class="swiper-button-prev base-box-shadow"></div>
            <div class="swiper-button-next base-box-shadow"></div>
        </div>

  </div>
</div>
