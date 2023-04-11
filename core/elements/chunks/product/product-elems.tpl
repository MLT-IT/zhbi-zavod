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
    <span class="js-product__btn-in-cart js-product__to-cart product-card__add btn btn_style_shadow">
        <span class="product-card__add-text">В корзину</span>
    </span>
    <div class="product-card__counter counter custom-counter js-product__custom-counter{$extraClass}">
        <span class="counter__btn counter__btn_minus custom-counter__btn custom-counter__btn_dir_less"></span>
        <input name="count" class="counter__input custom-counter__amount" value="1" data-min="{$dataMin}">
        <span class="counter__btn counter__btn_plus custom-counter__btn custom-counter__btn_dir_more"></span>
    </div>
</div>
<div class="js-product__controls js-product__controls_action_change">
    <a href="/cart/" class="product-card__add product-card__btn-in-cart btn btn_style_shadow active" title="в корзину"></a>
    <div class="product-card__counter counter custom-counter js-product__custom-counter{$extraClass}">
      <button class="counter__btn counter__btn_minus custom-counter__btn custom-counter__btn_dir_less"></button>
      <input class="counter__input custom-counter__amount" value="{$itemInCart?:0}" type="number" placeholder="0" data-min="0">
      <button class="counter__btn counter__btn_plus custom-counter__btn custom-counter__btn_dir_more"></button>
    </div>
</div>
<div class="js-product__ms2-elems hidden">
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
