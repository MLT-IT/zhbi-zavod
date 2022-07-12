<div class="popup" id="discount">
    <form method="POST" action class="popup__form form">
        <h2 class="title-2 form__title">Нашли дешевле?</h2>
        <div class="form__text">СНИЗИМ ЦЕНУ!</div>
        <div class="form__inputs">
            <label>
                <input type="text" placeholder="Укажите Ваше имя" name="NAME">
                <span class="error_NAME">[[!+fi.error.NAME]]</span>
            </label>

            <label>
                <input type="tel" placeholder="Укажите номер телефона*" name="PHONE">
                <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
            </label>

            <label>
                <input type="tel" placeholder="Ссылка на товар со скидкой" name="DISCOUNTLINK">
                <span class="error_DISCOUNTLINK">[[!+fi.error.DISCOUNTLINK]]</span>
            </label>
        </div>
        <button type="submit" class="form__button custom-btn" id="nashli_deshevle">Перезвоните мне</button>
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
