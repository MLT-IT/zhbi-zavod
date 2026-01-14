<div class="address-map__row">
  <div class="address-map__contacts">
    <div class="address-map__contacts-item">
      <svg class="contact__icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-location"></use>
      </svg>
      <div>
        <div class="address-map__contacts-item-title fw-700">Шоу-рум:</div>
        <div class="address-map__contacts-item-value">{$_modx->getPlaceholder('contacts.address')}
        </div>
      </div>
    </div>

    <div class="address-map__contacts-item">
      <svg class="contact__icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-calendar"></use>
      </svg>
      <div>
        <div class="address-map__contacts-item-title fw-700">График шоу-рума:</div>
        <div class="address-map__contacts-item-value">
          {$_modx->getPlaceholder('contacts.opening_hours')}
        </div>
      </div>
    </div>

    <a class="address-map__contacts-item" href="tel:{$_modx->getPlaceholder('contacts.phone_href')}">
      <svg class="contact__icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-phone"></use>
      </svg>
      <div>
        <div class="address-map__contacts-item-title fw-700">Номер телефона контактного центра:
        </div>
        <div class="address-map__contacts-item-value">{$_modx->getPlaceholder('contacts.phone')}
        </div>
      </div>
    </a>

    <a class="address-map__contacts-item" href="mailto:{$_modx->getPlaceholder('contacts.email')}">
      <svg class="contact__icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-email"></use>
      </svg>
      <div>
        <div class="address-map__contacts-item-title fw-700">Почта для связи:</div>
        <div class="address-map__contacts-item-value">{$_modx->getPlaceholder('contacts.email')}
        </div>
      </div>
    </a>

    <button style="padding: 16px 20px;" class="btn btn-primary"
      onclick="modals.events.open('modal-callback')">Записаться на посещение</button>
  </div>

  <div class="address-map__map">
    {if $_modx->getPlaceholder('virtual-router')['gmap']}
    {$_modx->getPlaceholder('virtual-router')['gmap']}
    {else}
    <script type="text/javascript" charset="utf-8" async
      src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%{$_modx->getPlaceholder('virtual-router')['yandex_map']}&amp;width=100%&amp;height=100%&amp;lang=ru_RU&amp;scroll=true"></script>
    {/if}
  </div>
</div>