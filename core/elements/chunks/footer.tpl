{switch $_modx->resource.context_key}
  {case 'web'}
    {set $logo = 'alterteplo-white.png'}
  {case 'gazosilikatstroy'}
    {set $logo = 'gazosilicatstroy-white.png'}
{/switch}

<footer class="footer">
  <div class="footer__container">
    <div class="footer__left">
      <div class="footer__column"><a class="footer__logo" href="/">
          <img class="footer__logo-image" src="assets/template/pictures/{$logo}" alt="monolit-logo"></a><span class="footer__copy">© 2010-{'' | date : "Y"}</span>
      </div>
      <div class="footer__column">
        <address class="footer__contacts">
            <a class="footer__contact" href="tel:+78122109963">
              <svg class="footer__contact-icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
              </svg>
              <span class="footer__contact-value">{'phone' | option}</span>
            </a>
            <a class="footer__contact" href="mailto:{'email' | option}" data-replace-elem="footer__contact-value">
              <svg class="footer__contact-icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-email-sm"></use>
              </svg>
              <span class="footer__contact-value">{'email' | option}</span>
            </a>
          <div class="footer__contact">
            <svg class="footer__contact-icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-location-sm"></use>
            </svg>
            <span class="footer__contact-value">{'address' | option}</span>
          </div>
        </address>

        {*
        <div class="footer__socials"><a class="footer__social" href="#">
            <svg class="footer__social-logo" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-vk"></use>
            </svg>
          </a><a class="footer__social" href="#">
            <svg class="footer__social-logo" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-ok"></use>
            </svg>
          </a><a class="footer__social" href="#">
            <svg class="footer__social-logo" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-tg"></use>
            </svg>
          </a><a class="footer__social" href="#">
            <svg class="footer__social-logo" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-zen"></use>
            </svg>
          </a><a class="footer__social" href="#">
            <svg class="footer__social-logo" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-youtube"></use>
            </svg>
          </a>
        </div>
        *}

        <a class="footer__politic link link_white" data-fancybox="" data-type="ajax" data-src="/confidential/">Политика конфиденциальности</a>
      </div>
    </div>
    <div class="footer__right">
      <div class="footer__right-top">
        <div class="footer__nav">
          <p class="footer__nav-title">Каталог</p>
          <nav class="footer__nav-list">
            <a class="footer__nav-item" href="/o-kompanii/">О компании</a>
            <a class="footer__nav-item" href="/dostavka-i-oplata/">Доставка и оплата</a>
            <a class="footer__nav-item" href="/certs/">Сертификаты</a>
            <a class="footer__nav-item" href="/garantii/">Гарантии</a>
          </nav>
        </div>
        <div class="footer__nav footer__nav_categories">
          <p class="footer__nav-title">Популярные категории</p>
          {set $resources =  $_modx->config.popular_categories}
          {if $resources ?}
            <nav class="footer__nav-list">
              {$_modx->runSnippet('pdoResources', [
                'parents' => 0,
                'depth' => 1000,
                'context' => $_modx->resource.context_key,
                'tpl' => '@INLINE <a class="footer__nav-item" href="[[+uri]]">[[+menutitle]]</a>',
                'limit' => 0,
                'resources' => $resources,
                'sortby' => 'FIELD(id, '~$resources~')',
                'sortdir' => 'ASC'
              ])}
            </nav>
          {/if}
        </div>
      </div>
      <div class="footer__payment">
        <p class="footer__payment-title">Мы принимаем к оплате:</p>
        <ul class="footer__payment-list">
          <li class="footer__payment-item">
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/mir.png" alt="mir">
          </li>
          <li class="footer__payment-item">
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/mastercard.png" alt="mastercard">
          </li>
          <li class="footer__payment-item">
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/mastercard-2.png" alt="mastercard-2">
          </li>
          <li class="footer__payment-item">
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/visa-2.png" alt="visa-2">
          </li>
          <li class="footer__payment-item">
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/visa.png" alt="visa">
          </li>
        </ul>
      </div>
    </div>
  </div>
</footer>

<section class="burger-menu">
  <div class="burger-menu__container">
    <nav class="burger-menu__nav">
      <div class="burger-menu__nav-items">
        <a class="burger-menu__nav-link" href="/o-kompanii/">О компании</a>
        <a class="burger-menu__nav-link" href="/akcii/">Акции</a>
        <a class="burger-menu__nav-link" href="/dostavka-i-oplata/">Доставка и оплата</a>
        <a class="burger-menu__nav-link" href="/contacts/">Контакты</a>
      </div>
    </nav>

    <div class="burger-menu__link-to-catalog-wrap">
      <a class="h-menu__link-to-catalog h-menu__link-to-catalog_mobile" href="/catalog/">Перейти в каталог</a>
    </div>
    <div class="burger-menu__catalog">
      {set $id = '@FILE snippets/getIdByAlias.php' | snippet : [
        'alias' => 'catalog'
      ]}
      {$_modx->runSnippet('pdoResources', [
        'parents' => $id,
        'depth' => 0,
        'context' => $_modx->resource.context_key,
        'tpl' => '@FILE chunks/create-menu/mobile-menu-item.tpl',
        'limit' => 10,
        'where' => '{"template:=", 5}',
        'includeTVs' => 'mainImage'
      ])}
    </div>
  </div>
</section>
