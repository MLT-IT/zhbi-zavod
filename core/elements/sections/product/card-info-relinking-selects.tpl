{* Данные для перелинковки *}
{if $_modx->resource.template == 17}
    {set $linksData = 'getRelinkingData_ColorSurfaceThickness' | snippet}
    {set $cvet = $_modx->resource.cvet[0]}
{/if}
{if $_modx->resource.template == 20}
    {set $linksData = 'getRelinkingData_OttenokSurfaceThickness' | snippet}
    {set $cvet = $_modx->resource.ottenok[0]}
{/if}

<div class="js-product{if $itemInCart?} js-product-in-cart{/if}{if $gallery?} product-card_with-gallery{/if}{if $outputOldPrice?} js-product_with-discount{/if}"
    {* Выводим data-атрибуты *}
    {foreach $itemUnits as $key => $val}
        data-{$key}="{$val['val']}"
    {/foreach}

    {insert "file:blocks/get-data-attrs.tpl"}
>
    <div class="product-card__top-line">
        <span class="product-card__article product-card__article_pc">Арт. {$_modx->resource['article']}</span>
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
        <div class="product-card__right-info">
            <span class="js-product__btn product-card__btn-compare js-product__btn-compare{if $checkItems['comp'][$_modx->resource['id']]?} active{/if}"
                  href="#">
                <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                     height="16">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                </svg>
            </span>
            <span class="js-product__btn product-card__btn-fav js-product__btn-fav{if $checkItems['fav'][$_modx->resource['id']]?} active{/if}" href="#">
                <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 21 18" width="21"
                     height="18">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                </svg>
            </span>
        </div>
    </div>

    <div class="product-card__top">
        <meta itemprop="brand" content="{$_modx->getPlaceholder('brand')}">

        <span class="product-card__article product-card__article_mobile">Арт. {$_modx->resource['article']}</span>

        <div class="product-card__gallery">
            <div class="product-card__img-wrap">
                {if $itemVendor?}
                    <div class="product-card__brand" data-val="{$itemVendor | toLowerAndRemoveChars}"></div>
                {/if}
                {if $outputOldPrice?}
                    <div class="js-product__discount product-card__discount">Скидка {'!calculateDiscount' | snippet}%</div>
                {/if}
                <a href="{$image}" data-fancybox class="product-card__img-link zoom-here">
                    <img class="product-card__img" itemprop="image" src="{$_modx->resource['thumb'] ?: '/assets/images/no_image.jpg'}" alt="{$_modx->resource.pagetitle}">
                </a>
            </div>

            {$_modx->getPlaceholder('gallery')}
        </div>

        <div class="hidden" itemprop="aggregateRating" itemscope="" itemtype="http://schema.org/AggregateRating">
            <meta itemprop="bestRating" content="5">
            <meta itemprop="ratingValue" content="5">
            <meta itemprop="ratingCount" content="82">
        </div>

        <div class="product-card__info-wrap">
            <div class="product-card__info" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                <link itemprop="availability" href="http://schema.org/InStock">

                <div class="product-card__info-inner">
                    <div class="product-card__left-info">
                        {if $condition}
                            <div class="product-card__units-wrap">
                                <input type="hidden" name="unit" value="1">
                                <span class="product-card__unit-span">Цена за</span>
                                <a class="product-card__unit-link active" href="#" data-val="1">{$pricePer}</a>
                                {foreach $itemUnits as $val}
                                    <a class="product-card__unit-link" href="#" data-val="{$val['id']}">{$val['title']}</a>
                                {/foreach}
                            </div>
                        {else}
                            <input type="hidden" name="unit" value="1">
                        {/if}

                        {if $price}
                            <div class="product-card__price-outer">
                                <div class="product-card__price-wrap js-product__price-wrap">
                                    {if $outputOldPrice?}
                                        <span itemprop="price" class="js-product__price" data-default="{$defaultOldPrice}">{$outputOldPrice}</span>
                                    {else}
                                        <span itemprop="price" class="js-product__price" data-default="{$defaultPrice}">{$outputPrice}</span>
                                    {/if}
                                    <meta itemprop="priceCurrency" content="RUB">
                                    руб
                                </div>
                                {if $outputOldPrice?}
                                    <div class="product-card__new-price-wrap js-product__new-price-wrap">
                                        <span class="js-product__new-price" data-default="{$defaultPrice}">
                                            {$outputPrice}
                                        </span>
                                        рублей<br>Цена действительна до {'getTomorrowDate' | snippet}
                                    </div>
                                {/if}

                                {if !$condition}
                                    {set $unit = $_modx->resource.unit}
                                    {$unit[0] ? '/ ' ~ $unit[0] : ''}
                                {/if}
                            </div>
                        {/if}

                        {if $_modx->resource.context_key not in list ['kirpich-m', 'fasady-pro', 'fasad', 'armatura-178', 'asconcrete']}
                            {set $upakovka = 'getPackageNew' | snippet}
                            {if $upakovka | length > 0}
                                <div class="product-card__package">В упаковке: {$upakovka}</div>
                            {/if}
                        {/if}
                    </div>
                </div>

                <div class="product-card__info-inner">
                    {if $linksData.pokrytie?}
                        <div class="product-card__select-wrap product-card__select-wrap_type_full">
                            <div class="product-card__select-span">Покрытие:</div>
                            <div class="custom-select-wrap">
                                <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                        <span class="euv-custom-select__input-value">{$_modx->resource.pokrytie[0]}</span>
                                    </div>
                                    <a href="#" class="euv-custom-select__btn"></a>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            {foreach $linksData.pokrytie as $id => $val}
                                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                    {$val}
                                                </a>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="custom-select-mobile-link"></div>
                                <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                            </div>
                        </div>
                    {/if}

                    {if $linksData.cvet?}
                        <div class="product-card__select-wrap product-card__select-wrap_type_half">
                            <div class="product-card__select-span">
                                {if $_modx->resource.template == 17}
                                    Цвет:
                                {/if}
                                {if $_modx->resource.template == 20}
                                    Оттенок:
                                {/if}
                            </div>
                            <div class="custom-select-wrap">
                                <div class="colors-options euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                        <span data-val="{$cvet | toLowerAndRemoveChars}" class="euv-custom-select__input-value">{$cvet}</span>
                                    </div>
                                    <a href="#" class="euv-custom-select__btn"></a>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            <div class="euv-custom-select__options-wrap-scroll-inner">
                                                {foreach $linksData.cvet as $data}
                                                    <div class="euv-custom-select__options-col">
                                                        {foreach $data as $id => $val}
                                                            {set $v = $val | toLowerAndRemoveChars}
                                                            <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option" data-val="{$v}">
                                                                {$val}
                                                            </a>
                                                        {/foreach}
                                                    </div>
                                                {/foreach}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="custom-select-mobile-link"></div>
                                <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                            </div>
                        </div>
                    {/if}

                    {if $linksData.item_thickness?}
                        <div class="product-card__select-wrap product-card__select-wrap_type_half{if $linksData.cvet?} product-card__select-wrap_align_right{/if}">
                            <div class="product-card__select-span">Толщина, мм:</div>
                            <div class="custom-select-wrap">
                                <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                        <span class="euv-custom-select__input-value">{$_modx->resource.item_thickness[0]}</span>
                                    </div>
                                    <a href="#" class="euv-custom-select__btn"></a>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            {foreach $linksData.item_thickness as $id => $val}
                                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                    {$val}
                                                </a>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="custom-select-mobile-link"></div>
                                <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                            </div>
                        </div>
                    {/if}
                </div>

                <div class="product-card__info-simple">
                    <div class="js-product__controls js-product__controls_action_add">
                        <div class="custom-counter js-product__custom-counter{$extraClass}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" class="custom-counter__amount" value="1"
                                   data-min="{$dataMin}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                        <span class="js-product__btn-in-cart js-product__to-cart">В корзину</span>
                    </div>
                    <div class="js-product__controls js-product__controls_action_change">
                        <div class="custom-counter js-product__custom-counter{$extraClass}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" class="custom-counter__amount" value="{$itemInCart?:0}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                        <a href="/cart/" class="js-product__btn-in-cart"><span class="js-product__btn-in-cart-top-text">В корзине</span>
                            Перейти</a>
                    </div>
                    <div class="js-product__ms2-elems">
                        <form class="js-product__form-add ms2_form" method="post">
                            <input name="options" value="[]">
                            <input name="id" value="{$prodId}">
                            <input name="count" value="1">
                            <input name="ctx" value="{$_modx->resource.context_key}">
                            <button type="submit" name="ms2_action" value="cart/add">Добавить</button>
                        </form>
                        <form class="js-product__form-change ms2_form" method="post">
                            <input name="key" value="{$productKey}">
                            <input name="count" value="{$itemInCart?:1}">
                            <input name="ctx" value="{$_modx->resource.context_key}">
                            <button type="submit" name="ms2_action" value="cart/change">Изменить кол-во</button>
                        </form>
                    </div>
                    <button data-fancybox="" href="#callback" class="product-card__buy white-btn">КУПИТЬ В 1 КЛИК</button>
                </div>
            </div>

            <div class="product-card__mobile">
                <div class="product-card__fav-n-comp">
                    <span class="js-product__btn product-card__btn-compare js-product__btn-compare{if $checkItems['comp'][$_modx->resource['id']]?} active{/if}"
                          href="#">
                        <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                             xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                             height="16">
                            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                        </svg>
                    </span>
                    <span class="js-product__btn product-card__btn-fav js-product__btn-fav{if $checkItems['fav'][$_modx->resource['id']]?} active{/if}"
                          href="#">
                        <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg"
                             xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 21 18" width="21"
                             height="18">
                            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                        </svg>
                    </span>
                </div>
                <button data-fancybox="" href="#callback"
                        class="product-card__buy white-btn product-card__buy_type_mobile">КУПИТЬ В 1 КЛИК
                </button>
            </div>

            <div class="product-card__delivery">
                <span class="product-card__delivery-title">Доставка</span>
                <div class="product-card__delivery-content">
                    <span class="product-card__delivery-text">
                        в Санкт-Петербург и Лен. область
                    </span>
                    <a class="product-card__delivery-link" data-fancybox href="#cost-delivery">
                        Узнать стоимость с доставкой
                    </a>
                </div>
            </div>

            <div class="product-card__aux-info">
                <span class="product-card__article product-card__article_pc">Арт. {$_modx->resource['article']}</span>
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

    <div class="product-card__mobile-btns">
        <div class="js-product__controls js-product__controls_action_add">
            <div class="custom-counter js-product__custom-counter{$extraClass}">
                <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                <input name="count" class="custom-counter__amount" value="1"
                       data-min="{$dataMin}">
                <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
            </div>
            <span class="js-product__btn-in-cart js-product__to-cart">В корзину</span>
        </div>
        <div class="js-product__controls js-product__controls_action_change">
            <div class="custom-counter js-product__custom-counter{$extraClass}">
                <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                <input name="count" class="custom-counter__amount" value="{$itemInCart?:0}">
                <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
            </div>
            <a href="/cart/" class="js-product__btn-in-cart"><span class="js-product__btn-in-cart-top-text">В корзине</span>
                Перейти</a>
        </div>
    </div>

</div>
