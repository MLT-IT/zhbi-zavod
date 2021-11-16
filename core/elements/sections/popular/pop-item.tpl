{set $productKey = '!getProductKey' | snippet : ['productId' => $id]}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

<div class="pop-item swiper-slide product-item" data-key="{$productKey}">
    <a class="pop-item__img-wrap" href="{$uri}">
        <img class="pop-item__img" src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="">
    </a>
    <a class="pop-item__title" href="{$uri}">{$menutitle}</a>
    <p class="pop-item__price">
        {if $price}
            {$price} руб
            {$unit[0] ? '/ ' ~ $unit[0] : ''}
        {/if}
    </p>
    <div class="pop-item__btns-wrap">
        <form method="post" class="ms2_form product-item__form">
            <input type="hidden" name="id" value="{$id}">
            <input type="hidden" name="options" value="[]">

            <div class="product-item__products-item-controls">
                <div class="custom-counter product-item__custom-counter">
                    <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
                    <input name="count" class="custom-counter__amount" value="1">
                    <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
                </div>

                <button type="submit" name="ms2_action" value="cart/add" class="product-item__btn-in-cart">В корзину
                </button>
            </div>
        </form>

        {*
        <a href="#" class="pop-item__to-fav">
            <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
            </svg>
        </a>
        *}
    </div>
</div>
