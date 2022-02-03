{set $checkItems = $_modx->getPlaceholder('checkItems')}

{* Ключ товара, нужен для добавления товара в корзину *}
{set $productKey = ($id ~ ($price | replace : ' ' : '') ~ $weight ~ '[]') | md5}
{* Кол-во товара в корзине *}
{set $itemInCart = $checkItems['cart'][$id]}

{* Основные единицы измерения *}
{set $pm = $_pls['kolvo-pm'][0]}
{set $m2 = $_pls['ploshad_m2'][0]}
{set $m3 = $_pls['obyem_m3'][0]}
{if $_pls['v_upakovke'][0]? && $price? && $_modx->resource.context_key == 'penoplex'}
    {set $list = $_pls['price'] * $_pls['v_upakovke'][0]}
    {set $list = $list | round : 2 | replace : ',' : '.'}
{/if}

{* Условие - выводить ли возможность выбирать единицу измерения для добавления товара в корзину *}
{set $condition = ($_modx->resource.context_key in list ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc']) &&
                  ($_pls['parent'] not in list [9052, 9125, 14193, 14269, 10998, 12018, 12819, 15201, 15202])}

{* Дополнительные рассчеты цен за единицы измерения для некоторых контекстов *}
{if $_pls['v_upakovke']? && $_modx->resource.context_key in list ['web', 'penoplex']}
    {set $m2 = $m2 * $_pls['v_upakovke'][0]}
    {set $m2 = $m2 | replace : ',' : '.'}
{/if}

{*
  data-priority1 и data-priority2 можно убрать, я их вывел чисто для того, чтобы понять, работает ли сортировка по популярности
*}
<div data-upakovka="{$_pls['v_upakovke'][0]}"  class="product-item listing__products-item{if $itemInCart?} product-item-in-cart{/if}"
     data-m2="{$m2}"
     data-m3="{$m3}"
     data-pm="{$pm}"
     data-list="{$list}"

     data-priority1="{$_pls['priority1']}"
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
        {*
        ВАЖНО! Когда раскомментируешь кнопки, измени у ".listing__products-item-art" grid-column: span 3 на 2.
        <div class="listing__products-item-btns-wrap">
            <span class="listing__products-item-btn listing__products-item-btn-more">
                <svg class="svg icon-dots" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                     height="16">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-dots"></use>
                </svg>
            </span>
            <div class="listing__products-item-btns-wrap-inner">
                <span class="listing__products-item-btn listing__products-item-btn-compare" href="#">
                    <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                         height="16">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                    </svg>
                </span>
                <span class="listing__products-item-btn listing__products-item-btn-fav" href="#">
                    <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 21 18" width="21"
                         height="18">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                    </svg>
                </span>
            </div>
        </div>
        *}
    </div>
    <div class="listing__products-item-right">
        <div class="listing__products-item-actions product-item__actions">
            <label for="product-item__actions-compare-{$id}" class="product-item__actions-compare-label">
                <span class="custom-checkbox product-item__actions-compare-checkbox">
                    <input class="product-item__actions-compare custom-checkbox__input" type="checkbox" name="product-item__actions-compare" id="product-item__actions-compare-{$id}"{if $checkItems['comp'][$id] === 1} checked{/if} />
                    <span class="custom-checkbox__checkmark"></span>
                </span>
                <span class="product-item__actions-compare-text">Сравнить</span>
            </label>
            <span class="product-item__btn product-item__btn-fav{if $checkItems['fav'][$id] === 1} active{/if}" href="#">
                <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 21 18" width="21"
                     height="18">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                </svg>
            </span>
        </div>

        <div class="listing__products-item-chars-wrap">
            <span class="listing__products-item-chars-btn">
                <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                     version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                </svg>
                Показать информацию
            </span>
            <div class="listing__products-item-chars">
                {set $primenenieCount = $_pls['primenenie'] | count}
                {set $primenenieInfo = []}
                {if $primenenieCount > 1}
                    {set $primenenie = $_pls['primenenie'][0] ~ '...'}

                    {foreach 1..($primenenieCount-1) as $value}
                        {set $primenenieInfo[] = $_pls['primenenie'][$value]}
                    {/foreach}
                {else}
                    {set $primenenie = $_pls['primenenie'][0]}
                {/if}

                {set $charsValues = [
                    $primenenie,
                    $_pls['plotnost'][0],
                    $_pls['teploprovodnost'][0],
                    $_pls['ploshad_m2'][0],
                    $_pls['obyem_m3'][0],
                    $_pls['v_upakovke'][0],
                    $pm,
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

                                {if $key == 'Применение' && $primenenieInfo | count > 0}
                                    <div class="listing__products-item-chars-val-info-wrap">
                                        <span class="listing__products-item-chars-val-info-btn">
                                            <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg"
                                                 xmlns:xlink="http://www.w3.org/1999/xlink"
                                                 version="1.1">
                                                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                                            </svg>
                                        </span>
                                        <div class="listing__products-item-chars-val-info">
                                            {$primenenieInfo | implode : ', '}
                                        </div>
                                    </div>
                                {/if}
                            </span>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>

        <div class="listing__products-item-price">
            {if $price}
                <span class="product-item__price" data-default="{$price}">{$price}</span>
                руб
            {/if}

            {if !$condition}
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

        {if $condition}
            <div class="product-item__selprice listing__products-item-selprice">
                <span class="product-item__selprice-span">Цена за</span>
                <select name="unit" class="euv-custom-select custom-select product-item__units-select">
                    <option value="1" selected>упаковку</option>
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
                </select>
            </div>
        {else}
            <input type="hidden" name="unit" value="1">
        {/if}

        {include "file:chunks/productElems.tpl" prodId=$id}
    </div>
</div>
