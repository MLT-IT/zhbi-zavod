// Стили
import '../sass/styles.sass';

// Библиотеки
import ImageZoom from 'js-image-zoom';
import overlayScrollbars from 'overlayscrollbars/js/jquery.overlayScrollbars.min';
import 'overlayscrollbars/css/OverlayScrollbars.min.css';
import euv_custom_select from '../libs/euv_custom_select/js/euv_custom_select';
import Cookies from 'js-cookie';

// Модули
import mailChange from './modules/mailchanger';
import initDistrictsMap from './modules/districts_map';
import mapsLazyload from './modules/lazyload_maps';
import add_cover_to_map from './modules/maps';

window.jQuery = $;
window.$ = $;

// Функции
import functions from './functions/functions.js';
import funcsProduct from './functions/funcsProduct.js';
import funcsCatalog from './functions/funcsCatalog.js';
import funcsFavAndComp from './functions/funcsFavAndComp';
import inputFilter from './functions/inputFilter.js';

// Замена сообщения о ненайденных результатах на странице каталога. Другого способа разделить сообщения mFilter2 и mSearch2, который не сбросится при обновлении / переустановке плагина, я не нашел. Код написан вверху и без jQuery, чтобы работать быстрее.
let elem = document.querySelector('.listing__content .msearch2message');
if (elem !== null) {
    elem.innerHTML = 'Подходящих результатов не найдено.';
}

$(function ($) {
    funcsCatalog();
    funcsProduct(ImageZoom, functions.formOfWord, functions.getActiveUnitValue, functions.numberWithSpaces);
    funcsFavAndComp(Cookies, functions.trim, functions.formOfWord);


    // -------------------------------
    // Меню на ПК
    // -------------------------------
    $('.header__catalog').on('click', function (e) {
        let $target = $(e.target);
        if (!$target.closest('.header__catalog-menu').length) {
            $(this).toggleClass('hover');
        }
    });

    $(document).on('click', function (e) {
        let $target = $(e.target);

        if (!$target.hasClass('header__catalog') && !$target.closest('.header__catalog').length) {
            $('.header__catalog.hover').removeClass('hover');
        }
    });


    // -------------------------------
    // Меню на мобилках
    // -------------------------------
    $('.header__mobile-menu-link').on('click', function (e) {
        e.preventDefault();

        let $this = $(this);
        let $headerNav = $this.closest('.header__nav-contents-wrap');

        $headerNav.addClass('fade');
        setTimeout(function () {
            $this.closest('.header__nav-content.active').removeClass('active');
            $this.closest('.header__nav-contents-wrap').find('.header__nav-content[data-key="' + $this.attr('data-key') + '"]').addClass('active');
            $headerNav.removeClass('fade');
        }, 300);
    });


    // -------------------------------
    // Запрет прокрутки карты до клика
    // -------------------------------
    let $map_containers = $('.map__container');
    $map_containers.each((idx, map_container) => {
        add_cover_to_map(map_container);
    });


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
    // Из какой формы отправили? Это костыль. По-хорошему надо делать через api fancybox. Но fancybox минифицирован
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
    // Подмена Email'а
    // -------------------------------
    mailChange();


    // -------------------------------
    // Работа со страницей товара на кровле
    // -------------------------------
    if ($('.product-card_type_relinking').length) {
        let $select = $('.product-card_type_relinking .euv-custom-select');

        $select.on('click', function () {
            let plugin_name = 'euv_custom_select';
            let custom_select_visible_class = 'euv-custom-select_visible';
            let custom_select_option_class = 'euv-custom-select__option';
            let custom_select_class = 'euv-custom-select';
            function close_select(e) {
                let $target = $(e.target);
                let $target_select = $target.closest('.' + custom_select_class);
                $('.' + custom_select_visible_class).each(function () {
                    let $this = $(this);
                    if ($this[0] != $target_select[0] || $target.hasClass(custom_select_option_class)) {
                        if ($('.' + custom_select_visible_class).length < 2) {
                            $(document).off('click.' + plugin_name, close_select);
                        }
                        $this.removeClass(custom_select_visible_class);
                    }
                });
            }

            let $this = $(this);
            $this.toggleClass(custom_select_visible_class);
            if ($this.hasClass('euv-custom-select_visible')) {
                $(document).off('click.' + plugin_name, close_select);
                $(document).on('click.' + plugin_name, close_select);
            } else {
                $(document).off('click.' + plugin_name, close_select);
            }
        });

        // -------------------------------
        // Стилизованный список на странице товара для кровли
        // -------------------------------
        $select.each(function () {
            let $this = $(this);
            let $scroll = $this.find('.euv-custom-select__options-wrap-scroll');

            $scroll.overlayScrollbars({});

            let $selectColors = $('.colors-options');
            $selectColors.on('change', selectColorsOnChange);
            function selectColorsOnChange(elem) {
                let $this = $(elem.target);
                let $parent = $this.closest('.euv-custom-select');
                let val = $parent.find('.euv-custom-select__selected-option').attr('data-val');
                $parent.find('.euv-custom-select__input-value').attr('data-val', val);
            }
            $selectColors.on('euv_custom_select_init', function () {
                selectColorsOnChange({target: $selectColors[0]});
            });
        });

        // -------------------------------
        // Мобильный стилизованный список на странице товара для кровли
        // -------------------------------
        $('.custom-select-mobile-link').on('click', function () {
            // Основные переменные
            let $popup = $('.popup-select');
            let $customSelectWrap = $(this).closest('.custom-select-wrap');
            let $children = $customSelectWrap.find('.os-content .euv-custom-select__option');

            // Очистка от предыдущего использования
            $popup.html('');
            $popup.removeClass('colors-options');

            // Добавление класса для отображения цветов
            if ($customSelectWrap.find('.colors-options').length) {
                $popup.addClass('colors-options');
            }

            // Добавление item'ов
            $children.each(function () {
                // Основные переменные
                let $item = $('<a href="#" class="popup-select__item euv-custom-select__option"></a>');
                let $child = $(this);

                // Установка текста
                $item.text($child.text());
                // Установка href
                $item.attr('href', $child.attr('href'));
                // Установка атрибут для цвета
                $item.attr('data-val', $child.attr('data-val'));

                // Добавление обработчика
                $item.on('click', function (e) {
                    // Закрываем всплывашку
                    // $('.popup-select .fancybox-button').click();
                });

                // Добавление айтема во всплывашку
                $item.appendTo($popup);
            });
        });
    }


    // -------------------------------
    // Стилизованный счетчик и стилизованный список
    // -------------------------------
    // Я объявил эту функцию в window, поскольку ее надо вызывать при событии mse2_load, а это событие в другом файле
    window.initStyledCounter = function initStyledCounter() {
        $('.not-init.listing__products-item, .product-card .product-item, .cart-table__table-row_type_product').each(function () {
            // Основные переменные
            let $item = $(this);
            let $counterInput = $item.find('.custom-counter__amount');

            // Инициализируем стилизованный список
            $item.find('.custom-select').euv_custom_select();

            // ---------------------------------------
            // Если находимся в кирпичах, то...
            // ---------------------------------------
            if ($('body.kirpich-m').length && $item.attr('data-on_pallet')) {
                // Устанавливаем data-step. Вешаем обработчик на смену единиц измерения для изменения data-step
                setStep($item);

                $item.on('changeUnit', function () {
                    setStep($item);
                });
            }
            // ---------------------------------------

            // Инициализируем фильтры для счетчика
            $counterInput.each(function () {
                let filter;
                const $this = $(this);
                const minVal = parseFloat($this.attr('data-min'));

                // Фильтр для изменения значения
                let regexp = /^(0|[1-9][0-9]{0,})$/;
                if ($this.closest('.custom-counter_type_fractional').length) {
                    regexp = /^((0|[1-9][0-9]{0,})(\.[0-9]{0,2}){0,1})$/;
                }
                if (!isNaN(minVal)) {
                    filter = function (value) {
                        return regexp.test(value) && (parseFloat(value) >= minVal);
                    };
                } else {
                    filter = function (value) {
                        return regexp.test(value);
                    };
                }
                $this.inputFilter(filter);

                // Фильтр для ввода значения
                $this.inputFilter(function (value) {
                    return regexp.test(value);
                }, {'event': 'input'});
            });

            // Обработчик кнопок стилизованного счетчкика
            $item.find('.custom-counter__btn').on('click', function (e) {
                e.preventDefault();

                // Основные переменные
                let $this = $(this);
                let $counter = $this.closest('.custom-counter');
                let $inputValue = $counter.find('.custom-counter__amount');

                // Получение step
                let step = 1;
                let dataStep = $item.attr('data-step');
                if (typeof dataStep !== 'undefined') {
                    dataStep = parseFloat(dataStep);
                    if (!isNaN(dataStep) && dataStep > 0) {
                        step = dataStep;
                    } else {
                        console.error('Ошибка при получении data-step');
                    }
                }

                // Установка val
                let val = parseInt($inputValue.val());
                val = Math.ceil(val / step);
                switch (true) {
                    case $this.hasClass('custom-counter__btn_dir_less'):
                        val -= 1;
                        break;
                    case $this.hasClass('custom-counter__btn_dir_more'):
                        val += 1;
                        break;
                }
                val = val * step;
                $inputValue.val(val);
                $inputValue.trigger('change');

                // Если кнопка находится в карточке товара корзины, то отправляем форму (кликаем по кнопке для отправки формы)
                $this.closest('.cart-table__table-row').find('.btn-sm').click();
            });

            // Если находимся на странице корзины, то вешаем дополнительный обработчик на change количества, чтобы менялась сумма корзины (она должна перерасчитываться сама, но почему-то этого не происходит)
            if ($('.sect-cart').length) {
                $counterInput.each(function () {
                    $(this).on('change', function () {
                        let $this = $(this);
                        let $product = $this.closest('.cart-table__table-row_type_product');
                        let price = $product.find('.cart-table__price-value').text();
                        price = parseFloat(price.replace(/\s/, ''));

                        let count = $product.find('.custom-counter__amount').val();
                        count = parseFloat(count.replace(/\s/g, ''));
                        count = Number((count).toFixed(2));

                        let cost = functions.numberWithSpaces(price * count);
                        $product.find('.cart-table__sum-value').text(cost);
                    });
                });
            }

            // Удаляем у чанка класс о том, что чанк еще не инициализирован
            $item.removeClass('not-init');
        });
    };
    window.initStyledCounter();

    function setStep($e) {
        let onPallet = parseFloat($e.attr('data-on_pallet'));
        if (isNaN(onPallet) || onPallet === 0) {
            onPallet = 1;
        }

        let unitVal = functions.getActiveUnitValue($e);
        let step;

        if (unitVal === 1) {
            step = onPallet * unitVal;
        } else {
            step = Math.ceil(onPallet / unitVal);
        }

        $e.attr('data-step', step);
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
    // faq
    // -------------------------------
    $('.questions__item-top').on('click', function (e) {
        e.preventDefault();
        $(this).parent().toggleClass('active');
    });

    $('.questions__btn-more').on('click', function (e) {
        e.preventDefault();
        const $this = $(this);
        $this.parent().find('.questions__list-hidden').slideToggle();
        $this.remove();
    });

});

