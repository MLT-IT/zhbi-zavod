import functions from "./functions";

/**
 * Функции, относящиеся к товару (добавление в корзину, изменение, удаление, переключение единиц измерения...).
 */
export default function funcsProduct(ImageZoom, Cookies, trim, formOfWord) {
    // -------------------------------
    // Щелчок по якорю "Отзывы"
    // -------------------------------
    $('.product-card__reviews-quantity').on('click', function (e) {
        e.preventDefault();

        $('.product-card__tabs-button_type_reviews').trigger('click');

        $([document.documentElement, document.body]).animate({
            scrollTop: $(".product-card__tabs").offset().top
        }, 300);
    });

    // -------------------------------
    // Приближение при наведении на картинку
    // -------------------------------
    const $productCardImg = $(".product-card__img");
    if ($productCardImg.length) {
        new ImageZoom($productCardImg[0], {
            fillContainer: true,
            height: 260,
            zoomWidth: 500,
            offset: {vertical: 0, horizontal: 10},
        });
    }

    // -------------------------------
    // Обработчик счетчика на товарах
    // -------------------------------
    $(document).on('change', '.product-item .custom-counter__amount', function (e) {
        e.preventDefault();
        // Основные переменные
        let $this = $(this);
        let $productItem = $this.closest('.product-item');

        // Кол-во товара
        let count = $this.val();
        count = getItemCount($productItem, count);

        // Определение формы
        let $form;
        let inCart = false;
        if ($productItem.hasClass('product-item-in-cart')) {
            // Товар уже в корзине, нужно изменить кол-во
            $form = $productItem.find('.product-item__form-change');
            inCart = true;
        } else {
            // Товара нет в корзине
            $form = $productItem.find('.product-item__form-add');
        }

        // Установка кол-ва товара
        $form.find('[name="count"]').val(count);

        // Если товар в корзине, то...
        if (inCart) {
            // Отправка
            $form.find('[type="submit"]')[0].click();

            // Если кол-во равно нулю
            if (count === 0) {
                let $elemsAdd = $productItem.find('.product-item__controls_action_add');
                // trigger input нужен, чтобы inputFilter запомнил текущее значение. И потом, если пользователь установит меньше минимального, подставится 1
                $elemsAdd.find('[name="count"]').val(1).trigger('input');
                // Удаление класса, что товар этой карточки в корзине
                $productItem.removeClass('product-item-in-cart');
            }
        }
    });

    // -------------------------------
    // Обработчик кнопки для добавления товара в корзину
    // -------------------------------
    $(document).on('click', '.product-item .product-item__to-cart', function (e) {
        e.preventDefault();

        // Основные переменные
        let $this = $(this);
        let $productItem = $this.closest('.product-item');
        let $formAdd = $productItem.find('.product-item__form-add');
        let $elemsChange = $productItem.find('.product-item__controls_action_change');

        // Установка кол-ва
        // В счетчик
        let count = $productItem.find('.custom-counter__amount').val();
        $elemsChange.find('.custom-counter__amount').val(count);
        // В скрытые поля
        count = getItemCount($productItem, count);
        $formAdd.find('[name="count"]').val(count);
        $('.product-item__form-change [name="count"]').val(count);

        // Отправка
        $formAdd.find('[type="submit"]')[0].click();
        // Добавление класса, что товар этой карточки в корзине
        $productItem.addClass('product-item-in-cart');
    });

    // -------------------------------
    // Обработчик списка в карточках для смены ед. измерения
    // -------------------------------
    $(document).on('change', '.product-item__units-select', function (e) {
        e.preventDefault();
        let $productItem = $(this).closest('.product-item');
        calcPrice($productItem);
    });

    // -------------------------------
    // Получить кол-во товара, которое будет добавлено в корзину
    // -------------------------------
    function getItemCount($productItem, count) {
        // TODO: надо бы сделать проверку на isNaN
        let unitVal = functions.getActiveUnitValue($productItem);

        // Получившееся кол-во
        count = Math.ceil(1 / unitVal * count);

        // Результат
        return count;
    }

    // -------------------------------
    // Функция для смены цены в соответствии с ед. измерения
    // -------------------------------
    function calcPrice($productItem) {
        let unitVal = functions.getActiveUnitValue($productItem);

        // Изменение цены
        const $price = $productItem.find('.product-item__price');
        if ($price.length) {
            let price = parseFloat($price.attr('data-default').replace(/\s/g, ''));
            if (isNaN(price)) {
                price = 0;
            }

            price = functions.numberWithSpaces(Math.ceil(1 / unitVal * price));
            $price.text(price);
        }
    }

    // -------------------------------
    // Обработчики Minishop2
    // -------------------------------
    // Добавление товара в корзину. Вызывается при добавлении товара в корзину с карточки товара и со страницы товара
    miniShop2.Callbacks.Cart.add.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count, response.data.total_cost);
        }
    }

    // Удаление товара из корзины. Вызывается при нажатии на крестик на странице корзины
    miniShop2.Callbacks.Cart.remove.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count, response.data.total_cost);

            checkCart(response.data.total_cost);
        }
    }

    // Изменение товара в корзине. Вызывается при изменении кол-ва товара на странице корзины
    miniShop2.Callbacks.Cart.change.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count, response.data.total_cost);

            checkCart(response.data.total_cost);
        }
    }

    function checkCart(total_count) {
        // Если товаров в корзине 0. И если мы на странице корзины. То перезагружаем страницу
        if (total_count === 0 && $('.sect-cart').length) {
            location.reload();
        }
    }

    // -------------------------------
    // Работа со страницей товара
    // -------------------------------
    if ($('.product-card').length) {
        // Переключение ед. измерения на странице товара
        $('.product-card__unit-link').on('click', function (e) {
            e.preventDefault();
            let $this = $(this);
            $('.product-card__unit-link.active').removeClass('active');
            $this.addClass('active');
            $('[name="unit"]').val($this.attr('data-val'));

            // Обработчик кнопки на странице товара для смены ед. измерения
            calcPrice($this.closest('.product-item'));
        });

        // Вкладки на мобилках
        // Расставляем data-tab-page. Он нужен для кода в base.js. Это не только для мобилок, но и для ПК. Важно делать это через JS, т.к. некоторые вкладки могут не выводиться. А index должен быть по порядку
        $('.product-card__tabs-button').each(function (i, e) {
            $(this).attr('data-tab-page', i);
        });

        // Обработчик кнопок для смены вкладок
        $('.product-card__mobile-tabs-button').on('click', function (e) {
            e.preventDefault();
            let $this = $(this);
            let $tabsPage = $this.closest('.product-card__tabs-page');

            $('.product-card__tabs-page.active').removeClass('active');
            $this.closest('.product-card__tabs-page').addClass('active');

            let index = $tabsPage.index() + 1;
            $('.product-card__tabs-button.active').removeClass('active');
            $('.product-card__tabs-button:nth-child(' + index + ')').addClass('active');
        });
    }

    // -------------------------------
    // Мини-корзина в шапке сайта
    // -------------------------------
    function handleMiniCart(count, cost) {
        const $cartValueElem = $('.header__cart-value');
        const $cartInfoCountVal = $('.header__info-val_type_count-val');
        const $cartInfoCountText = $('.header__info-val_type_count-text');
        const $cartInfoCostVal = $('.header__info-val_type_cost-val');

        let cartValue;
        if (typeof count !== 'undefined') {
            cartValue = count;
            $cartValueElem.add($cartInfoCountVal).text(cartValue);
            $cartInfoCountText.text(functions.formOfWord(cartValue, 'товар', 'товара', 'товаров'));
        } else {
            cartValue = parseInt($cartValueElem.text());
        }

        let cartCost;
        if (typeof cost !== 'undefined') {
            cartCost = functions.numberWithSpaces(cost);
            $cartInfoCostVal.text(cartCost);
        }

        if (cartValue > 0) {
            $cartValueElem.removeClass('hidden');
        } else {
            $cartValueElem.addClass('hidden');
        }
    }

    handleMiniCart();

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
        if ($this.hasClass('listing__actions-btn-fav')) {
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
