import '../sass/main.sass';

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
import inputFilter from './libs/inputFilter/inputFilter.js';
import mapsLazyload from './modules/lazyload_maps';


// -------------------------------------
// MODULES
// -------------------------------------
import modxJS from './functions/modxJS';
import {initSliders} from "./modules/sliders";
import calcProperties from "./utils/calcProperties";
import initMobilemenu from "./modules/mobileMenu";
import Dropdowns from "./modules/dropdowns";
import Tabs from "./modules/tabs";
import {initFancybox} from "./libs/fancybox";
import {initSlimSelect} from "./libs/slimSelect";
import LazyLoad from "vanilla-lazyload";
import FastSearch from './modules/fast_search';
import shadowMap from './modules/shadow_map';
import initDistrictsMap from './modules/districts_map';
import Inputmask from 'inputmask';
import mailChange from './modules/mailchanger';


document.addEventListener('DOMContentLoaded', () => {
    // Добавление дублирующихся заголовков в fancybox через JS, чтобы поисковики не видели их
    $('#callback').find('.form__title').text('Оставьте свои контакты ниже');

    calcProperties.calcAppProperties();
    initMobilemenu('.js-burger-1', '.burger-menu');
    initMobilemenu('.js-burger-2', '.burger-menu');
    initSliders();
    new Dropdowns();
    new Tabs();

    initSlimSelect(".default-select__select");

    initFancybox();

    // id для целей Яндекс.Метрики
    const yandexMetrikaId = getYandexMetrikaId();
    // Lazyload для картинок
    let lazyLoadInstance = new LazyLoad();
    // Код с обработчиками MODX
    modxJS(lazyLoadInstance, yandexMetrikaId);

    // Инициализация быстрого поиска
    new FastSearch('.header__search_screen_desktop');
    new FastSearch('.header__search_screen_mobile');


    // -------------------------------------
    // Маска для телефона
    // -------------------------------------
    // Inputmask для ввода номера телефона
    let im = new Inputmask("+7 (999) 999-99-9{2,3}");
    im.mask(document.querySelectorAll('input[name="PHONE"]'));


    // -------------------------------------
    // Функции страниц на JQuery
    // -------------------------------------
    // Функции для каталога
    funcsCatalog.init();
    // Функции для карточки товара
    funcsProduct.init(yandexMetrikaId);
    // Функции для избранного и сравнения
    funcsFavAndComp.init();


    // -------------------------------
    // Яндекс карты
    // -------------------------------
    window.initDistrictsMap = initDistrictsMap;
    mapsLazyload();


    // -------------------------------
    // Запрет прокрутки карты до клика
    // -------------------------------
    shadowMap('.shadow-map');


    // -------------------------------
    // Переключение вкладок в меню в шапке
    // -------------------------------
    let $hCatalogItem = $('.h-catalog-item_main');
    $hCatalogItem.on('mouseenter', function (e) {
        e.preventDefault();
        let $this = $(this);

        if ($this.hasClass('active')) {
            return false;
        }

        $('.h-catalog-item.active').removeClass('active');
        $this.addClass('active');
        $('.h-catalog-item_dependent[data-cat-id=' + $this.attr('data-cat-id') + ']').addClass('active');
    });


    // -------------------------------
    // Переключение типа покупателя в корзине
    // -------------------------------
    if ($('.popup_type_order').length) {
        $('[name="CUSTOMER-TYPE"]').on('change', function () {
            let $this = $(this);
            let $wrapper = $this.closest('[data-forms-wrapper]');
            let $form = $wrapper.find('form[data-form="' + $this.val() + '"]');
            if (!$form.length) {
                return true;
            }

            $wrapper.find('form').removeAttr('data-active');
            $form.attr('data-active', 1);
        });
    }


    // -------------------------------
    // Раскрытие панелек с фильтрами на странице каталога / категории
    // -------------------------------
    let $filterBtn = $('.catalog__filter');
    if (window.innerWidth >= 1200) {
        // Если мы на компах, то раскрываем фильтры прямо при загрузке страницы.
        $('.filter-item__top').click();
    } else {
        let needExpandFilters = 1;
        // На телефонах надо делать иначе, в противном случае будет баг в фильтре с ценой (фильтр будет отображаться не полностью)
        $filterBtn.on('dropdown-toggle', function () {
            if (needExpandFilters) {
                $('.filter-item__top').click();
                needExpandFilters = 0;
            }
        });
    }


    // -------------------------------
    // Подмена Email'а
    // -------------------------------
    mailChange();


    // -------------------------------
    // Добавление в бургер кнопки "Все производители"
    // -------------------------------
    let toCatalogBtnText = 'Все производители';
    if ($('[data-ctx="kraska"]').length) {
        toCatalogBtnText = 'Все разделы';
    }
    $('.h-catalog__column:first').append('<a class="h-catalog-item h-catalog-item_to-catalog h-catalog-item__name h-catalog-item__name_bold" href="/catalog/">' + toCatalogBtnText + '</a>');


    // -------------------------------
    // Раскрытие тегов
    // -------------------------------
    let $catalogItemMoreBtn = $('.catalog-screen__item_type_more');
    if ($catalogItemMoreBtn.length) {
        $catalogItemMoreBtn.on('click', function () {
            $catalogItemMoreBtn.parent().add($catalogItemMoreBtn).toggleClass('active');
        });
    }


    // -------------------------------
    // Фиксация шапки
    // -------------------------------
    function fixAndUnfixHeader() {
        const $wrap = $('.wrap');
        const clsFixed = 'header-fixed';
        const clsShadow = 'header-shadow';
        const $header = $('.header__bottom');

        // На мобилках шапка ВСЕГДА фиксированная
        if (window.innerWidth < 992) {
            $wrap.addClass(clsFixed);
        }

        // Если расстояние от начала страницы до шапки меньше нужного нам, то удаляем тень. А на больших экранах удаляем еще и класс для фиксации шапки
        if ($(window).scrollTop() <= ($header.outerHeight() + $('.header__top').outerHeight())) {
            $wrap.removeClass(clsShadow);
            if (window.innerWidth >= 992) {
                $wrap.removeClass(clsFixed);
            }
        } else {
            // Если расстояние от начала страницы до шапки больше нужного, то добавляем тень. А на больших экранах еще и класс для фиксации шапки
            $wrap.addClass(clsShadow);
            if (window.innerWidth >= 992) {
                if (!$('.body-blackout').length) {
                    $wrap.addClass(clsFixed);
                }
            }
        }

        // Переустанавливаем переменную, равную высоте шапки
        calcProperties.calcHeaderHeight();
    }

    // TODO: добавь throttling
    $(window).scroll(function () {
        fixAndUnfixHeader();
    });
    fixAndUnfixHeader();


    // --------------------------------
    // Кнопка для скролла вверх
    // --------------------------------
    let $btn = $('.to-top-btn');
    $(window).scroll(function () {
        if ($(window).scrollTop() > window.innerHeight) {
            $btn.addClass('active');
        } else {
            $btn.removeClass('active');
        }
    });

    $btn.on('click', function (e) {
        e.preventDefault();
        $('html, body').animate({scrollTop: 0}, 300);
    });


    // --------------------------------
    // Раскрытие / скрытие фильтров
    // --------------------------------
    $filterBtn.on('dropdown-close dropdown-toggle', function (e) {
        const $body = $('body');

        if ($(this).hasClass('active')) {
            $body.addClass('filters-expanded');
        } else {
            $body.removeClass('filters-expanded');
        }
    });


    // --------------------------------
    // Меню "Каталог"
    // --------------------------------
    let $headerCatalog = $('.header__catalog, .header__menu');
    let timeout;
    if ($headerCatalog.length) {
        let $body = $('body');
        $headerCatalog.on('dropdown-toggle', function () {
            let cls;
            if ($('.header-fixed').length) {
                cls = 'body-blackout body-blackout_overhidden';
            } else {
                cls = 'body-blackout'
            }

            clearTimeout(timeout);
            if ($headerCatalog.hasClass('active')) {
                if (!$('.body-blackout__screen').length) {
                    let $screen = $('<div class="body-blackout__screen"></div>').appendTo('body');

                    $screen.on('click', function (e) {
                        e.preventDefault();
                        $body.removeClass('body-blackout body-blackout_overhidden');
                        clearTimeout(timeout);
                        timeout = setTimeout(function() {
                            $('.body-blackout__screen').remove();
                        }, 370);
                    });
                }

                setTimeout(function() {
                    $body.addClass(cls);
                }, 0);
            } else {
                timeout = setTimeout(function() {
                    $body.removeClass('body-blackout body-blackout_overhidden');
                    $('.body-blackout__screen').remove();
                }, 370);
            }
        });
    }

});

function getYandexMetrikaId() {
    switch (location.host) {
        case 'knauf':
            return 11111111;
        case 'paroc':
            return 11111111;
        case 'krovlya':
            return 11111111;
        case 'fasad':
            return 11111111;
    }
}
