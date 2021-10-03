<header class="header">
    <div class="header__wrapper wrapper">
        <a href="#" class="header__burger burger">
            <span></span>
            <span></span>
            <span></span>
        </a>
        <div class="header__line header__line_type_about">
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
        <div class="header__line header__line_type_elems">
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
                <input class="header__search" placeholder="Поиск по сайту" name="search">
                <button class="header__search-btn"></button>
            </form>

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
        <nav class="header__nav">
            <p class="header__nav-header">Каталог</p>
            <form class="header__search-wrap" name="search">
                <input class="header__search" placeholder="Поиск по сайту">
                <button class="header__search-btn"></button>
            </form>
            <ul class="header__nav-list">
                <li class="header__nav-item"><a class="header__nav-link" href="{'3' | url}">Доставка и оплата</a></li>
                <li class="header__nav-item"><a class="header__nav-link" href="#">Гарантии</a></li>
                <li class="header__nav-item sale"><a class="header__nav-link" href="#">Скидки</a></li>
                <li class="header__nav-item"><a class="header__nav-link" href="#">Акции</a></li>
                <li class="header__nav-item"><a class="header__nav-link" href="#">О компании</a></li>
                {*
                <li class="header__nav-item openable"><a href="#">О компании</a>
                    <ul class="header__nav-sublist">
                        <li><a href="#">Вопрос-ответ</a></li>
                        <li><a href="#">Отзывы</a></li>
                    </ul>
                </li>
                *}
                <li class="header__nav-item"><a class="header__nav-link" href="{'2' | url}">Контакты</a></li>
                <li class="header__nav-item header__nav-item_special"><a class="header__nav-link" href="#">Акции</a>
            </ul>
        </nav>
    </div>
</header>
