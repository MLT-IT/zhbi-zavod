{extends "file:layouts/default.layout.tpl"}

{block "page"}
  <main class="layout__main">

    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <article class="contacts contacts_separate section">
      <div class="contacts__container">
        <div class="contacts__top">
          <h1 class="contacts__title section__title">Контакты</h1>
        </div>

        {switch $_modx->resource.context_key}
          {case 'web'}
            {set $text = 'утеплителей'}
          {case 'gazosilikatstroy'}
            {set $text = 'газобетона'}
          {case 'kraska'}
            {set $text = 'ЛКМ (краски, эмали, шпатлевки)'}
          {case 'suhiesmesi'}
            {set $text = 'сухих смесей'}
          {case 'krovelnyjstroymarket'}
            {set $text = 'krovelnyjstroymarket'}
        {/switch}
        {if $_modx->context.key == 'web'}
            {set $site_context = 'alterteplo'}
        {else}
            {set $site_context = $_modx->context.key}
        {/if}

        {* >>> meta *}
        <meta itemprop="name" content="Продажа {$text} в Санкт-Петербурге">
        <meta itemprop="priceRange" content="От 250 RUB">
        <meta itemprop="image" content="/assets/template/img/favicons/{$site_context}/favicon.ico">
        <time itemprop="openingHours" datetime="Mo-Su 08:00−21:00">
        {* <<< meta *}

        <div class="contacts__body">
          <div class="contacts__block">
            <div class="contacts__info">
              <p class="contacts__text contacts__text_bold">Режим работы складов: 8:00 - 21:00</p>
              <address class="contacts__items">
                {set $storehouse1 = 'Мурино'}
                {set $storehouse2 = 'Красном Селе'}
                {set $storehouse3 = 'Гатчине'}

                <div class="contact contact_hover">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Телефон склада в {$storehouse1}:</p>
                    <p class="contact__value">{'phone' | option}, доб 1</p>
                  </div><a class="contact__link" href="tel:{'phone' | option}"></a>
                </div>
                <div class="contact contact_hover">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Телефон склада в {$storehouse2}:</p>
                    <p class="contact__value">{'phone' | option}, доб 2</p>
                  </div><a class="contact__link" href="tel:{'phone' | option}"></a>
                </div>
                <div class="contact contact_hover">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Телефон склада в {$storehouse3}:</p>
                    <p class="contact__value">{'phone' | option}, доб 3</p>
                  </div><a class="contact__link" href="tel:{'phone' | option}"></a>
                </div>
              </address><span class="contacts__availability btn btn_style_base" data-fancybox data-src="#availability">Узнать наличие материала на ближайшем складе</span>
            </div>
            <div class="contacts__map shadow-map" id="districts_map" data-map-script="districts_map"></div>
          </div>
          <div class="contacts__block">
            <div class="contacts__info">
              <p class="contacts__text contacts__text_bold">Офис продаж</p>
              <address class="contacts__items">
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-location"></use>
                  </svg>
                  <div class="contact__content" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                    <p class="contact__title">Офис:</p>
                    {if $_modx->getPlaceholder('localdata').local}
                      <p class="contact__value">{$_modx->getPlaceholder('localdata').offices.0.address}</p>
                    {else}
                      <p class="contact__value">{'address' | option}</p>
                    {/if}
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
                <div class="contact contact_hover">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Номер телефона контактного центра:</p>
                    <p class="contact__value"><span itemprop="telephone">{$_modx->getPlaceholder('localdata').offices.0.phone}</span>, доб 2</p>
                  </div><a class="contact__link" href="tel:{'phone' | option}"></a>
                </div>
                <div class="contact contact_hover contact_type_mail">
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
                    {if $_modx->getPlaceholder('localdata').local}
                      <iframe src="https://www.google.com/maps/d/u/0/embed?mid={$_modx->getPlaceholder('localdata').offices.0.gmap}" width="640" height="480"></iframe>
                    {else}
                      {'map_office' | option}
                    {/if}
            </div>
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
