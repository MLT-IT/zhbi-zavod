{set $productKey = '!getProductKey' | snippet : ['productId' => $id]}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

<div data-key="{$productKey}" class="pop-slide swiper-slide product-item listing__products-item" data-m2="{$ploshad_m2[0]}" data-m3="{$obyem_m3[0]}">
    {include "file:chunks/productElems.tpl"}

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
    </div>
    <div class="listing__products-item-right">
        <div class="listing__products-item-price">
            {if $price}
                <span class="product-item__price" data-default="{$price}">{$price}</span> руб
            {/if}

            {if $_modx->resource.context_key !== 'rockwool'}
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

        {if $_modx->resource.context_key === 'rockwool'}
            <div class="product-item__selprice">
                <span class="product-item__selprice-span">Цена за</span>
                <select name="unit" class="euv-custom-select custom-select product-item__units-select">
                    <option value="1" selected>упаковка</option>
                    {if $ploshad_m2[0]}
                        <option value="2">м2</option>
                    {/if}
                    {if $obyem_m3[0]}
                        <option value="3">м3</option>
                    {/if}
                </select>
            </div>
        {else}
            <input type="hidden" name="unit" value="1">
        {/if}

        <form method="post" class="ms2_form product-item__form" {if $itemInCart > 0}style="display: none;"{/if}>
            <input type="hidden" name="id" value="{$id}">
            <input type="hidden" name="options" value="[]">

            <div class="custom-counter product-item__custom-counter">
                <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
                <input name="count" class="custom-counter__amount" value="1" data-min="1">
                <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
            </div>
            <button type="submit" name="ms2_action" value="cart/add" class="product-item__btn-in-cart">В корзину</button>
        </form>
        <div{if $itemInCart == 0} style="display: none;"{/if} class="product-item__controls">
            <div class="custom-counter product-item__custom-counter">
                <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
                <input name="count" class="custom-counter__amount" value="{$itemInCart}">
                <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
            </div>
            <a href="/cart/" class="product-item__btn-in-cart">
                <span class="product-item__btn-in-cart-top-text">В корзине</span>
                Перейти
            </a>
        </div>
    </div>
</div>
