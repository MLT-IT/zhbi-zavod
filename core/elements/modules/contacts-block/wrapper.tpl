{set $warehouses = '@FILE modules/contacts-block/snippets/getWarehouses.php' | snippet}
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
            {foreach $warehouses.stores as $warehouse}
              <div class="contact">
              <svg class="contact__icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
              </svg>
              <div class="contact__content">
                <p class="contact__title">Телефон склада в {$warehouse.case}:</p>
                <p class="contact__value">{$warehouse.phone}</p>
              </div><a class="contact__link" href="tel:{$warehouse.phone | ereplace : '/доб \d+/i' : '' | ereplace : '/[^0-9+]/i' : ''}"></a>
            </div>
            {/foreach}
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
                {set $addr = 'address' | option}
                {if $_modx->getPlaceholder('localdata').local}
                  {set $addr = $_modx->getPlaceholder('localdata').offices.0.address}
                {/if}
                <p class="contact__value">{$addr}</p>
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
              <div class="contact__content contact_type_mail">
                <p class="contact__title">Почта для связи:</p>
                <p class="contact__value"><span itemprop="email">{'email' | option}</span></p>
              </div><a class="contact__link" href="mailto:{'email' | option}"></a>
            </div>
          </address><span class="contacts__availability btn btn_style_base" data-fancybox data-src="#availability">Узнать наличие материала на ближайшем складе</span>
        </div>
        <div class="contacts__map shadow-map" data-map-script="contacts-map-2">
            {if $_modx->getPlaceholder('localdata').local}
              {if $_modx->getPlaceholder('localdata').offices.0.ymap}
                <script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%{$_modx->getPlaceholder('localdata').offices.0.ymap}&amp;width=460&amp;height=400&amp;lang=ru_RU&amp;scroll=true"></script>
              {else}
                <iframe src="https://www.google.com/maps/d/u/0/embed?mid={$_modx->getPlaceholder('localdata').offices.0.gmap}" width="640" height="480"></iframe>
              {/if}
            {else}
              {'map_office' | option}
            {/if}
        </div>
      </div>
    </div>
  </div>
</article>
