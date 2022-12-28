<footer class="footer">
    <div class="wrapper">
        <div class="footer__left">
            <a class="footer__logo" href="/">
                {if $_modx->resource.context_key in list ['plitaosb', 'web', 'rockwool', 'tn', 'paroc', 'penoplex', 'ursa', 'isover', 'fasady-pro', 'pro-fanera', 'fasad']}
                    {*
                    <picture>
                        <source srcset="/assets/template/img/logos/plitaosb-mobile.png" media="(max-width: 768px)">
                        <img class="header__logo-img adaptive-img" src="/assets/template/img/logos/plitaosb.png">
                    </picture>
                    *}
                    <img class="footer__logo-img adaptive-img" src="/assets/template/img/logos/{$site_context}.png">
                {else}
                    <img class="footer__logo-img adaptive-img" src="/assets/template/img/logos/{$site_context}.svg">
                {/if}
            </a>
            <div class="footer__about">© 2010-{'' | date : "Y"}</div>
            <div class="footer__payment"><span>Принимаем к оплате:</span>
                <div class="footer__payment-list">
                    <img src="{$_modx->config['template_path']}img/payment/payment1.png" alt="">
                    <img src="{$_modx->config['template_path']}img/payment/payment2.png" alt="">
                    <img src="{$_modx->config['template_path']}img/payment/payment3.png" alt="">
                    <img src="{$_modx->config['template_path']}img/payment/payment4.png" alt="">
                    <img src="{$_modx->config['template_path']}img/payment/payment5.png" alt="">
                </div>
            </div>
            <ul class="footer__nav-list">
                <li class="footer__nav-item"><span class="footer__link" data-fancybox data-type="ajax" data-src="/confidential/">Политика конфиденциальности</span></li>
                {if $_modx->resource.template === 1}
                <li class="footer__nav-item"><a href="/sitemap/">Карта сайта</a></li>
                {/if}
            </ul>

            {if $_modx->resource.context_key == 'kirpich-m'}
                <div class="footer__rating-badge">
                    <iframe src="https://yandex.ru/sprav/widget/rating-badge/87565500476?type=rating" width="150" height="50" frameborder="0"></iframe>
                </div>
            {/if}
        </div>
        {if $_modx->getPlaceholder('footer_nav_ids') | length > 1}
        <div class="footer__nav-block">
            <div class="footer__nav-block-title">Категории</div>
            <ul class="footer__nav-list">
                {'pdoResources' | snippet : [
                  'parents' => $_modx->getPlaceholder('catalog_id'),
                  'resources'=> $_modx->getPlaceholder('footer_nav_ids'),
                  'tpl' => '@INLINE <li class="footer__nav-item"><a href="{$uri}">{$menutitle}</a></li>',
                  'where' => '{"template":5}',
                  'limit' => '0',
                  'select' => 'uri,menutitle'
                ]}
            </ul>
            </div>
        {/if}
        <div class="footer__nav-block">
            <div class="footer__nav-block-title">Покупателям</div>
            <ul class="footer__nav-list">
                <li class="footer__nav-item"><a href="/o-kompanii/">О компании</a></li>
                <li class="footer__nav-item"><a href="/contacts/">Контакты</a></li>
                <li class="footer__nav-item"><a href="/dostavka-i-oplata/">Доставка и оплата</a></li>

                {if $_modx->resource.context_key in list ['kirpich-m', 'krovlya', 'fasady-pro', 'fasad']}
                    {set $showroom = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'show-room']}

                    {if $showroom['hidemenu'] == 0 && $showroom['published'] == 1}
                      <li class="footer__nav-item"><a href="/show-room/">Шоурум</a></li>
                    {/if}
                {/if}

                <li class="footer__nav-item"><a href="/faq/">Вопросы-ответы</a></li>
                <li class="footer__nav-item"><a href="/akcii/">Акции</a></li>

                {set $raspil = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'raspil']}
                {if $raspil['hidemenu'] == 0 && $raspil['published'] == 1}
                  <li class="footer__nav-item"><a href="/raspil/">Распил</a></li>
                {/if}

                <li class="footer__nav-item"><a href="/certs/">Сертификаты</a></li>
                <li class="footer__nav-item"><a href="/garantii/">Гарантии</a></li>
            </ul>
        </div>
        <div class="footer__right">
            <div class="footer__nav-block-title">Контактная информация</div>
            <ul class="footer__contacts-list">
                <li><a class="footer__about-phone" href="tel:{'phone' | option}">{'phone' | option}</a></li>
                <li><a class="footer__email" href="mailto:{'email' | option}"> {'email' | option} </a></li>
                <li>{'address' | option}</li>
                <li>Часы работы: ежедневно с 8:00 до 21:00</li>
            </ul>

            {include "file:elements/social-list.tpl"}
        </div>
    </div>
</footer>
