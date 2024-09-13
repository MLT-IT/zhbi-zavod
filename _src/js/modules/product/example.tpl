{*Настройка карточки кровли, центральное место, выносить в шаблон карточки *}
{set $settingCardKrovlya = [
    'width' => 0,
    'optionWidth' => 'rabochaya-shirina',
    'maxLength' => 12000,
    'stepLength' => 500,
    'minLength' => 500
]}
{if $settingCardKrovlya['optionWidth']}
    {set $settingCardKrovlya['width'] = $_modx->runSnippet("@FILE snippets/getOptionProduct.php", ['key' => $settingCardKrovlya['optionWidth']])}
{/if}
{*  *}
{* 
  - с префиксом ms- то, что нужно для работы с корзиной minishop
  - классы кэмэлкейсом с префиксом calc, типа calcPrice - для js расчетов
*}

{* <div class="js-product"> *}
  <div class="product-calc">
    <input type="hidden" class='calc-width' name="width" value="{$settingCardKrovlya['width']}">
    <input type="hidden" class="ms-amount" value="{$prodValues['itemInCart']?:1}">
    <input type="hidden" class="calcPrice" data-default="{$prodValues['defaultPrice']?:0}"
        style="display:none!important"></input>

      <div class="product-calc__input calc-input">
        <div class="calc-input__title">Длина листа, мм</div>
        <div class="calc-input__input-wrapper">
          <span class="calc-input__decrease calcMinus"></span>
          <input type="number" name="long" class="calcInput" value="{$settingCardKrovlya['minLength']}"
            min="{$settingCardKrovlya['minLength']}" max="{$settingCardKrovlya['maxLength']}"
            step="{$settingCardKrovlya['stepLength']}">
          <span class="calc-input__increase"></span>
        </div>
      </div>
      <div class="counter">
        <div class="counter-title">Количество листов, шт.</div>
        <div class="counter-controls counter">
          <span class="decrease counter__btn"></span>
          <input type="number" name="count" class="calcInput" value="1" min="1" step="1" max="10000">
          <span class="increase counter__btn counter__btn_plus"></span>
        </div>
      </div>
      <div class="resultSum">
        <div class="resultSum-m2"><span class="title">ИТОГО: </span><span class="value"></span><span
            class="prefix">м2</span></div>
        <div class="resultSum-rub"><span class="value"> </span><span class="prefix"> руб</span></div>
      </div>

    <div class="js-product__controls js-product__controls_action_add">
      
      <span class="js-product__btn-to-cart js-product__to-cart product-card__add btn btn_style_shadow">
        <span class="product-card__add-text">В корзину</span>
      </span>
    </div>
    <div class="js-product__controls js-product__controls_action_change">
      <div class="counter">
        <div class="counter-title">Длина листа, мм</div>
        <div class="counter-controls counter custom-counter">
          <span class="decrease counter__btn custom-counter__btn_dir_less"></span>
          <input name="long" class="calcInput" value="{$settingCardKrovlya['minLength']}"
            data-min="{$settingCardKrovlya['minLength']}" data-max="{$settingCardKrovlya['maxLength']}"
            data-step="{$settingCardKrovlya['stepLength']}">
          <span class="increase counter__btn counter__btn_plus custom-counter__btn_dir_more"></span>
        </div>
      </div>
      <div class="counter">
        <div class="counter-title">Количество листов, шт.</div>
        <div class="counter-controls counter">
          <span class="decrease counter__btn"></span>
          <input type="hidden" name="count" value="1">
          <span class="increase counter__btn counter__btn_plus"></span>
        </div>
      </div>
      <div class="resultSum">
        <div class="resultSum-m2"><span class="title">ИТОГО: </span><span class="value custom-counter__amount"></span><span
            class="prefix">м2</span></div>
        <div class="resultSum-rub"><span class="value"> </span><span class="prefix">0 ₽</span></div>
      </div>
      <span class="js-product__price" data-default="{$prodValues['defaultPrice']?:0}"
        style="display:none!important"></span>
      <a href="/cart/" class="product-card__add product-card__btn-in-cart btn btn_style_shadow active">
        <span class="js-product__btn-in-cart-top-text">В корзине</span>
        <span class="js-product__btn-in-cart-bottom-text">Перейти</span>
      </a>
    </div>
  </div>
  <div class="js-product__ms2-elems hidden">
    <form class="js-product__form-add ms2_form" method="post">
      <input name="options" value="[]">
      <input name="id" value="{$prodValues['prodId']}">
      <input name="count" value="1">
      <input name="ctx" value="{$_modx->resource.context_key}">
      <button type="submit" name="ms2_action" value="cart/add"></button>
    </form>
    <form class="js-product__form-change ms2_form" method="post">
      <input name="key" value="{$prodValues['productKey']}">
      <input name="count" value="{$prodValues['itemInCart']?:1}">
      <input name="ctx" value="{$_modx->resource.context_key}">
      <button type="submit" name="ms2_action" value="cart/change"></button>
    </form>
  </div>
{* </div> *}
