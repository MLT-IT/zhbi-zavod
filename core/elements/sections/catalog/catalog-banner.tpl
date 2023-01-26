<section class="catalog-banner">
    <div class="catalog-banner__content">
        <p class="catalog-banner__header">Не знаете, что вам подходит?</p>
        <p class="catalog-banner__subheader">Правильная консультация <span class="catalog-banner__special-text">сэкономит Вам до 40%</span> бюджета!</p>
        <p class="catalog-banner__text">Оставьте заявку и получите бесплатную консультацию по подбору
            {if $_modx->context.key == 'krovlya'}
                кровли
            {elseif $_modx->context.key == 'kirpich-m'}
                кирпича
            {elseif $_modx->context.key == 'pilomat'}
                пиломатериала
            {elseif $_modx->context.key == 'fasady-pro'}
                деревянных фасадов
            {elseif $_modx->context.key == 'fasad'}
                фасадов
            {elseif $_modx->context.key == 'armatura-178'}
                арматуры
            {elseif $_modx->context.key == 'asconcrete'}
                асфальтобетона
            {elseif $_modx->context.key == 'plitaosb'}
                плит ОСБ
            {elseif $_modx->context.key == 'pro-fanera'}
                фанеры
            {elseif $_modx->context.key == 'plity-mdvp'}
                плит МДВП
            {elseif $_modx->context.key == 'policarbonat'}
                поликарбоната
            {else}
                утеплителя
            {/if}
            под Ваши требования</p>
        <form class="catalog-banner__form" method="post">
            <input type="text" class="catalog-banner__input" name="NAME" placeholder="Ваше имя">
            <input type="tel" class="catalog-banner__input" name="PHONE" placeholder="Укажите номер телефона*">

            <label class="catalog-banner__privacy-wrap privacy">
                <span class="custom-checkbox">
                    <input class="custom-checkbox__input" type="checkbox" checked="" name="privacy">
                    <span class="custom-checkbox__checkmark"></span>
                </span>
                <span class="privacy__text">согласен(на) с <span
                            class="privacy__link" data-fancybox data-type="ajax"
                            data-src="/confidential/">политикой конфиденциальности</span> сайта</span>
            </label>

            <button class="catalog-banner__btn-submit">Отправить</button>
            <input type="text" name="mobilephone" class="fmobilephone">
        </form>
    </div>

    {switch $_modx->resource.context_key}
        {case 'web'}
            {set $imgname = 'knauf.jpg'}
        {case 'tn'}
            {set $imgname = 'tehnonikol.jpg'}
        {case default}
            {set $imgname = $_modx->resource.context_key ~ '.jpg'}
    {/switch}

    <div class="catalog-banner__img" style="background-image: url(/assets/template/img/catalog-banner/{$imgname})"></div>
</section>
