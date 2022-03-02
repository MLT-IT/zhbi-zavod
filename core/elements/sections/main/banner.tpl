<section class="banner">
    {if $dontNeedWrapper != true}
        <div class="wrapper">
    {/if}
        <div class="banner__slide">
            {if $_modx->context.key == 'krovlya'}
                <img src="/assets/template/img/banners-full/krovlya.jpg" class="banner__slide-img">
            {elseif $_modx->context.key == 'kirpich-m'}
                <img src="/assets/template/img/banners-full/kirpich-m.jpg" class="banner__slide-img">
            {elseif $_modx->context.key == 'fasady-pro'}
                <img src="/assets/template/img/banners-full/fasady-pro.jpg" class="banner__slide-img">
            {elseif $_modx->context.key == 'fasad'}
                <img src="/assets/template/img/banners-full/fasad.jpg" class="banner__slide-img">
            {elseif $_modx->resource.context_key == 'armatura-178'}
                <img src="/assets/template/img/banners-full/armatura-178.jpg" class="banner__slide-img">
            {elseif $_modx->resource.context_key == 'asconcrete'}
                <img src="/assets/template/img/banners-full/asconcrete.jpg" class="banner__slide-img">
            {else}
                <img src="/assets/template/img/banners-full/{$site_context}.jpg" class="banner__slide-img">
            {/if}

            {*
            <div class="banner__slide-content">
                <div class="banner__slide-text-lg">Knauf</div>
                <div class="banner__slide-text-md">Утеплитель</div>
                <div class="banner__slide-text-sm">по заводским ценам</div>
            </div>
            <div class="banner__slide-img-wrap">
                <img src="/assets/template/img/banner-img.png" class="banner__slide-img">
            </div>
            *}
            {*
            <a data-fancybox="" href="#callback" class="banner__slide-link delivery__banner-btn yellow-btn">
                <svg viewBox="0 0 180 50">
                    <text x="16" y="14">Оставить заявку и</text>
                    <text x="4" y="30">получить скидку 30%</text>
                    <text x="40" y="46">на доставку</text>
                </svg>
            </a>
            *}

            <a data-btn-key="{$dataBtnKey?:'banner-main'}" data-fancybox="" href="#cost-delivery" class="banner__slide-link delivery__banner-btn yellow-btn">
                {if $_modx->resource.context_key in list ['fasady-pro', 'fasad', 'armatura-178', 'kirpich-m', 'asconcrete']}
                    <svg viewBox="0 0 235 50">
                        <text class="banner__text-big" x="37" y="24">Оставить заявку</text>
                        <text class="banner__text-small" x="26" y="40">И получите расчёт за 5 минут</text>
                    </svg>
                {else}
                    <svg viewBox="0 0 235 50">
                        <text x="0" y="21">Оставить заявку и получить</text>
                        <text x="16" y="40">скидку 30% на доставку</text>
                    </svg>
                {/if}
            </a>

        </div>
    {if $dontNeedWrapper != true}
        </div>
    {/if}
</section>
