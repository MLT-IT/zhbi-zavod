{set $checkItems = $_modx->getPlaceholder('checkItems')}

{* Цена за ... *}
{if ($unit[0] is empty) || ($unit[0] == 'упаковка')}
    {set $pricePer = 'упаковку'}
{elseif $unit[0] == 'тонна'}
    {set $pricePer = 'тонну'}
{else}
    {set $pricePer = $unit[0]}
{/if}

{* Цена для красивого вывода *}
{set $outputPrice = $_pls['price'] | preg_replace : '/\B(?=(\d{3})+(?!\d))/': ' ' | replace : ',' : '.'}
{if $_pls['old_price']?}
    {set $outputOldPrice = $_pls['old_price'] | preg_replace : '/\B(?=(\d{3})+(?!\d))/': ' ' | replace : ',' : '.'}
{/if}


<div class="not-init pop-slide comp-slide swiper-slide js-product listing__products-item{if $itemInCart?} js-product-in-cart{/if}">
    <input type="hidden" name="id" value="{$id}">
    <div class="listing__products-item-left">
        <a class="listing__products-item-photo" href="{$uri}" itemscope itemtype="http://schema.org/ImageObject">
            <img src="/assets/images/loader.svg" class="lazy" data-src="{$thumb ?: '/assets/images/no_image.jpg'}" alt="{$pagetitle}" itemprop="contentUrl">
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
        <div class="not-init listing__products-item-fav-remove-btn js-product__action-btn js-product__actions-compare active"></div>
    </div>
    <div class="listing__products-item-right">
        {*
        <div class="listing__products-item-price-and-logo">
            <div class="listing__products-item-price">
                <div class="listing__products-item-price-wrap">
                    {if $price}
                        <span class="js-product__price">{$outputPrice}</span>
                        руб
                    {/if}

                    {if !$condition}
                        {if $price and $unit[0]}
                            <div class="listing__products-item-measure">
                                Цена за
                                {$pricePer}
                            </div>
                        {/if}
                    {/if}
                </div>
            </div>

            <div class="product-logo listing__product-logo" data-val="{$proizvoditel[0] | toLowerAndRemoveChars}"></div>
        </div>
        *}
    </div>

    <div class="pop-slide__options-wrap pop-slide__options-wrap_type_source">
        {if $outputOldPrice?}
            <div class="pop-slide__option" data-title="Цена без скидки">
                <div class="pop-slide__option-caption">Цена без скидки</div>
                <div class="pop-slide__option-value">
                    {$outputOldPrice} руб
                </div>
            </div>
        {/if}

        <div class="pop-slide__option" data-title="Цена">
            <div class="pop-slide__option-caption">Цена</div>
            <div class="pop-slide__option-value">
                {$outputPrice} руб
            </div>
        </div>

        {'msProductOptions' | snippet : [
            'tpl' => '@FILE sections/product/card-options.tpl',
            'product' => $id
        ]}
    </div>

    <div class="pop-slide__options-wrap pop-slide__options-wrap_type_default"></div>
    <div class="pop-slide__options-wrap pop-slide__options-wrap_type_only-different"></div>
</div>
