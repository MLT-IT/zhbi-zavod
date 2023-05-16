import '../sass/main.sass'

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
import calcAppProperties from "./utils/calcProperties";
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

    calcAppProperties();
    initMobilemenu('.header__burger', '.burger-menu');
    initSliders();
    new Dropdowns();
    new Tabs();

    initSlimSelect(".default-select__select");
    console.log('initSlimSelect', initSlimSelect);

    initFancybox();

    // id для целей Яндекс.Метрики
    const yandexMetrikaId = getYandexMetrikaId();
    // Lazyload для картинок
    let lazyLoadInstance = new LazyLoad();
    // Код с обработчиками MODX
    modxJS(lazyLoadInstance, yandexMetrikaId);

    // Инициализация быстрого поиска
    new FastSearch();


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
    // Переключение типа заказчика в корзине
    // -------------------------------
    $('[data-influent]').on('change', function (e) {
        let $elem = $(this);
        let $container = $elem.closest('[data-dependence]')
        $container.find('[data-dependent]').hide().find('input').prop('disabled', true);
        $container.find('[data-dependent=' + $elem.attr('id') + ']').show().find('input').prop('disabled', false);
        $container.find('[data-dependence-value]').val($elem.val());
    });


    // Можно сделать не при наведении, а при клике:
    // $('.h-catalog-item_main').on('click', function(e) {
    //     e.preventDefault();
    //     let $this = $(this);
    //
    //     if ($this.hasClass('active')) {
    //         return false;
    //     }
    //
    //     $('.h-catalog-item.active').removeClass('active');
    //     $this.addClass('active');
    //     $('.h-catalog-item_dependent[data-cat-id='+$this.attr('data-cat-id')+']').addClass('active');
    // });


    // -------------------------------
    // Раскрытие панелек с фильтрами на странице каталога / категории
    // -------------------------------
    $('.filter-item__top').each(function (i, e) {
        e.click();
    });


    // -------------------------------
    // Подмена Email'а
    // -------------------------------
    mailChange();
})

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
