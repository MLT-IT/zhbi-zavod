<div class="popup js-thanks popup-reviews" id="reviews">
    <form method="POST" action class="popup__form form popup-reviews__form">
        <input type="text" name="mobilephone" class="fmobilephone">

        <h2 class="title-2 form__title popup-reviews__title">Оставить отзыв</h2>
        <div class="popup-reviews__subtitle">
            <span class="popup-reviews__subtitle-text">
                Оцените товар
            </span>
            <div class="popup-reviews__stars">
                <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="/assets/template/img/svg-sprite.svg#icon-star"></use>
                </svg>
                <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="/assets/template/img/svg-sprite.svg#icon-star"></use>
                </svg>
                <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="/assets/template/img/svg-sprite.svg#icon-star"></use>
                </svg>
                <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="/assets/template/img/svg-sprite.svg#icon-star"></use>
                </svg>
                <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="/assets/template/img/svg-sprite.svg#icon-star"></use>
                </svg>
            </div>
        </div>

        <div class="form__inputs">
            <label class="form__label">
                <span class="form__label-text">
                    Оставьте свой комментарий
                </span>
                <textarea placeholder="Что Вам понравилось в этом товаре? Кому бы Вы его рекомендовали?" name="TEXT" class="popup-reviews__input-text" id="popup-reviews__input-text" cols="30" rows="10"></textarea>
                <span class="form__error error_TEXT"></span>
            </label>

            <label class="form__label">
                <input type="text" placeholder="Укажите Ваше имя" name="NAME">
                <span class="form__error error_NAME"></span>
            </label>
        </div>

        <button type="submit" class="form__button custom-btn">Отправить</button>
        <label class="form__checkbox">
            <input id="callback-policy" type="checkbox" name="callback-policy" checked>
            <span>
                <span>
                     Нажимая кнопку «Отправить», Вы потверждаете, что ознакомились с
                    <span data-fancybox data-type="ajax"
                       data-src="/confidential/" class="privacy-link">Условиями обработки персональных данных </span>
                    и принимаете их
                </span>
            </span>
        </label>
    </form>
</div>
