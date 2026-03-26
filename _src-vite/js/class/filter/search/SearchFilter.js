class SearchFilter {


    /**
     * Функция конструктора инициализирует свойства объекта с предоставленными параметрами.
     * @param $filter — Параметр $filter — это ссылка на обьект jQuery фильтра, которая будет использоваться для фильтрации
     * @param $elems — Параметр $elems — это ссылка на обьект jQuery опций фильтра.
     * @param selector_past_search — параметр selector_past_search — это селектор на элемент html куда будет вставлен поиск с помощью prepend
     * @param [maxLength=10] — параметр maxLength используется для указания максимальной длины массива элементов поиска для отображения поиска.
     */
    constructor($filter, $elems, selector_past_search, maxLength = 10) {
        this.$filter = $filter;
        this.$elems = $elems;
        this.maxLength = maxLength;
        this.selector_past_search = selector_past_search;
        this.initialization();
    }

    /**
     * Функция проверяет, превышает ли длина переменной указанную максимальную длину, и регистрирует сообщение.
     * соответственно.
     */
    initialization() {
        var self = this;
        if (self.$elems.length > self.maxLength) {
            self.$filter.find(self.selector_past_search).prepend(self.addSearchElement());
            //console.log("поиск обьявлен" + self.$elems.length);
        }
    }

   /**
     * Функция создает элемент ввода поиска с заполнителем и стилем, а также добавляет обработчик событий для поиска.
     * @returns Функция `addSearchElement()` возвращает элемент div, содержащий элемент ввода для поиска.
     * функциональность.
     */
    addSearchElement() {
        const searchInput = document.createElement("input");
        searchInput.className = "search-filter";
        searchInput.type = "text";
        searchInput.placeholder = "Поиск";
        searchInput.style.padding = "8px 10px";
        searchInput.style.width = "100%";
        searchInput.style.marginBottom = "20px";
        this.addHandlerSearch(searchInput);

        const searchDiv = document.createElement("div");
        searchDiv.appendChild(searchInput);
        return searchDiv;
    }


    showAllOption() {
        this.$elems.each(function () {
            $(this).show();
        });
    }

    /**
    * Функция добавляет к заданному элементу ввода обработчик поиска, который фильтрует и скрывает элементы на основе данных пользователя.
     * поиск ввода.
     * @param searchInput — параметр searchInput — это элемент ввода, в который пользователь может ввести свой поисковый запрос.
     */
    addHandlerSearch(searchInput) {
        var self = this;
        // при событии ввода
        searchInput.addEventListener('input', function (evt) {
            let search = evt.target.value;
            // отображаем все
            self.showAllOption();

            if (search.length >= 1) {
                //обходим все элементы фильтра
                self.$elems.each(function () {
                    //приводим к нижнему регистру
                    let valueLowerCase = $(this).data('value').toLowerCase();
                    // ищем
                    if (valueLowerCase.indexOf(search.toLowerCase()) < 0) {
                        $(this).hide();
                    }
                });

            } else {
                self.showAllOption();
            }
        });
    }
}

export default SearchFilter;