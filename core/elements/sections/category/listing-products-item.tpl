{* Данный код нужен, т.к. при подгрузке товаров через AJAX (mFilter2) плейсхолдер checkItems будет пустым, он ведь устанавливается при загрузке страницы *}
{if $_modx->getPlaceholder('checkItems') is null}
    {'!checkItems' | snippet}
{/if}

{* Устанавливаем переменные для чанка *}
{set $src = $_pls}
{insert "file:blocks/set-values-for-prod.tpl"}

<div class="not-init js-product listing__products-item{if $itemInCart?} js-product-in-cart{/if}{if $_modx->resource.old_price?} js-product_with-discount{/if}"
    {* Выводим data-атрибуты *}
    {foreach $itemUnits as $key => $val}
        data-{$key}="{$val['val']}"
    {/foreach}

    {insert "file:blocks/get-data-attrs.tpl"}

     {* data-priority1 и data-priority2 можно убрать, я их вывел чисто для того, чтобы понять, работает ли сортировка по популярности *}
     data-priority1="{$src['priority1']}"
     data-priority2="{$src['HitsPage']}"
>
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
                <span title="Сравнить" class="js-product__action-btn listing__products-item-btn listing__products-item-btn-compare{if $checkItems['comp'][$id]?} active{/if}" href="#">
                    <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                         height="16">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                    </svg>
                </span>
                <span title="Избранное" class="js-product__action-btn listing__products-item-btn listing__products-item-btn-fav{if $checkItems['fav'][$id]?} active{/if}" href="#">
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
        <div class="listing__products-item-chars-wrap">
            <span class="listing__products-item-chars-btn">
                <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                     version="1.1">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                </svg>
                Показать информацию
            </span>
            <div class="listing__products-item-chars">
                {* TODO: вынеси это в сниппет на php. Или в чанк на fenom. Т.к. здесь этот  огромный кусок кода смотрится не очень *}
                {* Массив со сложными опциями *}
                {if $_modx->resource.context_key == 'armatura-178'}
                    {set $compositeKeys = [
                        'Марка стали' => 'marka-stali'
                    ]}
                {/if}
                {if $_modx->resource.context_key not in list ['web', 'rockwool', 'tn', 'penoplex', 'isover', 'paroc', 'ursa']}
                    {set $compositeKeys['Применение'] = 'primenenie'}
                {/if}

                {* Получение значений опций *}
                {set $compositeValues = []}
                {set $compositeExtraValues = []}
                {set $compositeCount = []}
                {foreach $compositeKeys as $title => $key}
                    {set $compositeCount[$key] = $src[$key] | count}
                    {set $info = []}
                    {if $compositeCount[$key] > 1}
                        {set $compositeValues[$key] = $src[$key][0] ~ '...'}

                        {foreach 1..($compositeCount[$key]-1) as $value}
                            {set $compositeExtraValues[$key][] = $src[$key][$value]}
                        {/foreach}
                    {else}
                        {set $compositeValues[$key] = $src[$key][0]}
                    {/if}
                {/foreach}

                {* Какие опции будут выводиться *}
                {if $src['context_key'] == 'armatura-178'}
                    {set $charsValues = [
                        $src['diametr-mm'][0],
                        $src['dlina-m'][0],
                        $src['surface'][0],
                        $src['massa-1-m-profilya-kg'][0],
                        $src['marka-stali'][0],
                        $src['kolichestvo-metrov-v-1-tonne'][0],
                    ]}
                    {set $charsHeaders = [
                        'Диаметр, мм',
                        'Длина, м',
                        'Поверхность'
                        'Масса 1 п.м. профиля, кг'
                        'Марка стали'
                        'Количество п.м. в 1 тонне'
                    ]}
                {elseif $src['context_key'] == 'pilomat'}
                    {set $charsValues = [
                        ([$src['item_thickness'][0], $src['item_width'][0], $src['item_length'][0]] | implode : 'x'),
                        $src['vlazhnost'][0],
                        $src['sort'][0],
                        $src['vid-obrabotki'][0],
                        $src['massa'][0],
                        $src['kol-vokub-sh'][0],
                    ]}
                    {set $charsHeaders = [
                        'Размер',
                        'Влажность',
                        'Сорт',
                        'Вид обработки',
                        'Вес, кг',
                        'Кол-во в кубе, шт',
                    ]}
                {elseif $src['context_key'] == 'kirpich-m'}
                    {set $charsValues = [
                        $src['voidness'][0],
                        $src['proizvoditel'][0],
                        $src['razmer-mm'][0],
                        $src['strength_grade'][0],
                        $src['pallet_num'][0],
                        $src['plotnost'][0],
                        $src['massa'][0],
                        $src['format'][0],
                    ]}
                    {set $charsHeaders = [
                        'Пустотность',
                        'Производитель',
                        'Размер, мм',
                        'Марка прочности',
                        'Кол-во на поддоне',
                        'Плотность, кг/м3',
                        'Вес, кг',
                        'Формат',
                    ]}
                {else}
                    {set $charsValues = [
                        $primenenie,
                        $src['plotnost'][0],
                        $src['teploprovodnost'][0],
                        $src['ploshad_m2'][0],
                        $src['obyem_m3'][0],
                        $src['v_upakovke'][0],
                        $pm,
                    ]}
                    {set $charsHeaders = [
                        'Применение',
                        'Плотность, кг/м3',
                        'Теплопроводность',
                        'Площадь, м2',
                        'Объем, м3',
                        'Кол-во в упаковке, шт',
                        'Кол-во в упаковке, п.м.',
                    ]}
                {/if}

                {* Вывод опций *}
                {foreach $charsValues as $key => $value}
                    {if $value ?}
                        <div class="listing__products-item-chars-line">
                            <span class="listing__products-item-chars-span">
                                {$charsHeaders[$key]}:
                            </span>
                            <span class="listing__products-item-chars-val">
                                {if $compositeValues[$compositeKeys[$charsHeaders[$key]]]}
                                    {$compositeValues[$compositeKeys[$charsHeaders[$key]]]}

                                    {if $compositeExtraValues[$compositeKeys[$charsHeaders[$key]]] | count > 0}
                                        <div class="listing__products-item-chars-val-info-wrap">
                                        <span class="listing__products-item-chars-val-info-btn">
                                            <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg"
                                                 xmlns:xlink="http://www.w3.org/1999/xlink"
                                                 version="1.1">
                                                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                                            </svg>
                                        </span>
                                        <div class="listing__products-item-chars-val-info">
                                            {$compositeExtraValues[$compositeKeys[$charsHeaders[$key]]] | implode : ', '}
                                        </div>
                                    </div>
                                    {/if}
                                {else}
                                    {* На всякий случай делаем join, вдруг значение - это массив. Ну а если нет, то со значением ничего не будет *}
                                    {$value | join : ', '}
                                {/if}
                            </span>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>

        <div class="listing__products-item-price-and-logo">
            <div class="listing__products-item-price">
                <div class="listing__products-item-price-wrap">
                    {if $price}
                        <span class="js-product__price" data-default="{$defaultPrice}">{$outputPrice}</span>
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

        {if $condition}
            <div class="js-product__selprice listing__products-item-selprice">
                <span class="js-product__selprice-span">Цена за</span>
                <select name="unit" class="custom-select js-product__units-select">
                    <option value="1" selected>{$pricePer}</option>
                    {foreach $itemUnits as $val}
                        <option value="{$val['id']}">{$val['title']}</option>
                    {/foreach}
                </select>
            </div>
        {else}
            <input type="hidden" name="unit" value="1">
        {/if}

        {include "file:chunks/productElems.tpl" prodId=$id}
    </div>
</div>
