{set $src = $_modx->resource}
{insert "file:blocks/set-values-for-prod.tpl"}

{* Производитель / Бренд *}
{set $itemVendor = $_modx->resource['proizvoditel'][0]}
{if $itemVendor is empty}
    {set $itemVendor = $_modx->resource['brand'][0]}
{/if}

{* Данные для перелинковки *}
{set $linksData = 'getLinksDataBtns' | snippet}

{* Данные для добавления / изменения товара в корзине *}
{set $prodId = $_modx->resource['id']}
{if $_pls['isFractional'] == 1 OR $_modx->resource.isFractional == 1}
    {set $extraClass = ' custom-counter_type_fractional'}
    {set $dataMin = '0.01'}
{else}
    {set $extraClass = ''}
    {set $dataMin = '1'}
{/if}

<div class="product-item{if $itemInCart?} product-item-in-cart{/if}"
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

        <div class="product-card__main-content">
            <div class="product-card__main-content-top">
                <div class="product-card__gallery">
                    <div class="product-card__img-wrap">
                        <span {if $itemVendor is empty}style="display: none;"{/if} class="product-card__brand" data-val="{$itemVendor | toLowerAndRemoveChars}"></span>
                        <a href="{$image}" data-fancybox class="product-card__img-link">
                            <img class="product-card__img" itemprop="image" src="{$_modx->resource['thumb'] ?: '/assets/images/no_image.jpg'}" alt="{$_modx->resource.pagetitle}">
                        </a>
                    </div>

                    {'!msGallery' | snippet : [
                        'tpl' => '@FILE chunks/gallery.tpl',
                        'product' => $id,
                    ]}
                </div>

                <div class="product-card__mobile product-card__fav-n-comp">
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

                <div class="hidden" itemprop="aggregateRating" itemscope="" itemtype="http://schema.org/AggregateRating">
                    <meta itemprop="bestRating" content="5">
                    <meta itemprop="ratingValue" content="5">
                    <meta itemprop="ratingCount" content="82">
                </div>

                <div class="product-card__main-specs">
                    {if $_modx->resource['razmer-mm'][0]?}
                        <div class="product-card__specs-list-item" data-opt-key="unit">
                            <div class="product-card__specs-list-item-name">Размер</div>
                            <div class="product-card__specs-list-item-value">
                                {$_modx->resource['razmer-mm'][0]}
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

            {* TODO: УДАЛИ ЭТОТ КОД >>> *}
            <div class="product-card__relinking-block">
                <div class="product-card__side-panel-text">Формат, мм</div>
                <div class="product-card__relinking-items-wrap">
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1250×2500</a>
                    <a href="#" class="product-card__relinking-item">1500×3000</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                </div>
            </div>

            <div class="product-card__relinking-block">
                <div class="product-card__side-panel-text">Формат, мм</div>
                <div class="product-card__relinking-items-wrap">
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1250×2500</a>
                    <a href="#" class="product-card__relinking-item">1500×3000</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                    <a href="#" class="product-card__relinking-item">1220×2440</a>
                </div>
            </div>
            {* TODO: УДАЛИ ЭТОТ КОД <<< *}

            {if $linksData.format?}
                <div class="product-card__relinking-block">
                    <div class="product-card__side-panel-text">Формат, мм</div>
                    <div class="product-card__relinking-items-wrap">
                        <div class="product-card__relinking-item">1220×2440</div>
                        <div class="product-card__relinking-item">1250×2500</div>
                        <div class="product-card__relinking-item">1500×3000</div>
                        <div class="product-card__relinking-item">1220×2440</div>
                        <div class="product-card__relinking-item">1220×2440</div>
                        <div class="product-card__relinking-item">1220×2440</div>
                    </div>
                </div>
            {/if}

            {if $linksData.thickness?}
                <div class="product-card__relinking-block">
                    <div class="product-card__side-panel-text">Толщина, мм</div>
                    <div class="product-card__relinking-items-wrap">
                        <a href="#" class="product-card__relinking-item">4</a>
                        <a href="#" class="product-card__relinking-item">6</a>
                        <a href="#" class="product-card__relinking-item">9</a>
                        <a href="#" class="product-card__relinking-item">12</a>
                        <a href="#" class="product-card__relinking-item">15</a>
                        <a href="#" class="product-card__relinking-item">18</a>
                    </div>
                </div>
            {/if}

            {if $linksData.sort?}
                <div class="product-card__relinking-block">
                    <div class="product-card__side-panel-text">Сорт</div>
                    <div class="product-card__relinking-items-wrap">
                        <div class="product-card__relinking-item">4</div>
                        <div class="product-card__relinking-item">6</div>
                        <div class="product-card__relinking-item">9</div>
                        <div class="product-card__relinking-item">12</div>
                        <div class="product-card__relinking-item">15</div>
                        <div class="product-card__relinking-item">18</div>
                    </div>
                </div>
            {/if}

            <input type="hidden" name="unit" value="1">
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

            <div class="product-item__controls product-item__controls_action_add">
                <div class="product-card__controls-block">
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">Лист</div>
                        <div class="custom-counter product-item__custom-counter{$extraClass}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" class="custom-counter__amount product-card__amount_style_default" value="1" data-min="{$dataMin}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                    </div>
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">м<sup>2</sup></div>
                        <div class="custom-counter product-item__custom-counter{$extraClass}">
                            <input name="count" class="product-card__amount_style_bordered custom-counter__amount" value="{$itemInCart?:0}">
                        </div>
                    </div>
                </div>
                <div class="product-card__info-block">
                    <div class="product-card__info-block-elem">
                        <div class="product-card__info-elem">
                            <div class="product-card__side-panel-text">Вес</div>
                        </div>
                        <div class="product-card__info-val">
                            <div class="product-card__weight-val">156</div>
                            <div class="product-card__weight-unit">кг</div>
                        </div>
                    </div>
                    <div class="product-card__info-block-elem">
                        <div class="product-card__info-elem">
                            <div class="product-card__side-panel-text">Цена</div>
                        </div>
                        <div class="product-card__info-val">
                            <div class="product-card__price-val">750</div>
                            <div class="product-card__price-unit">руб</div>
                        </div>
                    </div>
                </div>
                <div class="product-card__btns-block">
                    <span class="product-item__btn-in-cart product-item__to-cart">В корзину</span>
                    <button data-fancybox href="#cost-fanera" class="white-btn product-card__callback-btn">
                        <span class="product-card__callback-btn-main-text">Получить расчёт фанеры</span>
                        <span class="product-card__callback-btn-spec-text">Бесплатно</span>
                    </button>
                </div>
            </div>

            <div class="product-item__controls product-item__controls_action_change">
                <div class="product-card__controls-block">
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">Лист</div>
                        <div class="custom-counter product-item__custom-counter{$extraClass}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" class="custom-counter__amount product-card__amount_style_default" value="{$itemInCart?:0}">
                            <span href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                    </div>
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">м<sup>2</sup></div>
                        <div class="custom-counter product-item__custom-counter{$extraClass}">
                            <input name="count" class="product-card__amount_style_bordered custom-counter__amount" value="{$itemInCart?:0}">
                        </div>
                    </div>
                </div>
                <div class="product-card__info-block">
                    <div class="product-card__info-block-elem">
                        <div class="product-card__info-elem">
                            <div class="product-card__side-panel-text">Вес</div>
                        </div>
                        <div class="product-card__info-val">
                            <div class="product-card__weight-val">156</div>
                            <div class="product-card__weight-unit">кг</div>
                        </div>
                    </div>
                    <div class="product-card__info-block-elem">
                        <div class="product-card__info-elem">
                            <div class="product-card__side-panel-text">Цена</div>
                        </div>
                        <div class="product-card__info-val">
                            <div class="product-card__price-val">750</div>
                            <div class="product-card__price-unit">руб</div>
                        </div>
                    </div>
                </div>
                <div class="product-card__btns-block">
                    <a href="/cart/" class="product-item__btn-in-cart"><span class="product-item__btn-in-cart-top-text">В корзине</span> Перейти</a>
                    <button data-fancybox href="#cost-fanera" class="white-btn product-card__callback-btn">
                        <span class="product-card__callback-btn-main-text">Получить расчёт фанеры</span>
                        <span class="product-card__callback-btn-spec-text">Бесплатно</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
