<div class="product-card__top">
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
        </div>
        <form method="post" class="ms2_form product-card__info-left">
            <input type="hidden" name="id" value="{$_modx->resource['id']}">
            <input type="hidden" name="options" value="[]">
            <div class="product-card__quantity quantity-block">
                <div class="custom-counter cart-table__custom-counter">
                    <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
                    <input name="count" class="custom-counter__amount" value="1">
                    <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
                </div>
            </div>
            <button type="submit" name="ms2_action" value="cart/add" class="yellow-btn">
                <svg class="svg icon-cart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 19 19" width="19" height="19">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart"></use>
                </svg>В КОРЗИНУ
            </button>
            <button data-fancybox="" href="#callback" class="product-card__buy white-btn">КУПИТЬ В 1 КЛИК</button>
        </form>
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
