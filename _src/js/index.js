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
    if (window.innerWidth >= 1200) {
        // Если мы на компах, то раскрываем фильтры прямо при загрузке страницы.
        $('.filter-item__top').click();
    } else {
        // На телефонах надо делать иначе, в противном случае будет баг в фильтре с ценой (фильтр будет отображаться не полностью)
        let $filterBtn = $('.catalog__filter');
        $filterBtn.on('dropdowns-toggle', function () {
            $filterBtn.off('dropdowns-toggle');
            $('.filter-item__top').click();
        });
    }


    // -------------------------------
    // Подмена Email'а
    // -------------------------------
    mailChange();


    // -------------------------------
    // Добавление в бургер кнопки "Все производители"
    // -------------------------------
    $('.h-catalog__column:first').append('<a class="btn btn_style_base" href="/catalog/">Все производители</a>');


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
        const cls = 'header-fixed';
        const $header = $('.header__bottom');

        if ((window.innerWidth >= 992) && ($(window).scrollTop() <= ($header.outerHeight() + $('.header__top').outerHeight()))) {
            $wrap.removeClass(cls);
        } else {
            // Поскольку шапка становтся fixed, высота документа уменьшается. Из-за этого будет некрасивый скачок. И некоторый контент будет сложно прочитать. Чтобы этого избежать, добавляем padding-top величиной в высоту НЕФИКСИРОВАННОЙ шапки
            $wrap.addClass(cls);
        }
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
