<form method="post" class="services-feedback__form ajax_form">
  <input type="text" name="MOBILEPHONE" class="secret">
  <input class="services-feedback__input" type="text" name="NAME" placeholder="Введите Ваше имя" value="[[!+fi.NAME]]">
  <span class="error_NAME">[[!+fi.error.NAME]]</span>
  <input class="services-feedback__input" type="tel" name="PHONE" placeholder="Укажите номер телефона*" value="[[!+fi.PHONE]]">
  <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
  <button type="submit" class="btn btn_style_trans services-feedback__submit">[[!+form_btn_text]]</button>
  <input type="hidden" name="af_action" value="[[!+af_action]]">
</form>
