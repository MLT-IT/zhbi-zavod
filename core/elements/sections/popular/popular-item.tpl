{set $productKey = '!getProductKey' | snippet : ['productId' => $id]}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

<div class="swiper-slide product-slider__slide product-item" data-key="{$productKey}">
    <a class="product-slider__slide-img" href="{$uri}">
        <img src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="{$menutitle}">
    </a>
    <div class="product-slider__title-wrap">
        <a class="product-slider__slide-title" href="{$uri}">{$menutitle}</a>
    </div>
    <div class="product-slider__slide-price"><span>{$price ? $price~" руб" : ""}</span>
        <div class="product-slider__slide-price-availability">В наличии</div>
    </div>

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

