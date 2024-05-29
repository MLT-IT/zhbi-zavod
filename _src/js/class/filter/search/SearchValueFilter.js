import SearchFilter from "./SearchFilter.js";

class SearchValueFilter {


   /**
     * Конструктор инициализирует свойства объекта и вызывает функцию инициализации.
     * @param selector_filter — селектор контейнер фильтрующего элемента. Используется для выбора элемента, который будет использоваться.
     * в качестве фильтра для функции поиска.
     * @param selector_option — параметр selector_option представляет собой строку, которая представляет селектор для HTML.
     * элемент, позволяющий пользователю выбрать вариант фильтрации.
     * @param selector_past_search — селектор элемента, которыей отображает место куда требуется вставить input поиска
     * @param maxLength — параметр maxLength — это максимальная количество элементов для начала отобржения поиска
     */
    constructor(selector_filter, selector_option, selector_past_search, maxLength) {
        this.selector_filter = selector_filter;
        this.selector_past_search = selector_past_search;
        this.selector_option = selector_option;
        this.maxLength = maxLength;
        this.$filteres = $(this.selector_filter);

        this.initialization();
    }

    /**
     * Функция searchOption() инициализирует фильтр поиска для каждого фильтруемого элемента. Он проходит через каждый отфильтрованный
     * элемент и создает новый экземпляр класса SearchFilter, передавая необходимые параметры, такие как
     * фильтруемый элемент, параметры поиска, селектор куда вставки поиска и максимальное кол элементов для активации поиска. Эта функция позволяет
     * инициализация фильтров поиска для нескольких элементов на странице.
     */
    searchOption() {
        var self = this;
        this.$filteres.each(function () {
            new SearchFilter($(this), $(this).find(self.selector_option), self.selector_past_search, self.maxLength);
        });
    }

    /**
     * Функция инициализирует фильтры поиска, если они существуют, в противном случае регистрирует сообщение об ошибке.
     */
    initialization() {
        var self = this;
        if (this.$filteres.length > 0) {
            self.searchOption();
            console.log("Инициализация поиска фильтров");
        } else {
            console.log("Не удалось инициализрировать поиск фильтров");
        }
    }
}

export default SearchValueFilter;