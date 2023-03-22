<article class="contacts section{$styleClass ? ' ' ~ $styleClass : ''}">
  <div class="contacts__container" data-tabs="">
    <div class="contacts__top">
      <h2 class="contacts__title section__title">Адреса</h2>
      <div class="tabs">
        <ul class="tabs__list">
          <li class="tabs__item active" data-tab="склады">склады</li>
          <li class="tabs__item" data-tab="офис">офис</li>
        </ul>
      </div>
    </div>
    <div class="contacts__body">
      <div class="contacts__block active" data-tab-page="склады">
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
        <div class="contacts__map"><iframe src="https://yandex.ru/map-widget/v1/?lang=ru_RU&amp;scroll=true&amp;um=constructor%3A9897d4d519ac0b96d53c1fe1657bd5a4f472e778fd55528a39aa276dbb7ce75e" frameborder="0" allowfullscreen="true" width="835px" height="450px" style="display: block;"></iframe></div>
      </div>
      <div class="contacts__block" data-tab-page="офис">
        <div class="contacts__info">
          <p class="contacts__text contacts__text_bold">Режим работы складов: 8:00 - 21:00</p>
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
        <div class="contacts__map"><iframe src="https://yandex.ru/map-widget/v1/?lang=ru_RU&amp;scroll=true&amp;um=constructor%3A9897d4d519ac0b96d53c1fe1657bd5a4f472e778fd55528a39aa276dbb7ce75e" frameborder="0" allowfullscreen="true" width="835px" height="450px" style="display: block;"></iframe></div>
      </div>
    </div>
  </div>
</article>
