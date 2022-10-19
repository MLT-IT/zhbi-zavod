<div class="popup js-thanks" id="help-in-choice">
    <form method="POST" action class="popup__form form">
        <input type="text" name="mobilephone" class="fmobilephone">

        <h2 class="title-2 form__title">Не знаете, что выбрать?</h2>
        <div class="form__text">Поможем подобрать материал!</div>
        <div class="form__inputs">
            <label>
                <input type="text" placeholder="Укажите Ваше имя" name="NAME">
                <span class="error_NAME">[[!+fi.error.NAME]]</span>
            </label>

            <label>
                <input type="tel" placeholder="Укажите номер телефона*" name="PHONE">
                <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
            </label>
        </div>
        <button type="submit" class="form__button custom-btn">Перезвоните мне</button>
        <label class="form__checkbox">
            <input id="callback-policy" type="checkbox" name="callback-policy" checked>
            <span>
                <span>
                     Нажимая кнопку «Перезвоните мне», Вы потверждаете, что ознакомились с
                    <a data-fancybox data-type="ajax"
                       data-src="/confidential/"
                       href="javascript:;">Условиями обработки персональных данных </a>
                    и принимаете их
                </span>
            </span>
        </label>
    </form>
</div>
