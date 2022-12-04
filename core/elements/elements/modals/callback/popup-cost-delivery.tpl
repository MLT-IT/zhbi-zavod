<div class="popup js-thanks" id="cost-delivery">
    <form method="POST" action class="popup__form form">
        <input type="text" name="mobilephone" class="fmobilephone">

        <h2 class="title-2 form__title">Оставьте свои контакты ниже</h2>
        <div class="form__text">и получите скидку 30% на доставку.<br>Мы перезвоним Вам в течение 15 минут.</div>
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
                    <span data-fancybox data-type="ajax"
                       data-src="/confidential/" class="privacy-link">Условиями обработки персональных данных </span>
                    и принимаете их
                </span>
            </span>
        </label>
    </form>
</div>
