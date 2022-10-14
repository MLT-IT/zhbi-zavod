<section class="banner">
    {if $dontNeedWrapper != true}
        <div class="wrapper">
    {/if}
        <div class="banner__slide">
            {if $_modx->context.key == 'krovlya'}
                <img src="/assets/template/img/banners-full/krovlya.jpg" class="banner__slide-img">
            {elseif $_modx->context.key == 'kirpich-m'}
                <img src="/assets/template/img/banners-full/kirpich-m.jpg" class="banner__slide-img">
            {elseif $_modx->context.key == 'pilomat'}
                <img src="/assets/template/img/banners-full/pilomat.jpg" class="banner__slide-img">
            {elseif $_modx->context.key == 'fasady-pro'}
                <img src="/assets/template/img/banners-full/fasady-pro.jpg" class="banner__slide-img">
            {elseif $_modx->context.key == 'fasad'}
                <img src="/assets/template/img/banners-full/fasad.jpg" class="banner__slide-img">
            {elseif $_modx->resource.context_key == 'armatura-178'}
                <img src="/assets/template/img/banners-full/armatura-178.jpg" class="banner__slide-img">
            {elseif $_modx->resource.context_key == 'asconcrete'}
                <img src="/assets/template/img/banners-full/asconcrete.jpg" class="banner__slide-img">
            {elseif $_modx->resource.context_key == 'pro-fanera'}
                <img src="/assets/template/img/banners-full/pro-fanera.jpg" class="banner__slide-img">
            {elseif $_modx->resource.context_key == 'plitaosb'}
                <img src="/assets/template/img/banners-full/plitaosb.jpg" class="banner__slide-img">
            {elseif $_modx->resource.context_key == 'plity-mdvp'}
                <img src="/assets/template/img/banners-full/plity-mdvp.jpg" class="banner__slide-img">
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

            <span data-btn-key="{$dataBtnKey?:'banner-main'}" data-fancybox="" data-src="#cost-delivery" class="banner__slide-link delivery__banner-btn yellow-btn">
                {if $_modx->resource.context_key == 'plitaosb'}
                    <svg class="banner__text-1" viewBox="0 0 174 20">
                        <text x="24" y="15">Оставить заявку</text>
                        <svg x="136" y="4">
                          <g transform="translate(0.8, 0.8)">
                            <path d="M 6.0516 11.2913 C 5.8917 11.1314 5.8088 10.9346 5.8029 10.7009 C 5.7965 10.4672 5.8732 10.2704 6.0332 10.1105 L 9.391 6.7526 H 1.5129 C 1.2792 6.7526 1.0794 6.6695 0.9136 6.5032 C 0.7473 6.3374 0.6642 6.1376 0.6642 5.9039 C 0.6642 5.6702 0.7473 5.4705 0.9136 5.3047 C 1.0794 5.1384 1.2792 5.0552 1.5129 5.0552 H 9.391 L 6.0332 1.6973 C 5.8732 1.5374 5.7965 1.3406 5.8029 1.1069 C 5.8088 0.8732 5.8917 0.6764 6.0516 0.5165 C 6.2115 0.3689 6.4083 0.2951 6.642 0.2951 C 6.8757 0.2951 7.0725 0.3689 7.2324 0.5165 L 12.0294 5.3135 C 12.1155 5.3873 12.177 5.4764 12.2139 5.5807 C 12.2508 5.6855 12.2692 5.7932 12.2692 5.9039 C 12.2692 6.0146 12.2508 6.1192 12.2139 6.2176 C 12.177 6.316 12.1155 6.4082 12.0294 6.4943 L 7.2324 11.2913 C 7.0725 11.4512 6.8757 11.5282 6.642 11.5223 C 6.4083 11.5159 6.2115 11.4389 6.0516 11.2913 Z" fill="white"/>
                          </g>
                          </svg>
                    </svg>
                {else}
                    <svg class="banner__text-2" viewBox="0 0 235 50">
                      <text x="0" y="21">Оставить заявку и получить</text>
                      <text x="16" y="40">скидку 30% на доставку</text>
                    </svg>
                {/if}


            </span>

        </div>
    {if $dontNeedWrapper != true}
        </div>
    {/if}
</section>
