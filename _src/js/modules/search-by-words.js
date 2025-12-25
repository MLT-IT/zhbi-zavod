/**
 * Поиск элементов по словам
 * data-search-by-words="ID" - Установить на input поиска
 * data-search-by-words-container="ID" Установить на контейнер с элемеентами по которым будет поиск
 */
export default class SearchByWords {
  find_elements = {}; // Найденные элементы, что бы повторно не бегать по DOM
  init() {
    this.events.input();
  }
  events = {
    input: () => {
      let inputs = document.querySelectorAll("[data-search-by-words]");
      inputs.forEach((input) => {
        input.addEventListener("input", () => {
          let container_id = input.dataset.searchByWords;
          let container = this.find_elements[container_id];
          if (!container) {
            container = document.querySelector(
              `[data-search-by-words-container="${container_id}"]`
            );
            this.find_elements[container_id] = container;
          }

          if (!container) return;

          let input_text = input.value.toLowerCase().trim();
          Array.from(container.children).forEach((child) => {
            let child_text = child.textContent.toLowerCase().trim();

            if (!input_text) {
              child.style.display = "";
              return;
            }

            if (child_text.indexOf(input_text) > -1) {
              child.style.display = "block";
            } else {
              child.style.display = "none";
            }
          });
        });
      });
    },
  };
}
