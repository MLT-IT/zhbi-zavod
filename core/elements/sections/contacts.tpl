<article class="contacts section{$styleClass ? ' ' ~ $styleClass : ''}" itemscope itemtype="http://schema.org/Organization">
  <meta itemprop="name" content="{'site_name' | option}">
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

            {if $_modx->getPlaceholder('localdata').region == "krasnodar"}
              {set $phone = $_modx->getPlaceholder('localdata').offices.0.phone}
            {else}
              {set $phone = 'phone'|config}
            {/if}

            {set $storehouses = '@FILE snippets/warehouses/getFirstStorehouses.php' | snippet}
            {set $storehouse1 = $storehouses.0}
            {set $storehouse2 = $storehouses.1}
            {set $storehouse3 = $storehouses.2}

            <div class="contact">
              <svg class="contact__icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
              </svg>
              <div class="contact__content">
                <p class="contact__title">Телефон склада: {$storehouse1}</p>
                <p class="contact__value">{$phone}, доб 1</p>
              </div><a class="contact__link" href="tel:{$phone}"></a>
            </div>
            <div class="contact">
              <svg class="contact__icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
              </svg>
              <div class="contact__content">
                <p class="contact__title">Телефон склада: {$storehouse2}</p>
                <p class="contact__value">{$phone}, доб 2</p>
              </div><a class="contact__link" href="tel:{$phone}"></a>
            </div>
            <div class="contact">
              <svg class="contact__icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
              </svg>
              <div class="contact__content">
                <p class="contact__title">Телефон склада: {$storehouse3}</p>
                <p class="contact__value">{$phone}, доб 3</p>
              </div><a class="contact__link" href="tel:{$phone}"></a>
            </div>
          </address><span class="contacts__availability btn btn_style_base" data-fancybox data-src="#availability">Узнать наличие материала на ближайшем складе</span>
        </div>
        <div class="contacts__map shadow-map" id="districts_map" data-map-script="districts_map"></div>
      </div>
      <div class="contacts__block" data-tab-page="офис">
        <div class="contacts__info">
          <p class="contacts__text contacts__text_bold">Режим работы складов: 8:00 - 21:00</p>
          <address class="contacts__items">
            <div class="contact">
              <svg class="contact__icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-location"></use>
              </svg>
              <div class="contact__content" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
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
                <p class="contact__value"><span itemprop="telephone">{$phone}</span>, доб 2</p>
              </div><a class="contact__link" href="tel:{$phone}"></a>
            </div>
            <div class="contact">
              <svg class="contact__icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-email"></use>
              </svg>
              <div class="contact__content">
                <p class="contact__title">Почта для связи:</p>
                <p class="contact__value"><span itemprop="email">{'email' | option}</span></p>
              </div><a class="contact__link" href="mailto:{'email' | option}"></a>
            </div>
          </address><span class="contacts__availability btn btn_style_base" data-fancybox data-src="#availability">Узнать наличие материала на ближайшем складе</span>
        </div>
        <div class="contacts__map shadow-map" data-map-script="contacts-map-2">
            {'map_office' | option}
        </div>
      </div>
    </div>
  </div>
</article>
