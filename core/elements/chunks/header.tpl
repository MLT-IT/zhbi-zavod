<header class="header">
  <div class="header__mobile">
    <div class="header__container">
      <button class="js-burger-1 header__burger icon-btn icon-btn_style_red">
        <svg class="icon-btn__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-burger"></use>
        </svg>
      </button>

      {switch $_modx->resource.context_key}
        {case 'web'}
          {set $logo = 'alterteplo.png'}
          {set $logoMobile = 'alterteplo.png'}
        {case 'gazosilikatstroy'}
          {set $logo = 'gazosilicatstroy.png'}
          {set $logoMobile = 'gazosilicatstroy.png'}
        {case 'kraska'}
          {set $logo = 'kraska.png'}
          {set $logoMobile = 'kraska.png'}
        {case 'suhiesmesi'}
          {set $logo = 'gazosilicatstroy.png'}
          {set $logoMobile = 'gazosilicatstroy.png'}
        {case 'krovelnyjstroymarket'}
          {set $logo = 'krovelnyjstroymarket.png'}
          {set $logoMobile = 'krovelnyjstroymarket.png'}
      {/switch}

      <div class="h-logo h-logo_mobile">
        <img class="h-logo__image" src="assets/template/pictures/{$logoMobile}">
      </div>
      <div class="header__actions">
          <a href="tel:+7 (812) 627-13-90" class="header__action icon-btn icon-btn_style_black">
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
          {switch $_modx->resource.context_key}
            {case 'web'}
              {set $text = 'утеплителей'}
            {case 'gazosilikatstroy'}
              {set $text = 'газобетона'}
            {case 'kraska'}
              {set $text = 'ЛКМ (краски, эмали, шпатлевки)'}
            {case 'suhiesmesi'}
              {set $text = 'сухих смесей'}
            {case 'krovelnyjstroymarket'}
              {set $text = 'krovelnyjstroymarket'}
          {/switch}
          Продажа {$text} в Санкт-Петербурге
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
        <a class="h-subinfo__link h-subinfo__link_type_mail" href="mailto:{'email' | option}">{'email' | option}</a>
      </div>
      <div class="h-subinfo h-subinfo_size_big">
        <svg class="h-subinfo__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
        </svg><a class="h-subinfo__link h-subinfo__link_type_phone" href="tel:{'phone' | option}">{'phone' | option}</a>
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
          <div class="h-menu__dropdown">
            <nav class="h-nav">
              <a class="h-nav__link" href="/contacts/">Контакты</a>
              <a class="h-nav__link" href="/dostavka-i-oplata/">Доставка и оплата</a>
              <a class="h-nav__link" href="/akcii/">Акции</a>
              <a class="h-nav__link" href="/o-kompanii/">О компании</a>
            </nav>
          </div>
        </div>

        {set $menu = '@FILE snippets/create-menu/createMenu.php' | snippet}

        <div class="h-menu header__catalog" data-dropdown>
          <button class="h-menu__btn btn btn_style_base">Каталог</button>
          <div class="h-menu__dropdown">
            <a class="h-menu__link-to-catalog" href="/catalog/">Перейти в каталог</a>
            <div class="h-catalog">

              <div class="h-catalog__column">
                  <div class="h-catalog__column-header">{$menu['column1']['title']}</div>
                  {foreach $menu['values'] as $catId => $catCols}
                    <a href="{$catCols['column1']['uri']}" class="h-catalog-item h-catalog-item_main{$activeCatId ? '' : ' active'}" data-cat-id="{$catId}">
                      <div class="h-catalog-item__preview">
                          {if $catCols['column1']['img'] is not empty}
                            <img class="h-catalog-item__image" src="{$catCols['column1']['img']}">
                          {elseif $catCols['column1']['svg'] is not empty}
                            <svg class="h-subinfo__svg" aria-hidden="true">
                              <use xlink:href="assets/template/pictures/icons.svg#{$catCols['column1']['svg']}"></use>
                            </svg>
                          {/if}
                      </div>
                      <span class="h-catalog-item__name h-catalog-item__name_bold">{$catCols['column1']['name']}</span>
                    </a>
                    {if $activeCatId is empty}
                        {set $activeCatId = $catId}
                    {/if}
                  {/foreach}
              </div>

              {foreach $menu as $colKey => $colValues}
                {if $colKey in list ['values', 'column1']}
                    {continue}
                {/if}

                <div class="h-catalog__column">
                  <div class="h-catalog__column-header">{$colValues['title']}</div>
                    {foreach $menu['values'] as $catId => $catCols}
                      {if $colValues['type'] == 'composite'}
                        <div class="h-catalog__parts-wrap">
                          {foreach $catCols[$colKey] as $parts}
                            <div class="h-catalog__part">
                              {foreach $parts as $val}
                                <div class="h-catalog-item h-catalog-item_dependent{$activeCatId == $catId ? ' active' : ''}" data-cat-id="{$catId}">
                                  <a href="{$val['uri']}" class="h-catalog-item__name">{$val['name']}</a>
                                </div>
                              {/foreach}
                            </div>
                          {/foreach}
                        </div>
                      {else}
                          {foreach $catCols[$colKey] as $val}
                            <div class="h-catalog-item h-catalog-item_dependent{$activeCatId == $catId ? ' active' : ''}" data-cat-id="{$catId}">
                              <a href="{$val['uri']}" class="h-catalog-item__name h-catalog-item__name_bold">{$val['name']}</a>
                            </div>
                          {/foreach}
                      {/if}
                    {/foreach}
                </div>
              {/foreach}

            </div>
          </div>
        </div>

        <div class="search header__search header__search_screen_desktop">
          <form action="/search/" class="search__wrapper search search_display_desktop" fast-search-form="desktop">
            <button type="submit" class="search__btn icon-btn icon-btn_style_red">
              <svg class="icon-btn__icon icon-btn__icon_small" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-search"></use>
              </svg>
            </button>
            <input name="query" class="search__input" fast-search-input="desktop" type="search" placeholder="Хочу найти...">
          </form>
          <form action="/search/" class="search__wrapper search_display_mobile" fast-search-form="mobile">
            <button type="submit" class="search__btn icon-btn icon-btn_style_red">
              <svg class="icon-btn__icon icon-btn__icon_small" aria-hidden="true">
                <use xlink:href="assets/template/pictures/icons.svg#svg-search"></use>
              </svg>
            </button>
            <input name="query" class="search__input" fast-search-input="mobile" type="search" placeholder="Хочу найти...">
          </form>
        </div>

        <nav class="header__nav h-nav">
          <a class="h-nav__link" href="/contacts/">Контакты</a>
          <a class="h-nav__link" href="/dostavka-i-oplata/">Доставка и оплата</a>
          <a class="h-nav__link" href="/akcii/">Акции</a>
          <a class="h-nav__link" href="/o-kompanii/">О компании</a>
        </nav>
        <div class="header__phonesched">
          <div class="h-subinfo header__phone h-subinfo_size_big">
            <svg class="h-subinfo__icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
            </svg><a class="h-subinfo__link h-subinfo__link_type_phone" href="tel:{'phone' | option}">{'phone' | option}</a>
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
                {set $favComp = $prodValues['checkItems']['comp'] | length}
                {*
                <a href="/comparison/" class="header__comparison header__action icon-btn icon-btn_style_white"{if $favComp > 0} data-amount="{$favComp}"{/if}>
                  <svg class="icon-btn__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-bars"></use>
                  </svg>
                </a>
                *}
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
  </div>
</header>
