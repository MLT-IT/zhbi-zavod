/**
 * Слушает отправки форм
 */

export default function fetchItObserve() {
  if (typeof FetchIt == "undefined") return;

  const callbackFormSelector = '#modal-callback form[data-modal-id="modal-callback"]';
  const bannerListingGoalAttribute = "data-banner-listing-form-goal";
  const bannerListingGoalDatasetKey = "bannerListingFormGoal";

  const setBannerListingGoal = (goal) => {
    if (!goal) return;

    let callbackForm = document.querySelector(callbackFormSelector);
    if (!callbackForm) return;

    callbackForm.dataset[bannerListingGoalDatasetKey] = goal;
  };

  const clearBannerListingGoal = () => {
    let callbackForm = document.querySelector(callbackFormSelector);
    if (!callbackForm || !callbackForm.dataset) return;

    delete callbackForm.dataset[bannerListingGoalDatasetKey];
  };

  document.addEventListener("click", function (event) {
    let bannerButton = event.target.closest(`[${bannerListingGoalAttribute}]`);
    if (!bannerButton) return;

    setBannerListingGoal(
      bannerButton.getAttribute(bannerListingGoalAttribute)
    );
  });

  document.addEventListener("click", function (event) {
    let closeButton = event.target.closest("#modal-callback [data-modal-close]");
    if (!closeButton) return;

    clearBannerListingGoal();
  });

  document.addEventListener(FetchIt.events.success, function (event) {
    /**
     * Скрывает контент модалки и открывает окно после отправки формы
     */
    let form = event.detail.form;
    let modal_id = form.dataset.modalId;
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

    const bannerListingGoal = form.dataset[bannerListingGoalDatasetKey];
    if (bannerListingGoal) {
      if (typeof ym === "function") {
        ym(95226790, "reachGoal", bannerListingGoal);
      }

      clearBannerListingGoal();
    }

    notifications.success("Форма успешно отправлена");

    // console.log(event.detail);
  });
  document.addEventListener(FetchIt.events.error, function (event) {
    notifications.error("Ошибка при отправке формы");
    // console.log(event.detail);
  });
}
