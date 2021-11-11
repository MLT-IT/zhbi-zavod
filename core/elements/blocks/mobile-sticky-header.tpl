<div class="mobile-sticky-header"><a class="mobile-sticky-header__logo" href="./">
        <svg class="svg logo-full" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#logo-full"></use>
        </svg></a>
    <div class="mobile-sticky-header__about">Комплексная поставка строительных материалов</div>
    <div class="mobile-sticky-header__burger">
        <div class="burger js-burger">
            <span class="burger__stick"></span>
            <span class="burger__stick"></span>
            <span class="burger__stick"></span>
        </div>
    </div>

    {'!msMiniCart' | snippet : ['tpl' => '@FILE: chunks/msMiniCartMobile.tpl']}

    <div class="mobilemenu">
        <div class="mobilemenu__search">
            <input type="search" name="" placeholder="Поиск">
            <svg class="svg zoom" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 17 17" width="17" height="17">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#zoom"></use>
            </svg>
        </div>
        <div class="mobilemenu__products">
            <a class="mobilemenu__products-item" href="/catalog/nerudnye-materialy/">
                <img src="{$_modx->config['template_path']}img/sidebar/products-1.png" alt="">
                <span>Нерудные материалы </span>
            </a>
            <a class="mobilemenu__products-item" href="/catalog/beton/">
                <img src="{$_modx->config['template_path']}img/sidebar/products-2.png" alt="">
                <span>Бетон товарный</span>
            </a>
            <a class="mobilemenu__products-item" href="/catalog/zhbi/">
                <img src="{$_modx->config['template_path']}img/sidebar/products-3.png" alt="">
                <span>ЖБИ изделия </span>
            </a>
            <a class="mobilemenu__products-item" href="/catalog/metalloprokat/">
                <img src="{$_modx->config['template_path']}img/sidebar/products-4.png" alt="">
                <span>Металлопрокат</span>
            </a>
            <a class="mobilemenu__products-item" href="/catalog/stenovye-materialy/">
                <img src="{$_modx->config['template_path']}img/sidebar/products-5.png" alt="">
                <span>Стеновые материалы</span>
            </a>
            <a class="mobilemenu__products-item" href="/catalog/krovelnye-materialy/">
                <img src="{$_modx->config['template_path']}img/sidebar/products-6.png" alt="">
                <span>Кровельные материалы</span>
            </a>
            <a class="mobilemenu__products-item" href="/catalog/uteplitel/">
                <img src="{$_modx->config['template_path']}img/sidebar/products-7.png" alt="">
                <span>Утеплитель</span>
            </a>
        </div>

        <div class="mobilemenu__list-title">Меню</div>
        {*  TODO: мобильное меню  *}
        <ul class="mobilemenu__list">
            <li><a href="/catalog/">Каталог</a></li>
            <li><a href="/dostavka-i-oplata/">Доставка и оплата</a></li>
            <li><a href="/contacts/">Контакты</a></li>
        </ul>
{*        <div class="mobilemenu__list-title">Меню</div>*}
{*        <ul class="mobilemenu__list">*}
{*            <li><a href="#">Кровельные материалы</a></li>*}
{*            <li><a href="#">Металлопрокат</a></li>*}
{*            <li><a href="#">Кровельные материалы</a></li>*}
{*            <li><a href="#">Бетон товарный</a></li>*}
{*            <li><a href="#">Бетон товарный</a></li>*}
{*            <li><a href="#">Бетон товарный</a></li>*}
{*        </ul>*}
        <a class="yellow-btn" href="#callback" data-fancybox="">Заказать звонок</a>
        <div class="mobilemenu__address"><b>{'address' | option}</b><span>Часы работы: с 8:00 до 21:00</span></div>
        <div class="mobilemenu__social">
            <a href="#">
                <svg class="svg icon-inst" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-inst"></use>
                </svg>
            </a>
            <a href="#">
                <svg class="svg icon-vk" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-vk"></use>
                </svg>
            </a>
            <a href="#">
                <svg class="svg icon-yt" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-yt"></use>
                </svg>
            </a>
            <a href="#">
                <svg class="svg icon-face" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-face"></use>
                </svg>
            </a>
        </div>
        <div class="mobilemenu__info"><span>ООО «СК «Монолит»</span><a href="mailto:{$_pls['+email']}">{$_pls['+email']}</a></div>
    </div>
</div>
