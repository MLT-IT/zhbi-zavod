<div class="delivery-material bg-light-gray-2">
  <div class="container">
    <div class="delivery-material__row">
      <div class="delivery-material__main">
        <div class="delivery-material__title fs-25 fw-700">Условия доставки материала</div>
        <div class="delivery-material__text fs-18">
          Доставка стройматерилов по Санкт-Петербургу осуществляется по
          следующему тарифу (условия по ЛО уточняйте у менеджера):
        </div>
        {include "file:chunks/delivery-table.tpl"}

        <div class="delivery-material__controls sm-d-block">
            <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">
                Заказать с доставкой
            </button>
        </div>
      </div>

      {include "file:sections/advantages/vertical/wrapper.tpl"}
    </div>

    <div class="delivery-material__controls sm-d-none">
        <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">
            Заказать с доставкой
        </button>
    </div>
  </div>
</div>
