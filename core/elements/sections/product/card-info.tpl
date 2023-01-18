<div class="product-card__top js-product{if $itemInCart?} js-product-in-cart{/if}{if $gallery?} product-card_with-gallery{/if}{if $_modx->resource.old_price?} js-product_with-discount{/if}"
        {* Выводим data-атрибуты *}
        {foreach $itemUnits as $key => $val}
            data-{$key}="{$val['val']}"
        {/foreach}

        {insert "file:blocks/get-data-attrs.tpl"}
>
    <meta itemprop="brand" content="{$_modx->getPlaceholder('brand')}">
    <span class="product-card__article product-card__article_mobile">Арт. {$_modx->resource['article']}</span>

    <div class="product-card__gallery">
        <div class="product-card__img-wrap">
            {if $itemVendor?}
                <div class="product-card__brand" data-val="{$itemVendor}"></div>
            {/if}
            {if $outputOldPrice?}
                <div class="js-product__discount product-card__discount">Скидка {'!calculateDiscount' | snippet}%</div>
            {/if}
            <a href="{$image ?: '/assets/images/no_image.jpg'}" data-fancybox class="product-card__img-link zoom-default" itemscope itemtype="http://schema.org/ImageObject">
                <img class="product-card__img" src="{'site_url' | option}{$_modx->resource['thumb'] ?: 'assets/images/no_image.jpg'}" alt="{$_modx->resource.pagetitle}" itemprop="contentUrl">
            </a>
        </div>

        {$_modx->getPlaceholder('gallery')}
    </div>

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
                        <span class="product-card__unit-link active" data-val="1">{$pricePer}</span>
                        {foreach $itemUnits as $val}
                            <span class="product-card__unit-link" data-val="{$val['id']}">{$val['title']}</span>
                        {/foreach}
                    </div>
                {else}
                    <input type="hidden" name="unit" value="1">
                {/if}

                {if $price}
                    <div class="product-card__price-outer">
                        <div class="product-card__price-wrap js-product__price-wrap">
                            <span itemprop="price" class="js-product__price" data-default="{$defaultPrice}">{$outputPrice}</span>
                            <meta itemprop="priceCurrency" content="RUB">
                            руб

                            {if !$condition}
                                {set $unit = $_modx->resource.unit}
                                {$unit[0] ? '/ ' ~ $unit[0] : ''}
                            {/if}
                        </div>

                        {if $outputOldPrice?}
                            <div class="product-card__new-price-wrap js-product__new-price-wrap">
                                <div class="js-product__new-price-val">
                                    <span class="js-product__new-price" data-default="{$defaultOldPrice}">
                                        {$outputOldPrice}
                                    </span>
                                    руб
                                </div>

                                <div class="js-product__new-price-text">
                                    Цена действительна до {'!getTomorrowDate' | snippet}
                                </div>
                            </div>
                        {/if}
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
                <span class="js-product__btn product-card__btn-compare js-product__btn-compare{if $checkItems['comp'][$_modx->resource['id']]?} active{/if}" href="#">
                    <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                         height="16">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                    </svg>
                </span>
                <span class="js-product__btn product-card__btn-fav js-product__btn-fav{if $checkItems['fav'][$_modx->resource['id']]?} active{/if}" href="#">
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
                    Купить в 1 клик
                {elseif $_modx->resource.context_key == 'fasady-pro'}
                    Получить расчет деревянных фасадов бесплатно
                {elseif $_modx->resource.context_key == 'fasad'}
                    Получить расчет фасадов бесплатно
                {elseif $_modx->resource.context_key == 'armatura-178'}
                    Получить расчет арматуры бесплатно
                {elseif $_modx->resource.context_key == 'asconcrete'}
                    Получить расчет асфальтобетона бесплатно
                {elseif $_modx->resource.context_key == 'pro-fanera'}
                    Получить консультацию бесплатно
                {elseif $_modx->resource.context_key == 'plitaosb'}
                    Получить консультацию бесплатно
                {elseif $_modx->resource.context_key == 'plity-mdvp'}
                    Получить расчет плит МДВП бесплатно
                {else}
                    КУПИТЬ В 1 КЛИК
                {/if}
            </button>
        </div>

        <div class="product-card__info-right">
            <div class="product-card__delivery">
              <b>
                {if $_modx->resource['freeShipping'] ?}
                    Доставка товара бесплатно
                {else}
                    Доставка в Санкт-Петербург и Лен. область
                {/if}
              </b>
                <span data-fancybox data-src="#cost-delivery" class="product-card__delivery-link">
                    <svg class="svg icon-delivery" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-delivery"></use>
                    </svg>
                    {if $_modx->resource['freeShipping'] ?}
                        Заказать с доставкой
                    {else}
                        Узнать стоимость с доставкой
                    {/if}
                </span>
            </div>

            {if $_modx->resource.context_key in ['web', 'rockwool', 'tn', 'penoplex', 'isover', 'paroc', 'ursa']}
                <div class="product-card__return">Возможность возврата товара</div>
            {/if}

            {if $_modx->resource.productNotAvailable == 1}
                <div class="product-card__availability negative">
                    <span class="product-card__availability-cross"></span>
                    Нет в наличии
                </div>
            {else}
                <div class="product-card__availability">
                    <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                      <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>
                    </svg>
                    В наличии
                </div>
            {/if}

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
                <span class="product-card__reviews-quantity">{$countReviews}
                    {'@FILE snippets/formOfWord.php' | snippet : [
                    'n' => $countReviews,
                    'f1' => 'отзыв',
                    'f2' => 'отзыва',
                    'f5' => 'отзывов'
                    ]}
                </span>
            </div>

            {if !$_modx->getPlaceholder('utm_source')}
                <div class="product-card__discount-block">
                    <span class="product-card__discount-block-proposal">Нашли дешевле? Снизим цену!</span>
                    <span class="product-card__discount-block-link" data-fancybox data-src="#discount" data-btn-key="discount">Подробнее</span>
                </div>
            {/if}

            {if $_modx->resource.context_key === 'pilomat'}
                <div class="product-card__discount-block">
                    <span class="product-card__discount-block-proposal">При заказе от 10 м3, доставка и разгрузка <b>БЕСПЛАТНО</b</span>
                </div>
            {/if}
        </div>
    </div>
</div>
