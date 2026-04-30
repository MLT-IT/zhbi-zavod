<div class="product-info action-banner">
  <div class="action-banner__head">
    Оформим <b>коммерческое предложение</b> в течение<br> 30 минут!
  </div>
  <div class="action-banner__actions">
    {if $phone && $phone != '+7 (000) 000-00-00'}
    <a class="btn btn_phone" href="tel:{$phone_href}">
      <img src="/assets/template/img/icons/phone.svg">{$phone}
    </a>
    {/if}
    <div class="btn btn_email">
      <div class="clipBoardable">
        <a href="mailto:{$email}">{$email}</a>
      </div>
    </div>
  </div>
</div>
