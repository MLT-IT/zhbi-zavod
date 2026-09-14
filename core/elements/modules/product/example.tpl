{set $inCart = $prodValues['itemInCart']?:0}
{set $listSize = ($settingCardKrovlya['width'] / 1000) * ($settingCardKrovlya['minLength'] / 1000)}
{set $listCount = ($inCart / $listSize)?:$listSize}
<!-- 
in cart: {$inCart} 
list size: {$settingCardKrovlya['width'] / 1000} * {$settingCardKrovlya['minLength'] / 1000} = {$listSize} 
lists: {$listCount} 
-->
<div class="calcProduct product-info__volume">
  <input type="hidden" class="calcWidth" name="width" value="{$settingCardKrovlya['width']}">
  <input type="hidden"class="calcLength" value="{$settingCardKrovlya['minLength']}">
  <input type="hidden"class="calcInCart" value="{$inCart}">
  <input type="hidden" class="calcPrice js-product__price" value="{$prodValues['defaultPrice']?:0}">
  <div class="product-info__complex product-calculator">
    <div class="product-calculator__inputs">
      <div class="product-calculator__input">
        <div class="product-calculator__input-title">Длина листа, мм</div>
        <div class="calcInput_length counter">
          <span class="decrement counter__btn counter__btn_minus"></span>
          <input name="long" class="counter__input" value="{$settingCardKrovlya['minLength']}"
            min="{$settingCardKrovlya['minLength']}" max="{$settingCardKrovlya['maxLength']}"
            step="{$settingCardKrovlya['stepLength']}">
          <span class="increment counter__btn counter__btn_plus"></span>
        </div>
      </div>
      <div class="product-calculator__input">
        <div class="product-calculator__input-title">Количество листов, шт.</div>
        <div class="calcInput_count counter">
          <span class="decrement counter__btn counter__btn_minus"></span>
          <input name="count" class="counter__input" value="{$listCount|number:0}" min="1" step="1">
          <span class="increment counter__btn counter__btn_plus"></span>
        </div>
      </div>
    </div>
    <div class="calcResult product-calculator__result calculator-result">
      <div class="calcResult_volume calculator-result__summary">
        <span class="title calculator-result__summary-title">Итого: </span>
        <span class="value custom-counter__amount calculator-result__summary-volume">{$inCart?:$listSize | number:2}</span>
        <span class="prefix calculator-result__summary-unit"> м<sup>2</sup></span>
      </div>
      <div class="calcResult_price calculator-result__price">
        <span class="calculator-result__price-value"><span class="value">{(($inCart ?: 1) * $prodValues['defaultPrice'])}</span><span class="prefix"> ₽</span></span>
      </div>
    </div>
  </div>
</div>

{include 'file:chunks/product/link-calculator.tpl'}

<div class="product-calculator__buttons product-info__actions">

  <div class="js-product__controls js-product__controls_action_add">
    <input type="hidden" class="custom-counter__amount" value="{$inCart}">
    <span class="js-product__btn-to-cart js-product__to-cart product-card__add btn btn_style_shadow">
      <span class="product-card__add-text">В корзину</span>
    </span>
  </div>
  <div class="js-product__controls js-product__controls_action_change">
    <a href="/cart/" class="product-card__add product-card__btn-in-cart btn btn_style_shadow active">
      <span class="js-product__btn-in-cart-top-text">В корзине{$inCart ? ' <span class="custom-counter__amount">{$inCart}</span><span class="prefix"> м<sup>2</sup></span>' : ''}</span>
      <span class="js-product__btn-in-cart-bottom-text">Перейти</span>
    </a>
  </div>
  <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Купить в 1 клик</button>
</div> 

<div class="js-product__ms2-elems hidden">
  <form class="js-product__form-add ms2_form" method="post">
    <input name="options" value="[]">
    <input name="id" value="{$prodValues['prodId']}">
    <input name="count" class="custom-counter__amount" value="1">
    <input name="ctx" value="{$_modx->resource.context_key}">
    <button type="submit" name="ms2_action" value="cart/add"></button>
  </form>
  <form class="js-product__form-change ms2_form" method="post">
    <input name="key" value="{$prodValues['productKey']}">
    <input name="count" class="custom-counter__amount" value="{$inCart}">
    <input name="ctx" value="{$_modx->resource.context_key}">
    <button type="submit" name="ms2_action" value="cart/change"></button>
  </form>
</div>
