{set $toCatalogBtnText = 'Все производители'}
{switch $_modx->resource.context_key}
  {case 'web'}
    {set $logo = 'alterteplo-white.png'}
  {case 'gazosilikatstroy'}
    {set $logo = 'gazosilicatstroy-white.png'}
  {case 'kraska'}
    {set $logo = 'kraska-white.png'}
    {set $toCatalogBtnText = 'Все разделы'}
  {case 'suhiesmesi'}
    {set $logo = 'gazosilicatstroy-white.png'}
  {case 'krovelnyjstroymarket'}
    {set $logo = 'krovelnyjstroymarket-white.png'}
{/switch}

<footer class="footer">
  <div class="footer__container">
    <div class="footer__left">
      <div class="footer__column"><a class="footer__logo" href="/">
          <img class="footer__logo-image" src="assets/template/pictures/{$logo}"></a><span class="footer__copy">© 2010-{'' | date : "Y"}</span>
      </div>
      <div class="footer__column">
        <address class="footer__contacts">

        {set $phone = '!virtual_phone' | snippet: []}
    
        <a class="footer__contact footer__contact_with-hover" href="tel:{$phone}">
              <svg class="footer__contact-icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
              </svg>
              <span class="footer__contact-value">{$phone}</span>
            </a>
            <a class="footer__contact footer__contact_with-hover" href="mailto:{'email' | option}" data-replace-elem="footer__contact-value">
              <svg class="footer__contact-icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-email-sm"></use>
              </svg>
              <span class="footer__contact-value">{'email' | option}</span>
            </a>
            <div class="footer__contact">
              <svg class="footer__contact-icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-location-sm"></use>
              </svg>
              <span class="footer__contact-value">
                    {if $_modx->getPlaceholder('localdata').local}
                      <p class="contact__value">{$_modx->getPlaceholder('localdata').offices.0.address}</p>
                    {else}
                      <p class="contact__value">{'address' | option}</p>
                    {/if}
              </span>
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
            <a class="footer__nav-item" href="/contacts/">Контакты</a>
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
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/mir.png">
          </li>
          <li class="footer__payment-item">
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/mastercard.png">
          </li>
          <li class="footer__payment-item">
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/mastercard-2.png">
          </li>
          <li class="footer__payment-item">
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/visa-2.png">
          </li>
          <li class="footer__payment-item">
            <img class="footer__payment-image" src="assets/template/pictures/payment-systems/visa.png">
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
      <a class="burger-menu__nav-link" href="/dostavka-i-oplata/">Доставка и оплата</a>
      <a class="burger-menu__nav-link" href="/akcii/">Акции</a>
      <a class="burger-menu__nav-link" href="/o-kompanii/">О компании</a>
      <a class="burger-menu__nav-link" href="/contacts/">Контакты</a>
      </div>
    </nav>

    <div class="search header__search header__search_screen_mobile">
      <form action="/search/" class="search__wrapper search search_display_desktop" fast-search-form="desktop">
        <button type="submit" class="search__btn icon-btn icon-btn_style_red">
          <svg class="icon-btn__icon icon-btn__icon_small" aria-hidden="true">
            <use xlink:href="assets/template/pictures/icons.svg#svg-search"></use>
          </svg>
        </button>
        <input name="query" class="search__input" fast-search-input="desktop" type="search" placeholder="Хочу найти..." id="_inp44444444">

      </form>
      <form action="/search/" class="search__wrapper search_display_mobile" fast-search-form="mobile">
        <button type="submit" class="search__btn icon-btn icon-btn_style_red">
          <svg class="icon-btn__icon icon-btn__icon_small" aria-hidden="true">
            <use xlink:href="assets/template/pictures/icons.svg#svg-search"></use>
          </svg>
        </button>
        <input name="query" class="search__input" fast-search-input="mobile" type="search" placeholder="Хочу найти..." id="_inp55555555">

      </form>
    </div>

    <div class="burger-menu__link-to-catalog-wrap">
      <a class="h-menu__link-to-catalog h-menu__link-to-catalog_mobile" href="/catalog/">Перейти в каталог</a>
    </div>
    <div class="burger-menu__catalog">
      {set $params = [
        'depth' => 0,
        'limit' => 0,
        'tpl' => '@FILE chunks/create-menu/mobile-menu-item.tpl',
        'where' => '{"template:=":"5"}',
        'includeTVs' => 'mainImage'
      ]}
      {switch $_modx->resource.context_key}
        {case 'web'}
          {set $params['parents'] = 4}
        {case 'gazosilikatstroy'}
          {set $resources = '101938,101936,101934,101932,101937,101929,101930,101933,101935,101931'}
          {set $params['resources'] = $resources}
          {set $params['parents'] = 0}
          {set $params['sortby'] = 'FIELD(modResource.id, ' ~ $resources ~ ')'}
          {set $params['sortdir'] = 'ASC'}
        {case 'kraska'}
          {set $params['parents'] = 102655}
        {case 'suhiesmesi'}
          {set $params['parents'] = 105697}
        {case 'krovelnyjstroymarket'}
          {set $resources = '125531,125540,125530,125532,125538,125536,125534,125535,125537,125541,125528,125539,125533,125529'}
          {set $params['resources'] = $resources}
          {set $params['parents'] = 0}
          {set $params['sortby'] = 'FIELD(modResource.id, ' ~ $resources ~ ')'}
          {set $params['sortdir'] = 'ASC'}
      {/switch}
      {$_modx->runSnippet('pdoResources', $params)}
    </div>
    <div class="burger-menu__link-to-catalog-wrap">
      <a class="h-menu__link-to-catalog h-menu__link-to-catalog_bottom h-menu__link-to-catalog_mobile btn btn_style_shadow" href="/catalog/">{$toCatalogBtnText}</a>
    </div>

  </div>
</section>

<a href="#" class="to-top-btn"></a>
