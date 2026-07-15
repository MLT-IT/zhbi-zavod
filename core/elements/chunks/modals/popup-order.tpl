<div class="popup popup_type_order js-thanks" id="order">
  <div class="popup__block">
    <div class="popup__content" data-forms-wrapper>

      <form method="POST" action class="popup__form" data-form="Физическое лицо" data-active="1">
        <div class="form">
          <h3 class="title-2 form__title">Оформление заказа</h3>
          <input type="text" name="MOBILEPHONE" class="secret">

          <div class="form__items form__items_double">
            <input type="hidden" name="CUSTOMER-TYPE" value="Физическое лицо">
            <div class="tab-radio form__item">
              <input value="Физическое лицо" class="tab-radio__input" type="radio" id="order-radio-1" name="CUSTOMER-TYPE" checked="checked">
              <label class="tab-radio__label" for="order-radio-1">Физическое лицо</label>
            </div>
            <div class="tab-radio form__item">
              <input value="Юридическое лицо" class="tab-radio__input" type="radio" id="order-radio-2" name="CUSTOMER-TYPE">
              <label class="tab-radio__label" for="order-radio-2">Юридическое лицо</label>
            </div>

            <div class="default-input form__item form__item_wide">
              <input class="default-input__input" name="CUSTOMER"  placeholder="ФИО получателя">
              <span class="error_CUSTOMER">[[!+fi.error.CUSTOMER]]</span>
            </div>
            <div style="display: none;" class="default-input form__item form__item_wide">
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
              <input value="Наличными при получении" class="default-radio__input" type="radio" id="order-radio-3" name="PAYMENT" checked="checked">
              <label class="default-radio__label" for="order-radio-3">Наличными при получении</label>
              <div class="default-input__error"></div>
            </div>
            <div class="default-radio">
              <input value="Банковской картой" class="default-radio__input" type="radio" id="order-radio-4" name="PAYMENT">
              <label class="default-radio__label" for="order-radio-4">Банковской картой</label>
              <div class="default-input__error"></div>
            </div>
            <div class="default-radio">
              <input value="Банковский перевод" class="default-radio__input" type="radio" id="order-radio-5" name="PAYMENT">
              <label class="default-radio__label" for="order-radio-5">Банковский перевод</label>
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
              <input class="default-checkbox__input" type="checkbox" id="privacy-order-person" name="privacy">
              <label class="default-checkbox__label" for="privacy-order-person">
                <span class="default-checkbox__label-text">Согласен(на) с <a data-fancybox data-type="ajax" data-src="/confidential/" class="popup__privacy-link link">политикой конфиденциальности</a> сайта</span>
              </label>
            </div>
            <button class="btn btn_style_shadow" type="submit">Оформить заказ</button>
          </div>
        </div>
      </form>

      <form method="POST" action class="popup__form" data-form="Юридическое лицо">
        <div class="form">
          <h3 class="title-2 form__title">Оформление заказа</h3>
          <input type="text" name="MOBILEPHONE" class="secret">

          <div class="form__items form__items_double">
            <input type="hidden" name="CUSTOMER-TYPE" value="Физическое лицо">
            <div class="tab-radio form__item">
              <input value="Физическое лицо" class="tab-radio__input" type="radio" id="order-radio-1" name="CUSTOMER-TYPE">
              <label class="tab-radio__label" for="order-radio-1">Физическое лицо</label>
            </div>
            <div class="tab-radio form__item">
              <input value="Юридическое лицо" class="tab-radio__input" type="radio" id="order-radio-2" name="CUSTOMER-TYPE" checked="checked">
              <label class="tab-radio__label" for="order-radio-2">Юридическое лицо</label>
            </div>

            <div class="default-input form__item form__item_wide">
              <input class="default-input__input" name="CUSTOMER"  placeholder="Название компании">
              <span class="error_CUSTOMER">[[!+fi.error.CUSTOMER]]</span>
            </div>
            <div style="display: none;" class="default-input form__item form__item_wide">
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
              <input class="default-radio__input" type="radio" id="order-yur-radio-4" name="PAYMENT" checked="checked" value="Банковский перевод">
              <label class="default-radio__label" for="order-yur-radio-4">Банковский перевод</label>
              <div class="default-input__error"></div>
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
              <input class="default-checkbox__input" type="checkbox" id="privacy-order-company" name="privacy">
              <label class="default-checkbox__label" for="privacy-order-company">
                <span class="default-checkbox__label-text">Согласен(на) с <a data-fancybox data-type="ajax" data-src="/confidential/" class="popup__privacy-link link">политикой конфиденциальности</a> сайта</span>
              </label>
            </div>
            <button class="btn btn_style_shadow" type="submit">Оформить заказ</button>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>
