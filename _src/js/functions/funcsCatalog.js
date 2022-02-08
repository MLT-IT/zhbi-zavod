/**
 * Функции, относящиеся к каталогу (в основном работа с mFilter2).
 */
export default function funcsCatalog() {
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
        let amount = $('#mse2_mfilter .product-item').length;
        if (typeof mSearch2 !== 'undefined' && mSearch2 && amount) {
            let total = parseInt(mSearch2.total.text());
            let remainder = 0;

            if (total > amount) {
                remainder = total - amount;
            }
            if (remainder > 42) {
                remainder = 42;
            }
            $('#mse2_mfilter .btn_more').text('Показать еще ' + remainder);
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


    // -------------------------------
    // Только отличающиеся
    // -------------------------------
    // TODO: сделай обновление слайдера. чтобы скроллбар был
    // TODO: только отличающиеся - сделай так, чтобы изменялся текст в h1
    if ($('.sect-comparison').length) {
        $('.custom-toggler__input').on('change', function () {
            let $toggler = $(this);
            if ($toggler.is(':checked')) {
                // Составляем массив из опций каждого товара
                let items = [];
                $('.product-item').each(function () {
                    let $this = $(this);
                    items[$this.find('[name="id"]').val()] = [];
                    $this.find('.pop-slide__option').each(function () {
                        let $opt = $(this);
                        let key = ($opt.find('.pop-slide__option-caption').html()).trim();
                        let val = ($opt.find('.pop-slide__option-value').html()).trim();
                        items[$this.find('[name="id"]').val()][key] = val;
                    });
                });

                // Сравниваем товары и ищем одинаковые
                let sameProducts = [];
                items.forEach(function (value1, index1) {
                    items.forEach(function (value2, index2) {
                        if (index2 <= index1) {
                            return;
                        }

                        if (checkSameness(value1, value2) === true) {
                            sameProducts.push(index1);
                        }
                    });
                });

                // Оставляем только уникальные
                sameProducts = sameProducts.filter((value, index, self) => {
                    return self.indexOf(value) === index;
                });

                sameProducts.forEach(function (value, index1) {
                    $('[name="id"][value="' + value + '"]').closest('.pop-slide').addClass('hidden');
                });
            } else {
                $('.pop-slide').removeClass('hidden');
            }
        });
    }

    /**
     * Функция проверяет, являются ли объекты одинаковыми? Если да, то возвращает true. В противном случае false.
     * @param obj1
     * @param obj2
     */
    function checkSameness(obj1, obj2) {
        if (Object.keys(obj1).length !== Object.keys(obj2).length) {
            return false;
        }

        for (let key in obj1) {
            if (typeof obj2[key] === 'undefined') {
                return false;
            }

            if (obj1[key] !== obj2[key]) {
                return false;
            }
        }

        return true;
    }

}
