<div class="header-sticky"></div>
<div class="mobile-sticky-header"></div>
<div class="mobile-header"></div>

<header class="header">
    <div class="header__wrapper wrapper">
        <a href="#" class="header__burger burger">
            <span class="burger__stick"></span>
            <span class="burger__stick"></span>
            <span class="burger__stick"></span>
        </a>
        <div class="header__line header__line_type_about">
            <div class="header__about">
                <a class="header__about-phone" href="tel:{'!utm' | snippet : ['val' => 'phone']}">{'!utm' | snippet : ['val' => 'phone']}</a>
                <div class="header__about-text">
                    Поставка
                    {if $_modx->context.key != 'krovlya'}
                        утеплителя {$brand}
                    {else}
                        кровли
                    {/if}
                    по Санкт-Петербургу и Ленинградской области от официального дилера
                </div>
                {*<a href="#" class="header__about-city">Санкт-Петербург и Ленинградская область</a>*}
            </div>
            <div class="header__contacts">
                <div class="header__contacts-city">{'address' | option}</div>
                <div class="header__contacts-time">Часы работы: с 8:00 до 21:00</div>
            </div>
            <div class="header__callback-wrap">
                <a class="header__phone" href="tel:{'!utm' | snippet : ['val' => 'phone']}">{'!utm' | snippet : ['val' => 'phone']}</a>
                <a data-btn-key="header-link" class="header__callback" data-fancybox="" href="#callback">
                    <svg class="svg icon-phone" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 17 17" width="17" height="17">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-phone"></use>
                    </svg>
                    Заказать звонок
                </a>
            </div>
        </div>
        <div class="header__line header__line_type_elems">
            {if $_modx->context.key != 'krovlya'}
                <a href="/" class="header__logo-wrap">
                    <img class="header__logo" src="/assets/template/img/logos/{$site_context}.png">
                </a>
            {else}
                <a href="/" class="header__logo-text-wrap">
                    <span class="header__logo-text">Кровельная компания №1</span>
                </a>
            {/if}
            <div class="header__catalog">
                <div class="header__catalog-btn">
                    <div class="burger">
                        <span class="burger__stick"></span>
                        <span class="burger__stick"></span>
                        <span class="burger__stick"></span>
                    </div>
                    <span class="header__catalog-text">Каталог</span>
                </div>
                <div class="header__catalog-menu header__catalog-menu_width_full">
                    <div class="header__catalog-menu-inner">
                        <a href="/catalog/" class="header__catalog-menu-header">Перейти в каталог</a>
                        {set $menu = 'createMenu' | snippet}
                        {foreach $menu as $key => $menuTypes}
                            <div class="header__catalog-menu-type">
                                <p class="header__column-header">{$key}</p>
                                <div class="header__columns-wrap">
                                    {foreach $menuTypes as $items}
                                        <div class="header__column">
                                            <div class="header__column-items-wrap">
                                                {foreach $items as $item}
                                                    <a class="header__menu-item" href="/{$item.uri}">
                                                        {$item.name}
                                                    </a>
                                                {/foreach}
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>

            <form action="/search/" class="header__search-wrap">
                <input class="header__search" placeholder="Поиск по сайту" name="query">
                <button type="submit" class="header__search-btn"></button>
            </form>

            <div class="header__btns-wrap">
                <a class="header__cat" href="/catalog/">
                    <span class="header__cat-icon">
                        <span class="header__cat-icon-stick"></span>
                        <span class="header__cat-icon-stick"></span>
                        <span class="header__cat-icon-stick"></span>
                    </span>
                    <span class="header__cat-text">Каталог</span>
                </a>

                <a class="header__mobile-phone" href="tel:{'phone' | option | phone}">
                    <svg class="svg icon-phone" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 17 17" width="17" height="17">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-phone"></use>
                    </svg>
                    <span class="header__mobile-phone-text">Телефон</span>
                </a>

                {'!msMiniCart' | snippet : ['tpl' => '@FILE: chunks/msMiniCart.tpl']}

                {*
                <a class="header__fav" href="#">
                    <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                    </svg>
                    <span class="header__fav-value">5</span>
                    <span class="header__fav-text">Избранное</span>
                </a>
                *}
            </div>
        </div>

        {include 'file:chunks/mobileMenu.tpl'}

    </div>
</header>
