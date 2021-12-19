{set $productKey = '!getProductKey' | snippet : ['productId' => $id]}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

<div data-m2="{$ploshad_m2[0]}" data-m3="{$obyem_m3[0]}" class="swiper-slide product-slider__slide product-item" data-key="{$productKey}">
    <a class="product-slider__slide-img" href="{$uri}">
        <img src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="{$menutitle}">
    </a>
    <div class="product-slider__title-wrap">
        <a class="product-slider__slide-title" href="{$uri}">{$menutitle}</a>
    </div>
    <div class="product-slider__slide-price">
        {if $price}
            <span class="product-item__price" data-default="{$price}">{$price}</span>
            <span class="product-slider__slide-price-currency">руб</span>
        {/if}
        <div class="product-slider__slide-price-availability">В наличии</div>
    </div>

    {if $_modx->resource.context_key === 'rockwool'}
        <div class="product-item__selprice listing__products-item-selprice">
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

