{* TODO: Наверно, надо переделать. Сделать выбор лица не через JS, а через HTML и табы *}

<div class="popup popup_type_order js-thanks" id="order">
  <div class="popup__block">
    <div class="popup__content">
      <form method="POST" action class="popup__form form">
        <h3 class="title-2 form__title">Оформление заказа</h3>
        <input type="text" name="MOBILEPHONE" class="secret">

        <div class="form__items form__items_double" data-dependence>
          <input type="hidden" name="CUSTOMER-TYPE" value="Физическое лицо" data-dependence-value>
          <div class="tab-radio form__item">
            <input value="Физическое лицо" class="tab-radio__input" type="radio" id="order-radio-1" name="CUSTOMER-TYPE" checked="checked" data-influent>
            <label class="tab-radio__label" for="order-radio-1">Физическое лицо</label>
          </div>
          <div class="tab-radio form__item">
            <input value="Юридическое лицо" class="tab-radio__input" type="radio" id="order-radio-2" name="CUSTOMER-TYPE" data-influent>
            <label class="tab-radio__label" for="order-radio-2">Юридическое лицо</label>
          </div>

          <div class="default-input form__item form__item_wide" data-dependent="order-radio-1">
            <input class="default-input__input" name="CUSTOMER"  placeholder="ФИО получателя">
            <span class="error_CUSTOMER">[[!+fi.error.CUSTOMER]]</span>
          </div>
          <div style="display: none;" class="default-input form__item form__item_wide" data-dependent="order-radio-2">
            <input disabled class="default-input__input" name="COMPANY"  placeholder="Название компании">
            <span class="error_COMPANY">[[!+fi.error.COMPANY]]</span>
          </div>

          <div class="default-input form__item">
            <input class="default-input__input" name="MAIL"  placeholder="Email">
            <span class="error_MAIL">[[!+fi.error.MAIL]]</span>
          </div>
          <div class="default-input valid form__item">
            <input class="default-input__input" name="PHONE" placeholder="Мобильный телефон" >
            <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
          </div>
        </div>

        <p class="form__title">Способы оплаты:</p>
        <div class="form__radios">
          <div class="default-radio">
            <input class="default-radio__input" type="radio" id="order-radio-3" name="PAYMENT" checked="checked">
            <label class="default-radio__label" for="order-radio-3">Наличными при получении</label>
            <div class="default-input__error"></div>
          </div>
          <div class="default-radio">
            <input class="default-radio__input" type="radio" id="order-radio-4" name="PAYMENT">
            <label class="default-radio__label" for="order-radio-4">Банковской картой</label>
            <div class="default-input__error"></div>
          </div>
          <div class="default-radio">
            <input class="default-radio__input" type="radio" id="order-radio-5" name="PAYMENT">
            <label class="default-radio__label" for="order-radio-5">Сбербанк Онлайн</label>
          </div>
        </div>

        <p class="form__title">Адрес доставки:</p>
        <div class="form__items form__items_double">
          <div class="default-input form__item">
            <input class="default-input__input" name="CITY"  placeholder="Город">
          </div>
          <div class="default-input form__item">
            <input class="default-input__input" name="STREET" placeholder="Улица">
          </div>
        </div>
        <div class="form__submit form__submit_row">
          <div class="default-checkbox form__suggestion">
            <input class="default-checkbox__input" type="checkbox" id="checkbox-order" checked name="privacy">
            <label class="default-checkbox__label" for="checkbox-order">
              <span class="default-checkbox__label-text">Согласен(на) с <a data-fancybox data-type="ajax" data-src="/confidential/" class="popup__privacy-link link">политикой конфиденциальности</a> сайта</span>
            </label>
          </div>
          <button class="btn btn_style_shadow" type="submit">Оформить заказ</button>
        </div>
      </form>
    </div>
  </div>
</div>
