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


<div class="data-calc-cart" data-calc-cart>
  <form data-cart-form="{$product_id}" onsubmit="">
    <input type="hidden" name="id" value="{$product_id}" />
    <input type="hidden" name="price" value="{$price}" />
    <input type="hidden" name="calc_price" />
    <input type="hidden" name="count" value="{$count}" />
    <input type="hidden" name="old_price" value="{$old_price}" />
    <input type="hidden" name="unit" value="{$unit}" />

    {* Опции товара для расчета *}
    <input type="hidden" name="calc_width" value="{$calc_width}" />
    <input type="hidden" name="calc_length" value="{$calc_length}" />

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

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const PRICE_PER_M2 = {$price}; // ₽ за м²
    const SHEET_WIDTH_M = {$calc_width}; // ширина листа в метрах

    const calc_cart = document.querySelector("[data-calc-cart]");
    const controls = calc_cart.querySelectorAll("[data-calc-cart-controls]");

    function recalc() {
      const lengthInput = controls[0].querySelector("input");
      const countInput = controls[1].querySelector("input");

      const lengthMm = Number(lengthInput.value);
      const count = Number(countInput.value);

      const lengthM = lengthMm / 1000;

      const area = (lengthM * SHEET_WIDTH_M * count).toFixed(2);
      const total = Math.round(area * PRICE_PER_M2);

      calc_cart.querySelector("[data-calc-cart-area]").textContent = area;

      calc_cart.querySelector("[data-calc-cart-total]").textContent = total;

      // Изменить цену за штуку
      const form = event.target.form;
      if (form) {
        const input_calc_price = form.querySelector("input[name='calc_price']");
        if (input_calc_price)
          input_calc_price.value = Math.round(total / count);
      }

      cart.submit(event);
    }

    document.addEventListener("click", (e) => {
      const btn = e.target.closest("[data-cart-event]");
      if (!btn) return;

      const parent = btn.parentNode;
      const input = parent.querySelector("input");

      const step = Number(input.step) || 1;
      let value = Number(input.value);

      if (btn.dataset.cartEvent === "plus") {
        value += step;
      }

      if (btn.dataset.cartEvent === "minus") {
        value -= step;
      }

      if (value < step) value = step;

      input.value = value;
      recalc();

      // Записали измененный параметр, например необходимо сохранять выбранную длину
      const form = e.target.form
      if(form){
        const find_input = form.querySelector("input[name='"+input.name+"']");
        if(find_input){
          find_input.value = value;
        }
      }
    });

    recalc();
  });
</script>
