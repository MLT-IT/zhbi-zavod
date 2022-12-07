{* Данные для перелинковки *}
{set $linksData = 'getRelinkingData_FormatThicknessSort' | snippet}

{* Данные для блока посередине *}
{set $mc = $_modx->resource.middleContent}
{if $mc >= 2}
    {set $bottomText = 'Мы хотим помочь построить Ваш дом. <a href="tel:' ~ ('phone' | option) ~ '">Звоните</a> или <span data-fancybox data-src="#callback">оставляйте заявку</span>, будем рады Вам помочь!'}
    {set $textItem1 = 'Прямой дилерский договор с заводом-производителем позволяет держать цены ниже среднерыночных.'}
    {set $textItem2 = '4000 плит в наличии на складе. Вы можете приехать и выбрать нужный размер плит, а также убедиться в качестве наших изделий. При срочных заказах доставим заказ в течение 3 часов с момента подачи заявки.'}
    {set $textItem3 = 'Гарантируем качество продукции. Каждое штучное изделие проходит повторную проверку.'}
    {set $textItem4 = 'Получаете товар, проверяете качество и ТОЛЬКО после этого оплачиваете. Никакой предоплаты! Наше главное правило - понятные условия и порядок работы с заказчиком!'}

    {if $mc == 8}
        {set $textItem2 = '4000 наименований в наличии на складе. Вы можете приехать и выбрать нужный размер листа, а также убедиться в качестве наших изделий. При срочных заказах доставим заказ в течение 3 часов с момента подачи заявки.'}
    {/if}

    {switch $mc}
        {case 2}
            {set $topText = '4 причины купить ОСБ плиту у нас'}
        {case 3}
            {set $topText = '4 причины купить гипсокартон у нас'}
        {case 4}
            {set $topText = '4 причины купить ГВЛ плиту у нас'}
        {case 5}
            {set $topText = '4 причины купить ДСП плиту у нас'}
        {case 6}
            {set $topText = '4 причины купить ЦСП плиту у нас'}
        {case 7}
            {set $topText = '4 причины купить фибролитовую плиту у нас'}
        {case 8}
            {set $topText = '4 причины купить лист фанеры у нас'}
        {case 9}
            {set $topText = '4 причины купить плиту МДВП у нас'}
    {/switch}
{/if}

{if $_modx->resource.context_key == 'plity-mdvp'}
    {set $variable = $list}
{elseif $_modx->resource.context_key == 'plitaosb'}
    {set $variable = $m2}
{/if}

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
            {if $_modx->resource.productNotAvailable == 1}
              <span class="product-card__availability-cross"></span>
              Нет в наличии
            {else}
              <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg"
                   xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>
              </svg>
              В наличии
            {/if}
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
            <span class="product-card__reviews-quantity">{$countReviews}
                {'@FILE snippets/formOfWord.php' | snippet : [
                'n' => $countReviews,
                'f1' => 'отзыв',
                'f2' => 'отзыва',
                'f5' => 'отзывов'
                ]}
            </span>
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
                        <a href="{$image ?: '/assets/images/no_image.jpg'}" data-fancybox class="product-card__img-link zoom-narrow" itemscope itemtype="http://schema.org/ImageObject">
                            <img class="product-card__img" src="{'site_url' | option}{$_modx->resource['thumb'] ?: 'assets/images/no_image.jpg'}" alt="{$_modx->resource.pagetitle}" itemprop="contentUrl">
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

                {if ($_modx->resource.middleContent is empty) || ($_modx->resource.middleContent == 1)}
                    <div class="product-card__main-specs">
                        {if ($_modx->resource['item_thickness'][0] is not empty) &&
                            ($_modx->resource['item_width'][0] is not empty) &&
                            ($_modx->resource['item_length'][0] is not empty)}
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
                {elseif $_modx->resource.middleContent >= 2}
                    <div class="product-card__reasons">
                        <p class="product-card__reasons-header">{$topText}</p>
                        <ul class="product-card__reasons-items-wrap">
                            <li class="product-card__reasons-item">
                                <span class="product-card__reasons-item-img product-card__reasons-item-img_icon_label"></span>
                                Оптовая цена
                                <span class="product-card__reasons-tip">
                                    <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                                    </svg>
                                    <span class="product-card__reasons-tip-text">{$textItem1}</span>
                                </span>
                            </li>
                            <li class="product-card__reasons-item">
                                <span class="product-card__reasons-item-img product-card__reasons-item-img_icon_availability"></span>
                                Наличие на складе
                                <span class="product-card__reasons-tip">
                                    <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                                    </svg>
                                    <span class="product-card__reasons-tip-text">{$textItem2}</span>
                                </span>
                            </li>
                            <li class="product-card__reasons-item">
                                <span class="product-card__reasons-item-img product-card__reasons-item-img_icon_heart"></span>
                                Качество
                                <span class="product-card__reasons-tip">
                                    <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                                    </svg>
                                    <span class="product-card__reasons-tip-text">{$textItem3}</span>
                                </span>
                            </li>
                            <li class="product-card__reasons-item">
                                <span class="product-card__reasons-item-img product-card__reasons-item-img_icon_money"></span>
                                Оплата "по факту"
                                <span class="product-card__reasons-tip">
                                    <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                                    </svg>
                                    <span class="product-card__reasons-tip-text">{$textItem4}</span>
                                </span>
                            </li>
                            
                            {* Иконки услуг для фанеры *}
	                        {if $_modx->context.key === 'pro-fanera'}
                                    <li>
			                          {include "file:chunks/fanera-service-icons.tpl"}
			                        </li>
			                {/if}
                        </ul>
                        <div class="product-card__reasons-text">{$bottomText}</div>
                    </div>
                {/if}

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
                <meta class="js-product__price" data-default="{$defaultPrice}">
                <meta itemprop="price" class="js-product__new-price" data-default="{$defaultOldPrice}" content="{$defaultPrice}">
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
                        <div class="product-card__side-panel-text">м<sup>2</sup></div>
                        <div class="custom-counter js-product__custom-counter{$extraClass}">
                            <span class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" data-purpose="pcs" class="custom-counter__amount product-card__amount_style_default" value="{$itemInCart?:1}" data-min="{$dataMin}">
                            <span class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                    </div>
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">Лист</div>
                        <div class="custom-counter js-product__custom-counter custom-counter_type_fractional">
                            <input name="count" data-purpose="list" class="product-card__amount_style_bordered custom-counter__amount" value="{$itemInCart?:1}" data-koeff="{$variable}" data-min="0.01">
                        </div>
                    </div>
                    {if $_modx->resource['massa'][0] > 0}
                        <div class="product-card__controls-elem">
                            <div class="product-card__side-panel-text">Вес, кг</div>
                            <div class="product-card__controls-elem-input product-card__weight-val">{$_modx->resource['massa'][0]}</div>
                        </div>
                    {/if}
                </div>

                {include "file:chunks/card-info-relinking-btns-info.tpl"}

                <div class="product-card__btns-block">
                    <span class="js-product__btn-in-cart js-product__to-cart">В корзину</span>
                    <button data-fancybox href="#cost-fanera" class="white-btn product-card__callback-btn">
                        <span class="product-card__callback-btn-main-text">Получить консультацию</span>
                        <span class="product-card__callback-btn-spec-text">Бесплатно</span>
                    </button>
                </div>
            </div>

            <div class="js-product__controls js-product__controls_action_change">
                <div class="product-card__controls-block">
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">м<sup>2</sup></div>
                        <div class="custom-counter js-product__custom-counter{$extraClass}">
                            <span class="custom-counter__btn custom-counter__btn_dir_less">-</span>
                            <input name="count" data-purpose="pcs" class="custom-counter__amount product-card__amount_style_default" value="{$itemInCart?:1}">
                            <span class="custom-counter__btn custom-counter__btn_dir_more">+</span>
                        </div>
                    </div>
                    <div class="product-card__controls-elem">
                        <div class="product-card__side-panel-text">Лист</div>
                        <div class="custom-counter js-product__custom-counter custom-counter_type_fractional">
                            <input name="count" data-purpose="list" class="product-card__amount_style_bordered custom-counter__amount" value="{$itemInCart?:1}" data-koeff="{$variable}" data-min="0.01">
                        </div>
                    </div>
                    {if $_modx->resource['massa'][0] > 0}
                        <div class="product-card__controls-elem">
                            <div class="product-card__side-panel-text">Вес, кг</div>
                            <div class="product-card__controls-elem-input product-card__weight-val">{$_modx->resource['massa'][0]}</div>
                        </div>
                    {/if}
                </div>

                {include "file:chunks/card-info-relinking-btns-info.tpl"}

                <div class="product-card__btns-block">
                    <a href="/cart/" class="js-product__btn-in-cart"><span class="js-product__btn-in-cart-top-text">В корзине</span> Перейти</a>
                    <button data-fancybox href="#cost-fanera" class="white-btn product-card__callback-btn">
                        <span class="product-card__callback-btn-main-text">Получить консультацию</span>
                        <span class="product-card__callback-btn-spec-text">Бесплатно</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
