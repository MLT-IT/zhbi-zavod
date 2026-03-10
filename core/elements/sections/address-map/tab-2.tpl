<div class="address-map__row">
  <div class="address-map__contacts">
    <div class="fw-700 fs-20">{$title_tab_2 ?: "Режим работы складов: 8:00 - 21:00"}</div>

    <div class="address-map__contacts-item">
      <svg class="contact__icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-location"></use>
      </svg>
      <div>
        <div class="address-map__contacts-item-title fw-700">Офис:</div>
        <div class="address-map__contacts-item-value">{$_modx->getPlaceholder('contacts.address')}</div>
      </div>
    </div>

    <div class="address-map__contacts-item">
      <svg class="contact__icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-calendar"></use>
      </svg>
      <div>
        <div class="address-map__contacts-item-title fw-700">График работы офиса:</div>
        <div class="address-map__contacts-item-value">{$_modx->getPlaceholder('contacts.opening_hours')}</div>
      </div>
    </div>

    <a class="address-map__contacts-item" href="tel:{$_modx->getPlaceholder('contacts.phone_href')}">
      <svg class="contact__icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-phone"></use>
      </svg>
      <div>
        <div class="address-map__contacts-item-title fw-700">Номер телефона контактного центра:</div>
        <div class="address-map__contacts-item-value">{$_modx->getPlaceholder('contacts.phone')}</div>
      </div>
    </a>

    <a class="address-map__contacts-item" href="mailto:{$_modx->getPlaceholder('contacts.email')}">
      <svg class="contact__icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-email"></use>
      </svg>
      <div>
        <div class="address-map__contacts-item-title fw-700">Почта для связи:</div>
        <div class="address-map__contacts-item-value">{$_modx->getPlaceholder('contacts.email')}</div>
      </div>
    </a>

    <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">Узнать наличие материала на ближайшем
      складе</button>
  </div>

  <div class="address-map__map">
    {if $_modx->getPlaceholder('virtual-router')['gmap']}
    <iframe src="https://www.google.com/maps/d/u/0/embed?mid={$_modx->getPlaceholder('virtual-router')['gmap']}"
      width="100%" height="480"></iframe>
    {else}
    <script type="text/javascript" charset="utf-8" async
      src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%{$_modx->getPlaceholder('virtual-router')['yandex_map']}&amp;width=100%&amp;height=100%&amp;lang=ru_RU&amp;scroll=true"></script>
    {/if}
  </div>
</div>