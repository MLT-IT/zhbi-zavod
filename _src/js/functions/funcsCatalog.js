import functions from "./functions";

/**
 * Функции, относящиеся к шаблону Каталог (в основном работа с mFilter2).
 */
export default {
    init,
    catalogSortFilters,
    catalogSortColorless,
    getRemainder,
    wrapTitle
};

let $discountBlock = $('.listing__catalog-promo');
if (!$discountBlock.length) {
    $discountBlock = null;
}

// Инициализация
function init() {
    // Перенос строки в названии в чанках товаров на pro-fanera и plitaosb
    wrapTitle();
    // Мы находимся на странице каталога?
    let $isCatalogPage = $('.listing').length;
    // Элемент - сайдбар
    let $aside = $(".listing__filter");

    // -------------------------------------------
    // Панель с фильтрами на мобилках
    // -------------------------------------------
    let $openFiltersBtn = $(".listing__open-filters-btn");
    if ($openFiltersBtn.length) {
        function toggleFiltersbar(skipChangeClasses) {
            let filterPanelWidth = $aside.outerWidth();

            skipChangeClasses = (typeof skipChangeClasses !== 'undefined') ? skipChangeClasses : false;

            if (!skipChangeClasses) {
                $aside.toggleClass("active");
                $('body').toggleClass("freeze-page");
            }

            // Панель открылась
            if ($aside.hasClass('active')) {
                $aside[0]['swapMinX'] = 0;
                $aside[0]['swapMaxX'] = filterPanelWidth;
            }
            // Панель закрылась
            else {
                $aside[0]['swapMinX'] = -filterPanelWidth;
                $aside[0]['swapMaxX'] = 0;
            }
        }


        // ----------------------------
        // Основные обработчики для открытия и закрытия панели с фильтрами
        // ----------------------------
        // Обработчик кнопки внутри панели с фильтрами для закрытия фильтров
        $('.listing__close-filter-btn').on('click', function () {
            toggleFiltersbar();
        });

        // Обработчик для раскрытия панели с фильтрами на мобилках
        $openFiltersBtn.on("click", function () {
            toggleFiltersbar();
        });
        // Обработчик на документ - клик по пустому месту должен скрывать панель с фильтрами
        $(document).on('click', function (e) {
            let $target = $(e.target);
            if (
                // Панель с фильтрами должна быть видна
                $aside.hasClass('active') &&
                // Клик должен быть за пределами панели с фильтрами
                !$target.closest('.listing__filter, .listing__open-filters-btn').length && !$target.hasClass('listing__filter, listing__open-filters-btn') &&
                // Клик не должен быть по подсказке (или ее содержимых элементов
                !$target.closest('.wintip').length && !$target.hasClass('wintip')
            ) {
                toggleFiltersbar();
            }
        });


        // ----------------------------
        // Эффект шторки для панели с фильтрами на мобилках
        // ----------------------------
        Drog.on($aside[0], {
            swapMinY: 0,
            swapMaxY: 0,
            swapMaxX: 0,
            swapMinX: -$aside.outerWidth(),
            elem: $('.listing__filter-btn')[0]
        });

        $aside.on('drogEnd', function () {
            let filterPanelWidth = $aside.outerWidth();
            let translateX = 0;

            // Если фильтры открыты
            if ($aside.hasClass('active')) {
                // Если достаточно сильно свайпнули панель с фильтрами, то необходимо закрыть ее
                if ($aside[0]['-x'] >= (filterPanelWidth / 2 - 10)) {
                    translateX = filterPanelWidth;
                }
            }
            // Если фильтры закрыты
            else {
                // Если достаточно сильно свайпнули панель с фильтрами, то необходимо открыть ее
                if ($aside[0]['-x'] <= (0 - (filterPanelWidth / 2 - 10))) {
                    translateX = -filterPanelWidth;
                }
            }

            // Возвращение шторки (с анимацией). Либо возвращаем шторку в исходное положение (какой она была до того, как пользователь начал ее тянуть). Либо помогаем пользователю открыть / закрыть ее
            $aside.css({
                transform: 'translateX(' + translateX + 'px)',
                transition: ".3s"
            });

            if (translateX !== 0) {
                // Сразу делаем затемнение для body
                $('body').toggleClass("freeze-page");
            }

            // Ждем выполнения анимации
            setTimeout(function () {
                // Сбрасываем Drog
                Drog.move($aside[0], 0, 0);

                // Отменяем transition для шторки, т.к. она уже переместилась
                $aside.removeAttr('style');

                if (translateX !== 0) {
                    // Делаем transition мгновенным (в css он прописан для right, из-за этого будет ненужный скачок)
                    $aside.css('transition', 'all 0s');
                    // Меняется right в стилях
                    $aside.toggleClass("active");
                    // ВАЖНО! Функция toggleFiltersbar обязательно должна идти ПОСЛЕ установки класса active, потому что в ней он проверяется
                    toggleFiltersbar(true);

                    // Между отменой мгновенного transition и действиями со стилями необходимо подождать немного
                    setTimeout(function () {
                        // Отменяем мгновенный transition
                        $aside.removeAttr('style');
                    }, 20);
                }
            }, 300);
        });
    }


    // -------------------------------------------
    // Уменьшение текста в тегах, если он слишком длинный
    // -------------------------------------------
    $('.listing__tags-item-title').each(function (i, e) {
        let $elem = $(e);

        // Получаем и проверяем высоту
        if ($elem.outerHeight() > 20) {
            $elem.css('font-size', '.775rem');
        }

        // Красивый перенос для тегов с подобным названием: "Доска строганная 20 мм"
        let text = $elem.text();
        if (text.match(/(\d+ мм)/g)) {
            text = text.replace(/(\d+ мм)/g, '<span style="white-space: nowrap; font-size: inherit;">$1</span>');
            $elem.html(text);
        }
    });


    // -------------------------------------------
    // Кнопка сброса фильтров
    // -------------------------------------------
    $('.listing__reset-filters').on('click', function (e) {
        $('.listing__reset-filters-action')[0].click();
    });

    $('.filter-option__link').on('click', function (e) {
        // Не знаю, почему, но на арматуре (ТОЛЬКО НА НЕЙ, что очень странно. На других контекстах все хорошо) при клике по фильтру (тегу а) срабатывает переход по ссылке, а не обработчик mSearch2. А на других контекстах - обработчик mSearch2, что приводит к применению фильтра. И этот баг вызывается только на боевом сайте (на локалке и на тестовом все работает). Данная строка помогают это исправить
        e.stopPropagation();
    });


    // -------------------------------------------
    // Сортировка фильтров - в самом верху те, у которых больше всего результатов
    // -------------------------------------------
    // Кирилл сказал отменить сортировку, поэтому я закомментировал ее вызов
    // catalogSortFilters();
    // TODO: Разве это нельзя сделать на PHP? В классе, с которым работает mFilter2, есть методы для фильтрации
    catalogSortColorless();


    // -------------------------------------------
    // Скрыть / показать характеристики на карточках
    // -------------------------------------------
    // let timeoutCharsAnimation;
    // let alignPricesInterval;

    $(document).on('click', '.listing__products-item-chars-btn', function (e) {
        e.preventDefault();
        $(this).closest('.listing__products-item-chars-wrap').toggleClass('active');
        alignPrices();

        // Для плавности изменения уровня цены добавляем еще один, но очень частый интервал
        // clearInterval(alignPricesInterval);
        // alignPricesInterval = setInterval(function () {
        //     alignPrices();
        // }, 0);
        //
        // // Убираем интервал, т.к. анимация закончилась
        // clearTimeout(timeoutCharsAnimation);
        // timeoutCharsAnimation = setTimeout(function () {
        //     clearInterval(alignPricesInterval);
        //     alignPrices();
        // }, 300);
    });

    if ($isCatalogPage) {
        let lastW = 0;

        $(window).resize(function () {
            handleCharsWrap();
        });
        handleCharsWrap();

        function handleCharsWrap() {
            let $charsWrap = $('.listing__products-item-chars-wrap');
            if (window.innerWidth <= 768 && (lastW > 768)) {
                $charsWrap.removeClass('active');
            } else if (window.innerWidth > 768 && (lastW <= 768)) {
                $charsWrap.addClass('active');
            }
            lastW = window.innerWidth;
        }
    }


    // -------------------------------------------
    // Раскрытие меню для фильтрации на мобилках
    // -------------------------------------------
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
            case 2:
                $elem = $('.listing__sort-item[data-sort="ms|price"]');
                dataDir = 'asc';
                break;
            // По цене по убыванию
            case 3:
                $elem = $('.listing__sort-item[data-sort="ms|price"]');
                dataDir = 'desc';
                break;
            // По популярности по убыванию
            case 1:
                $elem = $('.listing__sort-item[data-sort="tv|HitsPage"]');
                dataDir = 'desc';
                break;
            // По алфавиту по убыванию
            case 4:
                $elem = $('.listing__sort-item[data-sort="ms_product|pagetitle"]');
                dataDir = 'asc';
                break;
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
    // Расчет текста для кнопки "Показать еще"
    // -------------------------------
    getRemainder();


    // -------------------------------
    // Переключение конфликтующих фильтров: Длина, Ширина, Толщина и Размеры
    // -------------------------------
    $('.listing__filter-block-content-inner input[type="checkbox"]').on('change', function () {
        let $block = $(this).closest('.listing__filter-block');
        let $conflictingFilters;
        let dontDoAnything = false;

        switch (true) {
            case $block.hasClass('filter_type_razmer'):
                $conflictingFilters = $('.filter_type_thickness, .filter_type_width, .filter_type_length');
                break;

            case ($block.hasClass('filter_type_thickness') ||
                $block.hasClass('filter_type_width') ||
                $block.hasClass('filter_type_length')
            ):
                $conflictingFilters = $('.filter_type_razmer');
                break;

            default:
                dontDoAnything = true;
                break;
        }

        if (dontDoAnything === false) {
            if ($block.find('input[type="checkbox"]:checked').length) {
                $conflictingFilters.css('display', 'none');
            } else {
                $conflictingFilters.css('display', '');
            }
        }
    });


    // -------------------------------------------
    // Выравнивание цены по одному уровню
    // -------------------------------------------
    if ($('.listing__products-item-price-and-logo').length) {
        // document ready
        alignPrices();
        // window on load
        $(window).on('load', alignPrices);

        // Изменение ширины окна / скроллинг
        let timeoutAction;
        $(window).on('resize scroll', function () {
            clearTimeout(timeoutAction);
            timeoutAction = setTimeout(alignPrices, 100);
        });

        // Решил повесить выравнивание цены еще и на интервал - для надежности
        setInterval(function () {
            alignPrices();
        }, 100);
    }


    // -------------------------------------------
    // Раскрывашка для фильтров (если их много)
    // -------------------------------------------
    // Получаем блок с дополнительными фильтрами, которые раскрываются по кнопке
    let $extraFiltersBlock = $('.listing__additional-filters');

    if ($extraFiltersBlock.length) {
        // Высота блока с фильтрами, когда он свернут. Если меняешь это значение, то поменяй и в CSS. Можно было бы прочитать здесь CSS значение. Но на мобилках оно другое
        let startH = 40;

        $('.listing__more-filters-btn').on('click', function () {
            let heightBeforeToggleClass = $extraFiltersBlock.outerHeight();

            // Переключаем класс - открыто / закрыто
            $extraFiltersBlock.toggleClass('open');
            // И текст заодно
            functions.toggleText($(this), 'data-text');

            // Если блок открылся, то...
            if ($extraFiltersBlock.hasClass('open')) {
                // Получаем высоту раскрывшегося блока
                let newH = $extraFiltersBlock.outerHeight();
                // Ставим высоту, которая была при загрузке страницы. Чтобы не было резкого скачка
                $extraFiltersBlock.css('max-height', startH);
                // Ставим transition для анимации
                $extraFiltersBlock.css('transition', '.3s');
                // Убираем высоту - чтобы начала работать анимация
                setTimeout(function () {
                    $extraFiltersBlock.css('max-height', newH);

                    setTimeout(function () {
                        $extraFiltersBlock.css('max-height', '');
                        $extraFiltersBlock.css('transition', '');
                    }, 300);
                }, 20);
            }
            // Если блок закрылся, то...
            else {
                $extraFiltersBlock.css('max-height', heightBeforeToggleClass);
                $extraFiltersBlock.css('transition', '.3s');

                setTimeout(function () {
                    $extraFiltersBlock.css('max-height', '');

                    setTimeout(function () {
                        $extraFiltersBlock.css('transition', '');
                    }, 300);
                }, 0);
            }
        });
    }


    // -------------------------------------------
    // Подсказка в чекбоксах в фильтрах
    // -------------------------------------------
    // Они есть только на кровле
    if ($('body[data-ctx="krovlya"]').length) {
        const PAGE_TYPE_CATALOG = 1;
        const PAGE_TYPE_PRODUCT = 2;

        let pageType;
        if ($('.colors-options .euv-custom-select__option').length) {
            pageType = PAGE_TYPE_PRODUCT;
        } else if ($('.listing__filter').length) {
            pageType = PAGE_TYPE_CATALOG;
        } else {
            return;
        }

        // Пытаемся загрузить JSON с подсказками из файла
        $.getJSON('/assets/template/json/filters-tips.json', [], function (tipsData) {
                // В анимации используется setTimeout. Анимация активируется при клике. Если быстро покликать, то могут быть глюки в анимации. Чтобы их не было, нужно очищать timeout. Чтобы очищать timeout, нужно где-то его хранить. Данная переменная нужна для этой цели
                let animationTimeout = null;
                let positionTimeout = null;

                switch (pageType) {
                    case PAGE_TYPE_PRODUCT:
                        let key = 'msoption|cvet';
                        // Для страницы товара нужны именно цвета
                        if (!tipsData[key]
                            || Object.keys(tipsData[key]).length === 0
                            || Object.getPrototypeOf(tipsData[key]) !== Object.prototype) {
                            return;
                        } else {
                            for (const value in tipsData[key]) {
                                // Ищем опцию с нужным ключом
                                let $fltrVal = $('.colors-options .euv-custom-select__option[data-value="' + value + '"]');

                                // Если нашли, то...
                                if ($fltrVal.length) {
                                    let tipContent;

                                    // Тут может быть либо путь к картинке, либо hex-код цвета
                                    let cssBgValue;

                                    if (Array.from(tipsData[key][value]['visual'])[0] == '#') {
                                        cssBgValue = tipsData[key][value]['visual'];
                                    } else {
                                        cssBgValue = 'url(\'' + tipsData[key][value]['visual'] + '\')';
                                    }

                                    tipContent = '<div class="wintip__visual-text"><div class="wintip__visual" style="background: ' + cssBgValue + '"></div><div class="wintip__text-wrap"><strong class="wintip__header">' + value + '</strong><span class="wintip__text">' + tipsData[key][value]['text'] + '</span></div></div>';

                                    // Добавляем подсказку
                                    let $tip = $('<div class="filter-option__tip"><span class="filter-option__tip-icon"></span><div class="filter-option__tip-content">' + tipContent + '</div></div>');
                                    $fltrVal.append($tip);
                                }
                            }
                        }

                        break;
                    case PAGE_TYPE_CATALOG:
                        // Ищем фильтр с нужным ключом
                        for (const keyFilter in tipsData) {
                            let $fltr = $('.listing__filter-block[data-key="' + keyFilter + '"]');
                            // Если нашли, то...
                            if ($fltr.length) {
                                for (const value in tipsData[keyFilter]) {
                                    // Ищем опцию с нужным ключом
                                    let $fltrVal = $fltr.find('.filter-option[data-value="' + value + '"]');
                                    // Если нашли, то...
                                    if ($fltrVal.length) {
                                        // Определяем внутренний контент подсказки: это либо текст, либо (в некоторых случаях, например, для опции цвет) html-код
                                        let tipContent;
                                        if (keyFilter == 'msoption|cvet') {
                                            // Тут может быть либо путь к картинке, либо hex-код цвета
                                            let cssBgValue;

                                            if (Array.from(tipsData[keyFilter][value]['visual'])[0] == '#') {
                                                cssBgValue = tipsData[keyFilter][value]['visual'];
                                            } else {
                                                cssBgValue = 'url(\'' + tipsData[keyFilter][value]['visual'] + '\')';
                                            }

                                            tipContent = '<div class="wintip__visual-text"><div class="wintip__visual" style="background: ' + cssBgValue + '"></div><div class="wintip__text-wrap"><strong class="wintip__header">' + value + '</strong><span class="wintip__text">' + tipsData[keyFilter][value]['text'] + '</span></div></div>';
                                        } else {
                                            tipContent = tipsData[keyFilter][value];
                                        }

                                        // Добавляем подсказку
                                        let $tip = $('<div class="filter-option__tip"><span class="filter-option__tip-icon"></span><div class="filter-option__tip-content">' + tipContent + '</div></div>');
                                        $fltrVal.append($tip);
                                    }
                                }
                            }
                        }
                        break;
                }

                // Устанавливаем $winTip и добавляем его на страницу
                let $winTip = $('<div class="wintip"><span class="wintip__btn-close"></span><div class="wintip__content"></div></div>').appendTo('body');

                // Добавляем обработчик для клика по подсказке
                $(document).on('click', '.filter-option__tip', function (e) {
                    // На странице товара есть стилизованный список с цветами, там тоже подсказки. Но элементы списка - ссылки. И если нажать на вызов подсказки, будет переход по ссылке. preventDefault отменяет переход
                    e.preventDefault();

                    let $this = $(this);
                    clearTimeout(animationTimeout);

                    $('.filter-option__tip.active').not(this).removeClass('active');
                    $this.toggleClass('active');

                    if ($this.hasClass('active')) {
                        clearTimeout(positionTimeout);
                        $winTip.find('.wintip__content').html($this.find('.filter-option__tip-content').html());

                        $winTip.addClass('visible');
                        // Я заметил, что если делать без timeout'а, то иногда неправильно определяется ширина winTip. Из-за этого неправильно выставляется положение на странице
                        // Я вызываю setWinTipPosition 2 раза, чтобы пользователь не ждал 350 ms, чтобы увидеть winTip
                        setWinTipPosition($this);
                        positionTimeout = setTimeout(function () {
                            setWinTipPosition($this);
                        }, 350);
                    } else {
                        hideTip();
                    }
                });

                // Функция для установки позиции подсказки
                function setWinTipPosition($tip) {
                    let positionTop = $tip.offset().top;
                    let positionLeft = $tip.offset().left;
                    if (window.innerWidth <= 1200) {
                        let winTipWidth = $winTip.outerWidth();
                        positionLeft = positionLeft - winTipWidth + 60;
                    }
                    $winTip.css({
                        'top': positionTop,
                        'left': positionLeft,
                    });
                }

                // Функция для скрывания подсказки
                function hideTip() {
                    $winTip.removeClass('visible');
                    animationTimeout = setTimeout(function () {
                            $winTip.css({
                                'top': '',
                                'left': '',
                            });
                        },
                        // Если будешь менять это значение, то поменяй еще и у transition opacity в SASS
                        350);
                }

                // Вешаем обработчик на документ - клик по пустому месту должен скрывать подсказку
                $(document).on('click', function (e) {
                    let $target = $(e.target);
                    if (
                        // Подсказка должна быть видна
                        $winTip.hasClass('visible') &&
                        // Клик не должен быть по кнопке для вызова подсказки (или ее содержимых элементов)
                        !$target.closest('.filter-option__tip').length && !$target.hasClass('filter-option__tip') &&
                        // Клик не должен быть по самой подсказке (или ее содержимых элементов, исключение - кнопка для закрытия подсказки (крестик))
                        (!$target.closest('.wintip').length || $target.hasClass('wintip__btn-close')) && !$target.hasClass('wintip')
                    ) {
                        $('.filter-option__tip.active').removeClass('active');
                        hideTip();
                    }
                });
            }
        );
    }


    // -------------------------------
    // Кнопка "Показать все" в фильтрах
    // -------------------------------
    if ($isCatalogPage) {
        let resourceId = parseInt($('body').attr('data-resource-id'));

        $('.listing__filter-block').each(function (i, e) {
            let $e = $(e);
            let dataKey = $e.attr('data-key');
            let limit = 5;

            // В некотрых категориях нужно выводить не 5, а 6 или больше значений некоторых фильтров. Если будешь это менять / убирать, подправь и в filterCheckboxNew.tpl
            if (([37609, 19847, 37478].indexOf(resourceId) !== -1 && dataKey == 'msoption|proizvoditel') ||
                ((resourceId == 86214) && dataKey == 'msoption|profil') ||
                ([16788, 86214, 22594].indexOf(resourceId) !== -1 && dataKey == 'msoption|pokrytie')
            ) {
                limit = 6;
            } else if ((resourceId == 16788 && dataKey == 'msoption|collection') || ([16788, 86214, 22594].indexOf(resourceId) !== -1 && dataKey == 'msoption|cvet')) {
                limit = 8;
            }

            if ($e.find('.filter-option').length > limit) {
                $e.addClass('listing__filter-block_with-excess-elems');
                let $btnMore = $('<span class="listing__filter-block-btn-more" data-text="Свернуть все">Показать все</span>').appendTo($e.find('.listing__filter-block-content'));
                $btnMore.on('click', function (event) {
                    event.preventDefault();
                    $e.toggleClass('listing__filter-block_show-excess');
                    $e.find('.js-custom-scrollbar').overlayScrollbars().update();
                    functions.toggleText($(this), 'data-text');
                });
            }
        });
    }


    // -------------------------------
    // Фиксированный сайдбар
    // -------------------------------
    // Сайдбар есть только на странице каталога. Проверяем, действительно ли открыта страница каталога
    if ($isCatalogPage && $aside.length) {
        // TODO: удали ненужные переменные. Подчисть код

        // Объявление переменных
        // Если меняешь это значение, то поменяй и top в SASS. Это отступ от сайдбара до верхней грани окна
        const asideTopCSS = 20;

        // Текущий отступ от начала страницы до окна
        let currentOffsetTopWindow = $(window).scrollTop();
        // Последний отступ от начала страницы до окна. Нужен, чтобы понять, куда пользователь скроллит - вверх страницы или вниз. Если это значение меньше текущего отступа, то пользователь скроллит вниз. Если больше, то вверх
        let lastOffsetTopWindow = currentOffsetTopWindow;

        // Элемент - плитка с товарами
        let $listingContent = $('.listing__content');

        // Величина, на которую проскроллен сайдбар
        let sidebarScrollValue;
        // Величина, на которую МОЖНО проскроллить сайдбар
        let sidebarScrollValueMax;

        // Текущий отступ от сайдбара до его родителя
        let currentOffsetTopAside;
        // Отступ от начала страницы до блока с товарами
        let currentOffsetTopListing;
        // Высота сайдбара
        let heightAside;


        let newAsideTopCSSVal;

        // Функция для расчета сайдбара
        function handleAside() {
            // На ширине <= 1200 нет сайдбара. Поэтому никаких действий не надо делать, выходим из функции
            if (window.innerWidth <= 1200) {
                // console.log('[БЕЗДЕЙСТВИЕ] Ширина <= 1200 - выходим из функции handleAside');
                $aside.css('top', '');
                return;
            }

            heightAside = $aside.outerHeight();
            // Никаких действий делать не надо, если высота сайдбара меньше, чем высота окна - все сделает CSS свойство "position: sticky"
            if (heightAside < window.innerHeight) {
                // console.log('[БЕЗДЕЙСТВИЕ] Сайдбар по высоте меньше окна - выходим из функции handleAside');
                return;
            }

            // Обновляем переменные
            lastOffsetTopWindow = currentOffsetTopWindow;
            currentOffsetTopWindow = $(window).scrollTop();
            currentOffsetTopAside = $aside.offset().top;
            currentOffsetTopListing = $listingContent.offset().top;

            sidebarScrollValue = parseInt($aside.css('top'));
            sidebarScrollValueMax = 0 - (heightAside - window.innerHeight + asideTopCSS);


            // Скролл вверх
            if (lastOffsetTopWindow > currentOffsetTopWindow) {
                // console.log('Скролл вверх, поскольку lastOffsetTopWindow > currentOffsetTopWindow', lastOffsetTopWindow, currentOffsetTopWindow);

                // Сайдбар - это sticky, поэтому никакие расчеты не нужны, если нижняя грань окна браузера ниже нижней грани контейнера sticky
                if ((currentOffsetTopWindow + window.innerHeight) > (currentOffsetTopListing + $listingContent.outerHeight())) {
                    // console.log('[БЕЗДЕЙСТВИЕ] окно ниже, чем sticky контейнер');
                    return;
                }

                newAsideTopCSSVal = (sidebarScrollValue + (lastOffsetTopWindow - currentOffsetTopWindow));

                // console.log('Разница между последним скроллом и текущим скроллом равна 100 ', lastOffsetTopWindow - currentOffsetTopWindow);
                // console.log('Текущее значение top у сайдбара', sidebarScrollValue);
                // console.log('Новое значение top для сайдбара', newAsideTopCSSVal);

                if (newAsideTopCSSVal > asideTopCSS) {
                    newAsideTopCSSVal = asideTopCSS;

                    // console.log('Новое значение оказалось > asideTopCSS. Поэтому устанавливаем его равным asideTopCSS', newAsideTopCSSVal);
                }

                // console.log('[Действие] Установка нового значения', newAsideTopCSSVal);
                $aside.css('top', newAsideTopCSSVal);
                return;
            }
            // Скролл вниз
            else if (lastOffsetTopWindow < currentOffsetTopWindow) {
                if (currentOffsetTopListing > currentOffsetTopWindow) {
                    return;
                }

                newAsideTopCSSVal = (sidebarScrollValue + (lastOffsetTopWindow - currentOffsetTopWindow));

                // console.log('Текущее значение top у сайдбара', sidebarScrollValue);
                // console.log('Новое значение top для сайдбара', newAsideTopCSSVal);

                if (newAsideTopCSSVal > asideTopCSS) {
                    newAsideTopCSSVal = asideTopCSS;

                    // console.log('Новое значение оказалось > asideTopCSS. Поэтому устанавливаем его равным asideTopCSS', newAsideTopCSSVal);
                }

                if (newAsideTopCSSVal < sidebarScrollValueMax) {
                    newAsideTopCSSVal = sidebarScrollValueMax;
                }

                // console.log('[Действие] Установка нового значения', newAsideTopCSSVal);
                $aside.css('top', newAsideTopCSSVal);
                return;
            }
        }

        handleAside();
        $(window).on('resize scroll', handleAside);
    }


    // -------------------------------------------
    // Раскрывашка с цветами
    // -------------------------------------------
    let $selectionsBtn = $('.selections__btn');
    if ($selectionsBtn.length) {
        if ($('.selections__item').length > 5) {
            $selectionsBtn.show();
        }

        $selectionsBtn.on('click', function (e) {
            e.preventDefault();
            let $this = $(this);
            $this.closest('.selections').toggleClass('show-all');
            functions.toggleText($this, 'data-text');
        });
    }


    // -------------------------------------------
    // Прайс-лист в pdf
    // -------------------------------------------
    // TODO: по-хорошему, прайслист надо генерировать через php. И тогда убрать window-переменные:
    //  window.pdffont, window.jsPDF, window.jsPDFAutoTable
    //  Глобальные window-переменные - это что-то типа костылей, они нужны, т.к. скрипт с библиотеками для создания прайслистов подключается динамически, а код, в котором используются библиотеки, написан здесь, из-за этого возникают проблемы с областью видимости
    //  Я генерирую через JS, т.к. есть опыт именно с JS-библиотеками, а сроки для выполнения задачи небольшие.
    let $downloadPricelistBtn = $('span.listing__btn-download-pricelist');

    if ($downloadPricelistBtn.length) {
        // Timeout для убирания класса загрузки с кнопки. Я замечал, что во время загрузки JS немного глючит, из-за чего можно несколько раз нажать на кнопку для скачивания прайс-листа и выдастся много прайс-листов
        let removeClassTimeout;

        // Определение полей для pdf
        const spaceFromTopEdge = 58; // Верхнее поле
        const spaceFromLeftEdge = 40; // Левое поле
        const spaceFromRightEdge = 40; // Правое поле
        const spaceFromBottomEdge = 30; // Нижнее поле

        // Расстояние между несколькими таблицами на одном листе (но в данном случае на одном листе всего одна таблица будет - такой код в JSON). Также эта переменная участвует в расчете расстояния для переноса одной таблицы на следующий лист
        const spaceBetweenTables = 30;

        // Сколько файлов по AJAX нужно загрузить для формирования прайслиста?
        let needToLoadFiles = 2;
        // Сколько файлов по AJAX уже загружено?
        let uploadedFiles = 0;

        // Это первый клик по кнопке для скачивания прайс-листа (файлы нужно загружать)?
        let fstClick = true;

        // Данные из JSON-файла
        let pricelistData = [];

        // Вешаем обработчик на кнопку
        $downloadPricelistBtn.on('click', function () {
            // Проверяем класс загрузки на кнопке
            if ($downloadPricelistBtn.hasClass('loading')) {
                return false;
            }
            // Добавляем класс загрузки на кнопку
            $downloadPricelistBtn.addClass('loading');

            // Подключаем JSON файл с данными и библиотеки для создания прайс-листа (если это еще не сделано)
            if (fstClick) {
                fstClick = false;

                // Скачиваем JSON файл
                $.getJSON($downloadPricelistBtn.attr('data-href'), function (data) {
                    pricelistData = data;
                    increaseUploadedAndCallCreatePricelist();
                });

                // Подключаем библиотеки
                let script = document.createElement('script');
                script.type = 'text/javascript';
                script.src = '/assets/template/js/module_filter_table.js';
                document.getElementsByTagName('head')[0].appendChild(script);
                script.addEventListener('load', function () {
                    increaseUploadedAndCallCreatePricelist();
                });
            } else {
                // А если это уже сделано, то просто переходим к следующему шагу
                createPricelist();
            }
        });

        /**
         * Поскольку JSON-файл с данными и библиотеки подключаются асинхронно, неизвестно, что подключится быстрее. Но однозначно должно быть подключено 2 файла. Эта функция увеличивает переменную, отвечающую за кол-во подключенных файлов, и пытается запустить процесс создания прайс-листа
         */
        function increaseUploadedAndCallCreatePricelist() {
            uploadedFiles++;
            createPricelist();
        }

        /**
         * Функция для создания прайс-листа
         */
        function createPricelist() {
            // Если еще не все файлы загрузились, то выходим из функции
            if (uploadedFiles < needToLoadFiles) {
                return;
            }

            let doc = new window.jsPDF('p', 'pt');

            // Высота листа
            const pageHeight = doc.internal.pageSize.getHeight();
            // Ширина листа
            const pageWidth = doc.internal.pageSize.getWidth();

            // Добавляем шрифт, чтобы отображалась кириллица
            let font = window.pdffont;
            doc.addFileToVFS('Roboto-Regular-normal.ttf', font);
            doc.addFont('Roboto-Regular-normal.ttf', 'Roboto-Regular', 'normal');
            doc.setFont('Roboto-Regular');

            // Заголовки таблицы
            let tableHead = ['Название', 'Цена'];
            // Тело таблицы
            let tableBody = [];
            $(pricelistData.items).each(function (index, value) {
                tableBody.push(value);
            });
            // Название таблицы
            let tableTitle = pricelistData['title'];

            // Добавляем переносы строк, если название таблицы длинное
            tableTitle = doc.splitTextToSize(tableTitle, pageWidth - spaceFromLeftEdge - spaceFromRightEdge);

            // Получаем высоту заголовка таблицы. Это значение нужно для расчета корректного расстояния сверху листа
            const titleHeight = doc.getTextDimensions(tableTitle).h;
            // "+ 10" я сделал на глаз - для красоты
            const minSpaceFromTopEdge = spaceFromTopEdge + titleHeight + 10;

            // Y координата конца последней нарисованной таблицы. Если значение больше высоты листа (pageHeight), то из него вычитается высота листа
            let newTablePositionY = doc.previousAutoTable.finalY;

            // Проверяем newTablePositionY (и меняем, если необходимо)
            if (typeof newTablePositionY !== 'undefined') {
                // Если на странице почти не осталось места, то выводим таблицу на новую страницу ("+ 10" я подобрал на глаз - вдруг место снизу есть, заголовок вмещается, а таблица на следующей странице - как-то некрасиво)
                if ((newTablePositionY + spaceBetweenTables + titleHeight + 10) >= (pageHeight - spaceFromBottomEdge)) {
                    newTablePositionY = 0;
                    doc.addPage();
                }

                // Если newTablePositionY окажется меньше minSpaceFromTopEdge (таблица рисуется на новом листе), то заголовок таблицы врежется в верхний колонтитул. Поэтому нужно изменить newTablePositionY
                // Казалось бы, можно просто увеличить пространство верхнего колонтитула, зачем так мудрить? Но тогда у таблиц, которые растянулись на несколько листов, будет один колонтитул, а у таблиц, начинающихся с нового листа - другой (ведь у них есть заголовок)
                if (newTablePositionY <= minSpaceFromTopEdge) {
                    newTablePositionY = minSpaceFromTopEdge;
                } else {
                    newTablePositionY = newTablePositionY + spaceBetweenTables + titleHeight;
                }
            }
            // Отступ для самой первой таблицы. Он нужен для заголовка таблицы. Если отступа не будет, то заголовок врежется в содержимое верхнего колонтитула
            else {
                newTablePositionY = minSpaceFromTopEdge;
            }

            // Выводим заголовок перед таблицей ("+ 5" я подобрал на глаз - для красоты, а то заголовок слишком далеко от таблицы)
            doc.text(tableTitle, spaceFromLeftEdge, newTablePositionY - titleHeight + 5);

            // Рисуем таблицы
            new window.jsPDFAutoTable(doc, {
                head: [tableHead],
                body: tableBody,
                styles: {
                    font: 'Roboto-Regular',
                    fontStyle: 'normal',
                },

                // Цвет для шапки
                headStyles: {
                    fillColor: pricelistData['headerBgColor'],
                    halign: 'center',
                    valign: 'middle'
                },

                // Поля листа
                margin: {
                    top: spaceFromTopEdge,
                    bottom: spaceFromBottomEdge,
                    left: spaceFromLeftEdge,
                    right: spaceFromRightEdge
                },

                // Указываем атрибут startY - это отступ для каждой таблицы от предыдущей
                // jspdf-autotable сам расставляет отступы (и без этого атрибута), но они маленькие - в них не получится разместить заголовок таблицы
                startY: newTablePositionY
            });

            // Добавляем колонтитулы для листов
            addColontitulsToPricelist(doc, pageWidth, pricelistData);

            // Отдаем пользователю готовую pdf-ку
            doc.save(pricelistData['title'] + '.pdf');

            // Убираем класс загрузки с кнопки
            clearTimeout(removeClassTimeout);
            removeClassTimeout = setTimeout(function() {
                $downloadPricelistBtn.removeClass('loading');
            }, 1000);
        }


        /**
         * Добавляет колонтитулы для всех листов документа doc.
         * @param doc
         * @param pageWidth
         * @param pricelistData
         */
        function addColontitulsToPricelist(doc, pageWidth, pricelistData) {
            const pageCount = doc.internal.getNumberOfPages();
            const colontitulHeight = 50;
            const imgOffsetY = (colontitulHeight - pricelistData['logoHeight']) / 2;
            const colontitulEdgeMarginX = 10;

            // Логотип
            let logoImg = new Image();
            logoImg.src = pricelistData['logoPath'];

            // Телефон
            doc.setFontSize(10);
            let phoneText = pricelistData['phone'];
            let phoneTextWidth = doc.getTextDimensions(phoneText).w;
            let phoneMarginLeft = pageWidth - phoneTextWidth - colontitulEdgeMarginX;
            // Email
            doc.setFontSize(9);
            let emailText = pricelistData['email'];
            let emailTextWidth = doc.getTextDimensions(emailText).w;
            let emailMarginLeft = pageWidth - emailTextWidth - colontitulEdgeMarginX;

            // Цикл для создания колонтитулов на всех страницах
            for (let i = 1; i <= pageCount; i++) {
                doc.setPage(i);

                // TODO: Я заметил, что во вкладке Network в браузере картинка загружается для каждого листа, а это замедляет отдачу pdf'ки пользователю. Надо поискать, как загрузить картинку ВСЕГО 1 РАЗ
                // Логотип - картинка
                doc.addImage(logoImg, 'png', colontitulEdgeMarginX, imgOffsetY, pricelistData['logoWidth'], pricelistData['logoHeight']);

                // Телефон
                doc.setFontSize(10);
                doc.text(pricelistData['phone'], phoneMarginLeft, 22);

                // Электронный адрес
                doc.setFontSize(9);
                doc.text(pricelistData['email'], emailMarginLeft, 36);
            }
        }
    }
}


function alignPrices() {
    let group = [];
    let lastPriceElemTop = 0;
    let currPriceElemTop = 0;

    let $items = $('.listing__products-item');
    $items.each(function (i, e) {
        let $priceElem = $(e).find('.listing__products-item-price-and-logo');
        $priceElem.css('margin-top', '');
        currPriceElemTop = $priceElem.offset().top;

        if (lastPriceElemTop === 0) {
            lastPriceElemTop = currPriceElemTop;
        }

        let event1 = Math.abs(currPriceElemTop - lastPriceElemTop) > 300;
        let event2 = i === $items.length - 1;
        if (event1 || event2) {
            if (event2 && !event1) {
                group.push({
                    'elem': $priceElem,
                    'value': currPriceElemTop
                });
            }

            let arrayOfTops = group.map(a => a.value);
            let maxKey = arrayOfTops.indexOf(Math.max.apply(window, arrayOfTops));
            let maxVal = arrayOfTops[maxKey];

            group.forEach(function (item, index) {
                item['elem'].css('margin-top', maxVal - item['value']);
            });

            group = [];
            currPriceElemTop = $priceElem.offset().top;
        }

        group.push({
            'elem': $priceElem,
            'value': currPriceElemTop
        });

        lastPriceElemTop = currPriceElemTop;
    });
}


function catalogSortFilters() {
    $('.listing__filter-block').each(function (index, elem) {
        // Пропускаем фильтр по цене
        if (index === 0) {
            return;
        }

        let $this = $(this);
        let $container = $($this.find('.listing__filter-option')[0]).parent();

        let $items = $container.find('.listing__filter-option').sort(function (a, b) {
            if (isNaN(parseInt($(a).attr('data-priority')))) {
                return -1;
            }

            if (isNaN(parseInt($(b).attr('data-priority')))) {
                return 1;
            }

            if (parseInt($(a).attr('data-priority')) > parseInt($(b).attr('data-priority'))) {
                return -1;
            }

            if (parseInt($(a).attr('data-priority')) < parseInt($(b).attr('data-priority'))) {
                return 1;
            }

            return 0;
        });

        $items.appendTo($container);
    });
}


function catalogSortColorless() {
    // TODO: хорошо бы проверку написать - есть ли "Бесцветный" или нет. Чтобы за зря не сортировать, это же время отнимает
    $('#mse2_msoption\\|ottenok,#mse2_msoption\\|cvet').each(function (index, elem) {
        let $this = $(this);
        let $container = $($this.find('.listing__filter-option')[0]).parent();

        let $items = $container.find('.listing__filter-option').sort(function (a, b) {
            if ($(a).attr('data-val') === 'бесцветный' || $(a).attr('data-val') === 'бц-бесцветный') {
                return -1;
            }

            return 0;
        });

        $items.appendTo($container);
    });
}


function getRemainder() {
    // Количество товаров в листинге
    let amount = $('.js-catalog .js-product').length;
    let $btnMore = $('#mse2_mfilter .btn_more, .sect-listing__content .btn_more');

    // Проверка - существует ли листинг на основе pdoPage или mSearch2. И есть ли в таком листинге товары
    if (((typeof mSearch2 !== 'undefined' && mSearch2) ||
        (typeof pdoPage !== 'undefined' && pdoPage))
        && amount) {
        // Всего товаров
        let total;
        if (typeof mSearch2 !== 'undefined') {
            total = parseInt(mSearch2.total.text());
        } else {
            total = parseInt($('#pdopage_total').text());
        }

        // Сколько осталось вывести товаров?
        let remainder = 0;

        let remainderMax = 44;
        if ($btnMore.attr('data-max')) {
            remainderMax = $btnMore.attr('data-max');
        }

        if (total > amount) {
            remainder = total - amount;
        }
        if (remainder > remainderMax) {
            remainder = remainderMax;
        }

        // Установка текста для кнопки
        $btnMore.text('Показать еще ' + remainder);
    }
}


/**
 * Перенос строки в названии в чанках товаров на pro-fanera и plitaosb
 */
function wrapTitle() {
    if ($('.pro-fanera, .plitaosb').length) {
        $('.listing__products-item .listing__products-item-title a').each(function (i, e) {
            let $e = $(e);
            let text = $e.text();
            let sort = $e.closest('.listing__products-item').attr('data-sort');
            // Добавляем перенос строки после сорта
            if (sort) {
                sort = functions.escapeRegExp(sort);
                if (text.match(new RegExp(sort)) !== null) {
                    text = text.replace(new RegExp('(' + sort + ')\\s*'), '$1<br>');
                }
            }
                // Если сорта в названии нет, то перенос надо делать после названия предмета
            // Как вытащить из названия товара название продаваемого предмета? Как правило, название товара состоит из {Название предмета} {Сорт} {Размер}. Получается, перенос надо делать перед {Размер}. А размер - это следующее сочетание: числоХчисло или числоХчислоХчисло. Число может быть дробным. В качестве разделителя целой и дробной частей может быть как точка, так и запятая. В качестве разделителя чисел может быть как русская Х, так и английская X.
            else {
                text = text.replace(/(([0-9]+[.,])?[0-9]+[хx]([0-9]+[.,])?[0-9]+([хx]([0-9]+[.,])?[0-9]+)?)/, '<br>$1');
            }

            // Устанавливаем новое значение
            $e.html(text);
        });
    }
}


/**
 * Изменить позицию блока "Снизим цену"
 *
 * Не используется, поскольку позиция блока теперь расчитывается на back-end.
 * Можно удалять, но я пока решил оставить - вдруг пригодится.
 * Я вызывал эту функцию в modxJS и при загрузке страницы.
 */
// function discountBlockPosition() {
//     if ($discountBlock === null) {
//         return;
//     }
//
//     let $items = $('.listing__products-list .listing__products-item');
//     let afterPosition = 1;
//
//     if ($items.length === 0) {
//         $discountBlock.hide();
//         return;
//     }
//
//     $discountBlock.show();
//
//     if ($items.length === 1) {
//         afterPosition = 0;
//     }
//
//     $discountBlock.insertAfter($items.eq(afterPosition));
// }
