<div class="pop-item swiper-slide">
    <a class="pop-item__img-wrap" href="{$uri}">
        <img class="pop-item__img" src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="">
    </a>
    <a class="pop-item__title" href="{$uri}">{$menutitle}</a>
    <p class="pop-item__price">{$price ? $price~" ₽" : ""}</p>
    <form method="post" class="ms2_form">
        <input type="hidden" name="id" value="{$id}">
        <input type="hidden" name="count" value="1">
        <input type="hidden" name="options" value="[]">

        <button type="submit" name="ms2_action" value="cart/add" class="pop-item__button">
            <svg class="svg icon-cart-2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 19 19" width="19" height="19">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart-2"></use>
            </svg>В корзину
        </button>

        <a href="#" class="pop-item__to-fav">
            <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
            </svg>
        </a>
    </form>
</div>
