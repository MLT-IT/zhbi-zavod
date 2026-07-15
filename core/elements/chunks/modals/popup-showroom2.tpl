<div class="popup js-thanks popup_type_callback" id="showRoom_tp">
  <form method="POST" action class="popup__form form">
    <input type="text" name="MOBILEPHONE" class="secret">
    <input type="hidden" name="COMMENTS" value="Заявка на посещение шоурума">

    <h3 class="title-2 form__title">Запишитесь на просмотр образца в шоуруме</h3>
    <div class="form__text">Оставьте свои контакты, и наш менеджер свяжется с вами, чтобы согласовать удобное время визита</div>
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
      <input class="default-checkbox__input" type="checkbox" id="privacy-showroom-tp" name="privacy">
      <label class="default-checkbox__label" for="privacy-showroom-tp">
        <span class="default-checkbox__label-text">Согласен(на) с <a data-fancybox data-type="ajax" data-src="/confidential/" class="popup__privacy-link link">политикой конфиденциальности</a> сайта</span>
      </label>
    </div>

  </form>
</div>
