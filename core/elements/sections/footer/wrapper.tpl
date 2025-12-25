<div class="footer bg-dark-gray-2">
  <div class="container">
    <div class="footer__row">
        {include "file:sections/footer/contacts.tpl"}
        {include "file:sections/footer/menu.tpl"}
    </div>
    <div class="footer__bottom">
        <div class="footer__bottom-section">
          <div>© 2010-{'' | date : "Y"}</div>
          <div>
            <a class="link-dashed white" href="{$_modx->getPlaceholder('makeurls.policy')}">Политика конфиденциальности</a>
          </div>
        </div>
  
        <div class="footer__bottom-section">
          <div>Мы принимаем к оплате:</div>
          <div class="footer__bottom-payments">
            <img src="/assets/template/images/sections/footer/mir.png" />
            <img src="/assets/template/images/sections/footer/mastercard.png" />
            <img src="/assets/template/images/sections/footer/mastercard-2.png" />
            <img src="/assets/template/images/sections/footer/visa-2.png" />
            <img src="/assets/template/images/sections/footer/visa.png" />
          </div>
        </div>
      </div>
  </div>
</div>
