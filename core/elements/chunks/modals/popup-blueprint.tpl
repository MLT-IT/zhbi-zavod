<div class="popup js-thanks popup_type_callback" id="blueprint">
  <form method="POST" action class="popup__form form">
    <input type="text" name="MOBILEPHONE" class="secret">

    <h3 class="title-2 form__title">Отправьте чертеж</h3>
    <div class="form__text">Поможем подобрать материал и рассчитаем стоимость по Вашему чертежу.</div>
    <div class="form__inputs">
      <label>
        <input type="text" placeholder="Укажите Ваше имя" name="NAME">
        <span class="error_NAME">[[!+fi.error.NAME]]</span>
      </label>

      <label>
        <input placeholder="Укажите номер телефона*" name="PHONE">
        <span class="error_PHONE">[[!+fi.error.PHONE]]</span>
      </label>
     
      <input type="hidden" id="plan-file" name="FILE">
      {$_modx->runSnippet("!YandexDiskUploader", ["inputId" => "plan-file" ])}
      <span class="error_FILE">[[!+fi.error.FILE]]</span>
      <label for="plan-file"> 
          Формат: doc, jpg, png, pdf, dwg, xlsx;<br>
          Размер не более 15 Мб.
      </label>
    </div>
    <button type="submit" class="btn btn_style_shadow popup__btn">Получить расчет</button>

    <div class="default-checkbox">
      <input class="default-checkbox__input" type="checkbox" id="privacy-blueprint" name="privacy">
      <label class="default-checkbox__label" for="privacy-blueprint">
        <span class="default-checkbox__label-text">Согласен(на) с <a data-fancybox data-type="ajax" data-src="/confidential/" class="popup__privacy-link link">политикой конфиденциальности</a> сайта</span>
      </label>
    </div>

  </form>
</div>
