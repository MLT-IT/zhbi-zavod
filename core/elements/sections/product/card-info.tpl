{set $productKey = '!getProductKey' | snippet : ['productId' => $_modx->resource['id']]}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

<div class="product-card__top product-item" data-key="{$productKey}">
    <div class="product-card__img">
        <img src="{$_modx->resource['thumb'] ?: '/assets/images/no_image.jpg'}" alt=""></div>
    <div class="product-card__info">
        <div class="product-card__price">
            <p>Арт. {$_modx->resource['article']}</p>
            <span>
                {$_modx->resource['price']} руб
                {set $edizm = $_modx->resource.edizm}
                {$edizm[0] ? '/ ' ~ $edizm[0] : ''}
            </span>
            {set $upakovka = 'getPackage' | snippet}
            {if $upakovka | length > 0}
                <div class="product-card__package">В упаковке: {$upakovka}</div>
            {/if}
        </div>
        <div class="product-card__info-left">
            <form method="post" class="ms2_form product-item__form product-card__form" {if $itemInCart > 0}style="display: none;"{/if} >
                <input type="hidden" name="id" value="{$_modx->resource['id']}">
                <input type="hidden" name="count" value="1">
                <input type="hidden" name="options" value="[]">
                <button type="submit" name="ms2_action" value="cart/add" class="product-item__to-cart yellow-btn">
                    <svg class="svg icon-cart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 19 19" width="19" height="19">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart"></use>
                    </svg>В КОРЗИНУ
                </button>
            </form>

            <div {if $itemInCart == 0}style="display: none;"{/if} class="product-card__products-item-controls product-item__products-item-controls">
                <a href="/cart/" class="product-item__btn-in-cart"><span class="product-item__btn-in-cart-top-text">В корзине</span>
                    Перейти</a>
                <div class="custom-counter product-item__custom-counter">
                    <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
                    <input name="counter-count" class="custom-counter__amount" value="{$itemInCart}">
                    <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
                </div>
            </div>

            <button data-fancybox="" href="#callback" class="product-card__buy white-btn">КУПИТЬ В 1 КЛИК</button>
        </div>

        <div class="product-card__info-right">
            <div class="product-card__delivery"><b>Доставка в Санкт-Петербург и Лен. область</b>
                <a href="/dostavka-i-oplata/">
                    <svg class="svg icon-delivery" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-delivery"></use>
                    </svg>Узнать стоимость с доставкой</a>
            </div>
            <div class="product-card__availability">
                <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>
                </svg>В наличии </div>
            <div class="product-card__reviews">
                <div class="product-card__reviews-stars five">
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                </div>

                {set $countReviews = count($reviews)}
                <a class="product-card__reviews-quantity" href="#">{$countReviews}
                    {'@FILE snippets/formOfWord.php' | snippet : [
                        'n' => $countReviews,
                        'f1' => 'отзыв',
                        'f2' => 'отзыва',
                        'f5' => 'отзывов'
                        ]
                    }
                </a>

            </div>
        </div>
    </div>
</div>
