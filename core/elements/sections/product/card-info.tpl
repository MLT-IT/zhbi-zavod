{* Информация об избранном и сравнении *}
{set $checkFavAndComp = '!checkFavAndComp' | snippet : ['id' => $_modx->resource.id]| replace: "-" : ","}

{* Ключ товара, нужен для проверки, есть ли товар в корзине *}
{set $productKey = '!getProductKey' | snippet : ['productId' => $_modx->resource['id']]}
{set $itemInCart = '!itemInCart' | snippet : ['key' => $productKey]}

{* Основные единицы измерения *}
{set $pm = $_modx->resource['kolvo-pm'][0]}
{set $m2 = $_modx->resource['ploshad_m2'][0]}
{set $m3 = $_modx->resource['obyem_m3'][0]}
{if $_modx->resource['v_upakovke'][0]? && $price? && $_modx->resource.context_key == 'penoplex'}
    {set $list = $price * $_modx->resource['v_upakovke'][0]}
    {set $list = $list | round : 2 | replace : ',' : '.'}
{/if}

{* Условие - выводить ли возможность выбирать единицу измерения для добавления товара в корзину *}
{set $condition = ($_modx->resource.context_key in list ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc']) &&
                  ($_modx->resource.parent not in list [9052, 9125, 14193, 14269, 10998, 12018, 12819, 15201, 15202])}

{* Дополнительные рассчеты цен за единицы измерения для некоторых контекстов *}
{if $_modx->resource['v_upakovke']? && $_modx->resource.context_key in list ['web', 'penoplex']}
    {set $m2 = $m2 * $_modx->resource['v_upakovke'][0]}
    {set $m2 = $m2 | replace : ',' : '.'}
{/if}

<div class="product-card__top product-item{if $itemInCart > 0} product-item-in-cart{/if}"
     data-m2="{$m2}"
     data-m3="{$m3}"
     data-pm="{$pm}"
     data-list="{$list}">

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

    <div class="product-card__info" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
        <link itemprop="availability" href="http://schema.org/InStock">

        <div class="product-card__info-inner">
            <div class="product-card__left-info">
                {if $condition}
                    <div class="product-card__units-wrap">
                        <input type="hidden" name="unit" value="1">
                        <span class="product-card__unit-span">Цена за</span>
                        <a class="product-card__unit-link active" href="#" data-val="1">упаковку</a>
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
                    </div>
                {else}
                    <input type="hidden" name="unit" value="1">
                {/if}

                {if $price}
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
                {/if}

                {set $upakovka = 'getPackageNew' | snippet}
                {if $upakovka is empty}
                    {set $upakovka = 'getPackage' | snippet}
                {/if}

                {if $upakovka | length > 0}
                    <div class="product-card__package">В упаковке: {$upakovka}</div>
                {/if}
            </div>
            <div class="product-card__right-info">
                <span class="product-card__article product-card__article_pc">Арт. {$_modx->resource['article']}</span>
                <span class="product-card__btn product-card__btn-compare{if $checkFavAndComp['compIds'] === 'TRUE'} active{/if}" href="#">
                    <svg class="svg icon-compare" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 16 16" width="16"
                         height="16">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-compare"></use>
                    </svg>
                </span>
                <span class="product-card__btn product-card__btn-fav{if $checkFavAndComp['favIds'] === 'TRUE'} active{/if}" href="#">
                    <svg class="svg icon-heart" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 21 18" width="21"
                         height="18">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-heart"></use>
                    </svg>
                </span>
            </div>
        </div>

        <div class="product-card__info-left">
            {include "file:chunks/productElems.tpl"}
            <button data-fancybox="" href="#callback" class="product-card__buy white-btn">КУПИТЬ В 1 КЛИК</button>
        </div>

        <div class="product-card__info-right">
            <div class="product-card__delivery"><b>Доставка в Санкт-Петербург и Лен. область</b>
                <a data-fancybox href="#cost-delivery">
                    <svg class="svg icon-delivery" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-delivery"></use>
                    </svg>
                    Узнать стоимость с доставкой</a>
            </div>
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
