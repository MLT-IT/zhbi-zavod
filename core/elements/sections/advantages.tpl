{set $brand_with_space = ''}

{if $_modx->resource.context_key in list ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc']}
    {set $iword = 'утеплитель'}
    {set $rword = 'утеплителя'}
    {set $brand_with_space = ' ' ~ $brand}
{elseif $_modx->resource.context_key == 'krovlya'}
    {set $iword = 'кровельные материалы'}
    {set $rword = 'кровельных материалов'}
{elseif $_modx->resource.context_key == 'kirpich-m'}
    {set $iword = 'кирпич'}
    {set $rword = 'кирпича'}
{elseif $_modx->resource.context_key == 'asconcrete'}
    {set $iword = 'асфальт'}
    {set $rword = 'асфальта'}
{elseif $_modx->resource.context_key == 'fasady-pro'}
    {set $iword = 'деревянный фасад'}
    {set $rword = 'деревянного фасада'}
{elseif $_modx->resource.context_key == 'fasad'}
    {set $iword = 'фасадные материалы'}
    {set $rword = 'фасадных материалов'}
{elseif $_modx->resource.context_key == 'armatura-178'}
    {set $iword = 'арматуру'}
    {set $rword = 'арматуры'}
{elseif $_modx->resource.context_key == 'pilomat'}
    {set $iword = 'пиломатериалы'}
    {set $rword = 'пиломатериалов'}
{elseif $_modx->resource.context_key == 'plitaosb'}
    {set $iword = 'плитные материалы'}
    {set $rword = 'плитных материалов'}
{elseif $_modx->resource.context_key == 'pro-fanera'}
    {set $iword = 'фанеру'}
    {set $rword = 'фанеры'}
{/if}

<section class="advantages">
    <div class="wrapper">
        <div class="title-2">Преимущества компании</div>
        <div class="advantages__cards">
            <div class="advantages__card">
                <div class="advantages__card-img">
                    <svg class="svg advant-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 39 38" width="39" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#advant-1"></use>
                    </svg>
                </div>
                <div class="advantages__card-title">Комплексные поставки материалов</div>
                <div class="advantages__card-text">Для строительства дома под ключ</div>
            </div>
            <div class="advantages__card">
                <div class="advantages__card-img">
                    <svg class="svg advant-2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 38 38" width="38" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#advant-2"></use>
                    </svg>
                </div>
                <div class="advantages__card-title">Высокое качество продукции</div>
                <div class="advantages__card-text">Подтвержденное сертификатами и действующими ГОСТ</div>
            </div>
            <div class="advantages__card">
                <div class="advantages__card-img">
                    <svg class="svg advant-3" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 38 38" width="38" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#advant-3"></use>
                    </svg>
                </div>
                <div class="advantages__card-title">Доставка</div>
                <div class="advantages__card-text">В любую точку Санкт-Петербурга и Ленинградской области</div>
            </div>
            <div class="advantages__card">
                <div class="advantages__card-img">
                    <svg class="svg advant-4" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 38 38" width="38" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#advant-4"></use>
                    </svg>
                </div>
                <div class="advantages__card-title">Круглосуточная поставка</div>
                <div class="advantages__card-text">Без праздников и выходных</div>
            </div>
            <div class="advantages__card">
                <div class="advantages__card-img">
                    <svg class="svg advant-5" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 40 40" width="40" height="40">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#advant-5"></use>
                    </svg>
                </div>
                <div class="advantages__card-title">Лучшая цена</div>
                <div class="advantages__card-text">Мы гарантируем самую низкую цену на {$iword}{$brand_with_space}, так как являемся одним из самых крупных поставщиков</div>
            </div>
            <div class="advantages__card">
                <div class="advantages__card-img">
                    <svg class="svg advant-6" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 40 40" width="40" height="40">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#advant-6"></use>
                    </svg>
                </div>
                <div class="advantages__card-title">Доставка по звонку</div>
                <div class="advantages__card-text">После уточнения наличия вы можете получить {$iword} уже через 2 часа у Вас на объекте!</div>
            </div>
            <div class="advantages__card">
                <div class="advantages__card-img">
                    <svg class="svg advant-7" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 28 38" width="28" height="38">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#advant-7"></use>
                    </svg>
                </div>
                <div class="advantages__card-title">Бесплатная консультация менеджера</div>
                <div class="advantages__card-text">Позвоните нам и наш менеджер подберет наиболее оптимальный вариант под Ваши нужды</div>
            </div>
            <div class="advantages__card">
                <div class="advantages__card-img">
                    <svg class="svg advant-8" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 40 32" width="40" height="32">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#advant-8"></use>
                    </svg>
                </div>
                <div class="advantages__card-title">Огромный ассортимент</div>
                <div class="advantages__card-text">В наличии всегда имеются самые популярные позиции {$rword}{$brand_with_space}</div>
            </div>
        </div>
    </div>
</section>
