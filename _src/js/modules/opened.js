/**
 * Скрипт для открытия разных элементов
 *
 * data-opened-btn - У кнопки. Установит класс active
 * data-opened-element - У элемента который необходимо открыть. Установит класс opened
 * data-active-text - Текст кнопки при активном состоянии
 * data-close-early="basket-window" - Закрыть передыдущие элементы. Указать название, для группировки элементов
 * data-toggle-not=true - Имея такой аттрибут элемент не будет закрыт при повторном нажатии
 */

export default function initOpened() {
  // Ранее открытые элементы
  let early_elements = early.elements();

  document.querySelectorAll("[data-opened-btn]").forEach((open_btn) => {
    let open_btn_text = open_btn.textContent; // Соханяем для дальнейших манипуляций
    let early_id = open_btn.dataset.closeEarly; // Если надо закрывать предыдущие элменты
    let open_btn_toggle_not = open_btn.dataset.toggleNot;

    open_btn.addEventListener("click", () => {
      let elem_id = open_btn.dataset.openedBtn;
      if (!elem_id) return;

      let find_open_elem = document.querySelector(
        `[data-opened-element="${elem_id}"]`
      );

      if (!find_open_elem) return;

      if (open_btn_toggle_not) {
        open_btn.classList.add("active");
        find_open_elem.classList.add("opened");
      } else {
        open_btn.classList.toggle("active");
        find_open_elem.classList.toggle("opened");
      }

      if (open_btn.dataset.activeText) {
        if (open_btn.classList.contains("active")) {
          open_btn.textContent = open_btn.dataset.activeText;
        } else {
          open_btn.textContent = open_btn_text;
        }
      }

      if (early_id) {
        early.update(open_btn, find_open_elem, early_elements[early_id]);
      }
    });
  });
}

let early = {
  elements: () => {
    let early_elements = {};

    document.querySelectorAll("[data-close-early]").forEach((early_elem) => {
      let early_id = early_elem.dataset.closeEarly;

      if (!early_elements[early_id]) early_elements[early_id] = {};

      if (!early_elements[early_id].btn) {
        let early_btn = document.querySelector(
          `[data-close-early="${early_id}"][data-opened-btn].active`
        );
        early_elements[early_id].btn = early_btn;
      }

      if (early_elements[early_id].btn && !early_elements[early_id].element) {
        let elem_id = early_elements[early_id].btn.dataset.openedBtn;

        early_elements[early_id].element = document.querySelector(
          `[data-opened-element="${elem_id}"].opened`
        );
      }
    });

    return early_elements;
  },
  update: (open_btn, find_open_elem, early_elements) => {
    if (early_elements.btn && early_elements.btn !== open_btn)
      early_elements.btn.classList.remove("active");
    if (early_elements.element && early_elements.element !== find_open_elem)
      early_elements.element.classList.remove("opened");

    early_elements.btn = open_btn;
    early_elements.element = find_open_elem;
  },
};
