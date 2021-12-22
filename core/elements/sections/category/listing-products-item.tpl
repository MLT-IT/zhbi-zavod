{set $productKey = '!getProductKey' | snippet : ['productId' => $id]}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

{*
  data-priority1 и data-priority2 можно убрать, я их вывел чисто для того, чтобы понять, работает ли сортировка по популярности.
*}

<div data-m2="{$ploshad_m2[0]}" data-m3="{$obyem_m3[0]}" data-pm="{$_pls['kolvo-pm'][0]}"
     class="product-item listing__products-item{if $itemInCart > 0} product-item-in-cart{/if}" data-priority1="{$_pls['priority1']}"
     data-priority2="{$_pls['HitsPage']}">

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
        <div class="listing__products-item-chars-wrap">
            <span class="listing__products-item-chars-btn">
                <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                     version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                </svg>
                Показать информацию
            </span>
            <div class="listing__products-item-chars">
                {set $charsValues = [
                    $_pls['primenenie'][0],
                    $_pls['plotnost'][0],
                    $_pls['teploprovodnost'][0],
                    $_pls['ploshad_m2'][0],
                    $_pls['obyem_m3'][0],
                    $_pls['v_upakovke'][0],
                    $_pls['kolvo-pm'][0],
                ]}
                {set $charsHeaders = [
                    'Применение',
                    'Плотность, кг/м3',
                    'Теплопроводность',
                    'Площадь, м2',
                    'Объем, м3',
                    'Кол-во в упаковке, шт',
                    'Кол-во в упаковке, п.м.'
                ]}
                {foreach $charsValues as $key => $value}
                    {if $value ?}
                        <div class="listing__products-item-chars-line">
                            <span class="listing__products-item-chars-span">
                                {$charsHeaders[$key]}:
                            </span>
                            <span class="listing__products-item-chars-val">
                                {$value}
                            </span>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>

        <div class="listing__products-item-price">
            {if $price}
                <span class="product-item__price" data-default="{$price}">{$price}</span> руб
            {/if}

            {if $_modx->resource.context_key != 'rockwool'}
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
            {/if}
        </div>

        {if $_modx->resource.context_key === 'rockwool'}
            <div class="product-item__selprice listing__products-item-selprice">
                <span class="product-item__selprice-span">Цена за</span>
                <select name="unit" class="euv-custom-select custom-select product-item__units-select">
                    <option value="1" selected>упаковку</option>
                    {if $ploshad_m2[0]}
                        <option value="2">м2</option>
                    {/if}
                    {if $obyem_m3[0]}
                        <option value="3">м3</option>
                    {/if}
                    {if $_pls['kolvo-pm'][0]}
                        <option value="4">п.м.</option>
                    {/if}
                </select>
            </div>
        {else}
            <input type="hidden" name="unit" value="1">
        {/if}

        {include "file:chunks/productElems.tpl" prodId=$id}
    </div>
</div>
