import functions from "./functions";

/**
 * Функции, относящиеся к товару (добавление в корзину, изменение, удаление, переключение единиц измерения...).
 */
export default function funcsProduct(ImageZoom, formOfWord, getActiveUnitValue, numberWithSpaces, getActiveForm, getStep, getCorrectValueToCounter) {
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
    const $productCardImg = $(".zoom");
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
        changeCountItemInCart($(this).closest('.product-item'));
    });


    // -------------------------------
    // Изменить кол-во товара
    // -------------------------------
    function changeCountItemInCart($productItem, forbidZero) {
        forbidZero = typeof forbidZero !== 'undefined' ? forbidZero : false;

        // Товар в корзине?
        let inCart = false;
        // Счетчик с кол-вом товара
        let $inputAmount;

        // Все формы чанка
        let $forms = getActiveForm($productItem);
        // Системные формы, которые нужны для управления корзиной
        let $systemForm = $forms['system'];
        if ($productItem.hasClass('product-item-in-cart')) {
            inCart = true;
        }

        // Получаем input с количеством товара
        $inputAmount = $forms['action'];
        // На странице кровли с перелинковуой 2 формы - одна для ПК, другая для мобилок. Возможно, в будущем еще где-то будет также. Получаем видимую, она будет главной
        if ($inputAmount.length > 1) {
            $forms['action'].each(function (i, e) {
                if ($(e).is(':visible')) {
                    $inputAmount = $(e);
                }
            });
        }
        $inputAmount = $inputAmount.find('.custom-counter__amount');

        // Получаем последнее кол-во товара
        let lastVal = $inputAmount[0]['lastValue'];
        // Получаем новое кол-во товара, которое будет отображено на счетчике
        let val = $inputAmount.val();
        // Данный код нужен для расчета кол-ва соответственно кол-ву на поддоне
        // val = functions.getCorrectValueToCounter(getStep($productItem), val);

        // if ((isNaN(val) || lastVal == val)) {
        //     console.log('return', isNaN(val), lastVal == val);
        //     return;
        // }

        // Устанавливаем кол-во товара всем input'ам с количеством товара
        $forms['action'].each(function (i, e) {
            $(e).find('.custom-counter__amount').val(val);
        });

        // Устанавливаем то количество, которое будет добавлено в корзину
        let count = getItemCount($productItem, val);
        if (forbidZero && count === 0) {
            count = 1;
        }

        $systemForm.find('[name="count"]').val(count);

        // Если товар в корзине, то...
        if (inCart) {
            // Отправка
            $systemForm.find('[type="submit"]')[0].click();

            // Если кол-во равно нулю
            if (count === 0) {
                let $elemsAdd = $productItem.find('.product-item__controls_action_add');
                // refreshInput нужен, чтобы inputFilter запомнил текущее значение. И потом, если пользователь установит меньше минимального, подставится 1
                let clearVal = 1;
                // let clearVal = $productItem.attr('data-step');
                $elemsAdd.find('[name="count"]').val(clearVal).trigger('refreshInput');
                // Удаление класса, что товар этой карточки в корзине
                $productItem.removeClass('product-item-in-cart');
            }
        }

    }


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

        // Получение кол-ва
        let countRaw = $this.closest('.product-item__controls_action_add').find('.custom-counter__amount').val();
        let count = getItemCount($productItem, countRaw);

        // Установка кол-ва
        // В счетчик для изменения кол-ва. Цикл нужен, т.к. может быть 2 счетчика для изменения кол-ва. Первый - для ПК, второй - для мобилок
        $elemsChange.find('.custom-counter__amount').each(function (i, e) {
            $(e).val(countRaw);
            e["oldValue-change"] = count;
            e["lastValue"] = count;
        });
        // В скрытые поля
        $formAdd.find('[name="count"]').val(count);
        $('.product-item__form-change [name="count"]').val(count);

        // Отправка скрытой формы для добавления товара в корзину
        $formAdd.find('[type="submit"]')[0].click();
        // Добавление класса, что товар этой карточки в корзине
        $productItem.addClass('product-item-in-cart');
    });


    // -------------------------------
    // Обработчик списка в карточках для смены ед. измерения
    // -------------------------------
    $(document).on('change', 'select.product-item__units-select', function (e) {
        e.preventDefault();
        let $productItem = $(this).closest('.product-item');

        // Вызываем событие о том, что у товара изменилась ед. измерения
        $productItem.trigger('changeUnit');

        // ВАЖНО! Перерасчет цены и кол-ва товара должен быть ПОСЛЕ changeUnit, потому что на это событие вешается перерасчет step и кол-ва товара
        // Меняем цену
        calcPrice($productItem);
        // Пересчитываем кол-во товара в корзине
        changeCountItemInCart($productItem, true);
    });


    // -------------------------------
    // Получить кол-во товара, которое будет добавлено в корзину
    // -------------------------------
    function getItemCount($productItem, count) {
        let unitVal = getActiveUnitValue($productItem);
        count = parseFloat(count);

        // Получившееся кол-во
        count = 1 / unitVal * count;

        if ($productItem.find('.custom-counter_type_fractional').length) {
            count = Number((count).toFixed(2));
        } else {
            if ($('body.kirpich-m').length) {
                count = Math.round(count);
            } else {
                count = Math.ceil(count);
            }
        }

        // Результат
        return count;
    }


    // -------------------------------
    // Функция для смены цены в соответствии с ед. измерения
    // -------------------------------
    function calcPrice($productItem) {
        let unitVal = getActiveUnitValue($productItem);

        // Изменение цены
        const $price = $productItem.find('.product-item__price');
        if ($price.length) {
            const unit = $productItem.find('*[name="unit"]').val();
            let price = parseFloat($price.attr('data-default').replace(/\s/g, ''));
            if (isNaN(price)) {
                price = 0;
            }

            price = 1 / unitVal * price;
            if ($('body.kirpich-m').length) {
                price = Math.round(price);
            } else {
                price = Math.ceil(price);
            }

            price = Number((price).toFixed(2));
            price = numberWithSpaces(price);
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
    };

    // Удаление товара из корзины. Вызывается при нажатии на крестик на странице корзины
    miniShop2.Callbacks.Cart.remove.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count, response.data.total_cost);

            checkCart(response.data.total_cost);
        }
    };

    // Изменение товара в корзине. Вызывается при изменении кол-ва товара на странице корзины
    miniShop2.Callbacks.Cart.change.response.success = function (response) {
        if (response.success) {
            // Работа с мини-корзиной
            handleMiniCart(response.data.total_count, response.data.total_cost);

            checkCart(response.data.total_cost);
        }
    };

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
            let $productItem = $this.closest('.product-item');
            let val = $this.attr('data-val');
            let $unit = $('[name="unit"]');
            $productItem.attr('data-last-unit-value', functions.getActiveUnitValue($productItem));
            $('.product-card__unit-link.active').removeClass('active');
            $this.addClass('active');
            $unit.val(val);

            // ВАЖНО! Перерасчет цены и кол-ва товара должен быть ПОСЛЕ changeUnit, потому что на это событие вешается перерасчет step и кол-ва товара
            // Вызываем событие о том, что у товара изменилась ед. измерения
            $productItem.trigger('changeUnit');

            // Обработчик кнопки на странице товара для смены ед. измерения
            calcPrice($productItem);
            // Пересчитываем кол-во товара в корзине
            changeCountItemInCart($productItem, true);
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
            count = Number((count).toFixed(2));
            cartValue = count;
            $cartValueElem.add($cartInfoCountVal).text(count);
            $cartInfoCountText.text(formOfWord(count, 'товар', 'товара', 'товаров'));
        } else {
            cartValue = parseFloat($cartValueElem.text());
            cartValue = Number((cartValue).toFixed(2));
        }

        let cartCost;
        if (typeof cost !== 'undefined') {
            cost = Number((cost).toFixed(2));
            cartCost = numberWithSpaces(cost);
            $cartInfoCostVal.text(cartCost);
        }

        if (cartValue > 0) {
            $cartValueElem.removeClass('hidden');
        } else {
            $cartValueElem.addClass('hidden');
        }
    }

    handleMiniCart();
}
