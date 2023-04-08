<div class="popup js-thanks popup_type_callback" id="availability">
  <form method="POST" action class="popup__form form">
    <input type="text" name="MOBILEPHONE" class="secret">

    <h3 class="title-2 form__title">Узнать наличие материала</h3>
    <div class="form__text">мы Вам перезвоним в течение 15 минут</div>
    <div class="form__inputs">
      <label>
        <input type="text" placeholder="Укажите Ваше имя" name="NAME">
        <span class="error_NAME">[[!+fi.error.NAME]]</span>
      </label>

      <label>
        <input placeholder="Укажите номер телефона*" name="PHONE">
        <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
      </label>
    </div>
    <button type="submit" class="btn btn_style_shadow popup__btn">Перезвоните мне</button>

    <div class="default-checkbox">
      <input class="default-checkbox__input" type="checkbox" id="checkbox-availability" name="privacy" checked>
      <label class="default-checkbox__label" for="checkbox-availability">
        <span class="default-checkbox__label-text">Согласен(на) с <a data-fancybox data-type="ajax" data-src="/confidential/" class="privacy-link">политикой конфиденциальности</a> сайта</span>
      </label>
    </div>

  </form>
</div>
