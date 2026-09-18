const MltReviewAjaxForm = {
  elem_attr: {
    form_id: "mlt-review-form",
    success_message_id: "mlt-review-success-message",
    error_message: "data-error-message",
  },
  elems: {
    form: null,
    file_input: null,
    file_name: null,
  },
  field_values: {
    file: null,
  },
  init() {
    this.elems.form = document.getElementById(this.elem_attr.form_id);
    if (!this.elems.form) {
      console.error("Форма для отзыва не найдена");
      return;
    }
    this.formListener();
    this.fileChange();
  },
  fileChange() {
    this.elems.file_input = this.elems.form.querySelector(
      'input[name="avatar"]'
    );

    if (!this.elems.file_input) return;

    this.elems.file_name = this.elems.form.querySelector("#file_name");

    this.elems.file_input.addEventListener("change", () => {
      if (this.elems.file_input.value) {
        this.field_values.file = this.elems.file_input.files[0];

        if (this.elems.file_name) {
          this.elems.file_name.textContent = this.field_values.file.name;
        }
      }
    });
  },
  formListener() {
    this.elems.form.addEventListener("submit", (event) => {
      event.preventDefault();

      this.elems.form.classList.add("loading");

      let form_action = this.elems.form.action;
      let form_data = new FormData(this.elems.form);
      form_data.append("action", "create");

      if (this.field_values.file) {
        form_data.append("avatar", this.field_values.file);
      } else {
        form_data.delete("avatar");
      }

      fetch(form_action, {
        method: "POST",
        body: form_data,
      })
        .then((response) => response.json())
        .then((data) => {
          if (data.success) {
            console.log("true", data);
            this.successHandler();
          } else {
            console.log("false", data);
            this.errorHandler(data.object);
          }
          this.elems.form.classList.remove("loading");
        })
        .catch((error) => {
          console.error("Ошибка запроса:", error);
          this.elems.form.classList.remove("loading");
        });
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
      if (error.field == "avatar") {
        this.elems.file_input.value = null;
        this.field_values.file = null;
        if (this.elems.file_name) {
          this.elems.file_name.textContent = null;
        }
      }

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
