<div class="swiper-slide product-slider__slide">
    <a class="product-slider__slide-img" href="{$uri}">
        <img src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="">
    </a>
    <div class="product-slider__title-wrap">
        <a class="product-slider__slide-title" href="{$uri}">{$menutitle}</a>
    </div>
    <div class="product-slider__slide-price"><span>{$price ? $price~" руб" : ""}</span>
        <div class="product-slider__slide-price-availability">В наличии</div>
    </div>
    <form method="post" class="ms2_form">
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
</div>
