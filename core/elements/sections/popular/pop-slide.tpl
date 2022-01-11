{* Ключ товара, нужен для добавления товара в корзину *}
{set $productKey = '!getProductKey' | snippet : ['productId' => $id]}

{* Товар находится в корзине? *}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

{* Основные единицы измерения *}
{set $pm = $_pls['kolvo-pm'][0]}
{set $m2 = $_pls['ploshad_m2'][0]}
{set $m3 = $_pls['obyem_m3'][0]}
{if $_pls['v_upakovke'][0]? && $price? && $_modx->resource.context_key == 'penoplex'}
    {set $list = $_pls['price'] * $_pls['v_upakovke'][0]}
    {set $list = $list | round : 2 | replace : ',' : '.'}
{/if}

{* Условие - выводить ли возможность выбирать единицу измерения для добавления товара в корзину *}
{set $condition = ($_modx->resource.context_key in list ['rockwool', 'penoplex', 'web', 'tn', 'ursa']) &&
                  ($_pls['parent'] not in list [9052, 9125, 14193, 14269, 10998, 12018, 12819])}

{* Дополнительные рассчеты цен за единицы измерения для некоторых контекстов *}
{if $_pls['v_upakovke']? && $_modx->resource.context_key in list ['web', 'penoplex']}
    {set $m2 = $m2 * $_pls['v_upakovke'][0]}
    {set $m2 = $m2 | replace : ',' : '.'}
{/if}

<div class="pop-slide swiper-slide product-item listing__products-item{if $itemInCart > 0} product-item-in-cart{/if}"
     data-m2="{$m2}"
     data-m3="{$m3}"
     data-pm="{$pm}"
     data-list="{$list}">

    <div class="listing__products-item-left">
        <a class="listing__products-item-photo" href="{$uri}">
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
        {*
        ВАЖНО! Когда раскомментируешь кнопки, измени у ".listing__products-item-art" grid-column: span 3 на 2.
        <div class="listing__products-item-btns-wrap">
            <span class="listing__products-item-btn listing__products-item-btn-more">
                <svg class="svg icon-dots" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                     height="16">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-dots"></use>
                </svg>
            </span>
            <div class="listing__products-item-btns-wrap-inner">
                <span class="listing__products-item-btn listing__products-item-btn-compare" href="#">
                    <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                         height="16">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                    </svg>
                </span>
                <span class="listing__products-item-btn listing__products-item-btn-fav" href="#">
                    <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 21 18" width="21"
                         height="18">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                    </svg>
                </span>
            </div>
        </div>
        *}
    </div>
    <div class="listing__products-item-right">
        <div class="listing__products-item-price">
            {if $price}
                <span class="product-item__price" data-default="{$price}">{$price}</span>
                руб
            {/if}

            {if $condition}
                {if $price and $unit[0]}
                    <div class="listing__products-item-measure">
                        Цена за
                        {if $unit[0] == 'упаковка'}
                            упаковку
                        {else}
                            {$unit[0]}
                        {/if}
                    </div>
                {/if}
            {/if}
        </div>

        {if $condition}
            <div class="product-item__selprice">
                <span class="product-item__selprice-span">Цена за</span>
                <select name="unit" class="euv-custom-select custom-select product-item__units-select">
                    <option value="1" selected>упаковку</option>
                    {if $m2 ?}
                        <option value="2">м2</option>
                    {/if}
                    {if $m3 ?}
                        <option value="3">м3</option>
                    {/if}
                    {if $pm ?}
                        <option value="4">п.м.</option>
                    {/if}
                    {if $list ?}
                        <option value="5">лист</option>
                    {/if}
                </select>
            </div>
        {else}
            <input type="hidden" name="unit" value="1">
        {/if}

        {include "file:chunks/productElems.tpl" prodId=$id}
    </div>
</div>
