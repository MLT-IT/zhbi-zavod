<div class="popup-order popup" id="order">
    <div class="popup__form">
        <h2 class="popup-order__title-2">Оформление заказа</h2>

        <div class="js-tabs popup-order__tabs">
            <div class="js-tabs-headers-wrap popup-order__tabs-headers-wrap">
                <a href="#" class="js-tabs-header popup-order__tabs-header active">Физическое лицо</a>
                <a href="#" class="js-tabs-header popup-order__tabs-header">Юридическое лицо</a>
            </div>
            <div class="js-tabs-contents-wrap popup-order__tab-contents">

                <div class="js-tabs-content">
                    <form method="POST" action class="popup-order__form">
                        <div class="popup-order__inputs">
                            <label class="popup-order__label popup-order__label_width_full">
                                <input name="CUSTOMER" placeholder="Получатель"
                                       class="popup-order__input"
                                       type="text">
                                <span class="error_CUSTOMER">[[!+fi.error.CUSTOMER]]</span>
                            </label>
                            <label class="popup-order__label popup-order__label_width_half">
                                <input name="MAIL" placeholder="Email" class="popup-order__input"
                                       type="text">
                                <span class="error_MAIL">[[!+fi.error.MAIL]]</span>
                            </label>
                            <label class="popup-order__label popup-order__label_width_half mla">
                                <input name="PHONE" placeholder="Телефон" class="popup-order__input"
                                       type="tel">
                                <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
                            </label>
                        </div>

                        <h3 class="popup-order__title-3 popup-order__title-payment">Способ оплаты 1</h3>
                        <div class="popup-order__radios-wrap">
                            <label class="custom-radio">
                                <span class="custom-radio__label">Оплата наличными при получении</span>
                                <input class="custom-radio__input" type="radio" name="payment" value="1"
                                       checked="checked">
                                <span class="custom-radio__checkmark"></span>
                            </label>
                            <label class="custom-radio">
                                <span class="custom-radio__label">Наличными в офисе</span>
                                <input class="custom-radio__input" type="radio" name="payment" value="2">
                                <span class="custom-radio__checkmark"></span>
                            </label>
                            <label class="custom-radio">
                                <span class="custom-radio__label">Банковской картой</span>
                                <input class="custom-radio__input" type="radio" name="payment" value="3">
                                <span class="custom-radio__checkmark"></span>
                            </label>
                        </div>

                        <h3 class="popup-order__title-3">Адрес доставки</h3>
                        <div class="popup-order__inputs">
                            <label class="popup-order__label popup-order__label_width_half">
                                <input name="CITY" placeholder="Город" class="popup-order__input"
                                       type="text">
                                <span class="error_CITY">[[!+fi.error.CITY]]</span>
                            </label>
                            <label class="popup-order__label popup-order__label_width_half mla">
                                <input name="STREET" placeholder="Улица" class="popup-order__input"
                                       type="tel">
                                <span class="error_STREET">[[!+fi.error.STREET]]</span>
                            </label>
                            <label class="popup-order__label popup-order__label_width_full">
                                <input name="COMMENT" placeholder="Комментарий"
                                       class="popup-order__input" type="text">
                                <span class="error_COMMENT">[[!+fi.error.COMMENT]]</span>
                            </label>
                        </div>
                        <button type="submit" class="popup-order__submit custom-btn">Оформить заказ</button>
                    </form>
                </div>

                <div class="js-tabs-content">
                    <form method="POST" action class="popup-order__form">
                        <div class="form__inputs">
                            <label class="popup-order__label popup-order__label_width_full">
                                <input name="CUSTOMER" placeholder="Название компании"
                                       class="" type="text">
                                <span class="error_CUSTOMER">[[!+fi.error.CUSTOMER]]</span>
                            </label>
                            <label class="popup-order__label popup-order__label_width_half">
                                <input name="MAIL" placeholder="Email" class="popup-order__input"
                                       type="text">
                                <span class="error_MAIL">[[!+fi.error.MAIL]]</span>
                            </label>
                            <label class="popup-order__label popup-order__label_width_half">
                                <input name="PHONE" placeholder="Телефон" class="popup-order__input"
                                       type="tel">
                                <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
                            </label>
                        </div>

                        <h3 class="popup-order__title-3 popup-order__title-payment">Способ оплаты</h3>
                        <label class="custom-radio">
                            <span class="custom-radio__checkmark"></span>
                            <input class="custom-radio__input" type="radio" name="payment" value="1">
                            <span class="custom-radio__label">Оплата наличными при получении</span>
                        </label>
                        <label class="custom-radio">
                            <span class="custom-radio__checkmark"></span>
                            <input class="custom-radio__input" type="radio" name="payment" value="2">
                            <span class="custom-radio__label">Наличными в офисе</span>
                        </label>
                        <label class="custom-radio">
                            <span class="custom-radio__checkmark"></span>
                            <input class="custom-radio__input" type="radio" name="payment" value="3">
                            <span class="custom-radio__label">Банковской картой</span>
                        </label>

                        <h3 class="popup-order__title-3">Адрес доставки</h3>
                        <div class="form__inputs">
                            <label class="popup-order__label popup-order__label_width_half">
                                <input name="CITY" placeholder="Город" class="popup-order__input"
                                       type="text">
                                <span class="error_CITY">[[!+fi.error.CITY]]</span>
                            </label>
                            <label class="popup-order__label popup-order__label_width_half">
                                <input name="STREET" placeholder="Телефон" class="popup-order__input"
                                       type="tel">
                                <span class="error_STREET">[[!+fi.error.STREET]]</span>
                            </label>
                            <label class="popup-order__label popup-order__label_width_full">
                                <input name="COMMENT" placeholder="Комментарий"
                                       class="" type="text">
                                <span class="error_COMMENT">[[!+fi.error.COMMENT]]</span>
                            </label>
                        </div>
                        <button type="submit" class="popup-order__submit custom-btn">Оформить заказ</button>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
