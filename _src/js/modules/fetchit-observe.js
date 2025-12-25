/**
 * Слушает отправки форм
 */

export default function fetchItObserve() {
  if (typeof FetchIt == "undefined") return;

  document.addEventListener(FetchIt.events.success, function (event) {
    /**
     * Скрывает контент модалки и открывает окно после отправки формы
     */
    let modal_id = event.detail.form.dataset.modalId;
    if (modal_id) {
      let modal = document.getElementById(modal_id);
      if (!modal) return;

      // Показать окно спасибо
      modals.showBodyAfter();

      // Перезагрузить страницу если это модалка оформления заказа
      if (modal_id == "modal-order") {
        cart.events.clear(false);
        setTimeout(() => {
          location.reload();
        }, 3000);
      }
    }

    notifications.success("Форма успешно отправлена");

    // console.log(event.detail);
  });
  document.addEventListener(FetchIt.events.error, function (event) {
    notifications.error("Ошибка при отправке формы");
    // console.log(event.detail);
  });
}
