{if $_modx->getPlaceholder("virtual-router")["region"]["key"] === "krasnodar"}
  {set $contacts = [
      'warehouse' => [
          ['title' => 'Телефон склада в Краснодаре:','additional' => '1'],
          ['title' => 'Телефон склада в Армавире:','additional' => '2'],
          ['title' => 'Телефон склада в Адыгейске:','additional' => '3'],
      ]
  ]}
{elseif $_modx->getPlaceholder("virtual-router")["region"]["key"] === "msk"}
  {set $contacts = [
    'warehouse' => [
        ['title' => 'Телефон склада в Москве:','additional' => '1'],
        ['title' => 'Телефон склада в Одинцово:','additional' => '2'],
        ['title' => 'Телефон склада в Раменском:','additional' => '3'],
    ]
  ]}
{else}
  {set $contacts = [
    'warehouse' => [
        ['title' => 'Телефон склада в Мурино:','additional' => '1'],
        ['title' => 'Телефон склада в Красном Селе:','additional' => '2'],
        ['title' => 'Телефон склада в Гатчине:','additional' => '3'],
    ]
  ]}
{/if}

<div class="address-map__row">
  <div class="address-map__contacts">
    <div class="fw-700 fs-20">Режим работы складов: 8:00 - 21:00</div>
    {foreach $contacts['warehouse'] as $item}
    <a
      class="address-map__contacts-item"
      href="tel:{$_modx->getPlaceholder('contacts.phone_href')}"
    >
      <svg class="contact__icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-phone"></use>
      </svg>
      <div>
        <div class="address-map__contacts-item-title fw-700">
          {$item['title']}
        </div>
        <div class="address-map__contacts-item-value">
          {$_modx->getPlaceholder('contacts.phone')}, доб {$item['additional']}
        </div>
      </div>
    </a>
    {/foreach}

    <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">Узнать наличие материала на ближайшем складе</button>
  </div>

  <div class="address-map__map" id="districts_map"></div>
</div>
