{set $src = $_modx->resource}
{insert "file:blocks/set-values-for-prod.tpl"}

{* Данные для списков *}
{set $krovlyaData = 'getLinksData' | snippet}

<div class="product-item{if $itemInCart?} product-item-in-cart{/if}"
    data-m2="{$m2}"
    data-m3="{$m3}"
    data-pm="{$pm}"
    data-list="{$list}"
    data-thing="{$thing}"
    data-pilomat-thing="{$pilomat_thing}">

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
            <span class="product-item__btn product-card__btn-compare product-item__btn-compare{if $checkItems['comp'][$_modx->resource['id']]?} active{/if}"
                  href="#">
                <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                     height="16">
                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                </svg>
            </span>
            <span class="product-item__btn product-card__btn-fav product-item__btn-fav{if $checkItems['fav'][$_modx->resource['id']]?} active{/if}" href="#">
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

        <a href="{$image}" data-fancybox class="product-card__img">
            <img itemprop="image" src="{$_modx->resource['thumb'] ?: '/assets/images/no_image.jpg'}"
                 alt="{$_modx->resource.pagetitle}">
        </a>

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
                                {if $m2 ?}
                                    <a class="product-card__unit-link" href="#" data-val="2">м2</a>
                                {/if}
                                {if $m3 ?}
                                    <a class="product-card__unit-link" href="#" data-val="3">м3</a>
                                {/if}
                                {if $pm ?}
                                    <a class="product-card__unit-link" href="#" data-val="4">п.м.</a>
                                {/if}
                                {if $list ?}
                                    <a class="product-card__unit-link" href="#" data-val="5">лист</a>
                                {/if}
                                {if $thing ?}
                                    <a class="product-card__unit-link" href="#" data-val="6">штуку</a>
                                {/if}
                                {if $pilomat_thing ?}
                                    <a class="product-card__unit-link" href="#" data-val="7">штуку</a>
                                {/if}
                            </div>
                        {else}
                            <input type="hidden" name="unit" value="1">
                        {/if}

                        {if $price}
                            <div class="product-card__price-and-logo">
                                <span class="product-card__price-wrap">
                                    <span itemprop="price" class="product-item__price"
                                          data-default="{$_modx->resource['price']}">{$_modx->resource['price'] | preg_replace : '/\B(?=(\d{3})+(?!\d))/': ' '}</span>
                                    <meta itemprop="priceCurrency" content="RUB">
                                    руб

                                    {if !$condition}
                                        {set $unit = $_modx->resource.unit}
                                        {$unit[0] ? '/ ' ~ $unit[0] : ''}
                                    {/if}
                                </span>
                                {*
                                <div class="product-logo product-card__logo" data-brand="{$_modx->resource.proizvoditel[0] | toLowerAndRemoveChars}"></div>
                                *}
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
                    {if $krovlyaData.pokrytie?}
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
                                            {foreach $krovlyaData.pokrytie as $id => $val}
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

                    {if $krovlyaData.cvet?}
                        <div class="product-card__select-wrap product-card__select-wrap_type_half">
                            <div class="product-card__select-span">Цвет:</div>
                            <div class="custom-select-wrap">
                                <div class="colors-options euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                        <span data-val="{$_modx->resource.cvet[0] | toLowerAndRemoveChars}" class="euv-custom-select__input-value">{$_modx->resource.cvet[0]}</span>
                                    </div>
                                    <a href="#" class="euv-custom-select__btn"></a>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            <div class="euv-custom-select__options-wrap-scroll-inner">
                                                {foreach $krovlyaData.cvet as $data}
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

                    {if $krovlyaData.item_thickness?}
                        <div class="product-card__select-wrap product-card__select-wrap_type_half{if $krovlyaData.cvet?} product-card__select-wrap_align_right{/if}">
                            <div class="product-card__select-span">Толщина, мм:</div>
                            <div class="custom-select-wrap">
                                <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                        <span class="euv-custom-select__input-value">{$_modx->resource.item_thickness[0]}</span>
                                    </div>
                                    <a href="#" class="euv-custom-select__btn"></a>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            {foreach $krovlyaData.item_thickness as $id => $val}
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
                    <div class="product-item__controls product-item__controls_action_add">
                        <div class="custom-counter product-item__custom-counter{$extraClass}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" class="custom-counter__amount" value="1"
                                   data-min="{$dataMin}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                        <span class="product-item__btn-in-cart product-item__to-cart">В корзину</span>
                    </div>
                    <div class="product-item__controls product-item__controls_action_change">
                        <div class="custom-counter product-item__custom-counter{$extraClass}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" class="custom-counter__amount" value="{$itemInCart?:0}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                        <a href="/cart/" class="product-item__btn-in-cart"><span class="product-item__btn-in-cart-top-text">В корзине</span>
                            Перейти</a>
                    </div>
                    <div class="product-item__ms2-elems">
                        <form class="product-item__form-add ms2_form" method="post">
                            <input name="options" value="[]">
                            <input name="id" value="{$prodId}">
                            <input name="count" value="1">
                            <input name="ctx" value="{$_modx->resource.context_key}">
                            <button type="submit" name="ms2_action" value="cart/add">Добавить</button>
                        </form>
                        <form class="product-item__form-change ms2_form" method="post">
                            <input name="key" value="{$productKey}">
                            <input name="count" value="1">
                            <input name="ctx" value="{$_modx->resource.context_key}">
                            <button type="submit" name="ms2_action" value="cart/change">Изменить кол-во</button>
                        </form>
                    </div>
                    <button data-fancybox="" href="#callback" class="product-card__buy white-btn">КУПИТЬ В 1 КЛИК</button>
                </div>
            </div>

            <div class="product-card__mobile">
                <div class="product-card__fav-n-comp">
                    <span class="product-item__btn product-card__btn-compare product-item__btn-compare{if $checkItems['comp'][$_modx->resource['id']]?} active{/if}"
                          href="#">
                        <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                             xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                             height="16">
                            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                        </svg>
                    </span>
                    <span class="product-item__btn product-card__btn-fav product-item__btn-fav{if $checkItems['fav'][$_modx->resource['id']]?} active{/if}"
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
        <div class="product-item__controls product-item__controls_action_add">
            <div class="custom-counter product-item__custom-counter{$extraClass}">
                <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                <input name="count" class="custom-counter__amount" value="1"
                       data-min="{$dataMin}">
                <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
            </div>
            <span class="product-item__btn-in-cart product-item__to-cart">В корзину</span>
        </div>
        <div class="product-item__controls product-item__controls_action_change">
            <div class="custom-counter product-item__custom-counter{$extraClass}">
                <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                <input name="count" class="custom-counter__amount" value="{$itemInCart?:0}">
                <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
            </div>
            <a href="/cart/" class="product-item__btn-in-cart"><span class="product-item__btn-in-cart-top-text">В корзине</span>
                Перейти</a>
        </div>
    </div>

</div>
