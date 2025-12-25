/**
 * Работа с меню каталога
 *
 * data-subcategories-open - У родителя
 * id - у дочерний категории которая должна открыться
 */

export default class Menu {
  /**
   * @param {DOMElement} catalog
   */
  constructor(catalog) {
    this.catalog = catalog;
    this.selectors = {
      open: "[data-subcategories-open]",
    };
  }

  init() {
    // Первый открытый элемент
    let subcat_open_btns = document.querySelectorAll(this.selectors.open);

    // Первый открытый элемент
    let active_category = subcat_open_btns[0];

    if (!active_category) return;

    let active_subcategory = document.getElementById(
      subcat_open_btns[0].dataset.subcategoriesOpen
    );

    subcat_open_btns.forEach((subcat_open_btn) => {
      subcat_open_btn.addEventListener("mouseover", () => {
        if (active_subcategory) active_subcategory.classList.remove("opened");
        if (active_category) active_category.classList.remove("opened");

        let subcat_id = subcat_open_btn.dataset.subcategoriesOpen;
        if (!subcat_id) return;

        let subcategory = this.catalog.querySelector(`#${subcat_id}`);
        if (!subcategory) return;

        subcategory.classList.add("opened");
        subcat_open_btn.classList.add("opened");

        active_subcategory = subcategory;
        active_category = subcat_open_btn;
      });
    });
  }
}
