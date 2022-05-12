/**
 * Функции, относящиеся к каталогу (в основном работа с mFilter2).
 */
export default function funcsCatalog() {
    $('.listing__reset-filters').on('click', function(e) {
        $('.listing__reset-filters-action')[0].click();
    });

    $('.listing__filter-option').on('click', function(e) {
        // Не знаю, почему, но на арматуре (ТОЛЬКО НА НЕЙ, что очень странно. На других контекстах все хорошо) при клике по фильтру (тегу а) срабатывает переход по ссылке, а не обработчик mSearch2. А на других контекстах - обработчик mSearch2, что приводит к применению фильтра. И этот баг вызывается только на боевом сайте (на локалке и на тестовом все работает). Данная строка помогают это исправить
        e.stopPropagation();
    });

    // -------------------------------------------
    // Сортировка фильтров - в самом верху те, у которых больше всего результатов
    // -------------------------------------------
    window.catalogSortFilters = function () {
        $('.listing__filter-block').each(function (index, elem) {
            // Пропускаем фильтр по цене
            if (index === 0) {
                return;
            }

            let $this = $(this);
            let $container = $($this.find('.listing__filter-option')[0]).parent();

            let $items = $container.find('.listing__filter-option').sort(function (a, b) {
                if (isNaN(parseInt($(a).attr('data-priority')))) {
                    return -1
                }

                if (isNaN(parseInt($(b).attr('data-priority')))) {
                    return 1
                }

                if (parseInt($(a).attr('data-priority')) > parseInt($(b).attr('data-priority'))) {
                    return -1;
                }

                if (parseInt($(a).attr('data-priority')) < parseInt($(b).attr('data-priority'))) {
                    return 1;
                }

                return 0;
            });

            $items.appendTo($container);
        });
    }
    // Кирилл сказал отменить сортировку, поэтому я закомментировал ее вызов
    // window.catalogSortFilters();

    // -------------------------------------------
    // Скрыть / показать характеристики на карточках
    // -------------------------------------------
    $(document).on('click', '.listing__products-item-chars-btn', function (e) {
        e.preventDefault();
        $(this).closest('.listing__products-item-chars-wrap').toggleClass('active');
    });

    if ($('.listing').length) {
        let lastW = 0;

        $(window).resize(function () {
            let $charsWrap = $('.listing__products-item-chars-wrap');
            if (window.innerWidth <= 768 && (lastW > 768)) {
                $charsWrap.removeClass('active');
            } else if (window.innerWidth > 768 && (lastW <= 768)) {
                $charsWrap.addClass('active');
            }
            lastW = window.innerWidth;
        }).resize();
    }

    // -------------------------------------------
    // Раскрытие меню для фильтрации на мобилках
    // -------------------------------------------
    $('.listing__filter-button').on('click', function (e) {
        let $headerBtnsWrap = $('.header__btns-wrap');
        $headerBtnsWrap.toggleClass('closed');
    });

    // -------------------------------
    // Сортировка на мобильных экранах
    // -------------------------------
    $('.listing__sort-select-elem').on('change', function (e) {
        let val = $(this).val();
        let $elem;
        let dataDir;

        switch (parseInt(val)) {
            // По цене по возрастанию
            case 2:
                $elem = $('.listing__sort-item[data-sort="ms|price"]');
                dataDir = 'asc';
                break;
            // По цене по убыванию
            case 3:
                $elem = $('.listing__sort-item[data-sort="ms|price"]');
                dataDir = 'desc';
                break;
            // По популярности по убыванию
            case 1:
                $elem = $('.listing__sort-item[data-sort="tv|HitsPage"]');
                dataDir = 'desc';
                break
            // По алфавиту по убыванию
            case 4:
                $elem = $('.listing__sort-item[data-sort="ms_product|pagetitle"]');
                dataDir = 'asc';
                break
        }

        $('.listing__sort-item.active').removeClass('active');

        // Сохраняем data-атрибуты, потому что дальше они будут меняться (для применения сортировки)
        // Сохранять надо на случай, если пользователь снова включит большой экран
        let dataDefaultSave = $elem.attr('data-default');

        $elem.attr('data-dir', '');
        $elem.attr('data-default', dataDir);

        $elem[0].click();

        // Возвращаем data-атрибуты
        $elem.attr('data-default', dataDefaultSave);
    });


    // -------------------------------
    // Расчет текста для кнопки "Показать еще"
    // -------------------------------
    window.getRemainder = function () {
        // Количество товаров в листинге
        let amount = $('.listing__products-list .js-product').length;
        let $btnMore = $('#mse2_mfilter .btn_more, .sect-listing__content .btn_more');

        // Проверка - существует ли листинг на основе pdoPage или mSearch2. И есть ли в таком листинге товары
        if (((typeof mSearch2 !== 'undefined' && mSearch2) ||
            (typeof pdoPage !== 'undefined' && pdoPage))
            && amount) {
            // Всего товаров
            let total;
            if (typeof mSearch2 !== 'undefined') {
                total = parseInt(mSearch2.total.text());
            } else {
                total = parseInt($('#pdopage_total').text());
            }

            // Сколько осталось вывести товаров?
            let remainder = 0;


            let remainderMax = 42;
            if ($btnMore.attr('data-max')) {
                remainderMax = $btnMore.attr('data-max');
            }

            if (total > amount) {
                remainder = total - amount;
            }
            if (remainder > remainderMax) {
                remainder = remainderMax;
            }


            // Установка текста для кнопки
            $btnMore.text('Показать еще ' + remainder);
        }
    }

    window.getRemainder();

    // -------------------------------
    // Конфликтующие фильтры
    // -------------------------------
    // Переключение конфликтующих фильтров: Длина, Ширина, Толщина и Размеры
    $('.listing__filter-block-content input[type="checkbox"]').on('change', function () {
        let $block = $(this).closest('.listing__filter-block');
        let $conflictingFilters;
        let dontDoAnything = false;

        switch (true) {
            case $block.hasClass('filter_type_razmer'):
                $conflictingFilters = $('.filter_type_thickness, .filter_type_width, .filter_type_length');
                break;

            case ($block.hasClass('filter_type_thickness') ||
                $block.hasClass('filter_type_width') ||
                $block.hasClass('filter_type_length')
            ):
                $conflictingFilters = $('.filter_type_razmer');
                break;

            default:
                dontDoAnything = true
                break;
        }

        if (dontDoAnything === false) {
            if ($block.find('input[type="checkbox"]:checked').length) {
                $conflictingFilters.css('display', 'none');
            } else {
                $conflictingFilters.css('display', '');
            }
        }
    });

}
