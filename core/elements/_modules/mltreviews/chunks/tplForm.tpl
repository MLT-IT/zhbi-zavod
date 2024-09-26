<div class="mlt-reviews__form">
  <form action="[[+action]]" id="mlt-review-form">
    <input type="hidden" name="resource_id" value="{$_modx->resource.id}">
    <div class="mlt-reviews__form-field-row">
      <label>Ваше имя <span class="mlt-reviews__form-asterisk">*</span></label>
      <input type="text" name="user_name" />
      <div data-error-message="user_name" class="mlt-reviews__form-error-message"></div>
    </div>
    <div class="mlt-reviews__form-field-row">
      <label>Комментарий <span class="mlt-reviews__form-asterisk">*</span></label>
      <textarea name="content" rows="7"></textarea>
      <div data-error-message="content" class="mlt-reviews__form-error-message"></div>
    </div>
    <div class="mlt-reviews__form-upload-wrapper">
      <input type="file" id="fileInput" class="mlt-reviews__form-file-input" />
      <label for="fileInput" class="mlt-reviews__form-file-label">Прикрепить иконку</label>
    </div>
    <div class="mlt-reviews__form-field-row">
      <label>Поставьте оценку</label>
      <rating>
        <input type="radio" style="display: none" name="rating" value="0" checked />
        <input type="radio" name="rating" value="1" />
        <input type="radio" name="rating" value="2" />
        <input type="radio" name="rating" value="3" />
        <input type="radio" name="rating" value="4" />
        <input type="radio" name="rating" value="5" />
      </rating>
      <div data-error-message="rating" class="mlt-reviews__form-error-message"></div>
    </div>
    <div class="mlt-reviews__form-info">
      <span class="mlt-reviews__form-asterisk">*</span> - Обязательные поля для заполнения
    </div>
    <button class="btn btn_style_base">Отправить</button>
  </form>
  <div class="mlt-reviews__form-success-message" id="mlt-review-success-message"> Спасибо за обратную связь. Ваш отзыв
    отправлен на модерацию </div>
</div>
