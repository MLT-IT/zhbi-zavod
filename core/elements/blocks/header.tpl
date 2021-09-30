<header class="header">
    <div class="wrapper is-wide">
        <div class="header__line">
            <div class="header__about">
                <div class="header__about-text">Комплексная поставка строительных материалов</div>
                <a href="#" class="header__about-city">Санкт-Петербург и Ленинградская область</a>
            </div>
            <div class="header__contacts">
                <div class="header__contacts-city">{'address' | option}</div>
                <div class="header__contacts-time">Часы работы: с 8:00 до 21:00</div>
            </div>
            <div class="header__callback-wrap">
                <a class="header__phone" href="tel:{'phone' | option}">{'phone' | option}</a>
                <a class="header__callback" data-fancybox="" href="#callback">
                    <svg class="svg icon-phone" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 17 17" width="17" height="17">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-phone"></use>
                    </svg>
                    Заказать звонок
                </a>
            </div>
        </div>

        <div class="header__line">
            <a href="/" class="header__logo-wrap">
                <img class="header__logo" src="/assets/template/img/logo.svg">
            </a>
            <a href="#" class="header__catalog">
                <div class="burger">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
                <span class="header__catalog-text">Каталог</span>
                <ul class="header__catalog-list">
                    {*
                    <li class="header__catalog-item"><a href="#">Металлопрокат</a></li>
                    *}
                </ul>
            </a>
            <form class="header__search-wrap">
                <input class="header__search" placeholder="Поиск по сайту">
                <button class="header__search-btn"></button>
            </form>

            {'!msMiniCart' | snippet : ['tpl' => '@FILE: chunks/msMiniCart.tpl']}

            <a class="header__fav" href="#">
                <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                </svg>
                <span class="header__fav-text">Избранное</span>
            </a>
        </div>

        <nav class="header__nav">
            <ul class="header__nav-list">
                <li class="header__nav-item"><a href="{'4' | url}">Каталог</a></li>
                <li class="header__nav-item"><a href="{'3' | url}">Доставка и оплата</a></li>
                {*
                <li class="header__nav-item"><a href="#">Гарантии</a></li>
                <li class="header__nav-item sale"><a href="#">Скидки</a></li>
                <li class="header__nav-item"><a href="#">Акции</a></li>
                <li class="header__nav-item openable"><a href="#">О компании</a>
                    <ul class="header__nav-sublist">
                        <li><a href="#">Вопрос-ответ</a></li>
                        <li><a href="#">Отзывы</a></li>
                    </ul>
                </li>
                *}
                <li class="header__nav-item"><a href="{'2' | url}">Контакты</a></li>
            </ul>
        </nav>
    </div>
</header>
