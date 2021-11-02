import '../sass/styles.sass'
import mailChange from './modules/mailchanger';

window.jQuery = $;
window.$ = $;

$(function ($) {
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
        return /^(0|[1-9][0-9]{0,})$/.test(value);
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
    // Обработчик счетчика на карточках товара
    // -------------------------------
    $(document).on('change', '.custom-counter__amount', function (e) {
        e.preventDefault();

        let $this = $(this);
        let $productItem = $this.closest('.product-item');

        if (!$productItem.length) {
            return;
        }

        let key = $productItem.attr('data-key');
        if (!key.length) {
            return;
        }

        let sendingData;
        let val = $this.val();
        if (val <= 0) {
            // TODO: можно это убрать. change 0 и так работает, как remove
            sendingData = {
                action: 'cart/remove'
            }
        } else {
            sendingData = {
                action: 'cart/change',
                count: val
            }
        }

        sendingData.key = key;

        $.ajax({
            method: "POST",
            dataType: "json",
            url: window.location.origin + '/assets/components/minishop2/action.php',
            data: sendingData,
            success: function (data) {
                if (data.success) {
                    handleMiniCart(data.data.total_count);

                    if (sendingData.action === 'cart/remove') {
                        $productItem.find('.product-item__products-item-controls').hide();
                        $productItem.find('.product-item__to-cart').show();
                    }

                    miniShop2.Message.success(data.message);
                }
            }
        });
    });

    // -------------------------------
    // Обработчики Minishop2
    // -------------------------------
    // Добавление товара в корзину
    miniShop2.Callbacks.Cart.add.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count);

            // Работа с кнопкой
            let $item = this.sendData.$form.closest('.product-item');

            let val = parseInt($item.find('.custom-counter__amount').val());
            if (isNaN(val)) {
                val = 0;
            }
            val++;
            $item.find('.custom-counter__amount').val(val);

            $item.find('.listing__products-item-button').hide();
            $item.find('.product-item__products-item-controls').show();
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
});

