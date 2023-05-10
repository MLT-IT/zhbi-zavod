<div class="main-screen__banners">
  <div class="main-screen__slider">
    <div class="swiper-container">
      <div class="swiper-wrapper">
        <div class="swiper-slide banner">
          <picture class="banner__bg">
            <source srcset="assets/template/pictures/main-screen/main-screen-mob.jpg" media="(max-width: 480px)"><img class="banner__bg-img" src="assets/template/pictures/main-screen/main-screen.jpg" alt="banner">
          </picture>
          <div class="banner__title">
            {switch $_modx->resource.context_key}
              {case 'web'}
                {set $text = 'Закажите утеплитель сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
              {case 'gazosilikatstroy'}
                {set $text = 'Закажите газобетон сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на манипулятор'}
            {/switch}
            {$text}
          </div>
          <p class="banner__text">Акция до конца месяца</p>
          <div class="banner__action"><span data-fancybox data-src="#callback" class="banner__btn btn btn_style_yellow">Заказать со скидкой</span></div>
        </div>
        {*
        <div class="swiper-slide banner">
          <picture class="banner__bg">
            <source srcset="assets/template/pictures/main-screen/main-screen-mob.jpg" media="(max-width: 480px)"><img class="banner__bg-img" src="assets/template/pictures/main-screen/main-screen.jpg" alt="banner">
          </picture>
          <h2 class="banner__title">Закажите блоки сейчас<br> со <span class="text-highlighter">скидкой</span> — стройте весной</h2>
          <p class="banner__text">Акция до конца месяца</p>
          <div class="banner__action"><span data-fancybox data-src="#callback" class="banner__btn btn btn_style_yellow">Заказать со скидкой</span></div>
        </div>
        <div class="swiper-slide banner">
          <picture class="banner__bg">
            <source srcset="assets/template/pictures/main-screen/main-screen-mob.jpg" media="(max-width: 480px)"><img class="banner__bg-img" src="assets/template/pictures/main-screen/main-screen.jpg" alt="banner">
          </picture>
          <h2 class="banner__title">Закажите блоки сейчас<br> со <span class="text-highlighter">скидкой</span> — стройте весной</h2>
          <p class="banner__text">Акция до конца месяца</p>
          <div class="banner__action"><span data-fancybox data-src="#callback" class="banner__btn btn btn_style_yellow">Заказать со скидкой</span></div>
        </div>
        *}
      </div>
      <div class="swiper-pagination"></div>
    </div>
    <div class="swiper-buttons">
      <div class="swiper-button swiper-button-prev"></div>
      <div class="swiper-button swiper-button-next"></div>
    </div>
  </div>
  <div class="main-screen__sub-slider">
    <div class="swiper-slide banner banner_sm">
      <picture class="banner__bg"><img class="banner__bg-img" src="assets/template/pictures/main-screen/main-screen-sm.jpg" alt="banner"></picture>
      <h2 class="banner__title">Ликвидация склада успей забрать!</h2>
      <div class="banner__action"><a class="banner__btn btn btn_style_yellow" href="/akcii/likvidacziya-sklada-uspej-zabrat/">подробнее</a></div>
    </div>
  </div>
</div>
