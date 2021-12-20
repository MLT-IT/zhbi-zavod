<section class="catalog-banner">
    <div class="catalog-banner__content">
        <p class="catalog-banner__header">Не знаете, что вам подходит?</p>
        <p class="catalog-banner__subheader">Правильная консультация <span class="catalog-banner__special-text">сэкономит Вам до 40%</span> бюджета!</p>
        <p class="catalog-banner__text">Оставьте заявку и получите бесплатную консультацию по подбору
            {if $_modx->context.key != 'krovlya'}
                утеплителя
            {else}
                кровли
            {/if}
            под Ваши требования</p>
        <form class="catalog-banner__form" method="post">
            <input type="text" class="catalog-banner__input" name="NAME" placeholder="Ваше имя">
            <input type="text" class="catalog-banner__input" name="PHONE" placeholder="Телефон">

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
            {set $imgname = 'krovlyasp.jpg'}
    {/switch}

    <div class="catalog-banner__img" style="background-image: url(/assets/template/img/catalog-banner/{$imgname})"></div>
</section>
