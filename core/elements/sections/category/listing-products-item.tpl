{set $productKey = '!getProductKey' | snippet : ['productId' => $id]}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

<div data-key="{$productKey}" class="product-item listing__products-item" data-views="{$_pls['HitsPage']}" {*itemscope="" itemtype="https://schema.org/Product"*}>

    {*
    <div style="display: none;">
        <meta itemprop="name" content="{$pagetitle}">
        <meta itemprop="description" content="Товар">
        <meta itemprop="brand" content="{$_modx->getPlaceholder('brand')}">
        <meta itemprop="url" content="{$_modx->makeUrl($id, '', '', 'full')}">
        <span itemprop="offers" itemscope="" itemtype="https://schema.org/Offer" style="display: none;">
            <meta itemprop="price" content="{$price}">
            <meta itemprop="priceCurrency" content="RUB">
            <link itemprop="availability" href="http://schema.org/InStock">
        </span>
        <span itemprop="aggregateRating" itemscope="" itemtype="https://schema.org/AggregateRating">
            <span itemprop="ratingValue">5</span>
            <span itemprop="reviewCount">21</span>
        </span>
        <div itemprop="review" itemscope="" itemtype="https://schema.org/Review">
            <meta itemprop="author" content="Аноним">
            <div itemprop="reviewRating" itemscope="" itemtype="https://schema.org/Rating">
                <meta itemprop="worstRating" content="4.5">
                <meta itemprop="ratingValue" content="5">
                <meta itemprop="bestRating" content="5">
            </div>
        </div>
    </div>
    *}

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
                {$price} руб
            {/if}

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
        </div>

        <form method="post" class="ms2_form product-item__form" {if $itemInCart > 0}style="display: none;"{/if}>
            <input type="hidden" name="id" value="{$id}">
            <input type="hidden" name="options" value="[]">

            <button type="submit" name="ms2_action" value="cart/add" class="product-item__btn-in-cart">В корзину</button>
            <div class="custom-counter product-item__custom-counter">
                <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
                <input name="count" class="custom-counter__amount" value="1">
                <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
            </div>
        </form>
        <div{if $itemInCart == 0} style="display: none;"{/if} class="product-item__controls">
            <a href="/cart/" class="product-item__btn-in-cart">
                <span class="product-item__btn-in-cart-top-text">В корзине</span>
                Перейти
            </a>
            <div class="custom-counter product-item__custom-counter">
                <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
                <input name="count" class="custom-counter__amount" value="{$itemInCart}">
                <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
            </div>
        </div>

    </div>
</div>
