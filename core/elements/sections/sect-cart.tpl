{if count($products)}
    {set $hasProducts = 1}
{/if}

<h1 class="title-1 sect-cart__title">{$_modx->resource.pagetitle}</h1>
{if $hasProducts}
    <form method="post" class="sect-cart__btn-clear-wrap">
        <button type="submit" name="ms2_action" value="cart/clean" class="sect-cart__btn-clear">
            Удалить все товары
            <span class="sect-cart__btn-clear-cross"></span>
        </button>
    </form>
{/if}

<div class="sect-cart__inner" id="msCart">
    {if !$hasProducts}
        <div class="sect-cart__empty">
            <p class="sect-cart__empty-text">
                Корзина пока пуста
            </p>
            <a class="sect-cart__btn-back yellow-btn" href="/">Вернуться к покупкам</a>
        </div>
    {else}
        <div class="table-responsive">
            <table class="cart-table table table-striped">
                <tr class="cart-table__table-header cart-table__table-row">
                    <th class="title cart-table__table-cell"></th>
                    <th class="price cart-table__table-cell">Цена</th>
                    <th class="count cart-table__table-cell">Количество</th>
                    <th class="sum cart-table__table-cell">Стоимость</th>
                    <th class="remove cart-table__table-cell"></th>
                </tr>

                {foreach $products as $product}
                    {var $image}
                    {if $product.thumb?}
                        <img class="cart-table__img" src="{$product.thumb}" alt="{$product.pagetitle}" title="{$product.pagetitle}"/>
                    {else}
                        <img class="cart-table__img" src="{'assets_url' | option}components/minishop2/img/web/ms2_small.png"
                             srcset="{'assets_url' | option}components/minishop2/img/web/ms2_small@2x.png 2x"
                             alt="{$product.pagetitle}" title="{$product.pagetitle}"/>
                    {/if}
                    {/var}
                    <tr id="{$product.key}" class="cart-table__table-row cart-table__table-row_type_product">
                        <td class="title cart-table__table-cell">
                                {if $product.id?}
                                    <a class="cart-table__img-wrap" href="{$product.id | url}">{$image}</a>
                                {else}
                                    <div class="cart-table__img-wrap">{$image}</div>
                                {/if}
                            <div class="cart-table__title-wrap">
                                {if $product.id?}
                                    <a class="cart-table__title" href="{$product.id | url}">{$product.pagetitle}</a>
                                {else}
                                    <span class="cart-table__title">{$product.pagetitle}</span>
                                {/if}
                                <span class="cart-table__article">Арт. {$product.article}</span>
                            </div>
                        </td>
                        <td class="cart-table__table-cell price cart-table__table-cell_content_num">
                            <span class="cart-table__price-value">{$product.price}</span>
                            <span class="cart-table__currency cart-table__currency_screen_pc">руб.</span>
                            <span class="cart-table__currency cart-table__currency_screen_mobile">&#8381;</span>
                        </td>
                        <td class="count cart-table__table-cell">
                            <form method="post" class="cart-table__form ms2_form" role="form">
                                <input type="hidden" name="key" value="{$product.key}"/>
                                    <div class="custom-counter cart-table__custom-counter">
                                        <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
                                        <input name="count" class="custom-counter__amount" value="{$product.count}">
                                        <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
                                    </div>
                                <button class="btn btn-sm" type="submit" name="ms2_action" value="cart/change"></button>
                            </form>
                        </td>
                        <td class="cart-table__table-cell sum cart-table__table-cell_content_num">
                            <span class="cart-table__sum-value">
                                {$product.cost}
                            </span>
                            <span class="cart-table__currency cart-table__currency_screen_pc">руб.</span>
                            <span class="cart-table__currency cart-table__currency_screen_mobile">&#8381;</span>
                        </td>
                        <td class="remove cart-table__table-cell">
                            <form method="post" class="ms2_form text-md-right">
                                <input type="hidden" name="key" value="{$product.key}">
                                <button class="cart-table__btn-remove" type="submit" name="ms2_action"
                                        value="cart/remove">
                                    <span class="cart-table__remove-text">Удалить из<br>корзины</span>
                                </button>
                            </form>
                        </td>
                    </tr>
                {/foreach}
            </table>

            <div class="sect-cart__footer">
                <div class="sect-cart__footer-content">
                    <a href="#" class="sect-cart__btn-print">Распечатать смету</a>
                    <p class="sect-cart__total-count-wrap">Всего <span class="sect-cart__total-count ms2_total_count">{$total.count}</span> товара на сумму:</p>
                    <p class=" sect-cart__cost">
                        <span class="ms2_total_cost">{$total.cost}</span>
                        <span class="cart-table__currency cart-table__currency_screen_pc">руб.</span>
                        <span class="cart-table__currency cart-table__currency_screen_mobile">&#8381;</span>
                    </p>
                    <p class="sect-cart__delivery">Без учёта стоимости доставки</p>
                </div>
            </div>
            <div class="sect-cart__bot-btns-wrap">
                <a class="sect-cart__btn-back white-btn" href="{'@FILE snippets/getRefererLink.php' | snippet}">Вернуться к покупкам</a>
                <a class="sect-cart__btn-cost yellow-btn" data-fancybox="" href="#callback">Оформить заказ</a>
            </div>
        </div>
    {/if}
</div>
