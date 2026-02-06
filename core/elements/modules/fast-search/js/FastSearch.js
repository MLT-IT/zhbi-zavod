export default class FastSearch {
  constructor(edge) {
    this.limit_category_items = 3;
    this.edge = edge ?? 769;
    this.check_device = this.checkDevice();

    this.search_form = document.querySelector(
      `[data-fast-search-form="${this.check_device}"]`
    );
    this.search_input = document.querySelector(
      `[data-fast-search-input="${this.check_device}"]`
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
    if (window.innerWidth < this.edge) {
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

      // >>> Анимация загрузки
      const img = document.createElement("img");
      img.src = "/assets/template/images/icons/loader.svg";
      img.className = "fast-search__loader";
      this.search_form.insertBefore(img, this.search_input.nextSibling);
      // <<<

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
            img.remove();
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
        list_item.innerHTML = highlight(
          list_item.innerHTML, // текст для поиска
          this.search_input.value.trim().split(" "), // слова для обрамления
          "strong" // тег обрамления
        );
      });
    document.dispatchEvent(new CustomEvent('fast-search-show-results', {}));
  }

  hidePopup(html = "") {
    this.search_popup.innerHTML = html;
    if (html) {
      this.showPopup(html);
    } else {
      this.search_popup.style.display = "none";
      document.dispatchEvent(new CustomEvent('fast-search-hide-results', {}));
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

    // Закрытие модалки
    if (this.search_popup) {
      document.addEventListener("click", (event) => {
        // Проверяем, является ли целевой элемент клика дочерним popup или input или кнопкой поиска
        let inside = this.search_popup.contains(event.target);
        let submit_btns = this.search_form.querySelectorAll(
          'button[type="submit"]'
        );

        // Проверяем, был ли клик внутри одной из кнопок отправки
        let clickedSubmitBtn = Array.from(submit_btns).some((btn) =>
          btn.contains(event.target)
        );

        if (
          !inside &&
          !this.search_input.contains(event.target) &&
          !clickedSubmitBtn
        ) {
          this.hidePopup();
          this.search_input.value = "";
        }
      });
    }
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

// Выделяет найденное вхождение в тексте
function highlight(text, words, tag = "span") {
  var i,
    len = words.length,
    re;
  for (i = 0; i < len; i++) {
    let find = false;
    [
      words[i],
      translit(words[i], "en_ru"),
      translit(words[i], "ru_en"),
    ].forEach((word) => {
      if (!find) {
        re = new RegExp(word, "gi");
        if (re.test(text)) {
          find = true;
          text = text.replace(
            re,
            "<" + tag + ' class="highlight">$&</' + tag + ">"
          );
        }
      }
    });
  }
  return text;
}