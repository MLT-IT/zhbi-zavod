/**
 * Подгрузка по AJAX каталога
 * Открытие модалки каталога
 */
import Menu from "./Menu.js";

export default class Catalog {
  constructor() {
    this.selectors = {
      open: "[data-catalog-open]",
      close: "[data-catalog-close]",
      catalog_container: "[data-catalog-container]",
    };
    this.events = this.events();
    this.events_init = {};
  }
  init() {
    this.events.open();
    window.catalog = this;
  }
  events() {
    return {
      open: () => {
        let catalog_open_btns = document.querySelectorAll(this.selectors.open);
        catalog_open_btns.forEach((catalog_open_btn) => {
          catalog_open_btn.addEventListener("click", () => {
            let catalog_id = catalog_open_btn.dataset.catalogOpen;
            if (!catalog_id) return;

            let catalog = document.getElementById(catalog_id);
            if (!catalog) return;

            this.catalog = catalog;

            let menu = new Menu(catalog);
            menu.init();

            if (catalog.classList.contains("opened")) {
              catalog.classList.remove("opened");
            } else {
              catalog.classList.add("opened");
            }

            // Записали для каких каталогов уже была инициализация события
            if (!this.events_init[catalog_id]) {
              this.events_init[catalog_id] = true;
              this.events.close(catalog);
            }
          });
        });
      },
      close: (catalog) => {
        let catalog_close_btns = catalog.querySelectorAll(this.selectors.close);
        catalog_close_btns.forEach((catalog_close_btn) => {
          catalog_close_btn.addEventListener("click", () => {
            catalog.classList.remove("opened");
          });
        });
      },
    };
  }
}
