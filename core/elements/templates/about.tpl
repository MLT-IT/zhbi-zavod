{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    <div class="wrapper sect-inner">
        <h1 class="title-1 title-1_align_left bold">{$_modx->resource.pagetitle}</h1>

        {if $_modx->resource.content | length > 0}
            <article class="sect-inner__content content-block sect-inner__content_type_reduced">
                {$_modx->resource.content}
            </article>
        {/if}
    </div>

    {* >>> SVG градиент *}
    {if $_modx->resource.context_key == 'web'}
        {set $colorStart = '#5892FC'}
        {set $colorEnd = '#4F70AD'}
    {elseif $_modx->resource.context_key in list ['rockwool', 'krovlya', 'kirpich-m']}
        {set $colorStart = '#e90115'}
        {set $colorEnd = '#aa000f'}
    {elseif $_modx->resource.context_key == 'tn'}
        {set $colorStart = '#ed1c24'}
        {set $colorEnd = '#af0e14'}
    {elseif $_modx->resource.context_key == 'penoplex'}
        {set $colorStart = '#f36f21'}
        {set $colorEnd = '#bd4d0a'}
    {elseif $_modx->resource.context_key == 'isover'}
        {set $colorStart = '#83c320'}
        {set $colorEnd = '#578115'}
    {elseif $_modx->resource.context_key == 'paroc'}
        {set $colorStart = '#ce1126'}
        {set $colorEnd = '#870b19'}
    {elseif $_modx->resource.context_key == 'ursa'}
        {set $colorStart = '#ea4740'}
        {set $colorEnd = '#c81d16'}
    {/if}

    <div style="height: 0; width: 0; position: absolute; visibility: hidden;">
        <defs>
            <svg viewBox="0 0 48 48" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <linearGradient id="about-svg-gradient" gradientTransform="rotate(90)" gradientUnits="userSpaceOnUse">
                    <stop offset="0" stop-color="{$colorStart}"/>
                    <stop offset="1" stop-color="{$colorEnd}"/>
                </linearGradient>
            </svg>
        </defs>
    </div>
    {* <<< SVG градиент *}

    <section class="wrapper sect-segment">
        <h2 class="title-2 title-2_align_left bold">Основной сегмент наших клиентов</h2>
        <ul class="sect-segment__items-wrap">
            <li class="sect-segment__item">
                <div class="sect-segment__item-svg-wrap">
                    <svg fill="url(#about-svg-gradient)" class="svg sect-segment__item-svg" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="32" height="32">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#fizlic"></use>
                    </svg>
                </div>
                Физические лица
            </li>
            <li class="sect-segment__item">
                <div class="sect-segment__item-svg-wrap">
                    <svg fill="url(#about-svg-gradient)" class="svg sect-segment__item-svg" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="38" height="37">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#snab"></use>
                    </svg>
                </div>
                Снабженцы и прорабы
            </li>
            <li class="sect-segment__item">
                <div class="sect-segment__item-svg-wrap">
                    <svg fill="url(#about-svg-gradient)" class="svg sect-segment__item-svg" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="36" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#zastroy"></use>
                    </svg>
                </div>
                Крупные застройщики
            </li>
        </ul>
    </section>

    <section class="wrapper sect-benefits">
        <h2 class="title-2 title-2_align_left bold">Какие выгоды вы получите, обратившись к нам</h2>
        <ul class="sect-benefits__items-wrap">
            <li class="sect-benefits__item">
                <div class="sect-benefits__item-svg-wrap">
                    <svg fill="url(#about-svg-gradient)" class="svg sect-benefits__item-svg"
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="28" height="36">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#rouble"></use>
                    </svg>
                </div>
                <div class="sect-benefits__item-content">
                    <p class="sect-benefits__item-title">Лучшая цена</p>
                    <p class="sect-benefits__item-text">
                        Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на
                        фанеру.
                    </p>
                </div>
            </li>
            <li class="sect-benefits__item">
                <div class="sect-benefits__item-svg-wrap">
                    <svg fill="url(#about-svg-gradient)" class="svg sect-benefits__item-svg"
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="44" height="32">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#truck"></use>
                    </svg>
                </div>
                <div class="sect-benefits__item-content">
                    <p class="sect-benefits__item-title">Доставка по звонку</p>
                    <p class="sect-benefits__item-text">
                        После уточнения наличия Вы можете получить фанеру уже через 2 часа у Вас на объекте! Или в любой
                        удобный для Вас интервал времени.
                    </p>
                </div>
            </li>
            <li class="sect-benefits__item">
                <div class="sect-benefits__item-svg-wrap">
                    <svg fill="url(#about-svg-gradient)" class="svg sect-benefits__item-svg"
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="40" height="40">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#smile"></use>
                    </svg>
                </div>
                <div class="sect-benefits__item-content">
                    <p class="sect-benefits__item-title">Экономия бюджета до 40% !</p>
                    <p class="sect-benefits__item-text">
                        Позвоните нам и наш менеджер подберет наиболее оптимальный вариант под Ваши нужды.
                    </p>
                </div>
            </li>
            <li class="sect-benefits__item">
                <div class="sect-benefits__item-svg-wrap">
                    <svg fill="url(#about-svg-gradient)" class="svg sect-benefits__item-svg"
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="36" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#warranty"></use>
                    </svg>
                </div>
                <div class="sect-benefits__item-content">
                    <p class="sect-benefits__item-title">Гарантия от производителя.</p>
                    <p class="sect-benefits__item-text">
                        Комплексные поставки стройматериалов. Обратившись к нам Вы убережете себя от проблем с поиском
                        строительных материалов начиная с нулевого цикла и заканчивая внутренней отделой помещений.
                    </p>
                </div>
            </li>
        </ul>
    </section>

    {include "file:sections/appeal.tpl"}
{/block}
