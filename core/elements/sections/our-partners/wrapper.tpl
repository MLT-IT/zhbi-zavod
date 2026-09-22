{set $clients = [1,2,3,4,5,6,7,8,9,10]}

<div class="our-partners section-margin">
  <div class="container">
    <h2 class="section-title">С нами работают</h2>
    <div class="swiper" data-slider="our-partners-slider">
      <div class="swiper-wrapper">
        {foreach $clients as $client}
        <div class="swiper-slide our-partners__slide">
          <img src="/assets/template/images/clients/client{$client}.png" alt="Партнёр" loading="lazy" />
        </div>
        {/foreach}
      </div>
    </div>
  </div>
</div>
