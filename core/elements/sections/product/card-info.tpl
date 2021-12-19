{set $productKey = '!getProductKey' | snippet : ['productId' => $_modx->resource['id']]}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

<div class="product-card__top product-item" data-m2="{$_modx->resource['ploshad_m2'][0]}"
     data-m3="{$_modx->resource['obyem_m3'][0]}" data-key="{$productKey}">
    {include "file:chunks/productElems.tpl"}

    <meta itemprop="brand" content="{$_modx->getPlaceholder('brand')}">

    <a href="{$image}" data-fancybox class="product-card__img">
        <img itemprop="image" src="{$_modx->resource['thumb'] ?: '/assets/images/no_image.jpg'}"
             alt="{$_modx->resource.pagetitle}">
    </a>

    <div class="hidden" itemprop="aggregateRating" itemscope="" itemtype="http://schema.org/AggregateRating">
        <meta itemprop="bestRating" content="5">
        <meta itemprop="ratingValue" content="5">
        <meta itemprop="ratingCount" content="82">
    </div>

    <div class="product-card__info" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
        <link itemprop="availability" href="http://schema.org/InStock">

        <div class="product-card__price">
            <p class="product-card__article">Арт. {$_modx->resource['article']}</p>
            <div class="product-card__units-wrap">
                <span class="product-card__unit-span">Цена за</span>
                <a class="product-card__unit-link active" href="#" data-val="1">упаковку</a>
                {if $_modx->resource['ploshad_m2'][0] ?}
                    <a class="product-card__unit-link" href="#" data-val="2">квадратный метр</a>
                {/if}
                {if $_modx->resource['obyem_m3'][0] ?}
                    <a class="product-card__unit-link" href="#" data-val="3">кубический метр</a>
                {/if}
            </div>

            <input type="hidden" name="unit" value="1">

            {if $price}
                <span class="product-card__price-wrap">
                    <span itemprop="price" class="product-item__price"
                          data-default="{$_modx->resource['price']}">{$_modx->resource['price']}</span>
                    <meta itemprop="priceCurrency" content="RUB">
                    руб

                    {if $_modx->resource.context_key !== 'rockwool'}
                        {set $unit = $_modx->resource.unit}
                        {$unit[0] ? '/ ' ~ $unit[0] : ''}
                    {/if}

                </span>
            {/if}

            {set $upakovka = 'getPackage' | snippet}
            {if $upakovka | length > 0}
                <div class="product-card__package">В упаковке: {$upakovka}</div>
            {/if}
        </div>
        <div class="product-card__info-left">
            <form method="post" class="product-item__form product-card__form"
                {if $itemInCart > 0}style="display: none;"{/if}>
                <input type="hidden" name="id" value="{$_modx->resource['id']}">
                <input type="hidden" name="options" value="[]">

                <div class="custom-counter product-item__custom-counter">
                    <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
                    <input name="count" class="custom-counter__amount product-item__precount" value="1" data-min="1">
                    <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
                </div>
                <button type="submit" class="product-item__btn-in-cart">В корзину</button>
            </form>
            <div{if $itemInCart == 0} style="display: none;"{/if} class="product-item__controls product-card__controls">
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
            <button data-fancybox="" href="#callback" class="product-card__buy white-btn">КУПИТЬ В 1 КЛИК</button>
        </div>

        <div class="product-card__info-right">
            <div class="product-card__delivery"><b>Доставка в Санкт-Петербург и Лен. область</b>
                <a data-fancybox href="#cost-delivery">
                    <svg class="svg icon-delivery" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-delivery"></use>
                    </svg>
                    Узнать стоимость с доставкой</a>
            </div>
            <div class="product-card__availability">
                <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>
                </svg>
                В наличии
            </div>
            <div class="product-card__reviews">
                <div class="product-card__reviews-stars five">
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
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
                    ]}
                </a>
            </div>
        </div>
    </div>
</div>
