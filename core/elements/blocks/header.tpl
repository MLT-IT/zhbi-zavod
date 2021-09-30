<div class="header-sticky">
    <div class="header-sticky__search">
        <input type="search" name="" placeholder="Поиск">
        <svg class="svg zoom" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 17 17" width="17" height="17">
            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#zoom"></use>
        </svg>
    </div>
    <div class="header-sticky__right">
        <div class="header-sticky__contacts">
            <div class="header-sticky__contacts-phone">
                <svg class="svg icon-phone" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 17 17" width="17" height="17">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-phone"></use>
                </svg>
                <a href="tel:{'phone' | option}">{'phone' | option}</a>
            </div>
            <a class="header-sticky__contacts-callback" data-fancybox="" href="#callback">Заказать звонок</a>
        </div>
        <div class="header-sticky__menu">
            <div class="header-sticky__catalog">Каталог
                <div class="burger">
                    <span></span><span></span><span></span></div>
                <ul class="header-sticky__catalog-list">
{*                    <li class="header-sticky__catalog-item"><a href="#">Металлопрокат</a></li>*}
                </ul>
            </div>

            {'!msMiniCart' | snippet : ['tpl' => '@FILE: chunks/msMiniCartSticky.tpl']}

        </div>
    </div>
</div>
<header class="header">
    <div class="wrapper is-wide">
        <div class="header__top">
            <a class="header__logo-wrap">
                <img class="header__logo" src="/assets/template/img/logo.png">
            </a>
            <div class="header__catalog">
                <div class="burger"><span></span><span></span><span></span></div>
                <ul class="header__catalog-list">
{*                    <li class="header__catalog-item"><a href="#">Металлопрокат</a></li>*}
                </ul>
            </div>
            <div class="header__about">
                <div class="header__about-text">Комплексная поставка строительных материалов</div>
                <div class="header__about-city">Санкт-Петербург и Ленинградская область</div>
            </div>
            <div class="header__contacts">
                <div class="header__contacts-city">{'address' | option}</div>
                <div class="header__contacts-time">Часы работы: с 8:00 до 21:00</div>
            </div>

            {'!msMiniCart' | snippet : ['tpl' => '@FILE: chunks/msMiniCart.tpl']}

        </div>
        <nav class="header__nav">
            <ul class="header__nav-list">
                <li class="header__nav-item"><a href="{'4' | url}">Каталог</a></li>
                <li class="header__nav-item"><a href="{'3' | url}">Доставка и оплата</a></li>
{*                <li class="header__nav-item"><a href="#">Гарантии</a></li>*}
{*                <li class="header__nav-item sale"><a href="#">Скидки</a></li>*}
{*                <li class="header__nav-item"><a href="#">Акции</a></li>*}
{*                <li class="header__nav-item openable"><a href="#">О компании</a>*}
{*                    <ul class="header__nav-sublist">*}
{*                        <li><a href="#">Вопрос-ответ</a></li>*}
{*                        <li><a href="#">Отзывы</a></li>*}
{*                    </ul>*}
{*                </li>*}
                <li class="header__nav-item"><a href="{'2' | url}">Контакты</a></li>
            </ul>
        </nav>
    </div>
</header>
