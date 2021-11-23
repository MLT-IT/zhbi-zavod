import '../sass/styles.sass';
import mailChange from './modules/mailchanger';
import ImageZoom from 'js-image-zoom';
import overlayScrollbars from 'overlayscrollbars/js/jquery.overlayScrollbars.min';
import 'overlayscrollbars/css/OverlayScrollbars.min.css';

window.jQuery = $;
window.$ = $;

$(function ($) {
    // Это лучше сделать через Swiper. Пример: https://codesandbox.io/s/o0uzz?file=/index.html:8994-9227 . Но актуальных исходников нет
    $('.js-custom-scrollbar').overlayScrollbars({});

    // -------------------------------
    // Приближение при наведении на странице товара
    // -------------------------------
    const $productCardImg = $(".product-card__img");
    if ($productCardImg.length) {
        new ImageZoom($productCardImg[0], {
            fillContainer: true,
            height: 260,
            zoomWidth: 500,
            offset: {vertical: 0, horizontal: 10},
        });
    }

    // -------------------------------
    // Мини-корзина
    // -------------------------------
    function handleMiniCart(value) {
        let $cartValueElem = $('.header__cart-value');
        let cartValue;

        if (typeof value !== 'undefined') {
            cartValue = value;
            $cartValueElem.text(cartValue);
        } else {
            cartValue = parseInt($cartValueElem.text());
        }

        if (cartValue > 0) {
            $cartValueElem.removeClass('hidden');
        } else {
            $cartValueElem.addClass('hidden');
        }
    }

    handleMiniCart();

    // -------------------------------
    // Подмена Email'а
    // -------------------------------
    mailChange();

    // -------------------------------
    // Фильтрация ввода
    // -------------------------------
    /*
     * Фильтрация ввода.
     * Взял отсюда и немного улучшил:
     * https://stackoverflow.com/questions/995183/how-to-allow-only-numeric-0-9-in-html-inputbox-using-jquery
     */
    let methods = {
        // Отмена плагина
        destroy: function () {
            return this.each(function () {
                let $this = $(this);

                // Убираем обработчики
                $this.off($this.data(pluginName).events);

                // Удаляем data-значения
                $this.removeData(pluginName);
            });
        },

        // Инициализация
        init: function (func) {
            return this.each(function () {
                let $this = $(this);

                // -----------
                // Установка переменных и data-значений
                // -----------
                let events = 'change input keydown keyup mousedown mouseup select contextmenu drop';
                let events_array = events.split(' ')
                for (let i = 0; i < events_array.length; i++) {
                    events_array[i] += '.' + pluginName;
                }
                events = events_array.join(' ');

                $this.data(pluginName, {});
                $this.data(pluginName).init = true;
                $this.data(pluginName).events = events;

                // -----------
                // Функционал плагина
                // -----------
                $this[0].oldValue = $this[0].value;
                $this[0].oldSelectionStart = $this[0].selectionStart;
                $this[0].oldSelectionEnd = $this[0].selectionEnd;

                $this.on(events, function () {
                    if (func(this.value)) {
                        this.oldValue = this.value;
                        this.oldSelectionStart = this.selectionStart;
                        this.oldSelectionEnd = this.selectionEnd;
                    } else if (this.hasOwnProperty("oldValue")) {
                        this.value = this.oldValue;
                        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
                    }
                });
            });
        }
    }

    // Логика вызова функций
    let pluginName = 'inputFilter';

    $.fn.inputFilter = function (method) {
        if (methods[method]) {
            // ----------------------------------
            // Проверка на вызов функции у неициниализированного элемента
            // ----------------------------------
            this.each(function () {
                let $this = $(this);
                if (!$this.data(pluginName) || $this.data(pluginName).init !== true) {
                    $.error('Не удалось произвести действие, поскольку для одного из элементов в выборке не инициализирован jQuery.' + pluginName + '.');
                }
            });

            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'function') {
            // ----------------------------------
            // Проверка на повторную инициализацию
            // ----------------------------------
            this.each(function () {
                let $this = $(this);
                if ($this.data(pluginName) && $this.data(pluginName).init === true) {
                    $this[pluginName]('destroy');
                }
            });

            return methods.init.apply(this, arguments);
        } else {
            $.error('Функция с именем ' + method + ' не существует для jQuery.' + pluginName + '.');
        }
    }

    // -------------------------------
    // Стилизованный счетчик
    // -------------------------------
    let $counterInput = $('.custom-counter__amount');

    $counterInput.inputFilter(function (value) {
        return /^(0|[1-9][0-9]{0,})$/.test(value) && (parseInt(value) > 0);
    });

    $('.custom-counter__btn').on('click', function (e) {
        e.preventDefault();
        let $this = $(this);
        let $inputValue = $this.closest('.custom-counter').find('.custom-counter__amount');

        let val = parseInt($inputValue.val());
        switch (true) {
            case $this.hasClass('custom-counter__btn_dir_less'):
                val--;
                break;
            case $this.hasClass('custom-counter__btn_dir_more'):
                val++;
                break;
        }
        $inputValue.val(val);

        $inputValue.trigger('change');
        $this.closest('.cart-table__form').find('.btn-sm').click();
    });

    // TODO: этот код лучше перенести в change от Minishop2. И на monolit78 также.
    let pageCart = $('.sect-cart').length;
    if (pageCart) {
        $counterInput.each(function () {
            $(this).on('change', function () {
                let $this = $(this);
                let $product = $this.closest('.cart-table__table-row_type_product');
                let price = $product.find('.cart-table__price-value').text();
                price = parseFloat(price.replace(/\s/, ''));
                let count = parseInt($product.find('.custom-counter__amount').val());
                let cost = (price * count).toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
                $product.find('.cart-table__sum-value').text(cost);
            });
        });
    }

    // -------------------------------
    // Меню
    // -------------------------------
    // На ПК
    // $('.header__catalog').on('click', function(e) {
    //     e.preventDefault();
    //     $(this).toggleClass('opened');
    // });

    // На телефонах
    $('.header__burger').on('click', function (e) {
        e.preventDefault();
        let $this = $(this);
        $this.toggleClass('opened');
        $this.closest('.header__wrapper').find('.header__nav').toggleClass('opened');
    });

    // -------------------------------
    // Звездочки во всплывашке для рейтинга
    // -------------------------------
    $('.popup-reviews__stars svg').on('click', function (e) {
        e.preventDefault();

        $('.popup-reviews__stars svg').removeClass('active');

        let $this = $(this);
        $this.addClass('active');
    });

    // -------------------------------
    // Щелчок по якорю "Отзывы"
    // -------------------------------
    $('.product-card__reviews-quantity').on('click', function (e) {
        e.preventDefault();

        $('.product-card__tabs-button_type_reviews').trigger('click');

        $([document.documentElement, document.body]).animate({
            scrollTop: $(".product-card__tabs").offset().top
        }, 300);
    });

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
            case 1:
                $elem = $('.listing__sort-item[data-sort="ms|price"]');
                dataDir = 'asc';
                break;
            // По цене по убыванию
            case 2:
                $elem = $('.listing__sort-item[data-sort="ms|price"]');
                dataDir = 'desc';
                break;
            // По популярности по убыванию
            case 3:
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
    // Обработчики Minishop2
    // -------------------------------
    // Добавление товара в корзину
    miniShop2.Callbacks.Cart.add.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count);
        }
    }

    // Удаление товара из корзины
    miniShop2.Callbacks.Cart.remove.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count);
        }
    }

    // Изменение товара в корзине
    miniShop2.Callbacks.Cart.change.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count);
        }
    }

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
    // Вкладки на мобилках
    // -------------------------------
    // Расставляем data-tab-page. Он нужен для кода в base.js. Это не только для мобилов, но и для ПК. Важно делать это через JS, т.к. некоторые вкладки могут не выводиться. А index должен быть по порядку
    $('.product-card__tabs-button').each(function(i, e) {
        $(this).attr('data-tab-page', i);
    });

    // Обработчик
    $('.product-card__mobile-tabs-button').on('click', function (e) {
        e.preventDefault();
        let $this = $(this);
        let $tabsPage = $this.closest('.product-card__tabs-page');

        $('.product-card__tabs-page.active').removeClass('active');
        $this.closest('.product-card__tabs-page').addClass('active');

        let index = $tabsPage.index() + 1;
        $('.product-card__tabs-button.active').removeClass('active');
        $('.product-card__tabs-button:nth-child(' + index + ')').addClass('active');
    });
});

