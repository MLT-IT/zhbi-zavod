import functions from "./functions";

/**
 * Функции, относящиеся к шаблону Каталог (в основном работа с mFilter2).
 */
export default {
    init,
    catalogSortFilters,
    catalogSortColorless,
    getRemainder,
    wrapTitle,
    alignPrices
};

let $discountBlock = $('.listing__catalog-promo');
if (!$discountBlock.length) {
    $discountBlock = null;
}

// Инициализация
function init() {
    // Перенос строки в названии в чанках товаров на pro-fanera и plitaosb
    wrapTitle();


    // -------------------------------------------
    // Панель с фильтрами на мобилках
    // -------------------------------------------
    let $openFiltersBtn = $(".listing__open-filters-btn");
    if ($openFiltersBtn.length) {
        // Основные переменные
        let $filter = $(".listing__filter");

        function toggleFiltersbar(skipChangeClasses) {
            let filterPanelWidth = $filter.outerWidth();

            skipChangeClasses = (typeof skipChangeClasses !== 'undefined') ? skipChangeClasses : false;

            if (!skipChangeClasses) {
                $filter.toggleClass("active");
                $('body').toggleClass("freeze-page");
            }

            // Панель открылась
            if ($filter.hasClass('active')) {
                $filter[0]['swapMinX'] = 0;
                $filter[0]['swapMaxX'] = filterPanelWidth;
            }
            // Панель закрылась
            else {
                $filter[0]['swapMinX'] = -filterPanelWidth;
                $filter[0]['swapMaxX'] = 0;
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
                $filter.hasClass('active') &&
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
        Drog.on($filter[0], {
            swapMinY: 0,
            swapMaxY: 0,
            swapMaxX: 0,
            swapMinX: -$filter.outerWidth(),
            elem: $('.listing__filter-btn')[0]
        });

        $filter.on('drogEnd', function () {
            let filterPanelWidth = $filter.outerWidth();
            let translateX = 0;

            // Если фильтры открыты
            if ($filter.hasClass('active')) {
                // Если достаточно сильно свайпнули панель с фильтрами, то необходимо закрыть ее
                if ($filter[0]['-x'] >= (filterPanelWidth / 2 - 10)) {
                    translateX = filterPanelWidth;
                }
            }
            // Если фильтры закрыты
            else {
                // Если достаточно сильно свайпнули панель с фильтрами, то необходимо открыть ее
                if ($filter[0]['-x'] <= (0 - (filterPanelWidth / 2 - 10))) {
                    translateX = -filterPanelWidth;
                }
            }

            // Возвращение шторки (с анимацией). Либо возвращаем шторку в исходное положение (какой она была до того, как пользователь начал ее тянуть). Либо помогаем пользователю открыть / закрыть ее
            $filter.css({
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
                Drog.move($filter[0], 0, 0);

                // Отменяем transition для шторки, т.к. она уже переместилась
                $filter.removeAttr('style');

                if (translateX !== 0) {
                    // Делаем transition мгновенным (в css он прописан для right, из-за этого будет ненужный скачок)
                    $filter.css('transition', 'all 0s');
                    // Меняется right в стилях
                    $filter.toggleClass("active");
                    // ВАЖНО! Функция toggleFiltersbar обязательно должна идти ПОСЛЕ установки класса active, потому что в ней он проверяется
                    toggleFiltersbar(true);

                    // Между отменой мгновенного transition и действиями со стилями необходимо подождать немного
                    setTimeout(function () {
                        // Отменяем мгновенный transition
                        $filter.removeAttr('style');
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
    catalogSortColorless();


    // -------------------------------------------
    // Скрыть / показать характеристики на карточках
    // -------------------------------------------
    $(document).on('click', '.listing__products-item-chars-btn', function (e) {
        e.preventDefault();
        $(this).closest('.listing__products-item-chars-wrap').toggleClass('active');
    });

    if ($('.listing').length) {
        let lastW = 0;

        $(window).resize(function () {
            let $charsWrap = $('.listing__products-item-chars-wrap');
            if (window.innerWidth <= 768 && (lastW > 768)) {
                $charsWrap.removeClass('active');
            } else if (window.innerWidth > 768 && (lastW <= 768)) {
                $charsWrap.addClass('active');
            }
            lastW = window.innerWidth;
        }).resize();
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
    $('.listing__filter-block-content input[type="checkbox"]').on('change', function () {
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

        // window on resize (with throttling)
        let timeoutAction;
        $(window).on('resize', function () {
            clearTimeout(timeoutAction);
            timeoutAction = setTimeout(alignPrices, 1000);
        });

        // Почему-то после загрузки страницы цены не всегда становятся выравненными. Я решил добавить дополнительное выравнивание с помощью интервалов
        for (let i = 0; i < 10; i++) {
            setTimeout(function () {
                alignPrices();
            }, i * 300);
        }
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
        // Пытаемся загрузить JSON с подсказками из файла
        $.getJSON('/assets/template/json/filters-tips.json', [], function (tipsData) {
            // В анимации используется setTimeout. Анимация активируется при клике. Если быстро покликать, то могут быть глюки в анимации. Чтобы их не было, нужно очищать timeout. Чтобы очищать timeout, нужно где-то его хранить. Данная переменная нужна для этой цели
            let animationTimeout = null;
            let positionTimeout = null;

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

            // Устанавливаем $winTip и добавляем его на страницу
            let $winTip = $('<div class="wintip"><span class="wintip__btn-close"></span><div class="wintip__content"></div></div>').appendTo('body');

            // Добавляем обработчик для клика по подсказке
            $(document).on('click', '.filter-option__tip', function (e) {
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
        });
    }


    // -------------------------------
    // Фиксированный сайдбар
    // -------------------------------
    // Сайдбар есть только на странице каталога. Проверяем, действительно ли открыта страница каталога
    if ($('.listing').length) {
        // Объявление перепенных. В большинстве случаев я ставлю 0, т.к. на момент объявления значения неважны

        // Если меняешь это значение, то поменяй и top в SASS. Это отступ от сайдбара до верхней грани окна
        const asideTopCSS = 20;

        // Текущий отступ от начала страницы до окна
        let currentOffsetTopWindow = $(window).scrollTop();

        // Элемент - плитка с товарами
        let $listingContent = $('.listing__content');
        // Элемент - сайдбар
        let $aside = $('.listing__filter');

        // Величина, на которую проскроллен сайдбар
        let sidebarScrollValue = 0;
        // Величина, на которую МОЖНО проскроллить сайдбар
        let sidebarScrollValueMax = 0;

        // Текущий отступ от сайдбара до его родителя
        let currentOffsetTopAside = 0;
        // Отступ от начала страницы до блока с товарами
        let currentOffsetTopListing = 0;
        // Высота сайдбара
        let heightAside = 0;
        // Нижняя граница, на которой сайдбар должен остановиться
        let sidebarEdgeBottom = 0;
        // Верхняя граница, на которой сайдбар должен прекратить быть фиксированным
        let sidebarEdgeTop = 0;

        // Функция для расчета сайдбара
        function handleAside() {
            // На ширине <= 1200 нет сайдбара. Поэтому никаких действий не надо делать, выходим из функции
            if (window.innerWidth <= 1200) {
                console.log('[БЕЗДЕЙСТВИЕ] Ширина <= 1200 - выходим из функции handleAside');
                return;
            }

            heightAside = $aside.outerHeight();
            // Никаких действий делать не надо, если высота aside меньше, чем высота окна - все сделает CSS свойство "position: sticky"
            if (heightAside < window.innerHeight) {
                console.log('[БЕЗДЕЙСТВИЕ] Сайдбар по высоте меньше окна - выходим из функции handleAside');
                return;
            }

            // Обновляем переменные
            currentOffsetTopWindow = $(window).scrollTop();
            currentOffsetTopAside = $aside.offset().top;
            currentOffsetTopListing = $listingContent.offset().top;

            sidebarScrollValue = parseInt($aside.css('top'));
            sidebarScrollValueMax = 0 - (heightAside - window.innerHeight + asideTopCSS);

            let newAsideTopCSSVal = 0 - (currentOffsetTopWindow - currentOffsetTopListing);

            if (newAsideTopCSSVal > asideTopCSS) {
                console.log('[БЕЗДЕЙСТВИЕ] Новое значение для сайдбара больше, чем значение по умолчанию - выходим из функции handleAside');
                $aside.css('top', asideTopCSS);
                return;
            }

            if (newAsideTopCSSVal < sidebarScrollValueMax) {
                newAsideTopCSSVal = sidebarScrollValueMax;
            }

            if (currentOffsetTopListing < currentOffsetTopWindow) {
                console.log('[ДЕЙСТВИЕ] Установлено новое значение для сайдбара', newAsideTopCSSVal);
                $aside.css('top', newAsideTopCSSVal);
                return;
            }
        }

        handleAside();
        $(window).on('resize scroll', handleAside);
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
            if (!event1) {
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
