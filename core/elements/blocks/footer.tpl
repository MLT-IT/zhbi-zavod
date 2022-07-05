<footer class="footer">
    <div class="wrapper">
        <div class="footer__left">
            <a class="footer__logo" href="/">

                {if $_modx->resource.context_key === 'plitaosb'}
                    {*
                    <picture>
                        <source srcset="/assets/template/img/logos/plitaosb-mobile.png" media="(max-width: 768px)">
                        <img class="header__logo-img adaptive-img" src="/assets/template/img/logos/plitaosb.png">
                    </picture>
                    *}
                    <img class="header__logo-img adaptive-img" src="/assets/template/img/logos/{$site_context}.png">
                {else}
                    <img class="header__logo-img adaptive-img" src="/assets/template/img/logos/{$site_context}.svg">
                {/if}

            </a>
            <div class="footer__about">© 2010-{'' | date : "Y"}</div>
        </div>
        <nav class="footer__nav">
            <div class="footer__nav-block">
                <div class="footer__nav-block-title">Покупателям</div>
                <ul class="footer__nav-list">
                    {*<li class="footer__nav-item"><a href="/catalog/">Каталог товаров</a></li>*}
                    <li class="footer__nav-item"><a href="/dostavka-i-oplata/">Доставка и оплата</a></li>
                    <li class="footer__nav-item"><a href="/garantii/">Гарантии</a></li>
                    {*<li class="footer__nav-item"><a href="#">Скидки</a></li>*}
                    {*<li class="footer__nav-item"><a href="#">Акции</a></li>*}
                </ul>
            </div>
            <div class="footer__nav-block">
                <div class="footer__nav-block-title">О компании</div>
                <ul class="footer__nav-list">
                    {*<li class="footer__nav-item"><a href="#">О нас</a></li>*}
                    {*<li class="footer__nav-item"><a href="#">Отзывы</a></li>*}
                    {*<li class="footer__nav-item"><a href="#">Вопрос-ответ</a></li>*}

                    {if $_modx->resource.template === 1}
                        <li class="footer__nav-item"><a href="/sitemap/">Карта сайта</a></li>
                    {/if}

                    <li class="footer__nav-item"><a href="/contacts/">Контакты</a></li>
                </ul>
            </div>
        </nav>
        <div class="footer__right">
            {*
            <div class="footer__social"><span>Мы в соц. сетях</span>
                <div class="footer__social-list">
                    {include "file:elements/social-list.tpl"}
                </div>
            </div>
            *}
            <div class="footer__payment"><span>Принимаем к оплате:</span>
                <div class="footer__payment-list">
                    <img src="{$_modx->config['template_path']}img/payment/payment1.png" alt="">
                    <img src="{$_modx->config['template_path']}img/payment/payment2.png" alt="">
                    <img src="{$_modx->config['template_path']}img/payment/payment3.png" alt="">
                    <img src="{$_modx->config['template_path']}img/payment/payment4.png" alt="">
                    <img src="{$_modx->config['template_path']}img/payment/payment5.png" alt="">
                </div>
            </div>
            <span class="footer__policy" data-fancybox data-type="ajax" data-src="/confidential/">Политика конфиденциальности</span>
        </div>
    </div>
</footer>
