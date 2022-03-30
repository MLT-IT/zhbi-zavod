{set $src = $_pls}
{insert "file:blocks/set-values-for-prod.tpl"}

<div class="not-init pop-slide swiper-slide product-item listing__products-item{if $itemInCart?} product-item-in-cart{/if}"
     data-m2="{$m2}"
     data-m3="{$m3}"
     data-pm="{$pm}"
     data-list="{$list}"
     data-thing="{$thing}"
     data-pilomat-thing="{$pilomat_thing}">

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
        <div class="listing__products-item-btns-wrap">
            <span class="listing__products-item-btn listing__products-item-btn-more">
                <svg class="svg icon-dots" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                     height="16">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-dots"></use>
                </svg>
            </span>
            <div class="listing__products-item-btns-wrap-inner">
                <span title="Сравнить" class="product-item__action-btn listing__products-item-btn listing__products-item-btn-compare{if $checkItems['comp'][$id]?} active{/if}" href="#">
                    <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                         height="16">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                    </svg>
                </span>
                <span title="Избранное" class="product-item__action-btn listing__products-item-btn listing__products-item-btn-fav{if $checkItems['fav'][$id]?} active{/if}" href="#">
                    <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 21 18" width="21"
                         height="18">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                    </svg>
                </span>
            </div>
        </div>
    </div>

    <div class="listing__products-item-right">
        <div class="listing__products-item-price-and-logo">
            <div class="listing__products-item-price">
                <div class="listing__products-item-price-wrap">
                    {if $price}
                        <span class="product-item__price" data-default="{$price}">{$price}</span>
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

            <div class="product-logo listing__product-logo" data-brand="{$proizvoditel[0] | toLowerAndRemoveChars}"></div>
        </div>

        {if $condition}
            <div class="product-item__selprice">
                <span class="product-item__selprice-span">Цена за</span>
                <select name="unit" class="custom-select product-item__units-select">
                    <option value="1" selected>{$pricePer}</option>
                    {if $m2 ?}
                        <option value="2">м2</option>
                    {/if}
                    {if $m3 ?}
                        <option value="3">м3</option>
                    {/if}
                    {if $pm ?}
                        <option value="4">п.м.</option>
                    {/if}
                    {if $list ?}
                        <option value="5">лист</option>
                    {/if}
                    {if $thing ?}
                        <option value="6">штуку</option>
                    {/if}
                    {if $pilomat_thing ?}
                        <option value="7">штуку</option>
                    {/if}
                </select>
            </div>
        {else}
            <input type="hidden" name="unit" value="1">
        {/if}

        <div class="listing__products-item-bottom">
            {include "file:chunks/productElems.tpl" prodId=$id}
        </div>
    </div>
</div>
