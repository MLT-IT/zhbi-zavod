/**
 * additional-fields-callback-form Скрипт для создания доп полей в формах обратного звонка
 */

import config from "./_config";
import lexicon from "./_lexicon";

export default class AdditionalFieldsCallbackForm {
  constructor() {
    this.initConfig();
    this.initLexicon();
    this.appendHTML();
  }

  initConfig() {
    // Формы в которые будет добавлена кнопка
    this.forms = config.forms;
  }

  initLexicon() {
    this.lexicon = lexicon.ru;
  }

  initHTML() {
    let outer = document.createElement("div");
    outer.className = "afcf";
    outer.innerHTML = `
          <button class="afcf__main-button" data-event-main-button>
            ${this.lexicon.main_button}
          </button>
          <div class="afcf__opener">
            <div class="afcf__description">${this.lexicon.description}</div>
            <div class="afcf__field-group" data-cloned-fields data-material-item>
              <input
                name="afcf-material"
                type="text"
                placeholder="${this.lexicon.input_material}"
              />
              <input
                name="afcf-volume"
                type="text"
                placeholder="${this.lexicon.input_volume}"
              />
              <button class="afcf__added-button" data-event-added-button>
                +
              </button>
            </div>
              <input
                name="afcf-address"
                type="text"
                placeholder="${this.lexicon.input_address}"
              />
          </div>
          <input type="hidden" name="afcf-result"/>
      `;

    let clone_count = 0;
    outer
      .querySelector("[data-event-main-button]")
      .addEventListener("click", (e) => {
        e.preventDefault();

        if (outer.classList.contains("opened")) {
          outer.classList.remove("opened");
        } else {
          outer.classList.add("opened");
        }
      });

    let clonedBtnEvent = (e) => {
      e.preventDefault();

      let cloned_fields = outer.querySelector("[data-cloned-fields]");
      let clone = cloned_fields.cloneNode(true);
      clone_count++;

      // Найдем родительский элемент
      let parent = cloned_fields.parentNode;

      // Вставим клонированный элемент после исходного элемента
      if (cloned_fields.nextSibling) {
        parent.insertBefore(clone, cloned_fields.nextSibling);
      }

      clone
        .querySelector("[data-event-added-button]")
        ?.addEventListener("click", clonedBtnEvent);

      // Изменили name что бы поля не затирали друг друга
      let attribute_names = ["afcf-material", "afcf-volume"];
      attribute_names.forEach((attribute_name) => {
        clone
          .querySelector(`[name="${attribute_name}"]`)
          ?.setAttribute("name", `${attribute_name}-${clone_count}`);
      });

      // e.target.remove();
    };

    outer
      .querySelector("[data-event-added-button]")
      .addEventListener("click", clonedBtnEvent);

    return outer;
  }

  appendHTML() {
    this.forms.forEach((form_data) => {
      let form = document.getElementById(form_data.id);

      if (form) {
        let insertion_elem = form.querySelector(form_data.insertion.element);

        if (insertion_elem) {
          let ie_parent = insertion_elem.parentNode;

          switch (form_data.insertion.side) {
            case "after":
              if (ie_parent.nextSibling) {
                ie_parent.insertBefore(
                  this.initHTML(),
                  insertion_elem.nextSibling
                );
              }

              break;
            case "before":
              ie_parent.insertBefore(this.initHTML(), insertion_elem);
              break;
          }
        }

        form.addEventListener("submit", () => {
          let comment = form.querySelector('[name="afcf-result"]');
          if (!comment) {
            comment = document.createElement("input");
            comment.setAttribute("type", "hidden");
            comment.setAttribute("name", "afcf-result");
            form.appendChild(comment);
          }

          comment.value = this.getFieldValues(form);
        });
      }
    });
  }

  getFieldValues(form) {
    let material_items = form.querySelectorAll("[data-material-item]");
    let result = "";

    material_items.forEach((material_item) => {
      let inputs = material_item.querySelectorAll("input");
      if (!inputs) return;

      inputs = Array.from(inputs);
      let material = inputs.find((input) => {
        return input.name.indexOf("afcf-material") > -1;
      });
      let volume = inputs.find((input) => {
        return input.name.indexOf("afcf-volume") > -1;
      });

      if (material && volume) {
        result += `${this.lexicon.result_material}: ${material.value} - ${this.lexicon.result_volume}: ${volume.value};`;
      }
    });
    let address = form.querySelector('[name="afcf-address"]');
    if (address && address.value)
      result += `${this.lexicon.result_address}: ${address.value};`;

    return result;
  }
}
