{if $prodId is empty}
    {set $prodId = $_modx->resource['id']}
{/if}

{* Дробное добавление товара в корзину *}
{if $_pls['isFractional'] == 1 OR $_modx->resource.isFractional == 1}
    {set $extraClass = ' custom-counter_type_fractional'}
    {set $dataMin = '0.01'}
{else}
    {set $extraClass = ''}
    {set $dataMin = '1'}
{/if}

<div class="js-product__controls js-product__controls_action_add">
    <div class="custom-counter js-product__custom-counter{$extraClass}">
        <span href="#" class="custom-counter__btn custom-counter__btn_dir_less">-</span>
        <input name="count" class="custom-counter__amount" value="1" data-min="{$dataMin}">
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
    <a href="/cart/" class="js-product__btn-in-cart"><span class="js-product__btn-in-cart-top-text">В корзине</span> Перейти</a>
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
