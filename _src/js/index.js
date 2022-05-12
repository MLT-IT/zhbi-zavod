// -------------------------------------
// Стили
// -------------------------------------
// Стили библиотек
import '@fancyapps/fancybox/dist/jquery.fancybox.min.css';
import 'swiper/swiper-bundle.min.css';
import 'animate.css';
// Стили сайта
import '../sass/styles.sass';


// -------------------------------------
// Библиотеки (в основном из node_modules)
// -------------------------------------
import Inputmask from 'inputmask';
import LazyLoad from "vanilla-lazyload";
import '@fancyapps/fancybox';
import ImageZoom from 'js-image-zoom';
import overlayScrollbars from 'overlayscrollbars/js/jquery.overlayScrollbars.min'; // Эта библиотека не вызывается (PHPStorm подсвечивает ее серым, как неиспользуемую), но она используется - просто для ее работы достаточно подключить ее в JS, вызывать не надо
import 'overlayscrollbars/css/OverlayScrollbars.min.css';
import euv_custom_select from '../libs/euv_custom_select/js/euv_custom_select';
import Cookies from 'js-cookie';


// -------------------------------------
// Самописные модули на JS
// -------------------------------------
import './modules/sliders.js';
import initTabs from './modules/tabs.js';
import mailChange from './modules/mailchanger';
import initDistrictsMap from './modules/districts_map';
import mapsLazyload from './modules/lazyload_maps';
import add_cover_to_map from './modules/maps';
import modxJS from './modxJS';


// -------------------------------------
// Подключение JQuery
// -------------------------------------
window.jQuery = $;
window.$ = $;


// -------------------------------------
// Импорт функций на JQuery
// -------------------------------------
import functions from './functions/functions.js';
import funcsProduct from './functions/funcsProduct.js';
import funcsCatalog from './functions/funcsCatalog.js';
import funcsFavAndComp from './functions/funcsFavAndComp';
import inputFilter from './functions/inputFilter.js';


// -------------------------------------
// Основной код файла
// -------------------------------------
// Замена сообщения о ненайденных результатах на странице каталога. Другого способа разделить сообщения mFilter2 и mSearch2, который не сбросится при обновлении / переустановке плагина, я не нашел. Код написан вверху и без jQuery, чтобы работать быстрее.
let elem = document.querySelector('.listing__content .msearch2message');
if (elem !== null) {
    elem.innerHTML = 'Подходящих результатов не найдено.';
}

$(function ($) {
    // Код с обработчиками MODX
    modxJS();

    // Lazyload для картинок
    let lazyLoadInstance = new LazyLoad();

    // Inputmask для ввода номера телефона
    let im = new Inputmask("+7 (999) 999-99-9{2,3}");
    im.mask(document.querySelectorAll('input[name="PHONE"]'));

    // Инициализация табов
    initTabs();


    // -------------------------------------
    // Функции страниц на JQuery
    // -------------------------------------
    // Функции для каталога
    funcsCatalog();

    // Функции для карточки товара
    funcsProduct(ImageZoom, functions.formOfWord, functions.getActiveUnitValue, functions.numberWithSpaces, functions.getActiveForm, functions.getStep, functions.getCorrectValueToCounter);

    // Функции для избранного и сравнения
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
        $('.not-init.listing__products-item, .product-card .js-product, .cart-table__table-row_type_product').each(function () {
            // Основные переменные
            let $item = $(this);
            let $counterInput = $item.find('.custom-counter__amount');

            // Инициализируем стилизованный список для смены единиц измерения
            let $select = $item.find('select.custom-select');
            $select.euv_custom_select();
            $select.on('beforeChange.euv_custom_select', function () {
                $item.attr('data-last-unit-value', functions.getActiveUnitValue($item));
            });

            if (!$item.hasClass('cart-table__table-row_type_product')) {
                // Вешаем обработчик на смену единицы измерения - менять шаг и кол-во
                $item.on('changeUnit', function (e) {
                    setStepAndAmount($item, !$item.hasClass('js-product-in-cart'));
                });
                // Устанавливаем шаг и кол-во
                if ($item.hasClass('js-product-in-cart')) {
                    setStepAndAmount($item, true);
                } else {
                    setStepAndAmount($item, true);
                }
            }

            // Инициализируем фильтры для счетчика
            $counterInput.each(function () {
                let filter;
                const $this = $(this);
                const minVal = parseFloat($this.attr('data-min'));

                // Фильтр для изменения значения
                let regexp = /(^$)|(^(0|[1-9][0-9]{0,})$)/;
                if ($this.closest('.custom-counter_type_fractional').length) {
                    regexp = /(^$)|(^((0|[1-9][0-9]{0,})(\.[0-9]{0,2}){0,1})$)/;
                }
                filter = function (value) {
                    let floatVal = parseFloat(value);
                    let condition = !isNaN(floatVal) && regexp.test(value);

                    if (!isNaN(minVal)) {
                        condition = condition && (floatVal >= minVal);
                    }
                    return condition;
                };

                // Фильтр для изменения значения
                $this.inputFilter(filter);

                // Фильтр для ввода (input) значения
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
                let step = functions.getStep($item);

                // Установка val
                let val = parseFloat($inputValue.val());
                // val = Math.ceil(val / step);
                val = Math.floor(val / step);

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

                // При щелчке по кнопкам на странице корзины и так вызывается change, поэтому повторно его вызывать здесь не надо. Я бегло посмотрел файл плагина, чтобы удалить его оттуда и убрать эти строки. Но ничего там не нашел. По-хорошему надо подправить этот момент в фале плагина. Эти строки тут выглядят как костыль
                if (!$inputValue.closest('.ms2_form').length) {
                    $inputValue.trigger('change');
                }

                // Если кнопка находится в карточке товара корзины, то отправляем форму (кликаем по кнопке для отправки формы)
                $this.closest('.cart-table__table-row').find('.btn-sm').click();
            });

            // Удаляем у чанка класс о том, что чанк еще не инициализирован
            $item.removeClass('not-init');
        });
    };
    window.initStyledCounter();


    /**
     * Конвертация
     */
    function setStepAndAmount($item, dontChangeAmount) {
        dontChangeAmount = (typeof dontChangeAmount !== 'undefined') ? dontChangeAmount : false;

        // ---------------------------------------------
        // Определяем основные переменные
        // ---------------------------------------------
        // Текущий шаг
        // let step = functions.getStep($item);
        let step = 1;

        // Поле в текущей форме
        let $activeFormInput = functions.getActiveForm($item)['action'].find('.custom-counter__amount');

        // Значение активной ед. измерения
        let unitVal = functions.getActiveUnitValue($item);

        // ---------------------------------------------
        // Устанавливаем новый шаг и новое число (если шаг изменился)
        // ---------------------------------------------
        // Получаем коэффициент. Пока что он задан только у кирпичей. Он нам нужен для установки нового шага
        // let coeff = parseFloat($item.attr('data-coefficient'));
        let coeff;
        if (isNaN(coeff)) {
            coeff = 0;
        }

        // Получаем step
        if (coeff === 0) {
            step = 1;
        } else {
            if (unitVal === 1) {
                // Если это 1 (штуки), то умножаем коэффициент на активную ед. измерения
                step = coeff * unitVal;
            } else {
                // Если это что-то другое, то формула другая. Нужно разделить коэффициент на активную ед. измерения и округлить в большую сторону
                step = Math.ceil(coeff / unitVal);
            }
        }

        // Получаем новое количество товара
        let lastUnitValue = $item.attr('data-last-unit-value');
        let newVal = $activeFormInput.val();
        if (typeof lastUnitValue !== 'undefined') {
            // Если мы с штук перешли на другую ед. измерения
            if (lastUnitValue == 1) {
                newVal = newVal * unitVal;
            } else {
                // Если мы НЕ СО ШТУК перешли на любую другую единицу измерения
                newVal = newVal / lastUnitValue * unitVal;
            }
        } else {
            // Если мы не переходили ни с каких единиц измерения - просто произошла загрузка страницы
            newVal = newVal * step;
        }

        // Округляем новое значение в большую сторону
        newVal = Math.ceil(newVal);

        // Пересчитываем кол-во товара с учетом step
        // newVal = functions.getCorrectValueToCounter(step, newVal);

        // Устанавливаем новый шаг
        // $item.attr('data-step', step);

        // Устанавливаем новое количество
        if (!dontChangeAmount) {
            $activeFormInput.val(newVal);
        }
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


    // -------------------------------
    // Новый блок с ассортиментом товаров
    // -------------------------------
    let $assort = $('.assort');
    if ($assort.length) {
        const sidebar = 1;
        const content = 2;

        function toggleClasses(classConst) {
            let oldHeight = $assort.height();
            switch (classConst) {
                case sidebar:
                    $assort.removeClass('assort_active_content').addClass('assort_active_sidebar');
                    break;
                case content:
                    $assort.removeClass('assort_active_sidebar').addClass('assort_active_content');
                    break;
            }
            let newHeight = $assort.height();
            $assort.height(oldHeight);
            $assort.animate({'height': newHeight}, 300, function () {
                $assort.css('height', '');
            });
        }

        let $backBtnText = $assort.find('.assort__back-text');

        $assort.find('.assort__sidebar-item').on('click', function (e) {
            e.preventDefault();
            let $this = $(this);
            $assort.find('.active.assort__sidebar-item, .active.assort__content').removeClass('active');
            $this.addClass('active');
            $assort.find('.assort__content[data-tab="' + $this.attr('data-tab') + '"]').addClass('active');
            toggleClasses(content);
            $backBtnText.text($this.text());
        });

        $assort.find('.assort__back').on('click', function (e) {
            e.preventDefault();
            toggleClasses(sidebar);
            $backBtnText.text('');
        });
    }
});

