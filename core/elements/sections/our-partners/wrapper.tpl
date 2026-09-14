{set $imageDir = '/assets/template/img/clients'}
<section class="advantages-section section">
  <div class="advantages-section__container">
    <article class="our-partners">
      <h2 class="section__title margin-bottom-md">С нами работают</h2>
      <div class="swiper">
        <div class="swiper-wrapper">
          {foreach 1..10 as $i}
            <div class="swiper-slide our-partners__item">
              <img class="colortoggle" src="{$imageDir}/client{$i}.png" alt="">
            </div>
          {/foreach}
        </div>
      </div>
    </article>
  </div>
</section>
