{* Устанавливаем переменные для чанка *}
{set $src = $_modx->resource}
{insert "file:blocks/set-values-for-prod.tpl"}

<div class="product-card__top product-item{if $itemInCart?} product-item-in-cart{/if}"
    {* Выводим data-атрибуты *}
    {foreach $itemUnits as $key => $val}
        data-{$key}="{$val['val']}"
    {/foreach}

    {insert "file:blocks/get-data-attrs.tpl"}
>
    <meta itemprop="brand" content="{$_modx->getPlaceholder('brand')}">
    <span class="product-card__article product-card__article_mobile">Арт. {$_modx->resource['article']}</span>

    <a href="{$image}" data-fancybox class="product-card__img zoom">
        <img itemprop="image" src="{$_modx->resource['thumb'] ?: '/assets/images/no_image.jpg'}"
             alt="{$_modx->resource.pagetitle}">
    </a>

    <div class="hidden" itemprop="aggregateRating" itemscope="" itemtype="http://schema.org/AggregateRating">
        <meta itemprop="bestRating" content="5">
        <meta itemprop="ratingValue" content="5">
        <meta itemprop="ratingCount" content="82">
    </div>

    <div class="product-card__info" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
        <link itemprop="availability" href="http://schema.org/InStock">

        <div class="product-card__info-inner">
            <div class="product-card__left-info">
                {if $condition}
                    <div class="product-card__units-wrap">
                        <input type="hidden" name="unit" value="1">
                        <span class="product-card__unit-span">Цена за</span>
                        <a class="product-card__unit-link active" href="#" data-val="1">{$pricePer}</a>
                        {foreach $itemUnits as $val}
                            <a class="product-card__unit-link" href="#" data-val="{$val['id']}">{$val['title']}</a>
                        {/foreach}
                    </div>
                {else}
                    <input type="hidden" name="unit" value="1">
                {/if}

                {if $price}
                    <div class="product-card__price-and-logo">
                        <span class="product-card__price-wrap">
                            <span itemprop="price" class="product-item__price"
                                  data-default="{$defaultPrice}">{$outputPrice}</span>
                            <meta itemprop="priceCurrency" content="RUB">
                            руб

                            {if !$condition}
                                {$unit[0] ? '/ ' ~ $unit[0] : ''}
                            {/if}
                        </span>
                        {*
                        <div class="product-logo product-card__logo" data-val="{$_modx->resource.proizvoditel[0] | toLowerAndRemoveChars}"></div>
                        *}
                    </div>
                {/if}

                {if $_modx->resource.context_key not in list ['krovlya', 'kirpich-m', 'fasady-pro', 'fasad', 'armatura-178', 'asconcrete', 'pilomat']}
                    {set $upakovka = 'getPackageNew' | snippet}
                    {if $upakovka | length > 0}
                        {if $_modx->resource.context_key in list ['plitaosb', 'pro-fanera']}
                            {set $packageText = 'В листе:'}
                        {else}
                            {set $packageText = 'В упаковке:'}
                        {/if}

                        <div {if $_modx->resource.context_key == 'pro-fanera'}style="display: none;"{/if} class="product-card__package">{$packageText} {$upakovka}</div>
                    {/if}
                {/if}

                {if $_modx->resource.context_key === 'kirpich-m' && $_modx->resource['pallet_num'][0] ?}
                    {set $pricePerPallet = ($_modx->resource['pallet_num'][0] * $_modx->resource.price) | preg_replace : '/\B(?=(\d{3})+(?!\d))/': ' ' | replace : ',' : '.'}

                    {if $pricePerPallet > 0}
                        <div class="product-card__package">Цена за поддон: {$pricePerPallet} руб</div>
                    {/if}
                {/if}
            </div>
            <div class="product-card__right-info">
                <span class="product-card__article product-card__article_pc">Арт. {$_modx->resource['article']}</span>
                <span class="product-item__btn product-card__btn-compare product-item__btn-compare{if $checkItems['comp'][$_modx->resource['id']]?} active{/if}" href="#">
                    <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                         height="16">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                    </svg>
                </span>
                <span class="product-item__btn product-card__btn-fav product-item__btn-fav{if $checkItems['fav'][$_modx->resource['id']]?} active{/if}" href="#">
                    <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 21 18" width="21"
                         height="18">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                    </svg>
                </span>
            </div>
        </div>

        <div class="product-card__info-left">
            {include "file:chunks/productElems.tpl"}

            {if $_modx->resource.context_key === 'kirpich-m' && $_modx->resource['pallet_num'][0] ?}
                <div class="product-card__saleinfo">
                    На поддоне: {$_modx->resource['pallet_num'][0]} шт.
                </div>
            {/if}

            <button data-fancybox="" href="#callback" class="product-card__buy white-btn">
                {if $_modx->resource.context_key == 'krovlya'}
                    Получить расчет кровли бесплатно
                {elseif $_modx->resource.context_key == 'kirpich-m'}
                    Получить расчет кирпича бесплатно
                {elseif $_modx->resource.context_key == 'fasady-pro'}
                    Получить расчет деревянных фасадов бесплатно
                {elseif $_modx->resource.context_key == 'fasad'}
                    Получить расчет фасадов бесплатно
                {elseif $_modx->resource.context_key == 'armatura-178'}
                    Получить расчет арматуры бесплатно
                {elseif $_modx->resource.context_key == 'asconcrete'}
                    Получить расчет асфальтобетона бесплатно
                {elseif $_modx->resource.context_key == 'pro-fanera'}
                    Получить расчет фанеры бесплатно
                {elseif $_modx->resource.context_key == 'plitaosb'}
                    Получить расчет плит ОСБ бесплатно
                {elseif $_modx->resource.context_key == 'plity-mdvp'}
                    Получить расчет плит МДВП бесплатно
                {else}
                    КУПИТЬ В 1 КЛИК
                {/if}
            </button>
        </div>

        <div class="product-card__info-right">
            <div class="product-card__delivery"><b>Доставка в Санкт-Петербург и Лен. область</b>
                <a data-fancybox href="#cost-delivery">
                    <svg class="svg icon-delivery" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-delivery"></use>
                    </svg>
                    Узнать стоимость с доставкой</a>
            </div>
            <div class="product-card__availability">
                <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>
                </svg>
                В наличии
            </div>
            <div class="product-card__reviews">
                <div class="product-card__reviews-stars five">
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                </div>
                {set $countReviews = count($reviews)}
                <a class="product-card__reviews-quantity" href="#">{$countReviews}
                    {'@FILE snippets/formOfWord.php' | snippet : [
                    'n' => $countReviews,
                    'f1' => 'отзыв',
                    'f2' => 'отзыва',
                    'f5' => 'отзывов'
                    ]}
                </a>
            </div>
        </div>
    </div>
</div>
