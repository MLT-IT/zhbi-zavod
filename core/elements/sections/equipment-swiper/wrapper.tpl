<section class="advantages-section section">
  <div class="advantages-section__container">
    <h2 class="advantages-section__title section__title">Наше оборудование</h2>
    <div class="equipment section">
      <div class="equipment__text">
        <p>На заводах компании «Строймаркет» установлено высокотехнологичное оборудование. Наши производственные
          мощности помогают нам создавать качественные ЖБИ — сваи, колодезные кольца, ригели, плиты перекрытия и многое
          другое.</p>
      </div>
      <div class="equipment__swiper">
        <div class="swiper">
          <div class="swiper-wrapper">
            {set $images = '@FILE snippets/migx/getGallery.php' | snippet : ['path' => '/assets', 'tvname' => 'objectsGalleryMigx']}
            {if $images}
              {foreach $images as $img}
                {set $thumb = 'phpthumbon' | snippet : [
                  'input' => "{$img}",
                  'options' => '&w=450&h=300&zc=1'
                ]}
                <div class="swiper-slide equipment__slide">
                  <div class="equipment__slide-wrapper">
                    <a data-fancybox="postavki" href="{$img}"><img src="{$thumb}" alt="" /></a>
                  </div>
                </div>
              {/foreach}
            {/if}
          </div>
        </div>
        <div class="equipment-nav">
          <div class="equipment-button-prev swiper-button-prev"></div>
          <div class="equipment-button-next swiper-button-next"></div>
        </div>
      </div>
    </div>
  </div>
</section>
