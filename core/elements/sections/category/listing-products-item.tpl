{* Данный код нужен, т.к. при подгрузке товаров через AJAX (mFilter2) плейсхолдер checkItems будет пустым, он ведь устанавливается при загрузке страницы *}
{if $_modx->getPlaceholder('checkItems') is null}
    {'!checkItems' | snippet}
{/if}

{* Устанавливаем переменные для чанка *}
{set $src = $_pls}
{insert "file:blocks/set-values-for-prod.tpl"}

<div class="not-init js-product listing__products-item{if $itemInCart?} js-product-in-cart{/if}{if $outputOldPrice?} js-product_with-discount{/if}"
    {* Выводим data-атрибуты *}
    {foreach $itemUnits as $key => $val}
        data-{$key}="{$val['val']}"
    {/foreach}

    {insert "file:blocks/get-data-attrs.tpl"}

     {* data-priority1 и data-priority2 можно убрать, я их вывел чисто для того, чтобы понять, работает ли сортировка по популярности *}
     data-priority1="{$src['priority1']}"
     data-priority2="{$src['HitsPage']}"
>
    <div class="listing__products-item-left">
        <a class="listing__products-item-photo" href="{$uri}">
            {if $outputOldPrice?}
                <div class="listing__discount js-product__discount">Скидка {'!calculateDiscount' | snippet : ['id' => $id]}%</div>
            {/if}
            <img class="lazy" data-src="{$thumb ?: '/assets/images/no_image_small.jpg'}" alt="{$pagetitle}">
        </a>
        <div class="listing__products-item-title">
            <a href="{$uri}">{$pagetitle}</a>
        </div>
        <div class="listing__products-item-avail">
            <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg"
                 xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>
            </svg>
            В наличии
        </div>
        <div class="listing__products-item-rate five">
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
        </div>
        <div class="listing__products-item-art">Арт. {$article}</div>
        <div class="listing__products-item-btns-wrap">
            <span class="listing__products-item-btn listing__products-item-btn-more">
                <svg class="svg icon-dots" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                     height="16">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-dots"></use>
                </svg>
            </span>
            <div class="listing__products-item-btns-wrap-inner">
                <span title="Сравнить" class="js-product__action-btn listing__products-item-btn listing__products-item-btn-compare{if $checkItems['comp'][$id]?} active{/if}" href="#">
                    <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                         height="16">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                    </svg>
                </span>
                <span title="Избранное" class="js-product__action-btn listing__products-item-btn listing__products-item-btn-fav{if $checkItems['fav'][$id]?} active{/if}" href="#">
                    <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 21 18" width="21"
                         height="18">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                    </svg>
                </span>
            </div>
        </div>
    </div>
    <div class="listing__products-item-right">

        {include "file:blocks/listing-product-chars.tpl"}

        <div class="listing__products-item-price-and-logo">
            <div class="listing__products-item-price">
                <div class="listing__products-item-price-wrap js-product__price-wrap">
                    <span class="js-product__price" data-default="{$defaultPrice}">{$outputPrice}</span> руб
                </div>

                {if $outputOldPrice?}
                    <div class="listing__product-new-price-wrap js-product__new-price-wrap js-product__new-price-val">
                        <span class="listing__product-new-price js-product__new-price" data-default="{$defaultOldPrice}">{$outputOldPrice}</span>
                        руб
                    </div>
                {/if}

                {if !$condition}
                    {if $price and $unit[0]}
                        <div class="listing__products-item-measure">
                            Цена за
                            {$pricePer}
                        </div>
                    {/if}
                {/if}
            </div>

            <div class="product-logo listing__product-logo" data-val="{$proizvoditel[0] | toLowerAndRemoveChars}"></div>

            {if $outputOldPrice?}
                <div class="js-product__new-price-wrap listing__new-price-text js-product__new-price-text">
                    Цена действительна до {'!getTomorrowDate' | snippet}
                </div>
            {/if}
        </div>

        {if $condition}
            <div class="js-product__selprice listing__products-item-selprice">
                <span class="js-product__selprice-span">Цена за</span>
                <select name="unit" class="custom-select js-product__units-select">
                    <option value="1" selected>{$pricePer}</option>
                    {foreach $itemUnits as $val}
                        <option value="{$val['id']}">{$val['title']}</option>
                    {/foreach}
                </select>
            </div>
        {else}
            <input type="hidden" name="unit" value="1">
        {/if}

        {include "file:chunks/productElems.tpl" prodId=$id}
    </div>
</div>

{* Выводим блок "Нашли дешевле?" *}
{set $total = $_modx->getPlaceholder('total')}
{if ($_modx->resource.template in list [4, 19, 5]) &&
(($idx == 1 && $total == 1) || ($idx == 2 && $total >= 2))}
    <div class="listing__catalog-discount">
        <div class="listing__catalog-discount-text-1">Нашли дешевле?</div>
        <div class="listing__catalog-discount-text-2">Снизим цену!</div>
        <span data-fancybox="" data-src="#discount" class="listing__catalog-discount-btn-more" href="#" data-btn-key="discount">Подробнее</span>
    </div>
{/if}
