import functions from "./functions";
import Cookies from 'js-cookie';

/**
 * Функции, относящиеся к избранному и сравнению.
 */
export default {
    init
};

// Инициализация
function init() {
    // -------------------------------
    // Инициализация
    // -------------------------------
    let $comparison = $('.sect-comparison');

    // Обработчики кнопок для добавления / удаления товара из избранного / сравнения
    $(document).on('click', '.js-product__btn, .js-product__action-btn', actionsHandler);
    $(document).on('change', '.js-product__actions-compare', actionsHandler);

    // Если мы находимся на странице сравнения
    if ($comparison.length) {
        // Установка отступа
        setOrRemoveIndent($comparison);

        // Установка обработчика для переключателя "Только отличающиеся"
        $('.custom-toggler__input').on('change', function () {
            $comparison.toggleClass('sect-comparison_only-different');
            refreshOptions();
        });

        // Работа с характеристиками
        refreshOptions();

        // Установка обработчка для правильной высоты опций
        $(window).on('resize', setHeightToOptions);
    }
}


/**
 * Берет куки с товарами, превращает в массив, удаляет повторяющиеся элементы, возвращает результат - массив.
 *
 * @param cookie - название куки. Это либо favIds, либо compIds.
 * @returns {*}.
 */
function getSplitted(cookie) {
    let ids = Cookies.get(cookie);
    if (typeof ids === 'undefined') {
        ids = '';
    }

    // Обрезаем ненужные символы
    let splitted = functions.trim(ids, '-');

    // Превращаем значение куки в массив
    splitted = splitted.split('-');

    // Удаляем повторяющиеся элементы
    splitted = splitted.filter(function (item, pos) {
        return splitted.indexOf(item) === pos;
    });

    // Удаляем пустые элементы из массива
    splitted = splitted.filter(n => n);

    return splitted;
}


/**
 * Обработчики кнопок для добавления / удаления товара из избранного / сравнения.
 * @param e - событие.
 */
function actionsHandler(e) {
    e.preventDefault();

    // Основные переменные и константы
    let $this = $(this);
    let pageUri;
    let targetText1;
    let targetText2;
    let splitted;
    let cookieName;
    let $product = $this.closest('.js-product');

    switch (true) {
        // TODO: зачем по 2-3 класса? Подправь стили и скрипты, чтобы для JS был один класс
        case ($this.hasClass('js-product__btn-fav') || $this.hasClass('listing__products-item-btn-fav')):
            pageUri = '/favorites/';
            targetText1 = 'избранное';
            targetText2 = 'избранного';
            cookieName = 'favIds';
            splitted = getSplitted(cookieName);

            // Переключение класса. Кнопок в $product может быть несколько. На странице товара с перелинковкой это так - одна для ПК, другая для мобилок. Поэтому ищем все и переключаем у них класс
            $product.find('.js-product__btn-fav, .listing__products-item-btn-fav').toggleClass('active');
            break;
        case $this.hasClass('js-product__btn-compare') || $this.hasClass('js-product__actions-compare') || $this.hasClass('listing__products-item-btn-compare'):
            pageUri = '/comparison/';
            targetText1 = 'сравнение';
            targetText2 = 'сравнения';
            cookieName = 'compIds';
            splitted = getSplitted(cookieName);

            // Переключение класса
            $product.find('.js-product__actions-compare, .listing__products-item-btn-compare, .js-product__btn-compare').toggleClass('active');
            break;
    }

    // Дополнительные переменные
    let id = $product.find('input[name="id"]').val();
    let message = '<br><a href="' + window.location.origin + pageUri + '">Посмотреть</a>';

    // Добавляем или удаляем новый элемент в массив с куки
    if (($this.prop("tagName") === 'INPUT' && $this.is(':checked')) || ($this.prop("tagName") !== 'INPUT' && $this.hasClass('active'))) {
        splitted.push(id);
        message = 'Товар добавлен в ' + targetText1 + message;
    } else {
        const index = splitted.indexOf(id);
        if (index > -1) {
            splitted.splice(index, 1);
        }
        message = 'Товар удален из ' + targetText2;
    }

    // Обновляем кнопку в шапке
    refreshBtnsInHeader(splitted.length, cookieName);

    // Выводим сообщение
    miniShop2.Message.info(message);

    // Устанавливаем куки
    Cookies.set(cookieName, splitted.join('-'));

    // --------------------------------------------
    // Если мы находимся на странице сравнения
    // --------------------------------------------
    let $comparison = $('.sect-comparison');
    if ($comparison.length) {
        $('.title-1__sup').text(splitted.length + ' ' + functions.formOfWord(splitted.length, 'товар', 'товара', 'товаров'));

        // Удаление товара из сравнения
        if ($this.hasClass('listing__products-item-fav-remove-btn')) {
            $(this).closest('.comp-slide').remove();

            // Обновляем опции
            refreshOptions();

            // Если это была последняя карточка, то удаляем слайдер с карточками
            if (!$('.comp-slide').length) {
                $('.sect-pop__wrapper .swiper-container, .sect-pop__wrapper .sect-pop__swiper-buttons').remove();
            }

            // Обновление слайдера (т.к. изменилось количество карточек)
            window.dispatchEvent(new Event('resize'));
            // Скрыть / показать кнопки слайдера
            let $buttons = $('.swiper-buttons');
            if ($('.comp-slide').not('.hidden').length > 4) {
                $buttons.show();
            } else {
                $buttons.hide();
            }
            setOrRemoveIndent($comparison);
        }
    }

    // --------------------------------------------
    // Если мы находимся на странице избранного
    // --------------------------------------------
    if ($('.listing__products_full').length) {
        // Удаление товара из избранного
        if ($this.hasClass('listing__products-item-btn-fav')) {
            $(this).closest('.js-product').remove();
        }
    }
}


/**
 * Обновляет кнопки в шапке.
 * @param length - длина, которая будет в кружочке.
 * @param cookieName - название куки, влияет на то, какую именно кнопку обновить.
 */
function refreshBtnsInHeader(length, cookieName) {
    switch (cookieName) {
        case 'favIds':
            $('.header__fav-value').text(length);
            break;
        case 'compIds':
            $('.header__comp-value').text(length);
            break;
    }
}


/**
 * Устанавливает или удаляет отступ для кнопок, переключающих слайды
 */
function setOrRemoveIndent($comparison) {
    if ($('.comp-slide').not('.hidden').length <= 4) {
        $comparison.removeClass('with-buttons');
    } else {
        $comparison.addClass('with-buttons');
    }
}


/**
 * Делает все опции в карточках товаров на странице сравнения на одном уровне. Добавляет прочерки в карточки, где определенных опций нет. При необходимости удаляет дубликаты.
 */
function refreshOptions() {
    // Селектор, где содержатся опции
    let charsWrapSelector;
    // Удалить дубликаты?
    let removeDuplicates = false;

    // Установка переменных charsWrapSelector и removeDuplicates
    if ($('.custom-toggler__input').is(':checked')) {
        charsWrapSelector = '.pop-slide__options-wrap_type_only-different';
        removeDuplicates = true;
    } else {
        charsWrapSelector = '.pop-slide__options-wrap_type_default';
    }

    // Массив, где ключи - это название опций, а значения - это объект типа: {id товара: значение опции}
    let options = [];
    // Массив с id товаров
    let itemsIds = [];
    // Массив с каточками товаров (jQuery)
    let $productItems = $('.comp-slide');

    // Заполняем options и itemsIds
    $productItems.each(function () {
        let $this = $(this);
        let id = $this.find('[name="id"]').val();
        itemsIds.push(id);
        $this.find('.pop-slide__options-wrap_type_source .pop-slide__option').each(function () {
            let $opt = $(this);
            let key = functions.trim($opt.find('.pop-slide__option-caption').html());
            let val = functions.trim($opt.find('.pop-slide__option-value').html());
            if (typeof options[key] === 'undefined') {
                options[key] = [];
            }
            options[key][id] = val;
        });
    });

    if (removeDuplicates) {
        // Массив с названием опций, которые являются одинаковыми во всех карточках
        var duplicates = [];
    }

    // Проходимся по всем опциям
    for (let opt in options) {
        // Проходимся по всем товарам
        itemsIds.forEach(function (id, index) {
            // У тех товаров, где опция не заполнена, ставим прочерк
            if (typeof options[opt][id] === 'undefined') {
                options[opt][id] = '-';
            }
        });

        // Ищем опции-дубликаты, если это необходимо
        if (removeDuplicates) {
            // Принцип следующий. Создается объект duplicateOpts. В него помещаются ключи - это значения опций. И значения - это кол-во таких значений. Потом проверяется кол-во ключей. Если ключ всего 1 для такой опции, то значения одинаковые у всех карточек на странице.
            let duplicateOpts = {};
            options[opt].forEach(function (x) {

                // В применении одинаковые варианты могут быть заполнены в разном порядке. Учитываем это
                if (opt === 'Применение') {
                    x = x.split(', ');
                    x = x.sort();
                    x.join(', ');
                }

                duplicateOpts[x] = (duplicateOpts[x] || 0) + 1;
            });

            let lengthDuplicates = Object.keys(duplicateOpts).length;
            let lengthItems = options[opt].filter(n => n).length;
            if (lengthDuplicates === 1 && lengthItems > 1) {
                duplicates.push(opt);
            }
        }
    }

    // Удаляем дубликаты
    if (removeDuplicates) {
        for (let opt in options) {
            if (duplicates.indexOf(opt) !== -1) {
                delete options[opt];
            }
        }
    }

    // Проходимся по всем карточкам и выводим опции
    itemsIds.forEach(function (id, index) {
        $('.js-product input[name="id"][value="' + id + '"]').each(function () {
            // Контейнер, где находятся все опции
            let $optionsWrap = $(this).closest('.js-product').find(charsWrapSelector);

            // Очищаем этот контейнер
            $optionsWrap.html('');

            // Добавляем опции в контейнер
            for (let opt in options) {
                let $htmlOption = $('<div class="pop-slide__option" data-title="' + opt + '">' +
                    '   <div class="pop-slide__option-caption">' + opt + '</div>' +
                    '   <div class="pop-slide__option-value">' + options[opt][id] + '</div>' +
                    '</div>');

                if (opt === 'Цена без скидки') {
                    $htmlOption.prependTo($optionsWrap);
                } else {
                    $htmlOption.appendTo($optionsWrap);
                }

                $htmlOption.mouseenter(function () {
                    $(charsWrapSelector + ' .pop-slide__option[data-title="' + $(this).attr('data-title') + '"]').addClass('hover');
                }).mouseleave(function () {
                    $('.pop-slide__option.hover').removeClass('hover');
                });
            }
        });
    });

    // Обновляем высоту опций
    setHeightToOptions();
}


/**
 * Установка высоты опций в карточках на странице сравнения
 */
function setHeightToOptions() {
    let itemsHeight = [];
    $('.pop-slide__options-wrap:visible').find('.pop-slide__option').each(function () {
        let $this = $(this);
        $this.css('height', '');
        let dataTitle = $this.attr('data-title');
        let maxHeight = $this.height();

        if (typeof itemsHeight[dataTitle] === 'undefined') {
            itemsHeight[dataTitle] = maxHeight;
        } else if (itemsHeight[dataTitle] < maxHeight) {
            itemsHeight[dataTitle] = maxHeight;
        }
    });

    for (let title in itemsHeight) {
        $('.pop-slide__option[data-title="' + title + '"]').height(itemsHeight[title]);
    }
}
