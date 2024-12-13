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
    {set $logo = 'suhiesmesi2.png'}
  {case 'krovelnyjstroymarket'}
    {set $logo = 'krovelnyjstroymarket-white.png'}
  {case 'fibrofasad'}
    {set $logo = 'fibrofasad-white.png'}
  {case 'fibrofasad2'}
    {set $logo = 'fibrofasad-white.png'}
  {case 'plitnye'}  
    {set $logo = 'plitnyematerialy2.png'}
  {case 'beltermo'}  
    {set $logo = 'beltermo2.png'}

  {case 'profnastil'}
    {set $logo = 'profnastil-white.png'}
  {case 'gibkaya-cherepiza'}
    {set $logo = 'gibkaya-cerepica-white.png'}
  {case 'falcevaya-krovlya'}
    {set $logo = 'falcevaya-krovlya-white.png'}
  {case 'metallocherepica'}
    {set $logo = 'metallocherepica-white.png'}
  {case 'trotuarnaya-plitka'}
    {set $logo = 'trotuarnaya-plitka-white.png'}
{/switch}

{set $phone = '!virtual_phone' | snippet }
{set $email = '@FILE snippets/utm/virtual_email.php' | snippet }
{set $address = 'address' | option}
{if $_modx->getPlaceholder('localdata').local}
  {set $address = $_modx->getPlaceholder('localdata').offices.0.address}
{/if}

<footer class="footer">
  <div class="footer__container">
    <div class="footer__left">
      <div class="footer__column"><a class="footer__logo" href="/">
          <img class="footer__logo-image" src="assets/template/pictures/{$logo}"></a><span class="footer__copy">© 2010-{'' | date : "Y"}</span>
      </div>
      <div class="footer__column">
        <address class="footer__contacts">
            <a class="footer__contact footer__contact_with-hover" href="tel:{$phone | ereplace:'/[^0-9+]/':'' }">
              <svg class="footer__contact-icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
              </svg>
              <span class="footer__contact-value">{$phone}</span>
            </a>
            <a class="footer__contact footer__contact_with-hover" href="mailto:{$email}" data-replace-elem="footer__contact-value">
              <svg class="footer__contact-icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-email-sm"></use>
              </svg>
              <span class="footer__contact-value">{$email}</span>
            </a>
            <div class="footer__contact">
              <svg class="footer__contact-icon" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-location-sm"></use>
              </svg>
              <span class="footer__contact-value">
                <p class="contact__value">{$address}</p>
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
        {if $_modx->context.key !== 'plitnye'}
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
        {else}
        <div class="footer__nav">
          <p class="footer__nav-title">Покупателям</p>
          <nav class="footer__nav-list">
            <a class="footer__nav-item" href="/o-kompanii/">О компании</a>
            <a class="footer__nav-item" href="/contacts/">Контакты</a>
            <a class="footer__nav-item" href="/dostavka-i-oplata/">Доставка и оплата</a>
            <a class="footer__nav-item" href="/akcii/">Акции</a>
            <a class="footer__nav-item" href="/faq/">Вопросы и ответы</a>
            <a class="footer__nav-item" href="/certs/">Сертификаты</a>
            <a class="footer__nav-item" href="/garantii/">Гарантии</a>
            <a class="footer__nav-item" href="/otzyvy/">Отзывы</a>
          </nav>
        </div>
        {/if}
        <div class="footer__nav footer__nav_categories">
          <p class="footer__nav-title">Популярные категории</p>
          {set $resources =  $_modx->config.popular_categories}
          {if $resources ?}
              {set $lines = $_modx->runSnippet('pdoResources', [
                  'parents' => 0,
                  'depth' => 1000,
                  'offset' => 3,

                  'context' => $_modx->resource.context_key,
                  'tpl' => '@INLINE <a class="footer__nav-item" href="[[+uri]]">[[+menutitle]]</a>',
                  'limit' => 0,
                  'resources' => $resources,
                  'sortby' => 'FIELD(id, '~$resources~')',
                  'sortdir' => 'ASC'
              ])}
            {if $_modx->resource.context_key === 'kirpich-m5'}
              <nav class="footer__nav-list">
                <div class="footer__nav-list-col">
                  {'@FILE snippets/columns.php' | snippet : [
                    'input' => $lines
                    'separator' => "\n"
                    'columns' => 2,
                    'column' => 1
                  ]}
                </div>
                <div class="footer__nav-list-col">
                  {'@FILE snippets/columns.php' | snippet : [
                    'input' => $lines
                    'separator' => "\n"
                    'columns' => 2,
                    'column' => 2
                  ]}
                </div>
              </nav>
            {else}
              <nav class="footer__nav-list">
                {$lines}
              </nav>
            {/if}
          {/if}
          {if $_modx->resource.context_key === 'tagnerud'}
            {set $resources =  '196939,196940,196942,196943'}
            <nav class="footer__nav-list">
              <p class="footer__nav-group">По фракции:
              {$_modx->runSnippet('pdoResources', [
                'parents' => 0,
                'depth' => 1000,
                'tpl' => '@INLINE <a class="footer__nav-item" href="[[+uri]]">[[+menutitle]]</a>',
                'limit' => 0,
                'resources' => $resources,
                'sortby' => 'FIELD(id, '~$resources~')',
                'sortdir' => 'ASC'
              ])}
              </p>
            {set $resources =  '196948,196962,196966'}
            
              <p class="footer__nav-group">По размеру:
              {$_modx->runSnippet('pdoResources', [
                'parents' => 0,
                'depth' => 1000,
                'tpl' => '@INLINE <a class="footer__nav-item" href="[[+uri]]">[[+menutitle]]</a>',
                'limit' => 0,
                'resources' => $resources,
                'sortby' => 'FIELD(id, '~$resources~')',
                'sortdir' => 'ASC'
              ])}
              </p>
            </nav>
          {/if}
          {if $_modx->resource.context_key === 'fibrofasad'}
            {set $resources =  '171090,171056,171128,171133,171123,171124'}
            <nav class="footer__nav-list">
              <p class="footer__nav-group">
              {$_modx->runSnippet('pdoResources', [
                'parents' => 0,
                'depth' => 1000,
                'tpl' => '@INLINE <a class="footer__nav-item" href="[[+uri]]">[[+menutitle]]</a>',
                'limit' => 0,
                'resources' => $resources,
                'sortby' => 'FIELD(id, '~$resources~')',
                'sortdir' => 'ASC'
              ])}
              </p>
            {set $resources =  '171178,171135,171162,171186'}
              <p class="footer__nav-group">
              {$_modx->runSnippet('pdoResources', [
                'parents' => 0,
                'depth' => 1000,
                'tpl' => '@INLINE <a class="footer__nav-item" href="[[+uri]]">[[+menutitle]]</a>',
                'limit' => 0,
                'resources' => $resources,
                'sortby' => 'FIELD(id, '~$resources~')',
                'sortdir' => 'ASC'
              ])}
              </p>
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
      {switch $_modx->context.key}
      {case 'plitnye'}
      <div class="burger-menu__nav-items">
        <a class="burger-menu__nav-link" href="/contacts/">Контакты</a>
        <a class="burger-menu__nav-link" href="/o-kompanii/">О компании</a>
        <a class="burger-menu__nav-link" href="/dostavka-i-oplata/">Доставка</a>
        <a class="burger-menu__nav-link" href="/otzyvy/">Отзывы</a>
      </div>
      {case 'kirpich-m5'}
      <ul class="burger-menu__nav-items">
        <li class="burger-menu__nav-item">
          <a class="burger-menu__nav-link" href="/dostavka-i-oplata/">Доставка и оплата</a>
        </li>
        <li class="burger-menu__nav-item">
          <a class="burger-menu__nav-link" href="/akcii/">Акции</a>
        </li>
        <li class="burger-menu__nav-item"><a class="burger-menu__nav-link" href="/shourum/">Шоурум</a></li>
        <li class="burger-menu__nav-item"><a class="burger-menu__nav-link has-icon icon-star" href="/otzyvy/">Отзывы</a></li>
        <li class="burger-menu__nav-item">
          <a class="burger-menu__nav-link" href="/o-kompanii/">О компании</a>

          {*<div class="burger-menu__submenu">
            <ul><li><a class="burger-menu__sublink has-icon icon-star" href="/otzyvy/">Отзывы</a></li></ul>
          </div>*}

        </li>
        <li class="burger-menu__nav-item">
          <a class="burger-menu__nav-link" href="/contacts/">Контакты</a>
        </li>
      </ul>
      {default}
      <div class="burger-menu__nav-items">
        <a class="burger-menu__nav-link" href="/dostavka-i-oplata/">Доставка и оплата</a>
        <a class="burger-menu__nav-link" href="/akcii/">Акции</a>
        <a class="burger-menu__nav-link" href="/o-kompanii/">О компании</a>
        <a class="burger-menu__nav-link" href="/contacts/">Контакты</a>
      </div>
      {/switch}
    </nav>

    <div class="search header__search header__search_screen_mobile">
      <form action="/search/" method ="GET" class="search__wrapper search search_display_desktop" fast-search-form="desktop">
        <button type="submit" class="search__btn icon-btn icon-btn_style_red">
          <svg class="icon-btn__icon icon-btn__icon_small" aria-hidden="true">
            <use xlink:href="assets/template/pictures/icons.svg#svg-search"></use>
          </svg>
        </button>
        <input name="query" class="search__input" fast-search-input="desktop" type="search" placeholder="Хочу найти..." id="_inp44444444">

      </form>
      <form action="/search/" method ="GET" class="search__wrapper search_display_mobile" fast-search-form="mobile">
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
        'where' => '{"template:IN":[5,36]}',
        'includeTVs' => 'mainImage'
      ]}
      {switch $_modx->resource.context_key}
        {case 'web'}
          {set $params['parents'] = 4}
          {set $params['sortby'] = 'menuindex'}
          {set $params['sortdir'] = 'ASC'}
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
          {set $resources = '125530,125532,125537,125541,125538,125536,125534,125535,125531,125540,125528,125539,125533,125529'}
          {set $params['resources'] = $resources}
          {set $params['parents'] = 0}
          {set $params['sortby'] = 'FIELD(modResource.id, ' ~ $resources ~ ')'}
          {set $params['sortdir'] = 'ASC'}
        {case 'fibrofasad'}
          {set $params['resources'] = '171123,171056,171132,171090,171124'}
        {case 'plitnye'}
          {set $params['parents'] = 177020}
          {set $params['depth'] = 0}
          {set $params['limit'] = 15}
          {set $params['sortby'] = 'menuindex'}
          {set $params['sortdir'] = 'ASC'}
        {case 'trotuarnaya-plitka'}
          {set $params['parents'] = 250499}
          {set $params['resources'] = '250500,250501,250502'}
      {/switch}
      {$_modx->runSnippet('pdoResources', $params)}
    </div>
    {if $_modx->context.key not in ['krovelnyjstroymarket', 'plitnye', 'web']}
    <div class="burger-menu__link-to-catalog-wrap">
      <a class="h-menu__link-to-catalog h-menu__link-to-catalog_bottom h-menu__link-to-catalog_mobile btn btn_style_shadow" href="/catalog/">{$toCatalogBtnText}</a>
    </div>
    {/if}

  </div>
</section>

<a href="#" class="to-top-btn"></a>
