<section class="warehouse-contacts">
  <div class="warehouse-contacts__contacts">
    <h2 class="warehouse-contacts__title">{$_modx->resource.pagetitle}</h2>
    <ul class="warehouse-contacts__list">
      <li class="warehouse-contacts__item">
        <div class="warehouse-contacts__item-title">Адрес</div>
        <div class="warehouse-contacts__item-value">
          {$_modx->getPlaceholder('contacts.address')}
        </div>
      </li>
      <li class="warehouse-contacts__item">
        <div class="warehouse-contacts__item-title">Часы работы</div>
        <div class="warehouse-contacts__item-value">
          Ежедневно с 8:00 до 21:00
        </div>
      </li>
      <li class="warehouse-contacts__item">
        <div class="warehouse-contacts__item-title">Телефон</div>
        <a
          class="warehouse-contacts__item-value"
          href="tel:{$_modx->getPlaceholder('contacts.href_phone')}"
        >
          {$_modx->getPlaceholder('contacts.phone')},
          доб.{$_modx->resource.warehouse_additional_number}
        </a>
      </li>
    </ul>
    <div class="warehouse-contacts__controls">
      <button
        class="btn btn-primary"
        onclick="modals.events.open('modal-callback')"
      >
        РАССЧИТАТЬ СТОИМОСТЬ ДОСТАВКИ
      </button>
      <button
        class="btn btn-bordered"
        onclick="modals.events.open('modal-callback')"
      >
        ОСТАВИТЬ ЗАЯВКУ НА САМОВЫВОЗ
      </button>
    </div>
  </div>
  <div class="warehouse-contacts__photo">
    <img src="{$_modx->resource.main_image}" />
  </div>
</section>
