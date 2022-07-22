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
        <h1 class="title-1 title-1_align_left">{$_modx->resource.pagetitle}</h1>

        {if $_modx->resource.content | length > 0}
            <article class="sect-inner__content content-block">
                {$_modx->resource.content}
            </article>
        {/if}
    </div>

    {include "file:chunks/svg-gradient.tpl" w=48 h=48}

    <section class="wrapper sect-segment">
        <h2 class="title-2 title-2_align_left">Основной сегмент наших клиентов</h2>
        <ul class="sect-segment__items-wrap">
            <li class="sect-segment__item">
                <div class="sect-segment__item-svg-wrap">
                    <svg fill="url(#svg-gradient)" class="svg sect-segment__item-svg" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="32" height="32">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#fizlic"></use>
                    </svg>
                </div>
                Физические лица
            </li>
            <li class="sect-segment__item">
                <div class="sect-segment__item-svg-wrap">
                    <svg fill="url(#svg-gradient)" class="svg sect-segment__item-svg" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="38" height="37">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#snab"></use>
                    </svg>
                </div>
                Снабженцы и прорабы
            </li>
            <li class="sect-segment__item">
                <div class="sect-segment__item-svg-wrap">
                    <svg fill="url(#svg-gradient)" class="svg sect-segment__item-svg" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="36" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#zastroy"></use>
                    </svg>
                </div>
                Крупные застройщики
            </li>
        </ul>
    </section>

    {* >>> Значения для пунктов *}
    {if $_modx->resource.context_key in list ['web', 'rockwool', 'tn', 'penoplex', 'isover', 'paroc', 'ursa']}
        {set $textBestPrice = 'Владеем собственным автопарком, поэтому можем гарантировать максимально низкую цену на утеплитель данного бренда.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить утеплитель уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени. Гарантия от производителя.'}
    {elseif $_modx->resource.context_key == 'krovlya'}
        {set $textBestPrice = 'Владеем собственным автопарком, поэтому можем гарантировать максимально низкую цену на кровлю.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить стройматериал уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {elseif $_modx->resource.context_key == 'pro-fanera'}
        {set $textBestPrice = 'Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на фанеру.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить фанеру уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {elseif $_modx->resource.context_key == 'fasady-pro'}
        {set $textBestPrice = 'Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на фасадные материалы.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить фасадные материалы уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {elseif $_modx->resource.context_key == 'fasad'}
        {set $textBestPrice = 'Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на фасадные материалы.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить фасадные материалы уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {elseif $_modx->resource.context_key == 'pilomat'}
        {set $textBestPrice = 'Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на пиломат.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить пиломатериал уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {elseif $_modx->resource.context_key == 'plitaosb'}
        {set $textBestPrice = 'Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на плитные материалы.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить плитный материал уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {elseif $_modx->resource.context_key == 'plity-mdvp'}
        {set $textBestPrice = 'Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на МДВП плиты.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить плиту МДВП уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {elseif $_modx->resource.context_key == 'kirpich-m'}
        {set $textBestPrice = 'Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на кирпич.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить кирпич уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {elseif $_modx->resource.context_key == 'armatura-178'}
        {set $textBestPrice = 'Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на арматуру и металлопрокат.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить арматуру уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {elseif $_modx->resource.context_key == 'asconcrete'}
        {set $textBestPrice = 'Мы являемся официальным дистрибьютором, поэтому можем гарантировать максимально низкую цену на асфальтобетон.'}
        {set $textDelivery = 'После уточнения наличия Вы можете получить асфальт уже через 2 часа у Вас на объекте! Или в любой удобный для Вас интервал времени.'}
    {/if}
    {* <<< Значения для пунктов *}

    <section class="wrapper sect-benefits">
        <h2 class="title-2 title-2_align_left">Какие выгоды вы получите, обратившись к нам</h2>
        <ul class="sect-benefits__items-wrap">
            <li class="sect-benefits__item">
                <div class="sect-benefits__item-svg-wrap">
                    <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="28" height="36">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#rouble"></use>
                    </svg>
                </div>
                <div class="sect-benefits__item-content">
                    <p class="sect-benefits__item-title">Лучшая цена</p>
                    <p class="sect-benefits__item-text">
                        {$textBestPrice}
                    </p>
                </div>
            </li>
            <li class="sect-benefits__item">
                <div class="sect-benefits__item-svg-wrap">
                    <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="44" height="32">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#truck"></use>
                    </svg>
                </div>
                <div class="sect-benefits__item-content">
                    <p class="sect-benefits__item-title">Доставка по звонку</p>
                    <p class="sect-benefits__item-text">
                        {$textDelivery}
                    </p>
                </div>
            </li>
            <li class="sect-benefits__item">
                <div class="sect-benefits__item-svg-wrap">
                    <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
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
                    <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="36" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#warranty"></use>
                    </svg>
                </div>
                <div class="sect-benefits__item-content">
                    <p class="sect-benefits__item-title">Гарантия от производителя</p>
                </div>
            </li>
            <li class="sect-benefits__item">
                <div class="sect-benefits__item-svg-wrap">
                    <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="36" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#complex-supply"></use>
                    </svg>
                </div>
                <div class="sect-benefits__item-content">
                    <p class="sect-benefits__item-title">Комплексные поставки стройматериалов</p>
                    <p class="sect-benefits__item-text">
                        Обратившись к нам Вы убережете себя от проблем с поиском строительных материалов начиная с нулевого цикла и заканчивая внутренней отделой помещений.
                    </p>
                </div>
            </li>
        </ul>
    </section>

    {include "file:sections/appeal.tpl"}
{/block}
