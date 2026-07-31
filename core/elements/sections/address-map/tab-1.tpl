{if $_modx->getPlaceholder("virtual-router")["warehouses"]}
  {set $contacts = [
      'warehouse' => $_modx->getPlaceholder("virtual-router")["warehouses"]
  ]}
{else}
  {set $storehouses = '@FILE snippets/warehouses/getFirstStorehouses.php' | snippet}
  {set $storehouses_phone = $_modx->getPlaceholder('contacts.phone')}
  {set $contacts = [
    'warehouse' => [
        ['title' => 'Телефон склада: '~$storehouses.0,'additional' => '1','phone' => $storehouses_phone],
        ['title' => 'Телефон склада: '~$storehouses.1,'additional' => '2','phone' => $storehouses_phone],
        ['title' => 'Телефон склада: '~$storehouses.2,'additional' => '3','phone' => $storehouses_phone],
    ]
  ]}
{/if}

<div class="address-map__row">
  <div class="address-map__contacts">
    <div class="fw-700 fs-20">Режим работы складов: 8:00 - 21:00</div>
    {foreach $contacts['warehouse'] as $item}
      {if $item['phone'] && $item['phone'] != '+7 (000) 000-00-00'}
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
          {set $phone = $item['phone'] ?: $_modx->getPlaceholder('contacts.phone')}
          {set $add = $item['additional'] ?: ''}
          {$phone}{$add?', доб '~$add:''}
        </div>
      </div>
    </a>
      {else}
        <div style="height:84px"></div>
      {/if}
    {/foreach}

    <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">Узнать наличие материала на ближайшем складе</button>
  </div>

  <div class="address-map__map" id="districts_map"></div>
</div>
