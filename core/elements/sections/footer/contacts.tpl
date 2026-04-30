<div class="footer__contacts">
  <div class="footer__contacts-logo">
    <a href="/">
      <img src="{$_modx->getPlaceholder('images.logo-white')}" style="min-width: 138px;"/>
    </a>
  </div>
  <ul class="footer__contacts-list">
    {set $phone = $_modx->getPlaceholder('contacts.phone')}
    {if $phone && $phone != '+7 (000) 000-00-00'}
    <li>
      <svg class="footer__contact-icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-phone-sm"></use>
      </svg>
      <a
        class="fw-700 color-white"
        href="tel:{$_modx->getPlaceholder('contacts.phone_href')}"
        >{$_modx->getPlaceholder('contacts.phone')}</a
      >
    </li>
    {/if}
    <li>
      <svg class="footer__contact-icon">
        <use xlink:href="/assets/template/images/icons.svg#svg-email-sm"></use>
      </svg>
      <a class="fw-700 color-white" href="mailto:{$_modx->getPlaceholder('contacts.email')}"
        >{$_modx->getPlaceholder('contacts.email')}</a
      >
    </li>
    <li>
      <svg class="footer__contact-icon">
        <use
          xlink:href="/assets/template/images/icons.svg#svg-location-sm"
        ></use>
      </svg>
      {$_modx->getPlaceholder('contacts.address')}
    </li>
  </ul>
</div>
