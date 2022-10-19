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
import '../libs/Drog.js/Drog.js';
import Cookies from 'js-cookie';


// -------------------------------------
// Самописные модули на JS
// -------------------------------------
import './modules/sliders.js';
import initTabs from './modules/tabs.js';
import mailChange from './modules/mailchanger';
import initDistrictsMap from './modules/districts_map';
import mapsLazyload from './modules/lazyload_maps';
import youtubePlayer from './modules/youtube_player';
// import add_cover_to_map from './modules/maps';
import shadowMap from './modules/shadow_map';


// -------------------------------------
// Подключение JQuery
// -------------------------------------
window.jQuery = $;
window.$ = $;


// -------------------------------------
// Импорт функций на JQuery
// -------------------------------------
import modxJS from './functions/modxJS';
import functions from './functions/functions.js';
import funcsProduct from './functions/funcsProduct.js';
import funcsCatalog from './functions/funcsCatalog.js';
import funcsFavAndComp from './functions/funcsFavAndComp';
import inputFilter from '../libs/inputFilter/inputFilter.js';


// -------------------------------------
// Основной код файла
// -------------------------------------
// Замена сообщения о ненайденных результатах на странице каталога. Другого способа разделить сообщения mFilter2 и mSearch2, который не сбросится при обновлении / переустановке плагина, я не нашел. Код написан вверху и без jQuery, чтобы работать быстрее.
let elem = document.querySelector('.listing__content .msearch2message');
if (elem !== null) {
    elem.innerHTML = 'Подходящих результатов не найдено.';
}

$(function ($) {
    // --------------------------------
    // Копируем форму для шапки
    // --------------------------------
    // Это необходимо, т.к. после форм выдается сообщение об успешной отправки, которое не дает отправить форму еще раз. Форма в шапке такая же, как форма обратного звонка. Если ее отправить, то нельзя будет отправить форму обратного звонка. Чтобы это исправить, надо скопировать форму для шапки
    let $popupCallback = $('#callback');
    $popupCallback.clone().insertAfter($popupCallback).attr('id', 'header-callback');


    // --------------------------------
    // Основные установки
    // --------------------------------
    // id для целей Яндекс.Метрики
    const yandexMetrikaId = getYandexMetrikaId();

    // Lazyload для картинок
    let lazyLoadInstance = new LazyLoad();

    // Код с обработчиками MODX
    modxJS(lazyLoadInstance, yandexMetrikaId);

    // Inputmask для ввода номера телефона
    let im = new Inputmask("+7 (999) 999-99-9{2,3}");
    im.mask(document.querySelectorAll('input[name="PHONE"]'));

    // Инициализация табов
    initTabs();


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
    // let $map_containers = $('.map__container');
    // $map_containers.each((idx, map_container) => {
    //     add_cover_to_map(map_container);
    // });
    shadowMap('.map__container');


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
        $('body').toggleClass('freeze-page')
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
        // Основные переменные и константы
        const sidebar = 1;
        const content = 2;
        let $backBtnText = $assort.find('.assort__back-text');

        // Вспомогательная функция для анимации при переключении табов
        function toggleClasses(classConst, oldHeight) {
            // Завершаем предыдущую анимацию (если она выполняется)
            $assort.finish();
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

        $assort.find('.assort__sidebar-item').on('click', function (e) {
            e.preventDefault();
            let $this = $(this);

            if ($this.hasClass('active')) {
                return;
            }

            let oldHeight = $assort.height();
            $assort.find('.active.assort__sidebar-item, .active.assort__content').removeClass('active');
            $this.addClass('active');
            $assort.find('.assort__content[data-tab="' + $this.attr('data-tab') + '"]').addClass('active');
            toggleClasses(content, oldHeight);
            $backBtnText.text($this.text());
        });

        $assort.find('.assort__back').on('click', function (e) {
            e.preventDefault();
            toggleClasses(sidebar, $assort.height());
            $backBtnText.text('');
        });
    }


    // -------------------------------
    // Скрывание / раскрывание по клику
    // -------------------------------
    document.querySelectorAll("[data-dropdown]").forEach((function (e) {
        if (e.getAttribute("data-dropdown")) {
            Array.from(document.querySelectorAll(e.getAttribute("data-dropdown"))).forEach((function (e) {
                e.addEventListener("click", (function () {
                    e.parentElement.classList.toggle("active");
                }));
            }));
        } else {
            Array.from(e.children).forEach((function (e) {
                e.addEventListener("click", (function () {
                    e.classList.toggle("active");
                }));
            }));
        }
    }));


    // -------------------------------------
    // Уменьшение размера h1 на мобилках, если он длинный и переносится на 2 и более строки
    // -------------------------------------
    if (window.innerWidth <= 768) {
        let $h1 = $('.category-header');
        if ($h1.outerHeight() > 30) {
            $h1.css('font-size', 18);
        }
    }


    // --------------------------------
    // Кнопка для скролла вверх
    // --------------------------------
    let $btn = $('.scroll-top');
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
    // Главная с фильтрами
    // --------------------------------
    let $mainList = $('.sect-mainlist');
    if ($mainList.length) {
        // Если я буду смотреть, каким фильтрам добавлять hidden, когда все фильтры показаны и ширина блока с фильтрами не ограничена, может быть такое, что фильтры перенесутся на след. строку, но будут видны.
        // Если я буду смотреть, каким фильтрам добавлять hidden, когда все фильтры скрыты и ширина блока с фильтрами ограничена, может быть такое, что я нажму кнопку "Показать еще", а фильтры на след. строку не переносятся.
        // Я выбрал второй вариант.
        // TODO. Можно выбрать первый. Строго задать высоту строки. А то, что выходит за нее, будет прятаться (overflow: hidden).

        // Перерасчет фильтров на главной при изменении ширины браузера
        $(window).on('resize', function () {
            recalculateMainlist();
        });

        // Перерасчет фильтров на главной при загрузке страницы
        recalculateMainlist();

        // Щелчок по кнопке для скрытия / показа фильтров
        $('.sect-mainlist__btn-more').on('click', function () {
            // Основные переменные
            let $btn = $(this);
            let $fblockwrap = $btn.closest('.sect-mainlist__fblock-wrap');
            let $fblock = $fblockwrap.find('.sect-mainlist__fblock');

            // Переключение класса для кнопки, от которого будет зависеть, что делать дальше
            $btn.toggleClass('sect-mainlist__btn-more_toggled');
            functions.toggleText($btn, 'data-text');

            recalculateMainlist($fblock);
        });

        /**
         * Перерасчет фильтров
         */
        function recalculateMainlist($fblockArray) {
            let strictReset = false;
            if (typeof $fblockArray === 'undefined') {
                strictReset = true;
                $fblockArray = $('.sect-mainlist__fblock');
            }

            $fblockArray.each(function () {
                // Основные переменные
                let $fblock = $(this);
                let filtersNotFit = false;
                let fblockOffsetTop = $fblock.offset().top;
                let $fblockwrap = $fblock.parent();
                let $btnMore = $fblockwrap.find('.sect-mainlist__btn-more');
                let $filters = $fblock.find('.sect-mainlist__filter');
                let needHideFilters = true;

                // Сбрасываем кнопку "Показать еще" в вид по умолчанию
                if (strictReset && $btnMore.hasClass('sect-mainlist__btn-more_toggled')) {
                    functions.toggleText($btnMore, 'data-text');
                    $btnMore.toggleClass('sect-mainlist__btn-more_toggled');
                    $btnMore.appendTo($fblock);
                    needHideFilters = false;
                }
                // Или в вид, соответствующий предназначению кнопки
                else if (!strictReset) {
                    if ($btnMore.hasClass('sect-mainlist__btn-more_toggled')) {
                        $btnMore.appendTo($fblock);
                        needHideFilters = false;
                    } else {
                        $btnMore.appendTo($fblockwrap);
                    }
                }

                // Показываем все фильтры, скрываем кнопку "Показать еще" (т.к. она занимает место), убираем у блока с фильтрами класс, который убирает ограничение по ширине. Все это, чтобы правильно рассчитать, какие фильтры скрыть, а какие оставить
                $filters.removeClass('hidden');
                $btnMore.addClass('hidden');
                $fblock.removeClass('sect-mainlist__fblock_show-filters');

                // Скрываем лишние фильтры
                $filters.each(function () {
                    let $fltr = $(this);
                    // 2 - на всякий случай, вдруг в каких браузерах будут отображаться чуть ниже / чуть выше
                    if (Math.abs($fltr.offset().top - fblockOffsetTop) > 2) {
                        if (needHideFilters) {
                            $fltr.addClass('hidden');
                        }
                        if (!filtersNotFit) {
                            filtersNotFit = true;
                        }
                    }
                });

                if (filtersNotFit) {
                    $btnMore.removeClass('hidden');
                    $fblock.addClass('sect-mainlist__fblock_show-filters');
                }
            });
        }
    }


    // --------------------------------
    // Если на странице есть таблица.table-filter подгрузить module_filter_table
    // --------------------------------
    if (document.querySelector('.content-block table.table-filter')) {
        // Запрещаем перенос строки в ячейках с ценой
        $('.table-filter').each(function () {
            let $table = $(this);
            let index = $table.find('td.no-sort').index();
            if (index === -1) {
                return;
            }
            $table.find('tr').each(function (i) {
                if (i === 0) {
                    return;
                }
                let $tr = $(this);
                let $td = $tr.find('td').eq(index);
                if (!$td.length) {
                    return;
                }
                $td.css('white-space', 'nowrap');
            });
        });


        // Подгружаем module_filter_table
        let script = document.createElement("script");
        script.type = "text/javascript";
        script.src = '/assets/template/js/module_filter_table.js';
        document.getElementsByTagName("head")[0].appendChild(script);
    }


    // -------------------------------
    // Стилизованный список для адреса в шапке
    // -------------------------------
    $('.select-address').euv_custom_select();


    // --------------------------------
    // Ленивая загрузка видео
    // --------------------------------
    youtubePlayer();
});


function getYandexMetrikaId() {
    switch (location.host) {
        case 'armatura-178.ru':
            return 87592591;
        case 'asfalt-prof.ru':
            return 87877840;
        case 'fasady-pro.ru':
            return 87550456;
        case 'minvata-178.ru':
            return 86222127;
        case 'kirpich-m.ru':
            return 87468541;
        case 'minvata-78.ru':
            return 86221747;
        case 'krovlyasp.ru':
            return 86936986;
        case 'www-fasad.ru':
            return 88306051;
        case 'minvata-pro.ru':
            return 86222192;
        case 'plity-epps.ru':
            return 86222030;
        case 'pilomat-pro.ru':
            return 87877411;
        case 'plitaosb.ru':
            return 88179338;
        case 'plity-mdvp.ru':
            return 88305740;
        case 'www-minvata.ru':
            return 86220330;
        case 'pro-minvata.ru':
            return 86221954;
        case 'minvata-spb.ru':
            return 86222209;
        case 'pro-fanera.ru':
            return 88180782;
    }
}
