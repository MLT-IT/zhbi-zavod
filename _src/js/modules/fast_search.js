import functions from "../functions/functions";

export default class FastSearch {
  constructor(selector) {
    this.limit_category_items = 3;
    this.check_device = this.checkDevice();

    this.search_form = document.querySelector(
      `[fast-search-form="${this.check_device}"]`
    );
    this.search_input = document.querySelector(
      `[fast-search-input="${this.check_device}"]`
    );

    this.search_timeout = 400;

    this.init();
  }

  init() {
    if (!this.search_form || !this.search_input) {
      console.warn(
        "[FastSearch] Нет необходимых элементов для быстрого поиска"
      );
      return;
    }

    if (this.check_device === "mobile") {
      this.addClosePopupButton();
    }

    this.searchPopupInit();
    this.addListener();
  }

  addClosePopupButton() {
    const button = document.createElement("a");
    button.className = "fast-search-close-button";
    button.innerHTML = "✖";

    button.onclick = () => this.hidePopup();

    this.search_form.appendChild(button);

    this.close_button = button;
  }

  checkDevice() {
    if (window.innerWidth < 769) {
      return "mobile";
    } else {
      return "desktop";
    }
  }

  searchStart() {
    if (!this.search_input.value.length) {
      this.hidePopup();
      return;
    }

    clearInterval(this.search_timer);
    this.search_timer = setTimeout(() => {
      this.search_input.classList.add("search-loading");
      // this.search_input.setAttribute("readonly", "true");

      $.get(
        "/",
        {
          action: "fast-search",
          query: this.search_input.value,
        },
        (data, status) => {
          try {
            if (!this.search_input.value) {
              return;
            }

            if (status === "success" && data) {
              this.showPopup(data);
            } else {
              this.hidePopup(
                `К сожалению по запросу "${this.search_input.value}" ничего не найдено`
              );
            }
          } finally {
            this.search_input.classList.remove("search-loading");
            // this.search_input.removeAttribute("readonly");
          }
        }
      );
    }, this.search_timeout);
  }

  searchPopupInit() {
    const search_popup = document.createElement("div");
    search_popup.className = "fast-search";
    search_popup.style.display = "none";

    this.search_form.appendChild(search_popup);
    this.search_popup = search_popup;
  }

  showPopup(html) {
    this.search_popup.innerHTML = html;
    this.search_popup.style.display = "block";

    if (this.check_device === "mobile") {
      this.hideLongList();
      this.close_button.style =
        "opacity:1;width:25px;max-width:none;padding-left:4px;";
    }

    // Выделение найденных слов
    this.search_popup
      .querySelectorAll(".fast-search-container li [fast-search-result-text]")
      .forEach((list_item) => {
        list_item.innerHTML = functions.highlight(
          list_item.innerHTML, // текст для поиска
          this.search_input.value.trim().split(" "), // слова для обрамления
          "strong" // тег обрамления
        );
      });
  }

  hidePopup(html = "") {
    this.search_popup.innerHTML = html;
    if (html) {
      this.showPopup(html);
    } else {
      this.search_popup.style.display = "none";
    }

    if (this.check_device === "mobile") {
      this.close_button.style = "";
    }
  }

  addListener() {
    if (!this.search_input) {
      return;
    }

    ["input", " propertychange", " change"].forEach((event_name) => {
      this.search_input.addEventListener(
        event_name,
        () => {
          this.searchStart();
        },
        this.searchStart.bind(this),
        false
      );
    });
  }

  // Скрывает элементы в длинном списке категории
  hideLongList() {
    const limit_parent = this.search_popup.querySelector(
      "[fast-search-limit-items]"
    );

    if (!limit_parent) {
      return;
    }

    const limit_childrens = limit_parent.querySelectorAll(
      "li:not([fast-search-limit-protection])"
    );

    if (limit_childrens.length > this.limit_category_items) {
      limit_childrens.forEach((limit_children, index) => {
        if (index + 1 > this.limit_category_items) {
          limit_children.style.display = "none";
        }
      });

      // Создаем кнопку открытия списка
      const show_container = document.createElement("li");
      show_container.className = "fast-search-show-all";

      const show_button = document.createElement("span");
      show_button.onclick = () => {
        limit_childrens.forEach((limit_children) => {
          limit_children.style.display = "block";
        });
        show_container.remove();
      };
      show_container.appendChild(show_button);

      // Первый скрытый элемент
      const last_show_children = limit_childrens[this.limit_category_items];
      limit_parent.insertBefore(show_container, last_show_children);
    }
  }
}
