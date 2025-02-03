<section class="advantages-section section">
  <div class="advantages-section__container">
    <div class="about-zbi section">
      <div class="about-zbi__left">
        <div class="about-zbi__text">
          <h2 class="about-zbi__title">Работаем на рынке ЖБИ с 2010 года</h2>
          <p>Производим широкий перечень продукции и постоянно увеличиваем ассортимент изделий для более полного удовлетворения потребительского спроса.</p>
        </div>
      </div>
      <div class="about-zbi__right">
        <div class="about-zbi__swiper">
          {set $images = '@FILE snippets/migx/getGallery.php' | snippet : ['tvname' => 'aboutGalleryMigx']}
          {if $images}
            <div class="swiper">
              <div class="swiper-wrapper">
                  {foreach $images as $img}
                    {set $thumb = 'phpthumbon' | snippet : [
                      'input' => "{$img}",
                      'options' => '&w=400&h=200&zc=1'
                    ]}
                    <div class="swiper-slide about-zbi__slide">
                      <div class="about-zbi__slide-wrapper">
                        <a data-fancybox="about-gallery" href="{$img}"><img src="{$thumb}" alt="" /></a>
                      </div>
                    </div>
                  {/foreach}
              </div>
            </div>
          
            <div class="about-zbi-nav">
              <div class="about-zbi-button-prev swiper-button-prev"></div>
              <div class="about-zbi-button-next swiper-button-next"></div>
            </div>
          {/if}
        </div>
      </div>
    </div>
  </div>
</section>
