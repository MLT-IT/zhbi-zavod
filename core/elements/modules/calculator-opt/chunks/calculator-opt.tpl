<div class="calculator-opt">
    <form class="ms2_form" method="post">
    <input type="hidden" name="options" value="[]">
    <input type="hidden" name="ctx" value="{$_modx->resource.context_key}">

    <h2 class="calculator-opt__title">КАЛЬКУЛЯТОР</h2>
    <p class="calculator-opt__subtitle">ОПТОМ ВЫГОДНЕЕ!</p>
    <div class="calculator-opt__search">
        <div class="search-input">
            <input type="text"
                   class="calculator-opt__input"
                   placeholder="Выберите товар"
                   value="{if $product}{$product.pagetitle}{/if}"
                   data-product-id="{$product.id}"
            />
            <input type="hidden" name="id" class="form-product-id" value="{$product.id}">
            <span class="search-input__close">X</span>
        </div>

        <div class="calculator-opt__search-result search-result">
                <div class="search-result__container">
                </div>
        </div>
    </div>

    <div class="calculator-opt__group">
        <div class="calculator-opt__quantity">
            <div>Количество:</div>
            <div class="calculator-opt__quantity-input">
                <button class="counter__btn counter__btn_minus quantity__button"></button>
                <input class="counter__input custom-counter__amount custom-counter__amount" name="count" data-min="1" value="{$prodValues['itemInCart']?:1}" />
                <button class="counter__btn counter__btn_plus quantity__button"></button>
            </div>
        </div>
        <div class="calculator-opt__prices">
            <p class="price">Итоговая цена: <span class="price__value">0 р</span></p>
            <p class="price">Итоговая цена со скидкой: <span class="price__value price-sale__value">0 р</span></p>
        </div>
    </div>

    <div class="calculator-opt__action">
        {set $actionCart = "cart/add"}
        {if $prodValues['itemInCart']}
            {set $actionCart = "cart/change"}
            <a href="/cart">В корзине<br><span> Перейти</span></a>
            {else}
            <button type="submit" name="ms2_action" value="{$actionCart}">В корзину</button>
        {/if}

    </div>
    </form>
</div>