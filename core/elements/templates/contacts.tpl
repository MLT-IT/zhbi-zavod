{extends "file:layouts/default.layout.tpl"}

{block "page"}
  <main class="layout__main">

    {include "file:blocks/breadcrumbs.tpl"}

    <article class="contacts contacts_separate section">
      <div class="contacts__container">
        <div class="contacts__top">
          <h2 class="contacts__title section__title">Наши контакты</h2>
        </div>
        <div class="contacts__body">
          <div class="contacts__block">
            <div class="contacts__info">
              <p class="contacts__text contacts__text_bold">Режим работы складов: 8:00 - 21:00</p>
              <address class="contacts__items">
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Телефон склада в Мурино:</p>
                    <p class="contact__value">{'phone' | option}, доб 1</p>
                  </div><a class="contact__link" href="tel:{'phone' | option}"></a>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Телефон склада в Мурино:</p>
                    <p class="contact__value">{'phone' | option}, доб 2</p>
                  </div><a class="contact__link" href="tel:{'phone' | option}"></a>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Телефон склада в Мурино:</p>
                    <p class="contact__value">{'phone' | option}, доб 3</p>
                  </div><a class="contact__link" href="tel:{'phone' | option}"></a>
                </div>
              </address><span class="contacts__availability btn btn_style_base" data-fancybox data-src="#availability">Узнать наличие материала на ближайшем складе</span>
            </div>
            <div class="contacts__map"><script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3A9897d4d519ac0b96d53c1fe1657bd5a4f472e778fd55528a39aa276dbb7ce75e&amp;width=835&amp;height=450&amp;lang=ru_RU&amp;scroll=true"></script></div>
          </div>
          <div class="contacts__block">
            <div class="contacts__info">
              <p class="contacts__text contacts__text_bold">Офис продаж</p>
              <address class="contacts__items">
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-location"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Офис:</p>
                    <p class="contact__value">{'address' | option}</p>
                  </div>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-calendar"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">График работы офиса:</p>
                    <p class="contact__value">9:00 - 20:00</p>
                  </div>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Номер телефона контактного центра:</p>
                    <p class="contact__value">{'phone' | option}, доб 2</p>
                  </div><a class="contact__link" href="tel:{'phone' | option}"></a>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-email"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Почта для связи:</p>
                    <p class="contact__value">{'email' | option}</p>
                  </div><a class="contact__link" href="mailto:{'email' | option}"></a>
                </div>
              </address><span class="contacts__availability btn btn_style_base" data-fancybox data-src="#availability">Узнать наличие материала на ближайшем складе</span>
            </div>
            <div class="contacts__map"><script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3A9897d4d519ac0b96d53c1fe1657bd5a4f472e778fd55528a39aa276dbb7ce75e&amp;width=835&amp;height=450&amp;lang=ru_RU&amp;scroll=true"></script></div>
          </div>
        </div>
      </div>
    </article>

    <section class="advantages-section section">
      <div class="advantages-section__container">
          {include "file:sections/advantages.tpl" styleClass='section'}
      </div>
    </section>
  </main>
{/block}
