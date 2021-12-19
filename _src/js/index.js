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

// Функции
import functions from './functions/functions.js';
import funcsProduct from './functions/funcsProduct.js';
import funcsCatalog from './functions/funcsCatalog.js';
import inputFilter from './functions/inputFilter.js';

$(function ($) {
    funcsProduct();
    funcsCatalog();

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
    // Кнопка корзины
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
            $cartInfoCountText.text(functions.formOfWord(cartValue, 'товар', 'товара', 'товаров'));
        } else {
            cartValue = parseInt($cartValueElem.text());
        }

        let cartCost;
        if (typeof cost !== 'undefined') {
            cartCost = functions.numberWithSpaces(cost);
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
    // Стилизованный счетчик и стилизованный список
    // -------------------------------
    // Я объявил эту функцию в window, поскольку ее надо вызывать при событии mse2_load, а это событие в другом файле
    window.initStyledCounter = function initStyledCounter() {
        $('.custom-select').euv_custom_select();

        let $counterInput = $('.custom-counter__amount');
        // Фильтр для ввода
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

        // Кнопки стилизованного счетчкика
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

            // Если мы находимся в корзине, то отправляем форму (кликаем по кнопке для отправки формы)
            $this.closest('.sect-cart').find('.btn-sm').click();
        });

        // Если находимся на странице корзины, то вешаем дополнительный обработчик на change количества, чтобы менялась сумма корзины (она должна перерасчитываться сама, но почему-то этого не происходит)
        if ($('.sect-cart').length) {
            $counterInput.each(function () {
                $(this).on('change', function () {
                    let $this = $(this);
                    let $product = $this.closest('.cart-table__table-row_type_product');
                    let price = $product.find('.cart-table__price-value').text();
                    price = parseFloat(price.replace(/\s/, ''));
                    let count = parseInt($product.find('.custom-counter__amount').val());
                    let cost = functions.numberWithSpaces(price * count);
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
    // Обработчик списка для смены ед. измерения
    // -------------------------------
    $(document).on('change', '.product-item__units-select', function (e) {
        e.preventDefault();
        let $productItem = $(this).closest('.product-item');
        let unitVal = functions.getActiveUnitValue($productItem);

        // Изменение цены
        const $price = $productItem.find('.product-item__price');
        if ($price.length) {
            let price = parseFloat($price.attr('data-default').replace(/\s/g, ''));
            if (isNaN(price)) {
                price = 0;
            }

            price = functions.numberWithSpaces(Math.ceil(1 / unitVal * price));
            $price.text(price);
        }
    });

    // -------------------------------
    // Обработчик счетчика на карточках товара. Вызывается при изменении кол-ва товара с карточки товара и со страницы товара
    // -------------------------------
    // TODO: лучше это переписать. Делать trigger submit скрытой формы minishop2
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
        count = functions.getItemCount($productItem, count);

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

            checkCart(response.data.total_cost);
        }
    }

    // Изменение товара в корзине. Вызывается при изменении кол-ва товара на странице корзины
    miniShop2.Callbacks.Cart.change.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count, response.data.total_cost);

            checkCart(response.data.total_cost);
        }
    }

    function checkCart(total_count) {
        // Если товаров в корзине 0. И если мы на странице корзины. То перезагружаем страницу
        if (total_count === 0 && $('.sect-cart').length) {
            location.reload();
        }
    }

});

