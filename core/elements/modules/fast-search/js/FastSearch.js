export default class FastSearch {
  constructor() {
    this.limit_category_items = 3;
    this.check_device = this.checkDevice();
    // this.check_device = "desktop";

    this.search_form = document.querySelector(
      `[data-fast-search-form="${this.check_device}"]`
    );
    this.search_input = document.querySelector(
      `[data-fast-search-input="${this.check_device}"]`
    );

    this.search_timeout = 400;
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

            if (status === "success" && data.trim().length) {
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
      // this.close_button.style =
      //   "opacity:1;width:25px;max-width:none;padding-left:4px;";
      this.close_button.classList.add("opened");
    }

    // Выделение найденных слов
    this.search_popup
      .querySelectorAll(
        ".fast-search-container li [data-fast-search-result-text]"
      )
      .forEach((list_item) => {
        list_item.innerHTML = this.highlight(
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

    if (this.check_device === "mobile" && !html) {
      this.close_button.classList.remove("opened");
    }
  }
  // Выделяет найденное вхождение в тексте
  highlight(text, words, tag = "span") {
    var i,
      len = words.length,
      re;
    for (i = 0; i < len; i++) {
      if (!words[i].length) continue;

      let find = false;
      [
        words[i],
        this.translit(words[i], "en_ru"),
        this.translit(words[i], "ru_en"),
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

  // Транслитирация
  translit(word, key) {
    let converter = {
      // prettier-ignore
      ru_en: {
        а: "a", б: "b", в: "v", г: "g", д: "d", е: "e", ё: "yo", ж: "zh", з: "z", и: "i", й: "j", к: "k", л: "l", м: "m", н: "n", о: "o", п: "p", р: "r", с: "s", т: "t", у: "u", ф: "f", х: "h", ц: "c", ч: "ch", ш: "sh", щ: "sh", ъ: "``", ы: "y", ь: "`", э: "e`", ю: "yu", я: "ya",
      },
      // prettier-ignore
      en_ru: {
        a: "а", b: "б", v: "в", g: "г", d: "д", e: "е", yo: "ё", zh: "ж", z: "з", i: "и", j: "й", k: "к", l: "л", m: "м", n: "н", o: "о", p: "п", r: "р", s: "с", t: "т", u: "у", f: "ф", h: "х", c: "ц", ch: "ч", sh: "ш", sch: "щ", "``": "ъ", y: "ы", "`": "ь", "e`": "э", yu: "ю", ya: "я",
      },
    };

    word = word.toLowerCase();

    let answer = "";
    for (let i = 0; i < word.length; ++i) {
      let x = word[i];
      if (x === "c" && word[i + 1] === "h") {
        x = "ch";
        i++;
      } else if (x === "s" && word[i + 1] === "h") {
        x = "sh";
        i++;
      } else if (x === "y" && word[i + 1] === "u") {
        x = "yu";
        i++;
      } else if (x === "y" && word[i + 1] === "a") {
        x = "ya";
        i++;
      } else if (x === "y" && word[i + 1] === "o") {
        x = "yo";
        i++;
      } else if (x === "z" && word[i + 1] === "h") {
        x = "zh";
        i++;
      }

      if (converter[key][x] == undefined) {
        answer += x;
      } else {
        answer += converter[key][x];
      }
    }

    return answer;
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
        if (!inside && !this.search_input.contains(event.target)) {
          this.hidePopup();
          // this.search_input.value = "";
        }
      });
    }
  }

  // Скрывает элементы в длинном списке категории
  hideLongList() {
    const limit_parent = this.search_popup.querySelector(
      "[data-fast-search-limit-items]"
    );

    if (!limit_parent) {
      return;
    }

    const limit_childrens = limit_parent.querySelectorAll(
      "li:not([data-fast-search-limit-protection])"
    );

    if (limit_childrens.length > this.limit_category_items) {
      limit_childrens.forEach((limit_children, index) => {
        if (index + 1 > this.limit_category_items) {
          limit_children.style.display = "none";
        }
      });

      // Создаем кнопку открытия списка
      // const show_container = document.createElement("li");
      // show_container.className = "fast-search-show-all";

      // const show_button = document.createElement("span");
      // show_button.onclick = () => {
      //   limit_childrens.forEach((limit_children) => {
      //     limit_children.style.display = "block";
      //   });
      //   show_container.remove();
      // };
      // show_container.appendChild(show_button);

      // // Первый скрытый элемент
      // const last_show_children = limit_childrens[this.limit_category_items];
      // limit_parent.insertBefore(show_container, last_show_children);
    }
  }
}
