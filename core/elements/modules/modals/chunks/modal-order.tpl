{extends "file:modules/modals/layots/base.tpl"} 

{block 'params'}
  {set $id='modal-order'}
  {set $title="Оформление заказа"}
{/block}

{block 'body'}
  {set $email_subject = 'Сообщение со страницы '~$_modx->resource.pagetitle}
  
  <div class="order-modal">

    <div class="form__tab-controls form__flex">
      <label
        class="custom-radio active"
        data-opened-btn="order-form-1"
        data-toggle-not="true"
        data-close-early="order-form"
      >
        <input type="radio" name="buyer" value="Физическое лицо" checked />
        <span class="radio-indicator"></span>
        Физическое лицо
      </label>

      <label
        class="custom-radio"
        data-opened-btn="order-form-2"
        data-toggle-not="true"
        data-close-early="order-form"
      >
        <input type="radio" name="buyer" value="Юридическое лицо"/>
        <span class="radio-indicator"></span>
        Юридическое лицо
      </label>
    </div>

    {'!FetchIt' | snippet : [
      'form' => '@INLINE 
        <form
          class="form opened"
          data-modal-id="modal-order"
          data-opened-element="order-form-1"
        >
          {include "file:modules/modals/chunks/form__bx-source-input.tpl"}

          <input type="text" name="name" placeholder="ФИО получателя" />
    
          <div class="form__flex">
            <input type="email" name="email" placeholder="Email" />
            <input
              type="tel"
              name="phone"
              required
              placeholder="Мобильный телефон"
            />
          </div>
    
          <div class="form__title fs-20">Способы оплаты:</div>
    
          <div class="form__list">
            <label class="custom-radio">
              <input type="radio" name="pyments" value="Наличными при получении" checked />
              <span class="radio-indicator"></span>
              Наличными при получении
            </label>
    
            <label class="custom-radio">
              <input type="radio" name="pyments" value="Банковской картой" />
              <span class="radio-indicator"></span>
              Банковской картой
            </label>
            <label class="custom-radio">
              <input type="radio" name="pyments" value="Банковский перевод"/>
              <span class="radio-indicator"></span>
              Банковский перевод
            </label>
          </div>
    
          <div class="form__title fs-20">Адрес доставки:</div>
    
          <div class="form__flex">
            <input type="text" name="city" placeholder="Город" />
            <input type="text" name="address" placeholder="Улица" />
          </div>
    
          <div class="d-flex gap-16 mt-16">
            <label class="custom-checkbox fs-14">
              <input type="checkbox" name="privacy" />
              <span class="checkmark"></span>
              Согласен(на) с
              <a href="{$_modx->getPlaceholder("makeurls.policy")}" class="link-dashed"
                >политикой конфиденциальности</a
              >
              сайта
            </label>
    
            <button class="btn btn-primary" type="submit">Оформить заказ</button>
          </div>
        </form>'
      '-emailTo' => 'email' | config
      '-emailSubject' => $email_subject
      '-emailTpl' => '@FILE chunks/fetchit-email-tpl.tpl'
      'hooks' => 'bx_lead'
      'snippet' => 'FormIt'
      '-customValidators' => 'phone-format'
      'validate' => 'phone:required'
    ]}

    {'!FetchIt' | snippet : [
      'form' => '@INLINE 
        <form
          class="form"
          data-modal-id="modal-order"
          data-opened-element="order-form-2"
        >
          {include "file:modules/modals/chunks/form__bx-source-input.tpl"}
          
          <input type="text" name="name" placeholder="Название компании" />
    
          <div class="form__flex">
            <input type="email" name="email" placeholder="Email" />
            <input
              type="tel"
              name="phone"
              required
              placeholder="Мобильный телефон"
            />
          </div>
    
          <div class="form__title fs-20">Способы оплаты:</div>
    
          <div class="form__list">
            <label class="custom-radio">
              <input type="radio" name="pyments" checked />
              <span class="radio-indicator"></span>
              Безналичная оплата
            </label>
          </div>
    
          <div class="form__title fs-20">Адрес доставки:</div>
    
          <div class="form__flex">
            <input type="text" name="city" placeholder="Город" />
            <input type="text" name="address" placeholder="Улица" />
          </div>
    
          <div class="d-flex gap-16 mt-16">
            <label class="custom-checkbox fs-14">
              <input type="checkbox" name="privacy" />
              <span class="checkmark"></span>
              Согласен(на) с
              <a href="{$_modx->getPlaceholder("makeurls.policy")}" class="link-dashed"
                >политикой конфиденциальности</a
              >
              сайта
            </label>
    
            <button class="btn btn-primary" type="submit">Оформить заказ</button>
          </div>
        </form>'
      '-emailTo' => 'email' | config
      '-emailSubject' => $email_subject
      '-emailTpl' => '@FILE chunks/fetchit-email-tpl.tpl'
      'hooks' => 'bx_lead'
      'snippet' => 'FormIt'
      '-customValidators' => 'phone-format'
      'validate' => 'phone:required'
    ]}
  </div>
{/block}