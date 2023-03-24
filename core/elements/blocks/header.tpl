<div class="header-sticky"></div>
<div class="mobile-sticky-header"></div>
<div class="mobile-header"></div>

<header class="header" data-hello="1">
  <div class="header__mobile">
    <div class="header__container">
      <button class="header__burger icon-btn icon-btn_style_red">
        <svg class="icon-btn__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-burger"></use>
        </svg>
      </button>
      <div class="h-logo h-logo_mobile"><img class="h-logo__image" src="assets/template/pictures/logo-mob.svg" alt="monolit-logo"></div>
      <div class="header__actions">
        <button class="header__action icon-btn icon-btn_style_black">
          <svg class="icon-btn__icon" aria-hidden="true">
            <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
          </svg>
        </button>
        <button class="header__action icon-btn icon-btn_style_white">
          <svg class="icon-btn__icon" aria-hidden="true">
            <use xlink:href="assets/template/pictures/icons.svg#svg-basket"></use>
          </svg>
        </button>
      </div>
    </div>
  </div>
  <div class="header__top">
    <div class="header__container">
      <div class="h-subinfo h-subinfo_color_grey"><span class="h-subinfo__text">Продажа газобетона в Санкт-Петербурге</span></div>
      <div class="h-subinfo h-subinfo_display_widescreen">
        <svg class="h-subinfo__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-calendar-sm"></use>
        </svg><span class="h-subinfo__text">Ежедневно: 8:00&nbsp;-&nbsp;21:00</span>
      </div>
      <div class="h-subinfo">
        <svg class="h-subinfo__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-email-sm"></use>
        </svg>
        <a class="h-subinfo__link" href="mailto:{'email' | option}">{'email' | option}</a>
      </div>
      <div class="h-subinfo h-subinfo_size_big">
        <svg class="h-subinfo__icon" aria-hidden="true">
          <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
        </svg><a class="h-subinfo__link" href="tel:{'phone' | option}">{'phone' | option}</a>
      </div><a class="btn btn_size_small btn_style_trans" data-fancybox href="#callback">Заказать звонок</a>
    </div>
  </div>
  <div class="header__bottom">
    <div class="header__container">
      <a href="/" class="h-logo">
        <img class="h-logo__image" src="assets/template/pictures/logo.svg" alt="monolit-logo">
      </a>
      <div class="header__toolbar">
        <div class="h-menu header__menu" data-dropdown>
          <button class="h-menu__btn btn btn_style_base">Меню</button>
          <div class="h-menu__dropdown">
            <nav class="h-nav"><a class="h-nav__link" href="/o-kompanii/">О компании</a><a class="h-nav__link" href="/akcii/">Акции</a><a class="h-nav__link" href="/dostavka-i-oplata/">Доставка и оплата</a><a class="h-nav__link" href="/contacts/">Контакты</a>
            </nav>
          </div>
        </div>
        <div class="h-menu header__catalog" data-dropdown>
          <button class="h-menu__btn btn btn_style_base">Каталог</button>
          <div class="h-menu__dropdown">
            {set $menu = '@FILE snippets/createMenu.php' | snippet}
            <table class="h-catalog">
              <thead>
              <tr>
                <th class="h-catalog__title">Товар</th>
                <th class="h-catalog__title">Плотность</th>
                <th class="h-catalog__title">Размеры</th>
              </tr>
              </thead>
              <tbody>
                {foreach $menu as $row}
                  <tr class="h-catalog__row">

                    <td class="h-catalog__item h-catalog__item_border">
                      {if $row['param3'] ?}
                        <div class="h-catalog-item">
                          <div class="h-catalog-item__preview">
                            <img class="h-catalog-item__image" src="{$row['param1']['img']}" alt="{$row['param1']['text']}">
                          </div>
                          <a href="{$row['param1']['link']}" class="h-catalog-item__name h-catalog-item__name_bold">{$row['param1']['text']}</a>
                        </div>
                      {/if}
                    </td>

                    <td class="h-catalog__item">
                      {if $row['param2'] ?}
                        <div class="h-catalog-item">
                          <a href="{$row['param2']['link']}" class="h-catalog-item__name">{$row['param2']['text']}</a>
                        </div>
                      {/if}
                    </td>

                    <td class="h-catalog__item">
                      {if $row['param3'] ?}
                        <div class="h-catalog-item">
                          <a href="{$row['param3']['link']}" class="h-catalog-item__name">{$row['param3']['text']}</a>
                        </div>
                      {/if}
                    </td>

                  </tr>
                {/foreach}
              </tbody>
            </table>
          </div>
        </div>
        <div class="search header__search">
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
        <nav class="header__nav h-nav"><a class="h-nav__link" href="/o-kompanii/">О компании</a><a class="h-nav__link" href="/akcii/">Акции</a><a class="h-nav__link" href="/dostavka-i-oplata/">Доставка и оплата</a><a class="h-nav__link" href="/contacts/">Контакты</a>
        </nav>
        <div class="header__actions">
          {set $favLen = $_modx->getPlaceholder('checkItems')['fav'] | length}
          <a href="/favorites/" class="header__favorites header__action icon-btn icon-btn_style_white"{if $favLen > 0} data-amount="{$favLen}"{/if}>
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
        </div>
      </div>
    </div>
  </div>
</header>
