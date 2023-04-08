{extends "file:layouts/default.layout.tpl"}

{block "page"}
      <main class="layout__main">

        {include "file:chunks/breadcrumbs.tpl" styleClass='bg-gray'}

        <article class="main-screen section">
          <div class="main-screen__container">
            <div class="main-screen__banners">
              <div class="main-screen__slider">
                <div class="swiper-container">
                  <div class="swiper-wrapper">
                    <div class="swiper-slide banner">
                      <picture class="banner__bg">
                        <source srcset="assets/template/pictures/main-screen/main-screen-mob.jpg" media="(max-width: 480px)"><img class="banner__bg-img" src="assets/template/pictures/main-screen/main-screen.jpg" alt="banner">
                      </picture>
                      <h2 class="banner__title">Закажите блоки сейчас<br> со <span class="text-highlighter">скидкой</span> — стройте весной</h2>
                      <p class="banner__text">Акция до конца месяца</p>
                      <div class="banner__action"><span data-fancybox class="banner__btn btn btn_style_yellow" data-src="#callback">Заказать со скидкой</span></div>
                    </div>
                    <div class="swiper-slide banner">
                      <picture class="banner__bg">
                        <source srcset="assets/template/pictures/main-screen/main-screen-mob.jpg" media="(max-width: 480px)"><img class="banner__bg-img" src="assets/template/pictures/main-screen/main-screen.jpg" alt="banner">
                      </picture>
                      <h2 class="banner__title">Закажите блоки сейчас<br> со <span class="text-highlighter">скидкой</span> — стройте весной</h2>
                      <p class="banner__text">Акция до конца месяца</p>
                      <div class="banner__action"><span data-fancybox class="banner__btn btn btn_style_yellow" data-src="#callback">Заказать со скидкой</span></div>
                    </div>
                    <div class="swiper-slide banner">
                      <picture class="banner__bg">
                        <source srcset="assets/template/pictures/main-screen/main-screen-mob.jpg" media="(max-width: 480px)"><img class="banner__bg-img" src="assets/template/pictures/main-screen/main-screen.jpg" alt="banner">
                      </picture>
                      <h2 class="banner__title">Закажите блоки сейчас<br> со <span class="text-highlighter">скидкой</span> — стройте весной</h2>
                      <p class="banner__text">Акция до конца месяца</p>
                      <div class="banner__action"><span data-fancybox class="banner__btn btn btn_style_yellow" data-src="#callback">Заказать со скидкой</span></div>
                    </div>
                  </div>
                  <div class="swiper-pagination"></div>
                </div>
                <div class="swiper-buttons">
                  <div class="swiper-button swiper-button-prev"></div>
                  <div class="swiper-button swiper-button-next"></div>
                </div>
              </div>
            </div>
          </div>
        </article>
        {include "file:sections/delivery.tpl"}
        {include "file:sections/faq.tpl"}
        {include "file:sections/payment.tpl"}
        {include "file:sections/contacts.tpl" styleClass='section_view_bg'}
      </main>
{/block}
