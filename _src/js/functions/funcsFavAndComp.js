import functions from "./functions";

/**
 * Функции, относящиеся к товару (добавление в корзину, изменение, удаление, переключение единиц измерения...).
 */
export default function funcsFavAndComp(Cookies, trim, formOfWord) {
    // -------------------------------
    // Избранное и сравнение
    // -------------------------------
    // Берет куки с товарами, превращает в массив, удаляет повторяющиеся элементы, возвращает результат {array}.
    // Принимает параметр - название куки. Это либо favIds, либо compIds
    function getSplitted(cookie) {
        let ids = Cookies.get(cookie);
        if (typeof ids === 'undefined') {
            ids = '';
        }

        // Обрезаем ненужные символы
        let splitted = trim(ids, '-');

        // Превращаем значение куки в массив
        splitted = splitted.split('-');

        // Удаляем повторяющиеся элементы
        splitted = splitted.filter(function (item, pos) {
            return splitted.indexOf(item) === pos;
        })

        // Удаляем пустые элементы из массива
        splitted = splitted.filter(n => n)

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

        switch (true) {
            case ($this.hasClass('product-item__btn-fav') || $this.hasClass('listing__products-item-btn-fav')):
                pageUri = '/favorites/';
                targetText1 = 'избранное';
                targetText2 = 'избранного';
                cookieName = 'favIds';
                splitted = getSplitted(cookieName);
                break;
            case $this.hasClass('product-item__btn-compare') || $this.hasClass('product-item__actions-compare') || $this.hasClass('listing__products-item-btn-compare'):
                pageUri = '/comparison/'
                targetText1 = 'сравнение';
                targetText2 = 'сравнения';
                cookieName = 'compIds';
                splitted = getSplitted(cookieName);
                break;
        }

        // Дополнительные переменные
        let id = $this.closest('.product-item').find('input[name="id"]').val();
        let message = '<br><a href="' + window.location.origin + pageUri + '">Посмотреть</a>';

        // Переключение класса
        $this.toggleClass('active');

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
        let $sup = $('.title-1__sup');
        if ($sup.length) {
            $sup.text(splitted.length + ' ' + formOfWord(splitted.length, 'товар', 'товара', 'товаров'));
        }

        // Удаление товара из сравнения
        if ($this.hasClass('listing__products-item-fav-remove-btn')) {
            $(this).closest('.comp-slide').remove();

            // Если перключатель "Только отличающиеся" включен, то делаем проверку товаров на отличающиеся
            let $toggler = $('.custom-toggler__input');
            if ($toggler.is(':checked')) {
                checkOnlyDifferent($toggler);
            }

            // Если это была последняя карточка, то удаляем слайдер с карточками
            if (!$('.comp-slide').length) {
                $('.sect-pop__wrapper .swiper-container, .sect-pop__wrapper .sect-pop__swiper-buttons').remove();
            }

            // Обновление слайдера (т.к. изменилось количество карточек)
            if ($sup.length) {
                window.dispatchEvent(new Event('resize'));
                // Скрыть / показать кнопки слайдера
                let $buttons = $('.swiper-buttons');
                if ($('.comp-slide').not('.hidden').length > 4) {
                    $buttons.show();
                } else {
                    $buttons.hide();
                }
                setOrRemoveIndent();
            }
        }

        // --------------------------------------------
        // Если мы находимся на странице избранного
        // --------------------------------------------
        // Удаление товара из избранного
        if ($this.is('.listing__products_full .listing__products-item-btn-fav')) {
            $(this).closest('.product-item').remove();
        }
    }

    // Обработчики кнопок для добавления / удаления товара из избранного / сравнения
    $(document).on('click', '.product-item__btn, .product-item__action-btn', actionsHandler);
    $(document).on('change', '.product-item__actions-compare', actionsHandler);

    // Обновить кнопки в шапке
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

    // -------------------------------
    // Отступ на странице сравнения
    // -------------------------------
    let $comparison = $('.sect-comparison');

    function setOrRemoveIndent() {
        if ($('.comp-slide').not('.hidden').length <= 4) {
            $comparison.removeClass('with-buttons');
        } else {
            $comparison.addClass('with-buttons');
        }
    }

    if ($comparison.length) {
        setOrRemoveIndent();
    }


    // -------------------------------
    // Только отличающиеся
    // -------------------------------
    function checkOnlyDifferent($toggler) {
        if ($toggler.is(':checked')) {
            // Массив, где ключи - это название опций, а значения - это {id товара: значение опции}
            let options = [];
            // Массив с id товаров
            let itemsIds = [];

            let $productItems = $('.product-item');
            $productItems.each(function () {
                let $this = $(this);
                let id = $this.find('[name="id"]').val();
                itemsIds.push(id);
                $this.find('.pop-slide__option').each(function () {
                    let $opt = $(this);
                    let key = ($opt.find('.pop-slide__option-caption').html()).trim();
                    let val = ($opt.find('.pop-slide__option-value').html()).trim();
                    if (typeof options[key] === 'undefined') {
                        options[key] = [];
                    }
                    options[key][id] = val;
                });
            });

            let duplicates = [];
            // Проходимся по всем опциям
            for (let opt in options) {
                // Проходимся по всем товарам
                itemsIds.forEach(function (id, index) {
                    // У тех товаров, где опция не заполнена, ставим прочерк
                    if (typeof options[opt][id] === 'undefined') {
                        options[opt][id] = '-';
                    }
                });

                // Получаем только дубликаты
                const duplicateOpts = {};
                options[opt].forEach(function (x) {
                    duplicateOpts[x] = (duplicateOpts[x] || 0) + 1;
                });

                let lengthDuplicates = Object.keys(duplicateOpts).length;
                let lengthItems = options[opt].filter(n => n).length;

                if (lengthDuplicates === 1 && lengthItems > 1) {
                    duplicates.push(opt);
                }
            }

            // Проходимся по всем карточкам и выводим опции
            itemsIds.forEach(function (id, index) {
                $('.product-item input[name="id"][value="' + id + '"]').each(function () {
                    let $optionsWrap = $(this).closest('.product-item').find('.pop-slide__options-wrap_type_only-different');
                    $optionsWrap.html('');
                    for (let opt in options) {
                        if (duplicates.indexOf(opt) === -1) {
                            let $htmlOption = $('<div class="pop-slide__option" data-title="' + opt + '">' +
                                '   <div class="pop-slide__option-caption">' + opt + '</div>' +
                                '   <div class="pop-slide__option-value">' + options[opt][id] + '</div>' +
                                '</div>');
                            $htmlOption.appendTo($optionsWrap);
                        }
                    }
                });
            });
        } else {
            $('.comp-slide.hidden').removeClass('hidden');
        }

        // Обновляем текст в h1
        let length = $('.comp-slide').not('.hidden').length;
        $('.title-1__sup').text(length + ' ' + formOfWord(length, 'товар', 'товара', 'товаров'));

        // Обновляем высоту характеристик
        setHeightToOptions();
    }

    if ($comparison.length) {
        $('.custom-toggler__input').on('change', function () {
            $comparison.toggleClass('sect-comparison_only-different');
            checkOnlyDifferent($(this));
        });
    }

    // --------------------------------------------
    // Высота характеристик в сравнении
    // --------------------------------------------
    function setHeightToOptions() {
        let itemsHeight = [];
        $('.pop-slide__option').each(function () {
            let $this = $(this);
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

    if ($comparison.length) {
        $(window).on('resize', function () {
            setHeightToOptions();
        }).trigger('resize');
    }
}
