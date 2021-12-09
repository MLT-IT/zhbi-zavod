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
                <div class="header__about-text">Поставка утеплителя {$brand} по Санкт-Петербургу и Ленинградской области</div>
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
            <a href="/" class="header__logo-wrap">
                <img class="header__logo" src="/assets/template/img/logos/{$site_context}.png">
            </a>

            <div class="header__catalog">
                <a class="header__catalog-link" href="/catalog/"></a>
                <div class="burger">
                    <span class="burger__stick"></span>
                    <span class="burger__stick"></span>
                    <span class="burger__stick"></span>
                </div>
                <span class="header__catalog-text">Каталог</span>
                <div class="header__catalog-menu">
                    <div class="header__catalog-menu-inner">
                        {if $_modx->resource.context_key in list ['rockwool', 'penoplex', 'tn']}

                            {set $menu = 'createMenu' | snippet}
                            {foreach $menu as $key => $items}
                                <div class="header__catalog-column">
                                    <p class="header__column-header">{$key}</p>
                                    <div class="header__column-items-wrap">
                                        {foreach $items as $item}
                                            {$item}
                                        {/foreach}
                                    </div>
                                </div>
                            {/foreach}

                        {else}
                            <div class="header__catalog-column">
                                <ul class="header__catalog-list">
                                    {'pdoMenu' | snippet : [
                                    'parents' => '@FILE snippets/getIdByAlias.php' | snippet : ['alias' => 'catalog'],
                                    'depth' => 1000,
                                    'limit' => 0,
                                    'tplOuter' => '@INLINE {$wrapper}',
                                    'tplInner' => '@INLINE {$wrapper}',
                                    'tpl' => '@FILE chunks/catalogCategoryItem.tpl',
                                    'tplCategoryFolder' => '@FILE chunks/catalogCategoryItem.tpl',
                                    'where' => '{"template:=":"5"}',
                                    ]}

                                    {if $site_context === 'isover'}
                                        {set $menutitle = 8861 | resource : 'menutitle'}
                                        {set $pagetitle = 8861 | resource : 'pagetitle'}
                                        {set $uri = 8861 | resource : 'uri' ~ '/'}
                                        {include "file:chunks/catalogCategoryItem.tpl" menutitle=$menutitle pagetitle=$pagetitle uri=$uri}
                                    {/if}
                                </ul>
                            </div>
                        {/if}
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
        <nav class="header__nav">
            <div class="header__nav-text">Поставка утеплителя {$brand} по Санкт-Петербургу и Ленинградской области</div>

            <a href="/catalog/" class="header__nav-header">Каталог</a>
            <form action="/search/" class="header__search-wrap">
                <input class="header__search" placeholder="Поиск по сайту" name="query">
                <button type="submit" class="header__search-btn"></button>
            </form>
            <ul class="header__nav-list mobile">
                {'!pdoResources' | snippet : [
                'tpl' => '@FILE chunks/menuItem.tpl',
                'depth' => 0,
                'limit' => 0,
                'includeTVs' => 'mainImage',
                'parents' => '@FILE snippets/getIdByAlias.php' | snippet : ['alias' => 'catalog'],
                'sortby' => 'menuindex',
                'sortdir' => 'ASC'
                ]}
            </ul>

            <ul class="header__nav-list">
                <li class="header__nav-item"><a class="header__nav-link" href="/dostavka-i-oplata/">Доставка и оплата</a></li>
                {*<li class="header__nav-item"><a class="header__nav-link" href="/garantii/">Гарантии</a></li>*}
                {*<li class="header__nav-item sale"><a class="header__nav-link" href="#">Скидки</a></li>*}
                {*<li class="header__nav-item"><a class="header__nav-link" href="#">Акции</a></li>*}
                {*<li class="header__nav-item"><a class="header__nav-link" href="#">О компании</a></li>*}
                {*
                <li class="header__nav-item openable"><a href="#">О компании</a>
                    <ul class="header__nav-sublist">
                        <li><a href="#">Вопрос-ответ</a></li>
                        <li><a href="#">Отзывы</a></li>
                    </ul>
                </li>
                *}
                <li class="header__nav-item"><a class="header__nav-link" href="/contacts/">Контакты</a></li>
                {*<li class="header__nav-item header__nav-item_special"><a class="header__nav-link" href="#">Акции</a>*}
            </ul>
        </nav>
    </div>
</header>
