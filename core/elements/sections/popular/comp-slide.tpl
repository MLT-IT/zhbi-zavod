{set $checkItems = $_modx->getPlaceholder('checkItems')}

<div class="pop-slide comp-slide swiper-slide product-item listing__products-item{if $itemInCart?} product-item-in-cart{/if}">
    <input type="hidden" name="id" value="{$id}">
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
        <div class="listing__products-item-fav-remove-btn product-item__action-btn product-item__actions-compare active"></div>
    </div>
    <div class="listing__products-item-right">
        <div class="listing__products-item-price">
            {if $price}
                <span class="product-item__price" data-default="{$price}">{$price}</span>
                руб
            {/if}
            <div class="listing__products-item-measure">
                Цена за
                {if $unit[0] == 'упаковка'}
                    упаковку
                {else}
                    {$unit[0]}
                {/if}
            </div>
        </div>
    </div>

    {'msProductOptions' | snippet : [
        'tpl' => '@FILE sections/product/card-options.tpl',
        'product' => $id
    ]}

    <div class="pop-slide__options-wrap pop-slide__options-wrap_type_only-different">

    </div>
</div>
