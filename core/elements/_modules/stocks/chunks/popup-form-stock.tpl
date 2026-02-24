<div class="popup js-thanks" id="stock-modal" data-callback-open="stock-modal">
    <form method="POST" action class="popup__form form stock-form">
        <input type="text" name="mobilephone" class="fmobilephone">

        <div class="stock-form__header">
            <h2 class="stock-form__title">Данный товар поставляется на склад под запрос</h2>
            <p class="stock-form__subtitle">Пожалуйста, оставьте заявку — мы привезем<br> товар в течение 2–3 дней на склад!</p>
        </div>

        <div class="form__inputs stock-form__inputs">

            <label class="stock-form__field">
                <input type="text" name="NAME" class="stock-form__input" placeholder="Укажите Ваше имя">
                <span class="error_NAME">[[!+fi.error.NAME]]</span>
            </label>

            <label class="stock-form__field">
                <input type="tel" name="PHONE" class="stock-form__input" placeholder="Укажите номер телефона">
                <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
            </label>

            <label class="stock-form__field">
                <span class="stock-form__label">Материал:</span>
                <input type="text" name="material_type" class="stock-form__input js-material-input" placeholder="Название материала" readonly>
                <span class="error_MATERIAL">[[!+fi.error.material_type]]</span>
            </label>

            <label class="stock-form__field">
                <input type="text" name="material_volume" class="stock-form__input" placeholder="Объём">
                <span class="error_VOLUME">[[!+fi.error.material_volume]]</span>
            </label>

            
        </div>

        <label class="form__checkbox stock-form__checkbox">
            <input id="stock-policy" type="checkbox" name="callback-policy" checked>
            <span>
                <span>
                     Нажимая кнопку «Отправить, Вы подтверждаете, что ознакомились с
                    <span data-fancybox data-type="ajax"
                            data-src="/confidential/" class="privacy-link">Условиями обработки персональных данных </span>
                    и принимаете их
                </span>
            </span>
        </label>
        
        <button type="submit" class="stock-form__button custom-btn">Отправить</button>
        
        

        <!-- Скрытое поле для передачи типа заявки -->
        <input type="hidden" name="REQUEST_TYPE" value="Заявка на товар под запрос">
    </form>
</div>
