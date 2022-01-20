{if $prodId is empty}
    {set $prodId = $_modx->resource['id']}
{/if}

<div class="product-item__controls product-item__controls_action_add">
    <div class="custom-counter product-item__custom-counter">
        <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
        <input name="count" class="custom-counter__amount product-item__precount" value="1" data-min="1">
        <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
    </div>
    <a href="#" type="submit" class="product-item__btn-in-cart product-item__to-cart">В корзину</a>
</div>
<div class="product-item__controls product-item__controls_action_change">
    <div class="custom-counter product-item__custom-counter">
        <a href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</a>
        <input name="count" class="custom-counter__amount" value="{$itemInCart?:0}">
        <a href="#" class="custom-counter__btn custom-counter__btn_dir_more">+</a>
    </div>
    <a href="/cart/" class="product-item__btn-in-cart"><span class="product-item__btn-in-cart-top-text">В корзине</span> Перейти</a>
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
