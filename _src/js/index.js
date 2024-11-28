import '../sass/main.sass';

// -------------------------------------
// Подключение JQuery
// -------------------------------------
window.jQuery = $;
window.$ = $;

// -------------------------------------
// Импорт функций на JQuery
// -------------------------------------
// import functions from './functions/functions.js';
import './libs/inputFilter/inputFilter.js';
import funcsProduct from './functions/funcsProduct.js';
import funcsCatalog from './functions/funcsCatalog.js';
import funcsFavAndComp from './functions/funcsFavAndComp';
import mapsLazyload from './modules/lazyload_maps';


// -------------------------------------
// MODULES
// -------------------------------------
import modxJS from './functions/modxJS';
import { initSliders } from "./modules/sliders";
import calcProperties from "./utils/calcProperties";
import {Mobilemenu, Mobilemenu_kirpichM5} from "./modules/mobileMenu";
import Dropdowns from "./modules/dropdowns";
import Tabs from "./modules/tabs";
import { initFancybox } from "./libs/fancybox";
import { initSlimSelect } from "./libs/slimSelect";
import LazyLoad from "vanilla-lazyload";
import FastSearch from './modules/fast_search';
import shadowMap from './modules/shadow_map';
import initDistrictsMap from './modules/districts_map';
import Inputmask from 'inputmask';
import mailChange from './modules/mailchanger';

import AdditionalFieldsCallbackForm from '../../core/elements/_modules/additional-fields-callback-form/scripts/main.js'
import initSquareMetersHandler from './modules/squareMetersHandler.js';
import collapseLongTexts from './modules/collapseLontTexts.js';
import showMoreListing from './modules/showMoreListing.js';
import '../../core/elements/_modules/debug/Logger.js'
import { OurObjects } from '../../core/elements/_modules/our_objects/js/our_objects.js';

document.addEventListener('DOMContentLoaded', () => {
    waitForYm(null, function(counter, counterNum) {
        window.ymid = counterNum;
    });
    
    const ctx = body.getAttribute('data-ctx');

    switch(ctx){
        case 'kirpich-m5':
            const ourObjects = new OurObjects();
            ourObjects.bind();
        break;
    }

    // Добавление дублирующихся заголовков в fancybox через JS, чтобы поисковики не видели их
    $('#callback').find('.form__title').text('Оставьте свои контакты ниже');

    calcProperties.calcAppProperties();

    const js_burger_1 =  document.querySelector('.js-burger-1');
    const js_burger_2 =  document.querySelector('.js-burger-2');
    if(js_burger_1){
        js_burger_1.addEventListener("click", (e) => {
            if(typeof window.mm_js_burger_1 !== "undefined")return;
            //const ctx = body.getAttribute('data-ctx');
            let mm = null;
            switch(ctx){
                case 'kirpich-m5':
                    mm = Mobilemenu_kirpichM5;
                break;
                default:
                    mm = Mobilemenu;
                break;
            }
            console.log(mm);
            window.mm_js_burger_1 = new mm('.js-burger-1', '.burger-menu');
            window.mm_js_burger_1.toggleBurger(e);
        });
    }
    if(js_burger_2){
        js_burger_2.addEventListener("click", (e) => {
            if(typeof window.mm_js_burger_2 !== "undefined")return;
            //const ctx = body.getAttribute('data-ctx');
            let mm = null;
            switch(ctx){
                case 'kirpich-m5':
                    mm = Mobilemenu_kirpichM5;
                break;
                default:
                    mm = Mobilemenu;
                break;
            }
            window.mm_js_burger_2 = new mm('.js-burger-2', '.burger-menu');
            window.mm_js_burger_2.toggleBurger(e);
        });
    }

    //initMobilemenu('.js-burger-1', '.burger-menu');
    //initMobilemenu('.js-burger-2', '.burger-menu');
    initSliders();
    new Dropdowns();
    new Tabs();

    initSquareMetersHandler();

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
    // Переключение типа покупателя в корзине
    // -------------------------------
    if ($('.popup_type_order').length) {
        $('[name="CUSTOMER-TYPE"]').on('change', function() {
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
    // Выравнивание названий товара
    // -------------------------------

    function alignment(selector) {
        var rows = {};
        let currentTop = 0;
        let masRow = [];
        $(selector).each(function (index) {
            let top = Math.ceil($(this).offset().top);
            if (index == 0) {
                currentTop = top;
            }
            if (top == currentTop) {
                rows[top] = masRow;
            } else {

                masRow = [];
                currentTop = top;
            }
            masRow.push($(this));
        });

        for (var key in rows) {
            if (rows.hasOwnProperty(key)) {
                let maxHeight = 0;
                for (var keyRow in rows[key]) {
                    let objectRow = rows[key][keyRow];
                    if (objectRow.height() > maxHeight) {
                        maxHeight = objectRow.height();
                    }
                }
                for (var keyRow in rows[key]) {
                    let objectRow = rows[key][keyRow];
                    objectRow.height(maxHeight)
                }
            }
        }
    }

    alignment(".product-card__title")
    alignment(".product-card__stats")

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
        $filterBtn.on('dropdown-toggle', function() {
            if (needExpandFilters) {
                $('.filter-item__top').click();
                needExpandFilters = 0;
            }
        });
    }


    // -------------------------------
    // Подмена Email'а
    // -------------------------------
      
    // Проверяем, есть ли в URL параметр utm_source
    const urlParams = new URLSearchParams(window.location.search);
    
    // is_source - Определяется в плагине utm
    if (!urlParams.has("utm_source") && (window.is_source == 0 || !window.is_source)) {
        mailChange();
    }


    // -------------------------------
    // Добавление в бургер кнопки "Все производители"
    // -------------------------------
    let toCatalogBtnText = 'Все производители';
    if ($('[data-ctx="kraska"]').length) {
        toCatalogBtnText = 'Все разделы';
    }
    if ($('[data-ctx="krovelnyjstroymarket"]').length) {
        toCatalogBtnText = 'Каталог материалов';
    }

    // $('.h-catalog__column:first').append('<a class="h-catalog-item h-catalog-item_to-catalog h-catalog-item__name h-catalog-item__name_bold" href="/catalog/">' + toCatalogBtnText + '</a>');

    $('.h-menu__dropdown').scroll(function(){
        $('.h-catalog__column').not(':first').css('padding-top', $(this).scrollTop())
    });

    // -------------------------------
    // Раскрытие тегов каталога
    // -------------------------------
    let $catalogItemMoreBtn = $('.catalog-screen__item_type_more');
    if ($catalogItemMoreBtn.length) { // && $(document).width() > 992
        $catalogItemMoreBtn.on('click', function() {
            $(this).parent().add($catalogItemMoreBtn).toggleClass('active');
        });
    }
   
    $('.catalog-screen__items').each(function(){
        // Корректировка отображения меню на пк если элементов в списке категорий 5 то скрываем кнопку показать еще
        if($(this).children('.catalog-screen__item').length <= 5){
            // $(this).children('.catalog-screen__item').eq(4).css("display", "block")
            $(this).children('.catalog-screen__item_type_more').css('display', 'none')
        }
    });

    // -------------------------------
    // Раскрытие верхних тегов
    // -------------------------------
    let $catalogTagsMoreBtn = $('[data-tag-show-more-btn]');
    if ($catalogTagsMoreBtn.length) { // && $(document).width() > 992
        $catalogTagsMoreBtn.on('click', function() {
            $(this).parent().add($catalogTagsMoreBtn).toggleClass('active');
        });
    }
    $('.catalog-screen__items').each(function(){
        // Корректировка отображения меню на пк если элементов в списке Тэгов 5 то скрываем кнопку показать еще
        if($(this).children('.catalog-screen__tag').length <= 10){
            // $(this).children('.catalog-screen__tag').eq(4).css("display", "block")
            $(this).children('[data-tag-show-more-btn]').css('display', 'none')
        }
    });
    // -------------------------

    // -------------------------------
    // Раскрытие тегов из Подборки фильтров
    // -------------------------------
    document.querySelectorAll(".custom-selections__toggle-button").forEach((button) => {
        const preview = button
        .closest(".custom-selections")
        .querySelector(".custom-selections__preview");
        const groups = button
        .closest(".custom-selections")
        .querySelector(".custom-selections__groups");
        button.addEventListener("click", () => {
            // button.classList.toggle("active");
            preview.classList.toggle("active");
            groups.classList.toggle("active");
        });
    });

    // -------------------------------

    if($('body').width() < 778){
        const skipButtonMore = document.body.classList.contains('krovelnyjstroymarket') 
        || document.body.classList.contains('alterteplo')
        || document.body.classList.contains('plitnye');
        var $buttonMore = $('<div class="h-menu__link-to-catalog h-menu__link-to-catalog_bottom h-menu__link-to-catalog_mobile btn btn_style_shadow">Показать больше</div>');
        if(!skipButtonMore){
            $('.burger-menu__catalog').append($buttonMore);
            $('.bm-cat-item').each(function(index){
                if(index > 2){
                    $(this).hide();
                }
            });
        }
        $buttonMore.click(function (){
            if($buttonMore.text() == 'Скрыть'){
                $('.bm-cat-item').each(function(index){
                    if(index > 2){
                        $(this).hide();
                    }
                });
                $buttonMore.text('Показать больше');
            }else{
                $('.bm-cat-item').show();
                $buttonMore.text('Скрыть');
            }
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
    $(window).scroll(function() {
        fixAndUnfixHeader();
    });
    fixAndUnfixHeader();


    // --------------------------------
    // Кнопка для скролла вверх
    // --------------------------------
    let $btn = $('.to-top-btn');
    $(window).scroll(function() {
        if ($(window).scrollTop() > window.innerHeight) {
            $btn.addClass('active');
        } else {
            $btn.removeClass('active');
        }
    });

    $btn.on('click', function(e) {
        e.preventDefault();
        $('html, body').animate({ scrollTop: 0 }, 300);
    });


    // --------------------------------
    // Раскрытие / скрытие фильтров
    // --------------------------------
    $filterBtn.on('dropdown-close dropdown-toggle', function(e) {
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
        $headerCatalog.on('dropdown-toggle', function() {
            let cls;
            if ($('.header-fixed').length) {
                cls = 'body-blackout body-blackout_overhidden';
            } else {
                cls = 'body-blackout';
            }

            clearTimeout(timeout);
            if ($headerCatalog.hasClass('active')) {
                if (!$('.body-blackout__screen').length) {
                    let $screen = $('<div class="body-blackout__screen"></div>').appendTo('body');

                    $screen.on('click', function(e) {
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
    $('.h-catalog-item_to-catalog').on('hover');

    // -------------------------------
    // Отображение столбцов меню (проверка активных элементов)
    // -------------------------------

    // костыль для меню tagnerud, потому что так захотелось имъ
     const isTagNerud = document.body.classList.contains('tagnerud')
    //

    function displayMenuColumns() {
        $('.h-catalog__column').not(':first').each(function(index, element) {
            if ($(this).find('.h-catalog-item_dependent.active').length === 0) {
                $(this).addClass('disable');
            } else {
                $(this).removeClass('disable');
            }
        });

        $('.h-catalog__column:not(:first) .h-catalog-item__name').removeClass('h-catalog-item__name_bold');
        // костыль для меню tagnerud
        if(!isTagNerud) 
            $('.h-catalog__column:not(.disable):eq(1) .h-catalog-item__name').addClass('h-catalog-item__name_bold');
    }

    // -------------------------------
    // Переключение вкладок в меню в шапке
    // -------------------------------

    displayMenuColumns();
    const $hCatalogItem = $('.h-catalog-item_main, .h-catalog-item_to-catalog');
    

    $hCatalogItem.on('mouseenter', function(e) {
        e.preventDefault();
        let $this = $(this);

        // костыль для меню tagnerud
        if(isTagNerud){
            const headers = {
                'frakzia':'Фракция',
                'upakovka':'Фасовка',
                'tip':'Тип',
                'razmer':'Размер',
            }
            const catId = $this.attr('data-cat-id');
            $this.on('click', (e) => {
                e.preventDefault(); // сделать некликабельными ссылки в левом столбце
            });
            const hCatalogItemName = headers[catId] || 'Варианты';
            $('.h-catalog__column:nth-of-type(2) .h-catalog__column-header').text(hCatalogItemName);
            $('.h-catalog__column:not(:first) .h-catalog-item__name').removeClass('h-catalog-item__name_bold');
        }
        //

        if ($this.hasClass('active')) {
            return false;
        }

        $('.h-catalog-item.active, .h-catalog-item_to-catalog.active').removeClass('active');
        $this.addClass('active');
        $('.h-catalog-item_dependent[data-cat-id=' + $this.attr('data-cat-id') + ']').addClass('active');
        displayMenuColumns();
    });


    $(document).ready(function () {
      collapseLongTexts();

      showMoreListing();
    });

    $(".table__cell").each(function (cell){
        if($(this).text().indexOf("²") != -1){
            $(this).html($(this).html().replaceAll("²", "<span style='font-family: Sans-serif'>²</span>"))
        }
    });

    try{
        new AdditionalFieldsCallbackForm();
      }catch(error){
        console.error(`Ошибка модуля AdditionalFieldsCallbackForm`, error);
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

/** Ожидание загрузки счетчика Яндекс.Метрики
 * @param {?(number|string)} ymCounterNum - номер счетчика, если известен
 * @param {function} callback - получает аргументами объект и номер счетчика
 * @param {number} interval - интервал проверки готовности счетчика
 */
function waitForYm(ymCounterNum, callback, interval) {
    if (!callback) return;
    if (!ymCounterNum) {
        let metrikaObj = (window.Ya && (window.Ya.Metrika || window.Ya.Metrika2)) || null;
        ymCounterNum = (metrikaObj && metrikaObj.counters && (metrikaObj.counters() || [0])[0].id) || 0;
    }
    let ymCounterObj = window['yaCounter' + ymCounterNum] || null;
    if (ymCounterObj) return (callback(ymCounterObj, ymCounterNum), undefined);
    setTimeout(function() { waitForYm(ymCounterNum, callback, interval); }, interval || 250);
}


$(document).ready(function() {
    var $tags = $('.catalog-screen__tag-name');
    var $button = $(".catalog-screen__tag_type_more");
    var height = 75;
    $button.click(function (){
        if($tags.length > 0){
            $tags.each(function (index, element) {
                let $element = $(element);
                let big = $element[0].scrollHeight > height;
                if(big)
                {
                    $element.css('font-size', 14 + 'px');
                }
            });
        }
    })
});
