import functions from "./functions";

/**
 * Функции, относящиеся к шаблону Каталог (в основном работа с mFilter2).
 */
export default {
    init,
    catalogSortFilters,
    getRemainder,
    wrapTitle
};


// Инициализация
function init() {
    // Перенос строки в названии в чанках товаров на pro-fanera и plitaosb
    wrapTitle();


    // -------------------------------------------
    // Панель с фильтрами на мобилках
    // -------------------------------------------
    let $openFiltersBtn = $(".listing__open-filters-btn");
    if ($openFiltersBtn.length) {
        // Основные переменные
        let $filter = $(".listing__filter");
        let filterPanelWidth = $filter.outerWidth();

        function toggleFiltersbar(skipChangeClasses) {
            skipChangeClasses = (typeof skipChangeClasses !== 'undefined') ? skipChangeClasses : false;

            if (!skipChangeClasses) {
                $filter.toggleClass("active");
                $('body').toggleClass("filter-opened");
            }

            // Панель открылась
            if ($filter.hasClass('active')) {
                $filter[0]['swapMinX'] = 0;
                $filter[0]['swapMaxX'] = filterPanelWidth;
            }
            // Панель закрылась
            else {
                $filter[0]['swapMinX'] = -filterPanelWidth;
                $filter[0]['swapMaxX'] = 0;
            }
        }


        // ----------------------------
        // Основные обработчики для открытия и закрытия панели с фильтрами
        // ----------------------------
        // Обработчик кнопки внутри панели с фильтрами для закрытия фильтров
        $('.listing__close-filter-btn').on('click', function () {
            toggleFiltersbar();
        });

        // Обработчик для раскрытия панели с фильтрами на мобилках
        $openFiltersBtn.on("click", function () {
            toggleFiltersbar();
        });
        $(document).on('click', function (e) {
            let $target = $(e.target);
            if ($filter.hasClass('active') && !$target.closest('.listing__filter, .listing__open-filters-btn').length && !$target.hasClass('listing__filter, listing__open-filters-btn')) {
                toggleFiltersbar();
            }
        });


        // ----------------------------
        // Эффект шторки для панели с фильтрами на мобилках
        // ----------------------------
        Drog.on($filter[0], {
            swapMinY: 0,
            swapMaxY: 0,
            swapMaxX: 0,
            swapMinX: -filterPanelWidth,
            elem: $('.listing__filter-btn')[0]
        });

        $filter.on('drogEnd', function () {
            let translateX = 0;

            // Если фильтры открыты
            if ($filter.hasClass('active')) {
                // Если достаточно сильно свайпнули панель с фильтрами, то необходимо закрыть ее
                if ($filter[0]['-x'] >= (filterPanelWidth / 2 - 10)) {
                    translateX = filterPanelWidth;
                }
            }
            // Если фильтры закрыты
            else {
                // Если достаточно сильно свайпнули панель с фильтрами, то необходимо открыть ее
                if ($filter[0]['-x'] <= (0 - (filterPanelWidth / 2 - 10))) {
                    translateX = -filterPanelWidth;
                }
            }

            // Возвращение шторки (с анимацией). Либо возвращаем шторку в исходное положение (какой она была до того, как пользователь начал ее тянуть). Либо помогаем пользователю открыть / закрыть ее
            $filter.css({
                transform: 'translateX(' + translateX + 'px)',
                transition: ".3s"
            });

            if (translateX !== 0) {
                // Сразу делаем затемнение для body
                $('body').toggleClass("filter-opened");
            }

            // Ждем выполнения анимации
            setTimeout(function () {
                // Сбрасываем Drog
                Drog.move($filter[0], 0, 0);

                // Отменяем transition для шторки, т.к. она уже переместилась
                $filter.removeAttr('style');

                if (translateX !== 0) {
                    // Делаем transition мгновенным (в css он прописан для right, из-за этого будет ненужный скачок)
                    $filter.css('transition', 'all 0s');
                    // Меняется right в стилях
                    $filter.toggleClass("active");
                    // ВАЖНО! Функция toggleFiltersbar обязательно должна идти ПОСЛЕ установки класса active, потому что в ней он проверяется
                    toggleFiltersbar(true);

                    // Между отменой мгновенного transition и действиями со стилями необходимо подождать немного
                    setTimeout(function () {
                        // Отменяем мгновенный transition
                        $filter.removeAttr('style');
                    }, 20);
                }
            }, 300);
        });
    }


    // -------------------------------------------
    // Уменьшение текста в тегах, если он слишком длинный
    // -------------------------------------------
    $('.listing__tags-item-title').each(function (i, e) {
        let $elem = $(e);

        // Получаем и проверяем высоту
        if ($elem.outerHeight() > 20) {
            $elem.css('font-size', '.775rem');
        }
    });


    // -------------------------------------------
    // Кнопка сброса фильтров
    // -------------------------------------------
    $('.listing__reset-filters').on('click', function (e) {
        $('.listing__reset-filters-action')[0].click();
    });

    $('.listing__filter-option').on('click', function (e) {
        // Не знаю, почему, но на арматуре (ТОЛЬКО НА НЕЙ, что очень странно. На других контекстах все хорошо) при клике по фильтру (тегу а) срабатывает переход по ссылке, а не обработчик mSearch2. А на других контекстах - обработчик mSearch2, что приводит к применению фильтра. И этот баг вызывается только на боевом сайте (на локалке и на тестовом все работает). Данная строка помогают это исправить
        e.stopPropagation();
    });


    // -------------------------------------------
    // Сортировка фильтров - в самом верху те, у которых больше всего результатов
    // -------------------------------------------
    // Кирилл сказал отменить сортировку, поэтому я закомментировал ее вызов
    // catalogSortFilters();


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
                break;
            // По алфавиту по убыванию
            case 4:
                $elem = $('.listing__sort-item[data-sort="ms_product|pagetitle"]');
                dataDir = 'asc';
                break;
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
    getRemainder();


    // -------------------------------
    // Переключение конфликтующих фильтров: Длина, Ширина, Толщина и Размеры
    // -------------------------------
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
                dontDoAnything = true;
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


function catalogSortFilters() {
    $('.listing__filter-block').each(function (index, elem) {
        // Пропускаем фильтр по цене
        if (index === 0) {
            return;
        }

        let $this = $(this);
        let $container = $($this.find('.listing__filter-option')[0]).parent();

        let $items = $container.find('.listing__filter-option').sort(function (a, b) {
            if (isNaN(parseInt($(a).attr('data-priority')))) {
                return -1;
            }

            if (isNaN(parseInt($(b).attr('data-priority')))) {
                return 1;
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


function getRemainder() {
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


/**
 * Перенос строки в названии в чанках товаров на pro-fanera и plitaosb
 */
function wrapTitle() {
    if ($('.pro-fanera, .plitaosb').length) {
        $('.listing__products-item .listing__products-item-title a').each(function (i, e) {
            let $e = $(e);
            let text = $e.text();
            let sort = $e.closest('.listing__products-item').attr('data-sort');
            // Добавляем перенос строки после сорта
            if (sort) {
                sort = functions.escapeRegExp(sort);
                if (text.match(new RegExp(sort)) !== null) {
                    text = text.replace(new RegExp('(' + sort + ')\\s*'), '$1<br>');
                }
            }
                // Если сорта в названии нет, то перенос надо делать после названия предмета
            // Как вытащить из названия товара название продаваемого предмета? Как правило, название товара состоит из {Название предмета} {Сорт} {Размер}. Получается, перенос надо делать перед {Размер}. А размер - это следующее сочетание: числоХчисло или числоХчислоХчисло. Число может быть дробным. В качестве разделителя целой и дробной частей может быть как точка, так и запятая. В качестве разделителя чисел может быть как русская Х, так и английская X.
            else {
                text = text.replace(/(([0-9]+[.,])?[0-9]+[хx]([0-9]+[.,])?[0-9]+([хx]([0-9]+[.,])?[0-9]+)?)/, '<br>$1');
            }

            // Устанавливаем новое значение
            $e.html(text);
        });
    }
}
