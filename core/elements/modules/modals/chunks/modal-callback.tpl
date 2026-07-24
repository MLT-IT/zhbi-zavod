{extends "file:modules/modals/layots/base.tpl"} 

{block 'params'}
  {set $id='modal-callback'}
  {set $title="Оставьте свои контакты ниже"}
  {set $description="мы Вам перезвоним в течение 15 минут"}
{/block}

{block 'body'}
  {set $email_subject = 'Сообщение со страницы '~$_modx->resource.pagetitle}
  {'!FetchIt' | snippet : [
    'form' => '@INLINE 
      <form class="form" data-modal-id="modal-callback">
        {include "file:modules/modals/chunks/form__bx-source-input.tpl"}

        <div class="form__group">
          <input type="text" name="name" placeholder="Имя"/>
        </div>

        <div class="form__group">
          <input type="tel" name="phone" required placeholder="Номер телефона"/>
          <span class="" data-error="phone" style="display: none;"></span>
        </div>

        <div class="d-flex justify-center">
          <button class="btn btn-primary" type="submit">Перезвоните мне</button>
        </div>

        <label class="custom-checkbox fs-14">
          <input type="checkbox" name="privacy"/>
          <span class="checkmark"></span>
          Согласен(на) с <a href="{$_modx->getPlaceholder("makeurls.policy")}" class="link-dashed">политикой конфиденциальности</a> сайта
        </label>
      </form>'
    'emailTo' => 'email' | config
    'emailSubject' => $email_subject
    'emailTpl' => '@FILE chunks/fetchit-email-tpl.tpl'
    'hooks' => 'bx_lead'
    'snippet' => 'FormIt'
    '-customValidators' => 'phone-format'
    'validate' => 'phone:required'
  ]}
{/block}