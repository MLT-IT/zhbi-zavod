{* Данные для перелинковки *}
{set $linksData = 'getRelinkingData_FormatThicknessSort' | snippet}

<div class="js-product{if $itemInCart?} js-product-in-cart{/if}{if $gallery?} product-card_with-gallery{/if}{if $_modx->resource.old_price?} js-product_with-discount{/if}"
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

        <div class="product-card__main-content">
            <div class="product-card__main-content-top">
                <div class="product-card__gallery">
                    <div class="product-card__img-wrap">
                        {if $itemVendor?}
                            <div class="product-card__brand" data-val="{$itemVendor | toLowerAndRemoveChars}"></div>
                        {/if}
                        {if $outputOldPrice?}
                            <div class="js-product__discount product-card__discount">Скидка {'!calculateDiscount' | snippet}%</div>
                        {/if}
                        <a href="{$image}" data-fancybox class="product-card__img-link zoom">
                            <img class="product-card__img" itemprop="image" src="{$_modx->resource['thumb'] ?: '/assets/images/no_image.jpg'}" alt="{$_modx->resource.pagetitle}">
                        </a>
                    </div>

                    {$_modx->getPlaceholder('gallery')}
                </div>

                <div class="product-card__mobile product-card__fav-n-comp">
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

                <div class="hidden" itemprop="aggregateRating" itemscope="" itemtype="http://schema.org/AggregateRating">
                    <meta itemprop="bestRating" content="5">
                    <meta itemprop="ratingValue" content="5">
                    <meta itemprop="ratingCount" content="82">
                </div>

                <div class="product-card__main-specs">
                    {if ($_modx->resource['item_thickness'][0] is not empty) &&
                        ($_modx->resource['item_width'][0] is not empty) &&
                        ($_modx->resource['item_length'][0] is not empty)
                    }
                        <div class="product-card__specs-list-item" data-opt-key="unit">
                            <div class="product-card__specs-list-item-name">Размер</div>
                            <div class="product-card__specs-list-item-value">
                                {[$_modx->resource['item_thickness'][0], $_modx->resource['item_width'][0], $_modx->resource['item_length'][0]] | join : ' мм х '} мм
                            </div>
                        </div>
                    {/if}
                    {if $_modx->resource['strana'][0]?}
                        <div class="product-card__specs-list-item" data-opt-key="unit">
                            <div class="product-card__specs-list-item-name">Страна</div>
                            <div class="product-card__specs-list-item-value">
                                {$_modx->resource['strana'][0]}
                            </div>
                        </div>
                    {/if}
                    {if $_modx->resource['ploshad_m2'][0]?}
                        <div class="product-card__specs-list-item" data-opt-key="unit">
                            <div class="product-card__specs-list-item-name">Площадь</div>
                            <div class="product-card__specs-list-item-value">
                                {$_modx->resource['ploshad_m2'][0]} м2
                            </div>
                        </div>
                    {/if}
                </div>
            </div>
            {include 'file:sections/product/card-content-tab.tpl'}
        </div>

        <div class="product-card__side-panel">
            {if ($_modx->resource.context_key === 'pro-fanera')}
                {set $formatKey = 'razmer-mm'}
            {else}
                {set $formatKey = 'format_text'}
            {/if}

            {if $linksData['format']?}
                <div class="product-card__relinking-block">
                    <div class="product-card__side-panel-text">Формат, мм</div>
                    <div class="product-card__relinking-items-wrap">
                        {foreach $linksData['format'] as $id => $val}
                            {if $_modx->resource[$formatKey][0] == $val}
                                <span class="product-card__relinking-item active">
                                    {$val}
                                </span>
                            {else}
                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="product-card__relinking-item">
                                    {$val}
                                </a>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            {/if}

            {if $linksData['item_thickness']?}
                <div class="product-card__relinking-block">
                    <div class="product-card__side-panel-text">Толщина, мм</div>
                    <div class="product-card__relinking-items-wrap">
                        {foreach $linksData['item_thickness'] as $id => $val}
                            {if $_modx->resource['item_thickness'][0] == $val}
                                <span class="product-card__relinking-item active">
                                    {$val}
                                </span>
                            {else}
                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="product-card__relinking-item">
                                    {$val}
                                </a>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            {/if}

            {if $linksData['sort']?}
                <div class="product-card__relinking-block">
                    <div class="product-card__side-panel-text">Сорт</div>
                    <div class="product-card__relinking-items-wrap">
                        {foreach $linksData['sort'] as $id => $val}
                            {if $_modx->resource['sort'][0] == $val}
                                <span class="product-card__relinking-item active">
                                    {$val}
                                </span>
                            {else}
                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="product-card__relinking-item">
                                    {$val}
                                </a>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            {/if}

            {*
              Атрибут content нужен для поисковиков, т.к. это тег meta.
              Атрибут data-default нужен для расчета цены при смене ед. измерения. В data-default хранится цена за ед. измерения по умолчанию (без умножения на какие-либо коэффициенты) - как в админке.
            *}
            {if $outputOldPrice?}
                <meta class="js-product__price" data-default="{$defaultOldPrice}">
                <meta itemprop="price" class="js-product__new-price" data-default="{$defaultPrice}" content="{$defaultPrice}">
            {else}
                <meta itemprop="price" class="js-product__price" data-default="{$defaultPrice}" content="{$defaultPrice}">
            {/if}

            <meta itemprop="priceCurrency" content="RUB">
            <meta itemprop="weight" class="js-product__weight" content="{$_modx->resource['massa'][0]}">

            <input type="hidden" name="unit" value="1">
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

            <div class="js-product__controls js-product__controls_action_add">
                <div class="product-card__controls-block">
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">Лист</div>
                        <div class="custom-counter js-product__custom-counter{$extraClass}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" data-purpose="pcs" class="custom-counter__amount product-card__amount_style_default" value="{$itemInCart?:1}" data-min="{$dataMin}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                    </div>
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">м<sup>2</sup></div>
                        <div class="custom-counter js-product__custom-counter custom-counter_type_fractional">
                            <input name="count" data-purpose="m2" class="product-card__amount_style_bordered custom-counter__amount" value="{$itemInCart?:1}" data-koeff="{$m2}" data-min="0.01">
                        </div>
                    </div>
                </div>

                {include "file:chunks/card-info-relinking-btns-info.tpl"}

                <div class="product-card__btns-block">
                    <span class="js-product__btn-in-cart js-product__to-cart">В корзину</span>
                    <button data-fancybox href="#cost-fanera" class="white-btn product-card__callback-btn">
                        <span class="product-card__callback-btn-main-text">Получить расчёт фанеры</span>
                        <span class="product-card__callback-btn-spec-text">Бесплатно</span>
                    </button>
                </div>
            </div>

            <div class="js-product__controls js-product__controls_action_change">
                <div class="product-card__controls-block">
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">Лист</div>
                        <div class="custom-counter js-product__custom-counter{$extraClass}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" data-purpose="pcs" class="custom-counter__amount product-card__amount_style_default" value="{$itemInCart?:1}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                    </div>
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">м<sup>2</sup></div>
                        <div class="custom-counter js-product__custom-counter custom-counter_type_fractional">
                            <input name="count" data-purpose="m2" class="product-card__amount_style_bordered custom-counter__amount" value="{$itemInCart?:1}" data-koeff="{$m2}" data-min="0.01">
                        </div>
                    </div>
                </div>

                {include "file:chunks/card-info-relinking-btns-info.tpl"}

                <div class="product-card__btns-block">
                    <a href="/cart/" class="js-product__btn-in-cart"><span class="js-product__btn-in-cart-top-text">В корзине</span> Перейти</a>
                    <button data-fancybox href="#cost-fanera" class="white-btn product-card__callback-btn">
                        <span class="product-card__callback-btn-main-text">Получить расчёт фанеры</span>
                        <span class="product-card__callback-btn-spec-text">Бесплатно</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
