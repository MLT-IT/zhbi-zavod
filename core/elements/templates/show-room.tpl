{extends "file:layouts/default.layout.tpl"}

{block "page"}
  <main class="layout__main">

    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <article class="contacts contacts_separate section">
      <div class="contacts__container">
        {* <div class="contacts__top">
          <h1 class="contacts__title section__title">Контакты</h1>
        </div> *}

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

        {set $phone = '!virtual_phone' | snippet }
        {set $email = '@FILE snippets/utm/virtual_email.php' | snippet }
        {set $address = 'address' | option}
        {if $_modx->getPlaceholder('localdata').local}
          {set $address = $_modx->getPlaceholder('localdata').offices.0.address}
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
              {* <p class="contacts__text contacts__text_bold">Офис продаж</p> *}
              <address class="contacts__items">
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-location"></use>
                  </svg>
                  <div class="contact__content" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                    <p class="contact__title">Шоу-рум:</p>
                      <p class="contact__value">{$address}</p>
                      {* <p class="contact__value">Санкт-Петербург, ул. Руставели, 13, офис 458</p> *}
                  </div>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-calendar"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">График работы шоу-рума:</p>
                    <p class="contact__value">9:00 - 20:00</p>
                  </div>
                </div>
                <div class="contact contact_hover">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Номер телефона контактного центра:</p>
                    <p class="contact__value"><span itemprop="telephone">{$phone}</span>, доб 3</p>
                  </div><a class="contact__link" href="tel:{$phone | ereplace:'/[^0-9+]/':'' }"></a>
                </div>
                <div class="contact contact_hover contact_type_mail">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-email"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Почта для связи:</p>
                    <p class="contact__value"><span itemprop="email">{$email}</span></p>
                  </div><a class="contact__link" href="mailto:{$email}"></a>
                </div>
              </address>
              <span class="contacts__availability btn btn_style_base" data-fancybox data-src="#showRoom">Записаться на посещение</span>
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

    <article class="show-room section">
      <div class="show-room__container">
        <h1 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h1>
        <div class="content">
            {$_modx->resource.content}
        </div>
      </div>
    </article>

    <article class="show-room section">
      <div class="show-room__container">
        <h1 class="margin-bottom-md section__title">Фотографии шоу-рума</h1>
        {include 'file:chunks/show-room/show-room-gallery.tpl'}
      </div>
    </article>  

    <article class="show-room section">
      <div class="show-room__container">
        {* <h1 class="margin-bottom-md section__title">BANNER</h1> *}
          {include 'file:chunks/show-room/banner-showroom.tpl'}
      </div>
    </article>  

  </main>
{/block}
