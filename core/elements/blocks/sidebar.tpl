<div class="sidebar">
    <div class="sidebar__top">
        <a class="sidebar__logo" href="/">
            <svg class="svg logo-full" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#logo-full"></use>
            </svg>
        </a>
        {*
        <div class="sidebar__social">
            {include "file:elements/social-list.tpl"}
        </div>
        *}
    </div>
    <div class="sidebar__products">
        <a class="sidebar__products-item" href="/catalog/nerudnye-materialy/">
            <img src="{$_modx->config['template_path']}img/sidebar/products-1.png" alt="">
            <span>Нерудные материалы</span>
        </a>
        <a class="sidebar__products-item" href="/catalog/beton/">
            <img src="{$_modx->config['template_path']}img/sidebar/products-2.png" alt="">
            <span>Бетон товарный</span>
        </a>
        <a class="sidebar__products-item" href="/catalog/zhbi/">
            <img src="{$_modx->config['template_path']}img/sidebar/products-3.png" alt="">
            <span>ЖБИ изделия </span>
        </a>
        <a class="sidebar__products-item" href="/catalog/metalloprokat/">
            <img src="{$_modx->config['template_path']}img/sidebar/products-4.png" alt="">
            <span>Металлопрокат</span>
        </a>
        <a class="sidebar__products-item" href="/catalog/stenovye-materialy/">
            <img src="{$_modx->config['template_path']}img/sidebar/products-5.png" alt="">
            <span>Стеновые материалы</span>
        </a>
        <a class="sidebar__products-item" href="/catalog/krovelnye-materialy/">
            <img src="{$_modx->config['template_path']}img/sidebar/products-6.png" alt="">
            <span>Кровельные материалы</span>
        </a>
        <a class="sidebar__products-item" href="/catalog/uteplitel">
            <img src="{$_modx->config['template_path']}img/sidebar/products-7.png" alt="">
            <span>Утеплитель</span>
        </a>
    </div>
    <div class="sidebar__info">
        <span>ООО «СК «Монолит»</span><a href="mailto:{'email' | option}">{'email' | option}</a><span>
           Город работы:<a class="sidebar__info-city" href="#city" data-fancybox="">
                <svg class="svg icon-place" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                  <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-place"></use>
                </svg><span>Санкт-Петербург</span></a>
		</span>
    </div>
</div>
