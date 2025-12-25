export default function initProductCart() {
  // Отслеживаем событие корзины для скрытия кнопок + - и вывода большой кнопки
  document.addEventListener("CartEvent", function (event) {
    // Если у товара есть остаток ничего не меняем

    let forms = document.querySelectorAll(
      `[data-cart-form="${event.detail.product_data.id}"]`
    );

    if (
      !event.detail.product_data.count ||
      event.detail.product_data.count == 0
    ) {
      forms.forEach((form) => {
        form.classList.remove("active");
      });
    }

    if (event.detail.product_data.count > 0) {
      forms.forEach((form) => {
        form.classList.add("active");
      });
    }
  });
}
