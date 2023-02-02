<section class="promo">
    <div class="wrapper">
        <div class="promo__top">
            <a class="promo__top-card promo__top-card_type_guarantees" href="/garantii/">
                <div class="promo__top-card-img"><img src="{$_modx->config['template_path']}img/promo-garant.png" alt=""></div>
                <div class="promo__top-card-text">Узнайте о наших <span class="promo__top-card-text-span">гарантиях</span></div>
            </a>
            <a class="promo__top-card promo__top-card_type_delivery" href="/dostavka-i-oplata/">
                {if $_modx->resource.context_key in list ['krovlya', 'armatura-178', 'kirpich-m', 'pro-fanera', 'plitaosb', 'plity-mdvp', 'fasad', 'fasady-pro']}
                    {set $promoImg = 'promo-kran.png'}
                {elseif $_modx->resource.context_key in list ['policarbonat']}
                    {set $promoImg = 'promo-gazelle.png'}
                {else}
                    {set $promoImg = 'promo-kamaz.png'}
                {/if}
                <div class="promo__top-card-img"><img src="{$_modx->config['template_path']}img/{$promoImg}" alt=""></div>
                <div class="promo__top-card-text">Узнайте об <span class="promo__top-card-text-span">условиях доставки</span></div>
            </a>
        </div>
        {*        <div class="promo__bottom swiper-container">*}
        {*            <div class="swiper-buttons">*}
        {*                <div class="swiper-button-prev"></div>*}
        {*                <div class="swiper-button-next"></div>*}
        {*            </div>*}
        {*            <div class="swiper-wrapper">*}
        {*                <div class="swiper-slide"><img src="{$_modx->config['template_path']}img/promo-sale.png" alt="">*}
        {*                    <div class="promo__bottom-content">*}
        {*                        <div class="promo__bottom-title title-1">Покупай дешевле!</div>*}
        {*                        <div class="promo__bottom-text">Скидки на следующие категории товаров</div><a class="custom-btn" href="#">Перейти к распродаже товаров</a> </div>*}
        {*                </div>*}
        {*            </div>*}
        {*        </div>*}
    </div>
</section>
