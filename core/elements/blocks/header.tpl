<div class="header-sticky"></div>
<div class="mobile-sticky-header"></div>
<div class="mobile-header"></div>

{* Эта переменная используется не только тут, но и в chunks/mobileMenu.tpl. Так что повнимательнее, если захочешь удалить ее *}
{set $menuIsSimple = $_modx->resource.context_key not in list ['krovlya', 'kirpich-m', 'armatura-178', 'plitaosb', 'fasad']}

<header class="header">
    <div class="header__wrapper wrapper">
        <span class="header__burger burger">
            <span class="burger__stick"></span>
            <span class="burger__stick"></span>
            <span class="burger__stick"></span>
        </span>
        <div class="header__line header__line_type_about">
            <div class="header__about">
                <a class="header__about-phone" href="tel:{'phone' | option}">{'phone' | option}</a>

                <div class="header__about-text">
                    Поставка
                    {if $_modx->context.key == 'krovlya'}
                        кровли
                    {elseif $_modx->context.key == 'pilomat'}
                        пиломатериалов
                    {elseif $_modx->context.key == 'kirpich-m'}
                        кирпича
                    {elseif $_modx->context.key == 'fasady-pro'}
                        деревянных фасадов
                    {elseif $_modx->context.key == 'fasad'}
                        фасадов
                    {elseif $_modx->context.key == 'armatura-178'}
                        арматуры
                    {elseif $_modx->context.key == 'asconcrete'}
                        асфальтобетона
                    {elseif $_modx->context.key == 'plitaosb'}
                        плит ОСБ
                    {elseif $_modx->context.key == 'pro-fanera'}
                        фанеры
                    {elseif $_modx->context.key == 'plity-mdvp'}
                        плит МДВП
                    {else}
                        утеплителя {$brand}
                    {/if}
                    по Санкт-Петербургу и Ленинградской области
                </div>

                {*<a href="#" class="header__about-city">Санкт-Петербург и Ленинградская область</a>*}
            </div>
            <div class="header__contacts">
                <div class="header__contacts-city">
                    {'address' | option}
                </div>
                <div class="header__contacts-time">Часы работы: ежедневно с 8:00 до 21:00</div>
            </div>
            <div class="header__callback-wrap">
                <a class="header__phone" href="tel:{'phone' | option}">{'phone' | option}</a>
                <span data-btn-key="header-link" class="header__callback" data-fancybox="" data-src="#callback">
                    <svg class="svg icon-phone" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 17 17" width="17" height="17">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-phone"></use>
                    </svg>
                    Заказать звонок
                </span>
            </div>
        </div>
        <div class="header__line header__line_type_elems">
            <a href="/" class="header__logo-wrap">
                {if $_modx->resource.context_key === 'plitaosb'}
                    {*
                    <picture>
                        <source srcset="/assets/template/img/logos/plitaosb-mobile.png" media="(max-width: 768px)">
                        <img class="header__logo" src="/assets/template/img/logos/plitaosb.png">
                    </picture>
                    *}
                    <img class="header__logo" src="/assets/template/img/logos/{$site_context}.png">
                {else}
                    <img class="header__logo" src="/assets/template/img/logos/{$site_context}.svg">
                {/if}
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

                        {if $menuIsSimple}
                            {foreach $menu as $key => $menuTypes}
                                <div class="header__catalog-menu-type">
                                    <p class="header__column-header">{$key}</p>
                                    <div class="header__columns-wrap">
                                        {foreach $menuTypes as $items}
                                            <div class="header__column">
                                                <div class="header__column-items-wrap">
                                                    {foreach $items as $item}
                                                        <a class="header__menu-item" data-val="{$item.name}" href="{$item.uri}">
                                                            {$item.name}
                                                        </a>
                                                    {/foreach}
                                                </div>
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                            {/foreach}
                        {else}
                            {foreach $menu as $column}
                                <div class="header__catalog-menu-type">
                                    {foreach $column as $items}
                                        <div class="header__column">
                                            <p class="header__column-header">
                                                {if $items.uri ?}
                                                    <a class="header__column-header-link" href="{$items.uri}">{$items.name}</a>
                                                {else}
                                                    <span>{$items.name}</span>
                                                {/if}
                                            </p>

                                            <div class="header__columns-wrap">
                                                <div class="header__column-items-wrap">
                                                    {foreach $items.children as $item}
                                                        <a class="header__menu-item" data-val="{$item.name}" href="{$item.uri}">
                                                            {$item.name}
                                                        </a>
                                                    {/foreach}
                                                </div>
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            {/foreach}
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

                {'!msMiniCartCustom' | snippet : ['tpl' => '@FILE: chunks/msMiniCart.tpl']}
            </div>
        </div>

        <div class="header__nav-list">
            {set $about = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'o-kompanii']}
            {set $garantii = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'garantii']}
            {set $certs = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'certs']}
            {set $faq = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'faq']}
            {set $akcii = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'akcii']}

            {if $about['hidemenu'] == 0 && $about['published'] == 1}
                <span class="header__nav-item"><a class="header__nav-link" href="/o-kompanii/">О компании</a></span>
            {/if}

            <span class="header__nav-item"><a class="header__nav-link" href="/dostavka-i-oplata/">Доставка и оплата</a></span>

            {if $certs['hidemenu'] == 0 && $certs['published'] == 1}
                <span class="header__nav-item"><a class="header__nav-link" href="/certs/">Сертификаты</a></span>
            {/if}
            {if $faq['hidemenu'] == 0 && $faq['published'] == 1}
                <span class="header__nav-item"><a class="header__nav-link" href="/faq/">Вопросы-ответы</a></span>
            {/if}
            {if $garantii['hidemenu'] == 0 && $garantii['published'] == 1}
                <span class="header__nav-item"><a class="header__nav-link" href="/garantii/">Гарантии</a></span>
            {/if}
            {if $akcii['hidemenu'] == 0 && $akcii['published'] == 1}
                <span class="header__nav-item"><a class="header__nav-link" href="/akcii/">Акции</a></span>
            {/if}

            <span class="header__nav-item"><a class="header__nav-link" href="/contacts/">Контакты</a></span>

            <a class="header__email" href="mailto:{'email' | option}">
                {'email' | option}
            </a>
        </div>

        {include 'file:chunks/mobileMenu.tpl'}
    </div>
</header>
