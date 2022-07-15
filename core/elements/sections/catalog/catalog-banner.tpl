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
            {else}
                утеплителя
            {/if}
            под Ваши требования</p>
        <form class="catalog-banner__form" method="post">
            <input type="text" name="mobilephone" class="fmobilephone">

            <input type="text" class="catalog-banner__input" name="NAME" placeholder="Ваше имя">
            <input type="tel" class="catalog-banner__input" name="PHONE" placeholder="Укажите номер телефона*">

            <label class="catalog-banner__privacy-wrap privacy">
                <span class="custom-checkbox">
                    <input class="custom-checkbox__input" type="checkbox" checked="" name="privacy">
                    <span class="custom-checkbox__checkmark"></span>
                </span>
                <span class="privacy__text">согласен(на) с <a
                            class="privacy__link" data-fancybox="" data-type="ajax"
                            data-src="/confidential/" href="javascript:;">политикой конфиденциальности</a> сайта</span>
            </label>

            <button class="catalog-banner__btn-submit">Отправить</button>
        </form>
    </div>

    {switch $_modx->resource.context_key}
        {case 'pilomat'}
            {set $imgname = 'pilomat.jpg'}
        {case 'web'}
            {set $imgname = 'knauf.jpg'}
        {case 'rockwool'}
            {set $imgname = 'rockwool.jpg'}
        {case 'tn'}
            {set $imgname = 'tehnonikol.jpg'}
        {case 'penoplex'}
            {set $imgname = 'penoplex.jpg'}
        {case 'isover'}
            {set $imgname = 'isover.jpg'}
        {case 'paroc'}
            {set $imgname = 'paroc.jpg'}
        {case 'ursa'}
            {set $imgname = 'ursa.jpg'}
        {case 'krovlya'}
            {set $imgname = 'krovlya.jpg'}
        {case 'kirpich-m'}
            {set $imgname = 'kirpich-m.jpg'}
        {case 'fasady-pro'}
            {set $imgname = 'fasady-pro.jpg'}
        {case 'fasad'}
            {set $imgname = 'fasad.jpg'}
        {case 'armatura-178'}
            {set $imgname = 'armatura-178.jpg'}
        {case 'asconcrete'}
            {set $imgname = 'asconcrete.jpg'}
        {case 'pro-fanera'}
            {set $imgname = 'pro-fanera.jpg'}
        {case 'plitaosb'}
            {set $imgname = 'plitaosb.jpg'}
        {case 'plity-mdvp'}
            {set $imgname = 'plity-mdvp.jpg'}
    {/switch}

    <div class="catalog-banner__img" style="background-image: url(/assets/template/img/catalog-banner/{$imgname})"></div>
</section>
