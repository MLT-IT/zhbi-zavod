<div class="popup-order popup" id="order">
    <div class="popup__form">
        <h2 class="popup-order__title-2">Оформление заказа</h2>

        <div class="js-tabs popup-order__tabs">
            <div class="js-tabs-headers-wrap popup-order__tabs-headers-wrap">
                <a href="#" class="js-tabs-header popup-order__tabs-header active" data-tab="fiz">
                    <span class="popup-order__tabs-header-text pc">Физическое</span>
                    <span class="popup-order__tabs-header-text mobile">Физ.</span>
                    &nbsp;лицо
                </a>
                <a href="#" class="js-tabs-header popup-order__tabs-header" data-tab="yur">
                    <span class="popup-order__tabs-header-text pc">Юридическое</span>
                    <span class="popup-order__tabs-header-text mobile">Юр.</span>
                    &nbsp;лицо
                </a>
            </div>
            <div class="js-tabs-contents-wrap popup-order__tab-contents">
                <div class="js-tabs-content active" data-tab="fiz">
                    <form method="POST" action class="popup-order__form">
                        <input type="hidden" name="CUSTOMER-TYPE" value="Физическое лицо">

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
                                <input name="PHONE" placeholder="Укажите номер телефона*" class="popup-order__input" type="tel">
                                <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
                            </label>
                        </div>

                        <h3 class="popup-order__title-3 popup-order__title-payment">Способ оплаты</h3>
                        <div class="popup-order__radios-wrap">
                            <label class="custom-radio">
                                <span class="custom-radio__label">Оплата наличными при получении</span>
                                <input class="custom-radio__input" type="radio" name="PAYMENT"
                                       value="Оплата наличными при получении"
                                       checked="checked">
                                <span class="custom-radio__checkmark"></span>
                            </label>
                            <label class="custom-radio">
                                <span class="custom-radio__label">Наличными в офисе</span>
                                <input class="custom-radio__input" type="radio" name="PAYMENT"
                                       value="Наличными в офисе">
                                <span class="custom-radio__checkmark"></span>
                            </label>
                            <label class="custom-radio">
                                <span class="custom-radio__label">Банковской картой</span>
                                <input class="custom-radio__input" type="radio" name="PAYMENT"
                                       value="Банковской картой">
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

                        <div class="popup-order__submit-wrap">
                            <label class="popup-order__privacy-wrap privacy">
                            <span class="custom-checkbox">
                                <input class="custom-checkbox__input" type="checkbox" checked="" name="privacy">
                                <span class="custom-checkbox__checkmark"></span>
                            </span>
                                <span class="privacy__text">согласен(на) с <a
                                            class="privacy__link" data-fancybox="" data-type="ajax"
                                            data-src="/confidential/"
                                            href="javascript:;">политикой конфиденциальности</a> сайта</span>
                            </label>

                            <button type="submit" class="popup-order__submit custom-btn">Оформить заказ</button>
                        </div>
                    </form>
                </div>

                <div class="js-tabs-content" data-tab="yur">
                    <form method="POST" action class="popup-order__form">
                        <input type="hidden" name="CUSTOMER-TYPE" value="Юридическое лицо">

                        <div class="popup-order__inputs">
                            <label class="popup-order__label popup-order__label_width_full">
                                <input name="CUSTOMER" placeholder="Название компании"
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
                                <input name="PHONE" placeholder="Укажите номер телефона*" class="popup-order__input"
                                       type="tel">
                                <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
                            </label>
                        </div>

                        <h3 class="popup-order__title-3 popup-order__title-payment">Способ оплаты</h3>
                        <div class="popup-order__radios-wrap">
                            <label class="custom-radio">
                                <span class="custom-radio__label">Безналичная оплата</span>
                                <input class="custom-radio__input" type="radio" name="PAYMENT"
                                       value="Безналичная оплата"
                                       checked="checked">
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
            </div>
        </div>

    </div>
</div>
