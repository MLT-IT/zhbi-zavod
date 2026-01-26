{if $product}
  {set $product_id = $product['id']}

  {* Ширина листа - Опция указана в мм, переводим в м *}
  {set $calc_width = $product['calc_width']}
  {* Длина в местрах. По умолчанию 0.5 *}
  {set $calc_length = $product['calc_length']}
{else}
  {set $product_id = $_modx->resource.id}
  {set $product_data = '@FILE modules/cart/backend/snippets/getProductData.php' | snippet : [
    'product_id' => $product_id
  ]}

  {* Ширина листа - Опция указана в мм, переводим в м *}
  {set $calc_width = ($_modx->resource['rabochaya-shirina'][0] ?: $_modx->resource['poleznaya-shirina'][0]) / 1000}
  {* Длина в местрах. По умолчанию 0.5 *}
  {set $calc_length = $product_data['calc_length'] ?: 500}
{/if}

{* Вычисление площади листа *}
{set $price = $product['price'] ? $product['price'] : $_modx->resource.price ?: 0}
{set $unit = $product['unit'] ? $product['unit'] : ($unit | gettype == 'array' ? $unit[0] : $unit)}
{set $count = $product['count'] ? $product['count'] : ($product_data['count'] ?: 1)}


<div
  class="data-calc-cart"
  data-calc-cart
  data-calc-width="{$calc_width}"
  data-calc-price="{$price}"
>
  <form data-cart-form="{$product_id}" onsubmit="">
    <input type="hidden" name="id" value="{$product_id}" />
    <input type="hidden" name="price" value="{$price}" />
    <input type="hidden" name="calc_price" />
    <input type="hidden" name="count" value="{$count}" />
    <input type="hidden" name="old_price" value="{$old_price}" />
    <input type="hidden" name="unit" value="{$unit}" />

    {* Опции товара для расчета *}
    {if $calc_width && $calc_length}
      <input type="hidden" name="calc_width" value="{$calc_width}" />
      <input type="hidden" name="calc_length" value="{$calc_length}" />

      {* Отметка что используется калькулятор *}
      <input type="hidden" name="is_calc_cart" value="true" />
    {/if}

    <div class="default-controls" data-calc-cart-controls>
      <div class="default-controls__title">Длина листа, мм</div>
      <div class="default-controls__row">
        <button class="btn btn-primary" data-cart-event="minus">-</button>
        <input class="fw-600" type="number" name="calc_length" value="{$calc_length}" step="500" />
        <button class="btn btn-primary" data-cart-event="plus">+</button>
      </div>
    </div>

    <div class="default-controls" data-calc-cart-controls>
      <div class="default-controls__title">Кол-во листов, шт.</div>
      <div class="default-controls__row">
        <button class="btn btn-primary" data-cart-event="minus">-</button>
        <input
          class="fw-600"
          type="number"
          value="{$count}"
          name="count"
          step="1"
          data-cart-event="change"
          data-cart-product-count="{$product_id}"
        />
        <button class="btn btn-primary" data-cart-event="plus">+</button>
      </div>
    </div>
  </form>
  <div class="default-controls">
    <div class="default-controls__title" style="text-align: end">
      Итого: <span data-calc-cart-area>0</span> м<sup>2</sup>
    </div>
    <div class="fs-30 fw-700" style="text-align: end">
      <span data-calc-cart-total>0</span> ₽
    </div>
  </div>
</div>