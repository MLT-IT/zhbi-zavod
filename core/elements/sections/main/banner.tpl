{set $ctx = $_modx->context.key}
{set $banner_ctxs = [
    "kirpich-m" => [
        "image" => "/assets/template/img/banners-small/kirpich-m-small.png",
        "content" => ["text" => "Оставьте заявку на кирпич сейчас и<br> получите скидку 30% на доставку 👍", "class_names" => "color-white font-weight-500"]
        "button" => ["text" => "Получить скидку", "class_names" => "color-white bg-green"]
    ],
    "fasad" => [
        "image" => "/assets/template/img/banners-small/fasad-small.jpg",
        "content" => ["text" => " Бесплатно рассчитаем фасады под ключ", "class_names" => "color-white font-weight-500"]
        "button" => ["text" => "Закажите расчет фасада бесплатно", "class_names" => "color-white bg-green"]
    ],
    "krovlya" => [
        "image" => "/assets/template/img/banners-small/krovlya-small.jpg",
        "content" => ["text" => "Бесплатно рассчитаем комплект кровли ", "class_names" => "color-white font-weight-700"]
        "button" => ["text" => "Получить скидку", "class_names" => "color-white bg-green"]
    ],
]}

{* Массив контекстов с маленькими баннерами *}
{if $ctx in $banner_ctxs}
{set $content = $banner_ctxs[$ctx]["content"]}
{set $button = $banner_ctxs[$ctx]["button"]}
{set $image = $banner_ctxs[$ctx]["image"]}

<section class="banner-small" >
     <div class="wrapper">
         <div class="banner-small__slide" style="background:url({$image})">
            <div class="banner-small__content">
                <div class="banner-small__content-text {$content["class_names"]}">
                    {$content["text"]}
                </div>
                <button data-btn-key="banner-main" data-fancybox data-src="#cost-delivery" class="banner-small__content-button {$button["class_names"]}" >
                    <span>{$button["text"]}</span>
                    <span style=" height: 20px; ">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" width="20" fill="#fff">
                            <path d="M438.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L338.8 224 32 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l306.7 0L233.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160z"/>
                        </svg>
                    </span>
                </button>
            </div>
         </div>
     </div>
</section>
{else}

<section class="banner">
    {if $dontNeedWrapper != true}
        <div class="wrapper">
    {/if}
        <div class="banner__slide">
            {if $ctx == 'krovlya'}
                <img src="/assets/template/img/banners-full/krovlya.jpg" class="banner__slide-img">
            {elseif $ctx == 'kirpich-m'}
                <img src="/assets/template/img/banners-full/kirpich-m.jpg" class="banner__slide-img">
            {elseif $ctx == 'pilomat'}
                <img src="/assets/template/img/banners-full/pilomat.jpg" class="banner__slide-img">
            {elseif $ctx == 'fasady-pro'}
                <img src="/assets/template/img/banners-full/fasady-pro.jpg" class="banner__slide-img">
            {elseif $ctx == 'fasad'}
                <img src="/assets/template/img/banners-full/fasad.jpg" class="banner__slide-img">
            {elseif $ctx == 'armatura-178'}
                <img src="/assets/template/img/banners-full/armatura-178.jpg" class="banner__slide-img">
            {elseif $ctx == 'asconcrete'}
                <img src="/assets/template/img/banners-full/asconcrete.jpg" class="banner__slide-img">
            {elseif $ctx == 'pro-fanera'}
                <img src="/assets/template/img/banners-full/pro-fanera.jpg" class="banner__slide-img">
            {elseif $ctx == 'plitaosb'}
                <img src="/assets/template/img/banners-full/plitaosb.jpg" class="banner__slide-img">
            {elseif $ctx == 'plity-mdvp'}
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

            <span data-btn-key="{$dataBtnKey?:'banner-main'}" data-fancybox="" data-src="#cost-delivery" class="banner__slide-link delivery__banner-btn-text yellow-btn">
                {if $ctx == 'plitaosb'}
                    <svg class="svg banner__text-svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#main-banner-btn"></use>
                    </svg>
                {else}
                    <svg class="banner__text-2" viewBox="0 0 235 50">
                      <text x="0" y="21">Оставить заявку и получить</text>
                      <text x="16" y="40">скидку 30% на доставку</text>
                    </svg>
                {/if}
            </span>
        </div>

        {if $_modx->resource.context_key == 'pro-fanera'}
            <div class="subbanner">
                <a href="/bakelitovaya-fanera/" class="subbanner__item">
                    <img class="subbanner__item-img" src="/assets/template/img/subbanner/pro-fanera/new_bakelitovaja_fanera.png" alt="">
                    <p class="subbanner__text">Бакелитовая фанера</p>
                </a>
                <a href="/laminirovannaya-fanera/" class="subbanner__item">
                    <img class="subbanner__item-img" src="/assets/template/img/subbanner/pro-fanera/new_fanera_fk.png" alt="">
                    <p class="subbanner__text">Ламинированная фанера</p>
                </a>
                <a href="/transportnaya-fanera/" class="subbanner__item">
                    <img class="subbanner__item-img" src="/assets/template/img/subbanner/pro-fanera/new_fanera_fsf.png" alt="">
                    <p class="subbanner__text">Транспортная фанера</p>
                </a>
                <a href="/fanera-fk/" class="subbanner__item">
                    <img class="subbanner__item-img" src="/assets/template/img/subbanner/pro-fanera/new_lamin.png" alt="">
                    <p class="subbanner__text">Фанера ФК</p>
                </a>
                <a href="/fanera-fsf/" class="subbanner__item">
                    <img class="subbanner__item-img" src="/assets/template/img/subbanner/pro-fanera/new_transport.png" alt="">
                    <p class="subbanner__text">Фанера ФСФ</p>
                </a>
            </div>
        {/if}

    {if $dontNeedWrapper != true}
        </div>
    {/if}
</section>
{/if}
