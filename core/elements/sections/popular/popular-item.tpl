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
        <input type="hidden" name="count" value="1">
        <input type="hidden" name="options" value="[]">

        <button type="submit" name="ms2_action" value="cart/add" class="product-slider__slide-button yellow-btn">
            <svg class="svg icon-cart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 19 19" width="19" height="19">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart"></use>
            </svg>В КОРЗИНУ
        </button>
    </form>
</div>
