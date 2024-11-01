<div class="main-screen__banners">
    <div class="main-screen__slider">
      <div class="swiper-container">
        <div class="swiper-wrapper">
          <div class="swiper-slide banner">
            <picture class="banner__bg">
              <source srcset="assets/template/pictures/main-screen/{$_modx->resource.context_key}/main-screen-mob.jpg" media="(max-width: 480px)"><img class="banner__bg-img" src="assets/template/pictures/main-screen/{$_modx->resource.context_key}/main-screen.jpg">
            </picture>
            <div class="banner__title">
                <span class="text-highlighter">Скидка 7%</span> при заказе<br>тротуарной плитки от 80 000 ₽
            </div>
            {*<p class="banner__text">Акция до конца месяца</p>*}
            <div class="banner__action">
                <span data-fancybox data-src="#callback" class="banner__btn btn btn_style_yellow">Заказать со скидкой</span>
            </div>
          </div>

        </div>
        <div class="swiper-pagination"></div>
      </div>
    </div>

    {if $small_banner_hide}
    {else}
    <div class="main-screen__sub-slider">
      <div class="swiper-slide banner banner_sm">
        <picture class="banner__bg"><img class="banner__bg-img" src="assets/template/pictures/main-screen/{$_modx->resource.context_key}/main-screen-sm.jpg"></picture>
        <span class="banner__title">Ликвидация склада успей забрать!</span>
        <div class="banner__action">
            <a class="banner__btn btn btn_style_yellow" href="/rasprodazha-so-sklada/">подробнее</a></div>
      </div>
    </div>
    {/if}
  </div>
  