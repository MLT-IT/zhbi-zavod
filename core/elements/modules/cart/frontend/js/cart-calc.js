document.addEventListener("DOMContentLoaded", () => {
  const carts = document.querySelectorAll("[data-calc-cart]");

  carts.forEach((cart) => {
    const PRICE_PER_M2 = Number(cart.dataset.calcPrice) || 0;
    const SHEET_WIDTH_M = Number(cart.dataset.calcWidth) || 0;

    const controls = cart.querySelectorAll("[data-calc-cart-controls]");
    const areaEl = cart.querySelector("[data-calc-cart-area]");
    const totalEl = cart.querySelector("[data-calc-cart-total]");

    if (controls.length < 2) return;

    const lengthInput = controls[0].querySelector("input");
    const countInput = controls[1].querySelector("input");

    function recalc(event) {
      const lengthMm = Number(lengthInput.value) || 0;
      const count = Number(countInput.value) || 1;

      const lengthM = lengthMm / 1000;
      const area = +(lengthM * SHEET_WIDTH_M * count).toFixed(2);
      const total = Math.round(area * PRICE_PER_M2);

      areaEl.textContent = area;
      totalEl.textContent = total;

      // записываем цену за штуку
      const form = lengthInput.form;
      if (form) {
        const calcPriceInput = form.querySelector("input[name='calc_price']");
        if (calcPriceInput && count > 0) {
          calcPriceInput.value = Math.round(total / count);
        }
      }

      if (event) {
        window.cart?.submit(event);
      }
    }

    // кнопки + / -
    cart.addEventListener("click", (e) => {
      const btn = e.target.closest("[data-cart-event]");
      if (!btn) return;

      const row = btn.closest(".default-controls__row");
      if (!row) return;

      const input = row.querySelector("input");
      if (!input) return;

      const step = Number(input.step) || 1;
      let value = Number(input.value) || 0;

      if (btn.dataset.cartEvent === "plus") value += step;
      if (btn.dataset.cartEvent === "minus") value -= step;

      if (value < step) value = step;

      input.value = value;

      // синхронизируем hidden input
      const form = input.form;
      if (form && input.name) {
        const hidden = form.querySelector(
          `input[type="hidden"][name="${input.name}"]`,
        );
        if (hidden) hidden.value = value;
      }

      recalc(e);
    });

    // ручной ввод
    cart.addEventListener("input", (e) => {
      if (e.target.matches('input[type="number"]')) {
        recalc(e);
      }
    });

    recalc();
  });
});
