<header class="header">
  <div class="header__mobile">
    <div class="header__container">
      <button class="js-burger-1 header__burger icon-btn icon-btn_style_red">
        <svg class="icon-btn__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-burger"></use>
        </svg>
      </button>

      {switch $_modx->resource.context_key}
        {case 'kirpich-m5'}
          {set $logo = 'kirpich-m5.png'}
          {set $logoMobile = 'kirpich-m5.png'}
        {case 'plitnye'}  
          {set $logo = 'plitnyematerialy.png'}
          {set $logoMobile = 'plitnyematerialy.png'}
        {case 'gazosilikatstroy'}
          {set $logo = 'gazosilicatstroy.png'}
          {set $logoMobile = 'gazosilicatstroy.png'}
        {case 'kraska'}
          {set $logo = 'kraska.png'}
          {set $logoMobile = 'kraska.png'}
        {case 'suhiesmesi'}
          {set $logo = 'suhiesmesi.png'}
          {set $logoMobile = 'suhiesmesi.png'}
        {case 'beltermo'}
          {set $logo = 'beltermo.png'}
          {set $logoMobile = 'beltermo.png'}
        {case 'krovelnyjstroymarket'}
          {set $logo = 'krovelnyjstroymarket.png'}
          {set $logoMobile = 'krovelnyjstroymarket.png'}
        {case 'fibrofasad'}
          {set $logo = 'fibrofasad.png'}
          {set $logoMobile = 'fibrofasad.png'}
        {case 'fibrofasad2'}
          {set $logo = 'fibrofasad.png'}
          {set $logoMobile = 'fibrofasad.png'}
        {default}
          {set $logo = $_modx->resource.context_key~'.png'}
          {set $logoMobile = $_modx->resource.context_key~'.png'}
      {/switch}

      {set $phone = '!virtual_phone' | snippet }
      {set $phone_href = $phone | ereplace : '[^0-9+]' : ''}
      {set $email = '@FILE snippets/utm/virtual_email.php' | snippet }
      {set $address = 'address' | option}
      {if $_modx->getPlaceholder('localdata').local}
        {set $address = $_modx->getPlaceholder('localdata').offices.0.address}
      {/if}

      <div class="h-logo h-logo_mobile">
        <img class="h-logo__image" src="assets/template/pictures/{$logoMobile}">
      </div>
      <div class="header__actions">
          <a href="tel:{$phone_href}" class="header__action icon-btn icon-btn_style_black">
            <svg class="icon-btn__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
            </svg>
          </a>
          <a href="/cart/" class="header__action icon-btn icon-btn_style_white">
            <svg class="icon-btn__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-basket"></use>
            </svg>
          </a>
      </div>
    </div>
  </div>
  <div class="header__top">
    <div class="header__container">
      <div class="h-subinfo h-subinfo_color_grey">
        <span class="h-subinfo__text">
          {set $beforeText = "Продажа"}
          {set $afterText = "в Санкт-Петербурге"}
          {switch $_modx->resource.context_key}
            {case 'trotuarnaya-plitka'}
              {set $beforeText = ""}
              {set $text = 'Производство и продажа тротуарной плитки'}
              {set $afterText = ""}
            {case 'web'}
              {set $text = 'утеплителей'}
            {case 'gazosilikatstroy'}
              {set $text = 'газобетона'}
            {case 'plitnye'}
              {set $text = 'плитных материалов'}
            {case 'stenovye'}
              {set $text = 'стеновых материалов'}    
            {case 'kraska'}
              {set $text = 'ЛКМ (краски, эмали, шпатлевки)'}
            {case 'suhiesmesi'}
              {set $text = 'сухих смесей'}
            {case 'beltermo'}
              {set $text = 'Белтермо'}
            {case 'fibrofasad'}
              {set $beforeText = ""}
              {set $afterText = ""}
              {set $text = 'Продажа фиброфасада в Санкт-Петербурге и ЛО'}
            {case 'fibrofasad2'}
              {set $beforeText = ""}
              {set $afterText = ""}
              {set $text = 'Продажа фиброфасада в Санкт-Петербурге и ЛО'}
            {case 'krovelnyjstroymarket'}
              {set $beforeText = ""}
              {set $text = 'Производство и продажа кровельных материалов'}
              {set $afterText = ""}
            {case 'tagnerud'}
              {set $text = 'керамзита'}
            {case 'profnastil'}
              {set $text = 'Продажа профнастила в Санкт-Петербурге и ЛО'}
              {set $beforeText = ""}
              {set $afterText = ""}

            {case 'gibkaya-cherepiza'}
              {set $text = 'Продажа гибкой черепицы в Санкт-Петербурге и ЛО'}
              {set $beforeText = ""}
              {set $afterText = ""}
            {case 'falcevaya-krovlya'}
              {set $text = 'Продажа фальцевой кровли в Санкт-Петербурге и ЛО'}
              {set $beforeText = ""}
              {set $afterText = ""}
            {case 'metallocherepica'}
              {set $text = 'Продажа металлочерепицы в Санкт-Петербурге и ЛО'}
              {set $beforeText = ""}
              {set $afterText = ""}
            {case 'kirpich-m5'}
              {set $text = 'кирпича'}

          {/switch}
          {$beforeText} {$text} {$afterText}
        </span>
      </div>
      <div class="h-subinfo h-subinfo_display_widescreen">
        <svg class="h-subinfo__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-calendar-sm"></use>
        </svg><span class="h-subinfo__text">Ежедневно: 8:00&nbsp;-&nbsp;21:00</span>
      </div>
      <div class="h-subinfo">
        <svg class="h-subinfo__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-email-sm"></use>
        </svg>
        <a class="h-subinfo__link h-subinfo__link_type_mail" href="mailto:{$email}">{$email}</a>
      </div>
      <div class="h-subinfo h-subinfo_size_big">
        <svg class="h-subinfo__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
        </svg><a class="h-subinfo__link h-subinfo__link_type_phone" href="tel:{$phone_href}">{$phone}</a>
      </div><a class="btn btn_size_small btn_style_trans" data-fancybox href="#callback">Заказать звонок</a>
    </div>
  </div>
  <div class="header__bottom">
    <div class="header__container">
      <a href="/" class="h-logo">
        <img class="h-logo__image" src="assets/template/pictures/{$logo}">
      </a>
      <div class="header__toolbar">
        <div class="h-menu header__menu" data-dropdown>
          <button class="h-menu__btn btn btn_style_base">Меню</button>
          {if $_modx->resource.context_key == 'kirpich-m5'}
          {set $add_classes = 'u-marginLeft16'}
          {else}
          {set $add_classes = ''}
          {/if}
          <div class="h-menu__dropdown">
            <nav>
              <ul class="h-nav">
                <li class="h-nav__item"><a class="h-nav__link {$add_classes}" href="/dostavka-i-oplata/">Доставка и оплата</a></li>
                <li class="h-nav__item"><a class="h-nav__link {$add_classes}" href="/akcii/">Акции</a></li>
                {switch $_modx->resource.context_key}
                {case 'web'}
                  <li class="h-nav__item"><a class="h-nav__link has-icon icon-star" href="/otzyivyi/">Отзывы</a></li>
                {case 'trotuarnaya-plitka'}
                  <li class="h-nav__item"><a class="h-nav__link" href="/otzyvy/">Отзывы</a></li>
                {case 'kirpich-m5'}
                  {set $items}
                  <li class="h-nav__item"><a class="h-nav__link {$add_classes}" href="/shourum/">Шоурум</a></li>
                  <li class="h-nav__item"><a class="h-nav__link has-icon icon-star" href="/otzyvy/">Отзывы</a></li>
                  {/set}
                {default}
                {/switch}
                <li class="h-nav__item"><a class="h-nav__link {$add_classes}" href="/o-kompanii/">О компании</a></li>
                {$items}
                <li class="h-nav__item"><a class="h-nav__link {$add_classes}" href="/contacts/">Контакты</a></li>
              </ul>
            </nav>
          </div>
        </div>

        {if $_modx->context.key == 'trotuarnaya-plitka'}
          {include "file:chunks/desktop-catalog-menu/v2.tpl"}
        {else}
          {include "file:chunks/desktop-catalog-menu/v1.tpl"}
        {/if}

        <div class="search header__search header__search_screen_desktop">
          <form action="/search/" method="GET" class="search__wrapper search search_display_desktop" fast-search-form="desktop">
            <button type="submit" class="search__btn icon-btn icon-btn_style_red">
              <svg class="icon-btn__icon icon-btn__icon_small" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-search"></use>
              </svg>
            </button>
            <input name="query" class="search__input" fast-search-input="desktop" type="search" placeholder="Хочу найти...">
          </form>
          <form action="/search/" method="GET" class="search__wrapper search_display_mobile" fast-search-form="mobile1">
            <button type="submit" class="search__btn icon-btn icon-btn_style_red">
              <svg class="icon-btn__icon icon-btn__icon_small" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-search"></use>
              </svg>
            </button>
            <input name="query" class="search__input" fast-search-input="mobile1" type="search" placeholder="Хочу найти1...">
            
          </form>
        </div>

        {insert 'file:_modules/top_menu/top_menu.tpl'}
        
        <div class="header__phonesched">
          <div class="h-subinfo header__phone h-subinfo_size_big">
            <svg class="h-subinfo__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
            </svg><a class="h-subinfo__link h-subinfo__link_type_phone" href="tel:{$phone_href}">{$phone}</a>
          </div>
          <div class="h-subinfo header__schedule">
            <svg class="h-subinfo__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-calendar-sm"></use>
            </svg><span class="h-subinfo__text">Ежедневно: 8:00&nbsp;-&nbsp;21:00</span>
          </div>
        </div>
        <a class="header__callback-btn btn btn_size_small btn_style_trans" data-fancybox href="#callback">Заказать звонок</a>
        <div class="header__actions">
            <div class="header__actions-pc">
                {set $favLen = $_modx->getPlaceholder('checkItems')['fav'] | length}
                <a href="/favorites/" class="header__action_type_favorites header__action icon-btn icon-btn_style_white"{if $favLen > 0} data-amount="{$favLen}"{/if}>
                  <svg class="icon-btn__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-heart"></use>
                  </svg>
                </a>
                {set $favComp = $_modx->getPlaceholder('checkItems')['comp'] | length}
                <a href="/comparison/" class="header__comparison header__action icon-btn icon-btn_style_white"{if $favComp > 0} data-amount="{$favComp}"{/if}>
                  <svg class="icon-btn__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-bars"></use>
                  </svg>
                </a>
                {'!msMiniCartCustom' | snippet : ['tpl' => '@FILE: chunks/msMiniCart.tpl']}
                <a data-fancybox href="#callback" class="header__action_type_callback header__action icon-btn icon-btn_style_white">
                  <svg class="icon-btn__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
                  </svg>
                </a>
            </div>
            <div class="header__actions-mobile">
                <span class="btn btn_style_shadow header__actions-mobile-reset" data-dropdown-only-close="1" data-dropdown-body-doc=".filter">Сбросить фильтр</span>
                <span class="btn btn_style_shadow header__actions-mobile-apply" data-dropdown-only-close="1" data-dropdown-body-doc=".filter">Применить</span>
            </div>
        </div>

        <button class="js-burger-2 header__right-burger header__burger icon-btn icon-btn_style_red">
          <svg class="icon-btn__icon" aria-hidden="true">
            <use xlink:href="assets/template/pictures/icons.svg#svg-burger"></use>
          </svg>
        </button>
      </div>
    </div>
    {if $_modx->context.key in list ['krovelnyjstroymarket', 'plitnye']}
      {include 'file:chunks/nav/extranav.tpl'}
    {/if}
  </div>
</header>
