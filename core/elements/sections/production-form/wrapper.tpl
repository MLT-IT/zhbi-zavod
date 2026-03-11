{set $phone = $_modx->getPlaceholder('contacts.phone')}
{set $address = $_modx->getPlaceholder('contacts.address')}

{set $contacts = [
    ['title' => 'Телефон производства:', 'value' => '<a href="tel:'~$phone~'">'~$phone~'</a>, доб. 1', 'icon' => 'svg-phone'],
    ['title' => $address, 'icon' => 'svg-location'],
    ['title' => '<a class="fw-700" href="mailto:'~'email' | option~'">'~'email' | option~'</a>', 'icon' => 'svg-email'],
]}

<div class="production-form">
  <div class="container">
    <div class="production-form__container">
      <div class="production-form__row">
        <div class="production-form__content">
          <h2 class="production-form__content-title">
            Собственное производство
          </h2>
          <div class="production-form__contacts">
            {foreach $contacts as $item}
            <div class="production-form__contacts-item">
              <svg aria-hidden="true">
                <use
                  xlink:href="/assets/template/images/icons.svg#{$item['icon']}"
                ></use>
              </svg>
              <div class="production-form__contacts-item-row">
                <div class="production-form__contacts-item-title">
                  {$item['title']}
                </div>
                {if $item['value']}
                <div class="production-form__contacts-item-value">{$item['value']}</div>
                {/if}
              </div>
            </div>
            {/foreach}
          </div>
          {include "file:sections/production-form/images.tpl" classes="show-mobile"}

          {'!FetchIt' | snippet : [
            'snippet' => 'FormIt',
            'form' => '@INLINE 
            <form class="production-form__form">
                {include "file:modules/modals/chunks/form__bx-source-input.tpl"}
              
                <div class="production-form__form-title">Связаться с производством</div>
                <input type="text" placeholder="Введите Ваше имя" name="name">
                <input type="tel" placeholder="Укажите номер телефона*" name="phone" required>
                <button class="btn btn-bordered" type="submit" onclick="ym({$_modx->getPlaceholder(\'virtual-router\')[\'yandex_id\']},\'reachGoal\',\'otpravka-formy-skvoznoj-blok-proizvodstvo\')">Отправить заявку</button>
            </form>
            ',
            'hooks' => 'bx_lead'
            'snippet' => 'FormIt'
            'validate' => 'phone:required'
          ]}
        </div>
        {include "file:sections/production-form/images.tpl" classes="hide-mobile"}
      </div>
    </div>
  </div>
</div>
