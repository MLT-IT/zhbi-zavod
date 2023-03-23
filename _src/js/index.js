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

document.addEventListener('DOMContentLoaded', () => {
    // Добавление дублирующихся заголовков в fancybox через JS, чтобы поисковики не видели их
    $('#callback').find('.form__title').text('Оставьте свои контакты ниже');

    calcAppProperties();
    initMobilemenu('.header__burger', '.burger-menu');
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


    // -------------------------------------
    // Функции страниц на JQuery
    // -------------------------------------
    // Функции для каталога
    funcsCatalog.init();
    // Функции для карточки товара
    funcsProduct.init(yandexMetrikaId);
    // Функции для избранного и сравнения
    funcsFavAndComp.init();
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
