// Стили
import '../sass/styles.sass';

// Библиотеки
import ImageZoom from 'js-image-zoom';
import overlayScrollbars from 'overlayscrollbars/js/jquery.overlayScrollbars.min';
import 'overlayscrollbars/css/OverlayScrollbars.min.css';
import euv_custom_select from '../libs/euv_custom_select/js/euv_custom_select';

// Модули
import mailChange from './modules/mailchanger';
import initDistrictsMap from './modules/districts_map';
import mapsLazyload from './modules/lazyload_maps'

window.jQuery = $;
window.$ = $;

// TODO: лучше сделать все через модули webpack

$(function ($) {
    // -------------------------------
    // euv-custom-select
    // -------------------------------
    $('.custom-select').euv_custom_select();

    // -------------------------------
    // Вспомогательные функции
    // -------------------------------
    // Склонение по числам
    function formOfWord(n, f1, f2, f5) {
        n = Math.abs(parseInt(n)) % 100;
        if (n > 10 && n < 20) {
            return f5;
        }
        n = n % 10;
        if (n > 1 && n < 5) {
            return f2;
        }
        if (n === 1) {
            return f1;
        }

        return f5;
    }

    // Разделить тысячные пробелами
    function numberWithSpaces(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
    }

    // Получить значение активного unit
    function getActiveUnitValue($productItem) {
        // Все единицы измерения
        let unitValues = {
            '1': 1,
            '2': $productItem.attr('data-m2'),
            '3': $productItem.attr('data-m3')
        };

        // Обработка кол-ва единиц измерения
        for (let key in unitValues) {
            unitValues[key] = parseFloat(unitValues[key]);
            if (isNaN(unitValues[key])) {
                unitValues[key] = 0;
            }
        }

        const unit = $productItem.find('*[name="unit"]').val();

        return unitValues[unit];
    }

    // Рассчет кол-ва при добавлении товара в корзину
    function getItemCount($productItem, count) {
        let unitVal = getActiveUnitValue($productItem);

        // Получившееся кол-во
        count = Math.ceil(unitVal * count);

        // Результат
        return count;
    }

    // -------------------------------
    // Вкладки
    // -------------------------------
    $('.js-tabs').each(function () {
        let $this = $(this);
        let $headers = $this.find('.js-tabs-header');
        $headers.on('click', function (e) {
            e.preventDefault();
            $this.find('.js-tabs-content, .js-tabs-header').removeClass('active');

            let $header = $(this);
            $header.addClass('active');
            let tab = $header.attr('data-tab');
            $this.find('.js-tabs-content[data-tab="' + tab + '"]').addClass('active');
        });
    });

    // -------------------------------
    // Скрыть / показать кнопки слайдера
    // -------------------------------
    $('.swiper-buttons').each(function () {
        let $this = $(this);
        let $sliders = $(this).parent().find('.swiper-wrapper').find('.swiper-slide');
        if ($sliders.length > 4) {
            $this.show();
        }
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
    // Из какой формы отправили? Это костыль. Данные будут неверными, если отправлять не из всплывашек. Но на сайте нет форм без всплывашек. По-хорошему надо делать через api fancybox. Но fancybox минифицирован
    // -------------------------------
    window.currentPopupKey = '';
    $('[href]').on('click', function () {
        let $this = $(this);
        if ($this.attr('href') === 'javascript:;') {
            return;
        }

        window.currentPopupKey = '';

        let key = $this.attr('data-btn-key');
        if (key) {
            window.currentPopupKey = key;
        }
    });

    // -------------------------------
    // Яндекс карты
    // -------------------------------
    window.initDistrictsMap = initDistrictsMap;
    mapsLazyload();

    // -------------------------------
    // Стилизованный скроллбар
    // -------------------------------
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
    function handleMiniCart(count, cost) {
        const $cartValueElem = $('.header__cart-value');
        const $cartInfoCountVal = $('.header__info-val_type_count-val');
        const $cartInfoCountText = $('.header__info-val_type_count-text');
        const $cartInfoCostVal = $('.header__info-val_type_cost-val');

        let cartValue;
        if (typeof count !== 'undefined') {
            cartValue = count;
            $cartValueElem.add($cartInfoCountVal).text(cartValue);
            $cartInfoCountText.text(formOfWord(cartValue, 'товар', 'товара', 'товаров'));
        } else {
            cartValue = parseInt($cartValueElem.text());
        }

        let cartCost;
        if (typeof cost !== 'undefined') {
            cartCost = numberWithSpaces(cost);
            $cartInfoCostVal.text(cartCost);
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
    window.initStyledCounter = function initStyledCounter() {
        let $counterInput = $('.custom-counter__amount');

        $counterInput.each(function () {
            let filter;
            const $this = $(this);
            const minVal = parseInt($this.attr('data-min'));

            if (!isNaN(minVal)) {
                filter = function (value) {
                    return /^(0|[1-9][0-9]{0,})$/.test(value) && (parseInt(value) >= minVal);
                }
            } else {
                filter = function (value) {
                    return /^(0|[1-9][0-9]{0,})$/.test(value);
                }
            }

            $this.inputFilter(filter);
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
            // Если мы находимся в корзине, то вызываем change
            $this.closest('.cart-table__form').find('.btn-sm').click();
        });

        // TODO: Возможно, этот код лучше перенести в change от Minishop2. И на monolit78 также.
        let pageCart = $('.sect-cart').length;
        if (pageCart) {
            $counterInput.each(function () {
                $(this).on('change', function () {
                    let $this = $(this);
                    let $product = $this.closest('.cart-table__table-row_type_product');
                    let price = $product.find('.cart-table__price-value').text();
                    price = parseFloat(price.replace(/\s/, ''));
                    let count = parseInt($product.find('.custom-counter__amount').val());
                    let cost = numberWithSpaces(price * count);
                    $product.find('.cart-table__sum-value').text(cost);
                });
            });
        }
    }
    window.initStyledCounter();


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
            case 3:
                $elem = $('.listing__sort-item[data-sort="ms|price"]');
                dataDir = 'asc';
                break;
            // По цене по убыванию
            case 2:
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
    // Обработчик списка для смены ед. измерения
    // -------------------------------
    $(document).on('change', '.product-item__units-select', function (e) {
        e.preventDefault();
        let $productItem = $(this).closest('.product-item');
        let unitValue = getActiveUnitValue($productItem);

        // Изменение цены
        const $price = $productItem.find('.product-item__price');
        if ($price.length) {
            let price = parseFloat($price.attr('data-default').replace(/\s/g, ''));
            if (isNaN(price)) {
                price = 0;
            }

            price = numberWithSpaces(Math.ceil(1 / unitValue * price));
            $price.text(price);
        }
    });

    // -------------------------------
    // Обработчик счетчика на карточках товара. Вызывается при изменении кол-ва товара с карточки товара и со страницы товара
    // -------------------------------
    $(document).on('change', '.custom-counter__amount', function (e) {
        e.preventDefault();

        // -------------------------------------------
        // Установка основных переменных и проверка, выполняться ли дальше скрипту или нет
        // -------------------------------------------
        let $this = $(this);
        let $productItem = $this.closest('.product-item');

        if (!$productItem.length) {
            return;
        }

        let key = $productItem.attr('data-key'); // Ключ. Нужно для правильной работы Minishop2
        if (!key.length) {
            return;
        }

        let ctx = $('body').attr('data-ctx'); // Нужно для правильной работы Minishop2
        let sendingData; // Массив с отправляемыми данными
        let count = $this.val(); // Кол-во товара

        // -------------------------------------------
        // Рассчет кол-ва
        // -------------------------------------------
        count = getItemCount($productItem, count);

        // -------------------------------------------
        // ajax
        // -------------------------------------------
        sendingData = {
            action: 'cart/change',
            count: count,
            key: key,
            ctx: ctx
        }

        $.ajax({
            method: "POST",
            dataType: "json",
            url: window.location.origin + '/assets/components/minishop2/action.php',
            data: sendingData,
            success: function (data) {
                if (data.success) {
                    handleMiniCart(data.data.total_count, data.data.total_cost);

                    if (count <= 0) {
                        $productItem.find('.product-item__controls').hide();
                        $productItem.find('.product-item__form').show();
                        // trigger change нужен, чтобы фильтр запомнил текущее значение. И потом, если пользователь установит меньше минимального, подставится 1
                        $productItem.find('.product-item__form .custom-counter__amount').val(1).trigger('change');
                    }

                    miniShop2.Message.success(data.message);
                }
            }
        });
    });

    // -------------------------------
    // Обработчики Minishop2
    // -------------------------------
    // Добавление товара в корзину. Вызывается при добавлении товара в корзину с карточки товара и со страницы товара
    miniShop2.Callbacks.Cart.add.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count, response.data.total_cost);

            // Если это не внутри карточки, то выходим из функции
            let $item = this.sendData.$form.closest('.product-item');
            if (!$item.length) {
                return;
            }

            // Устанавливаем значение для поля с количеством
            let val = parseInt($item.find('.product-item__form .custom-counter__amount').val());
            if (isNaN(val)) {
                val = 0;
            }
            $item.find('.product-item__controls .custom-counter__amount').val(val);

            // Меняем видимость
            $item.find('.product-item__form').hide();
            $item.find('.product-item__controls').show();
        }
    }

    // Удаление товара из корзины. Вызывается при нажатии на крестик на странице корзины
    miniShop2.Callbacks.Cart.remove.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count, response.data.total_cost);
        }
    }

    // Изменение товара в корзине. Вызывается при изменении кол-ва товара на странице корзины
    miniShop2.Callbacks.Cart.change.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count, response.data.total_cost);
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
    // Расставляем data-tab-page. Он нужен для кода в base.js. Это не только для мобилок, но и для ПК. Важно делать это через JS, т.к. некоторые вкладки могут не выводиться. А index должен быть по порядку
    $('.product-card__tabs-button').each(function (i, e) {
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

