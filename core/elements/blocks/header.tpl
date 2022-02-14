<div class="header-sticky"></div>
<div class="mobile-sticky-header"></div>
<div class="mobile-header"></div>

<header class="header">
    <div class="header__wrapper wrapper">
        <span class="header__burger burger">
            <span class="burger__stick"></span>
            <span class="burger__stick"></span>
            <span class="burger__stick"></span>
        </span>
        <div class="header__line header__line_type_about">
            <div class="header__about">
                <a class="header__about-phone" href="tel:{'!utm' | snippet : ['val' => 'phone']}">{'!utm' | snippet : ['val' => 'phone']}</a>
                <div class="header__about-text">
                    Поставка
                    {if $_modx->context.key == 'krovlya'}
                        кровли
                    {elseif $_modx->context.key == 'kirpich-m'}
                        кирпича
                    {elseif $_modx->context.key == 'fasady-pro'}
                        деревянных фасадов
                    {else}
                        утеплителя {$brand}
                    {/if}
                    по Санкт-Петербургу и Ленинградской области
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
            <a href="/" class="header__logo-wrap">
                <img class="header__logo" src="/assets/template/img/logos/{$site_context}.svg">
            </a>
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
                                                    <a class="header__menu-item" href="{$item.uri}">
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

                <a class="header__favorites" href="/favorites/">
                    <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                    </svg>
                    <span class="header__fav-value">{$_modx->getPlaceholder('checkItems')['fav'] | length}</span>
                    <span class="header__favorites-text">Избранное</span>
                </a>
                <a class="header__comparison" href="/comparison/">
                    <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                    </svg>
                    <span class="header__comp-value">{$_modx->getPlaceholder('checkItems')['comp'] | length}</span>
                    <span class="header__comparison-text">Сравнение</span>
                </a>

                {'!msMiniCart' | snippet : ['tpl' => '@FILE: chunks/msMiniCart.tpl']}
            </div>
        </div>

        <div class="header__nav-list">
            <span class="header__nav-item"><a class="header__nav-link" href="/dostavka-i-oplata/">Доставка и оплата</a></span>

            {set $certs = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'certs']}
            {set $faq = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'faq']}
            {set $akcii = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'akcii']}
            {if $certs->hidemenu == 0}
                <span class="header__nav-item"><a class="header__nav-link" href="/certs/">Сертификаты</a></span>
            {/if}
            {if $faq->hidemenu == 0}
                <span class="header__nav-item"><a class="header__nav-link" href="/faq/">Вопросы-ответы</a></span>
            {/if}
            {if $akcii->hidemenu == 0}
                <span class="header__nav-item"><a class="header__nav-link" href="/akcii/">Акции</a></span>
            {/if}

            <span class="header__nav-item"><a class="header__nav-link" href="/contacts/">Контакты</a></span>

            <a class="header__email" href="mailto:{'!utm' | snippet : ['val' => 'email']}">
                {'!utm' | snippet : ['val' => 'email']}
            </a>
        </div>

        {include 'file:chunks/mobileMenu.tpl'}
    </div>
</header>
