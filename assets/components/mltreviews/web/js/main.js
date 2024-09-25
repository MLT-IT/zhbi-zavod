const MltReviewAjaxForm = {
  elem_attr: {
    form_id: "mlt-review-form",
    success_message_id: "mlt-review-success-message",
    error_message: "data-error-message",
  },
  elems: {
    form: null,
  },
  init() {
    this.elems.form = document.getElementById(this.elem_attr.form_id);
    if (!this.elems.form) {
      console.error("Форма для отзыва не найдена");
      return;
    }
    this.formListener();
  },
  formListener() {
    this.elems.form.addEventListener("submit", (event) => {
      event.preventDefault();

      this.elems.form.classList.add("loading");

      let action = this.elems.form.action;
      let form_data = new FormData(this.elems.form);

      let xhr = new XMLHttpRequest();
      xhr.open("POST", action, true);

      xhr.onload = () => {
        let data = JSON.parse(xhr.responseText);

        if (data.success) {
          console.log("true", data);
          this.successHandler();
        } else {
          console.log("false", data);
          this.errorHandler(data.object);
        }

        this.elems.form.classList.remove("loading");
      };

      xhr.onerror = () => {
        console.error("Ошибка запроса");
      };

      xhr.send(form_data);
    });
  },
  successHandler() {
    document
      .getElementById(this.elem_attr.success_message_id)
      .classList.add("show");
    this.elems.form.classList.add("hidden");
  },
  errorHandler(errors) {
    this.elems.form
      .querySelectorAll(`[${this.elem_attr.error_message}].show`)
      .forEach((show_error_elem) => {
        show_error_elem.classList.remove("show");
        show_error_elem.textContent = "";
      });
    this.elems.form.querySelectorAll(`[name]`).forEach((show_error_elem) => {
      show_error_elem.classList.remove("is-error");
    });

    errors.forEach((error) => {
      let error_message_elem = this.elems.form.querySelector(
        `[${this.elem_attr.error_message}="${error.field}"]`
      );
      if (error_message_elem) {
        error_message_elem.classList.add("show");
        error_message_elem.textContent = error.message;
      }

      let field = this.elems.form.querySelector(`[name="${error.field}"]`);
      if (field) {
        field.classList.add("is-error");
      }
    });
  },
};

MltReviewAjaxForm.init();
