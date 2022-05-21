import functions from "./functions";

/**
 * Функции, относящиеся к товару (добавление в корзину, изменение, удаление, переключение единиц измерения...).
 */
export default {
    init,
    initStyledCounter
};

// Инициализация
function init(ImageZoom) {
    // -------------------------------
    // Приближение при наведении на месте, а не в отдельном квадратике (js-image-zoom)
    // -------------------------------
    let $zoomImg = $('.zoom-here');
    if ($zoomImg.length) {
        $zoomImg.css('background-image', 'url(' + $zoomImg.find('img').attr('src') + ')');
        $zoomImg.mousemove(function (e) {
            let zoomer = e.currentTarget;
            let offsetX, offsetY;

            e.offsetX ? offsetX = e.offsetX : offsetX = e.touches[0].pageX;
            e.offsetY ? offsetY = e.offsetY : offsetX = e.touches[0].pageX;
            let x = offsetX / zoomer.offsetWidth * 100;
            let y = offsetY / zoomer.offsetHeight * 100;

            zoomer.style.backgroundPosition = x + '% ' + y + '%';
            zoomer.style.backgroundSize = 200 + '%';
        });
    }


    // -------------------------------
    // Код для страницы с перелинковкой для фанеры и плит ОСБ
    // -------------------------------
    // TODO: Будет красивее, если рассчитывать цену, вес и кол-во товара для м2 на back-end. Загружалось бы сразу с нужным количеством, а не менялось на глазах от JS.
    let $proFaneraCard = $('.product-card_type_relinking-btns');
    if ($proFaneraCard.length) {
        let $productItem = $('.product-card__content .js-product');

        $productItem.on('changeAmount', changeAmountHandler);
        changeAmountHandler();

        function changeAmountHandler() {
            let $activeForm = functions.getActiveForm($productItem);
            let amount = $activeForm.action.find('.custom-counter__amount').val();

            // Установка цены
            let price = $productItem.find('.js-product__price').attr('data-default');
            let priceNewVal = Number(amount * price).toFixed(2);
            $('.product-card__price-val_type_total').text(functions.numberWithSpaces(priceNewVal));

            if ($productItem.hasClass('js-product_with-discount')) {
                let newPrice = $productItem.find('.js-product__new-price').attr('data-default');
                let newPriceNewVal = Number(amount * newPrice).toFixed(2);
                $('.product-card__new-price').text(functions.numberWithSpaces(newPriceNewVal));
            }

            // Установка веса
            let weight = $('.js-product__weight').attr('content');
            if (weight > 0) {
                let newWeight = Number(amount * weight).toFixed(2);
                $('.product-card__weight-val').text(functions.numberWithSpaces(newWeight));
            }
        }

        // Если товар есть в корзине, то надо пересчитать кол-во м2
        if ($proFaneraCard.find('.js-product-in-cart')) {
            let $amountM2 = $('.custom-counter__amount[data-purpose="m2"]');
            $amountM2.val(($amountM2.val() * $amountM2.attr('data-koeff')).toFixed(2));
        }
    }


    // -------------------------------------
    // Щелчок по якорю "Отзывы"
    // -------------------------------------
    $('.product-card__reviews-quantity').on('click', function (e) {
        e.preventDefault();

        $('.product-card__tabs-button_type_reviews').trigger('click');

        $([document.documentElement, document.body]).animate({
            scrollTop: $(".product-card__tabs").offset().top
        }, 300);
    });


    // -------------------------------------
    // Приближение при наведении на картинку
    // -------------------------------------
    // Объявляем эту переменную до if, т.к. она еще понадобится
    let ImageZoomInstance;

    const $productCardImg = $(".zoom");
    if ($productCardImg.length) {
        ImageZoomInstance = new ImageZoom($productCardImg[0], {
            height: 260,
            width: 260,
            zoomWidth: 500,
            offset: {vertical: 0, horizontal: 10},
        });
    }


    // -------------------------------------
    // Обработчик счетчика на товарах - в карточке, в листинге, везде
    // -------------------------------------
    $(document).on('change', '.js-product .custom-counter__amount', function (e) {
        e.preventDefault();
        changeCountItemInCart($(this).closest('.js-product'), false, $(this));
    });


    // -------------------------------------
    // Пересчет "В листе" при изменении кол-ва товара в карточке товара для фанеры
    // -------------------------------------
    let $prod = $('.pro-fanera .product-card__top');
    if ($prod.length) {
        function changeTextDependingOnAmount($prod) {
            let m2 = $('.product-card__specs-list-item[data-opt-key="ploshad_m2"] .product-card__specs-list-item-value').text();
            let m3 = $('.product-card__specs-list-item[data-opt-key="obyem_m3"] .product-card__specs-list-item-value').text();

            let amount = functions.getActiveForm($prod)['action'].find('.custom-counter__amount').val();
            m2 *= amount;
            m3 *= amount;

            if (m2) {
                m2 += ' м2';
            }

            if (m3) {
                m3 += ' м3';
            }

            let val;
            if (amount == 1) {
                val = 'В листе: ';
            } else {
                val = 'В ' + amount + ' ' + functions.formOfWord(amount, 'листе', 'листах', 'листах') + ': ';
            }
            val += [m2, m3].join(', ');

            $('.product-card__package').text(val).show();
        }

        changeTextDependingOnAmount($prod);

        $prod.on('changeAmount', function () {
            changeTextDependingOnAmount($(this));
        });
    }


    // -------------------------------------
    // Обработчик кнопки для добавления товара в корзину - в карточке, в листинге, везде
    // -------------------------------------
    $(document).on('click', '.js-product .js-product__to-cart', function (e) {
        e.preventDefault();

        // Основные переменные
        let $this = $(this);
        let $productItem = $this.closest('.js-product');
        let $formAdd = $productItem.find('.js-product__form-add');
        let $formChange = $productItem.find('.js-product__controls_action_change');
        let $closestFormAdd = $(this).closest('.js-product__controls_action_add');
        let purposes = {};

        // Обновление input'ов в форме для изменения кол-ва товара
        /*
        После добавления товара к узлу добавляется класс, который скрывает форму для добавления и показывает форму для изменения кол-ва товара. В этой форме input'ы имеют неправильное значение, нужно обновить его в соответствии с тем, которое указал пользователь при добавлении товара в корзину.
        Но проблема в том, что input'ов может быть несколько: один для штук, другой для м2 (так в карточке с перелинковкой для фанеры). И в них должны быть разные значения (взаимо-сконвертированные). Для этого им указывается атрибут data-purpose, значения input'ов заносятся в массив, где ключ - это значение данного атрибута.
        Если же input всего один, то массив с data-purpose будет пустым. Таким образом, сначала проверяем массив с data-purpose. Если он пустой, то просто копируем значение.
        */
        // Получение кол-ва
        let countRaw = $closestFormAdd.find('.custom-counter__amount').val();
        let count = getItemCount($productItem, countRaw);

        $closestFormAdd.find('.custom-counter__amount').each(function (i, e) {
            let $e = $(e);
            let key = $e.attr('data-purpose');
            if (typeof key !== 'undefined') {
                purposes[key] = $e.val();
            }
        });

        // Установка кол-ва в пользовательский счетчик для изменения кол-ва
        // Цикл для input'ов нужен, т.к. может быть 2 счетчика для изменения кол-ва. Первый - для ПК, второй - для мобилок. Так, например, в карточке с перелинковкой для кровли
        if (Object.keys(purposes).length) {
            for (let key in purposes) {
                $formChange.find('.custom-counter__amount[data-purpose="' + key + '"]').each(function (i, e) {
                    $(e).val(purposes[key]);
                    e["oldValue-change"] = purposes[key];
                    e["lastValue"] = purposes[key];
                });
            }
        } else {
            $formChange.find('.custom-counter__amount').each(function (i, e) {
                $(e).val(countRaw);
                e["oldValue-change"] = count;
                e["lastValue"] = count;
            });
        }

        // В скрытые поля
        $formAdd.find('[name="count"]').val(count);
        $('.js-product__form-change [name="count"]').val(count);

        // Отправка скрытой формы для добавления товара в корзину
        $formAdd.find('[type="submit"]')[0].click();
        // Добавление класса, что товар этой карточки в корзине
        $productItem.addClass('js-product-in-cart');
    });


    // -------------------------------------
    // Обработчик списка для смены ед. измерения - в карточке, в листинге, везде
    // -------------------------------------
    $(document).on('change', 'select.js-product__units-select', function (e) {
        e.preventDefault();
        let $productItem = $(this).closest('.js-product');

        // Вызываем событие о том, что у товара изменилась ед. измерения
        $productItem.trigger('changeUnit');

        // ВАЖНО! Перерасчет цены и кол-ва товара должен быть ПОСЛЕ changeUnit, потому что на это событие вешается перерасчет step и кол-ва товара
        // Меняем цену
        calcPrice($productItem);
        // Пересчитываем кол-во товара в корзине
        changeCountItemInCart($productItem, true);
    });


    // -------------------------------------
    // Обработчики Minishop2
    // -------------------------------------
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


    // -------------------------------------
    // Работа со страницей товара
    // -------------------------------------
    if ($('.product-card').length) {
        // Переключение ед. измерения на странице товара
        $('.product-card__unit-link').on('click', function (e) {
            e.preventDefault();
            let $this = $(this);
            let $productItem = $this.closest('.js-product');
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

    // -------------------------------------
    // Мини-корзина в шапке сайта
    // -------------------------------------
    handleMiniCart();


    // -------------------------------------
    // Галерея
    // -------------------------------------
    let $galleryItem = $('.product-card__gallery-item');
    let $gallerySlider = $('.product-card__gallery-slider');

    if ($gallerySlider.length) {
        $galleryItem.on('click', function (e) {
            e.preventDefault();

            // Основные переменные
            let $this = $(this);
            let srcBig = $this.attr('href');
            let srcSmall = $this.find('.product-card__gallery-item-img').attr('src');

            // Меняем элемент с классом active
            $this.parent().find('.active').removeClass('active');
            $this.addClass('active');
            // Меняем картинку (href - для всплывашки, src - для избражения)
            $('.product-card__img-link').attr('href', srcBig);
            $('.product-card__img').attr('src', srcSmall);

            // Поскольку картинка сменилась, нужно обновить скрипт для увеличения при наведении
            if (typeof ImageZoomInstance !== 'undefined') {
                ImageZoomInstance.setup();
            }
        });

        // Если шаблон с перелинковкой, то вешаем обработчик для показа / скрытия стрелок в слайдере галереи
        if ($('.product-card_type_relinking').length) {
            $(window).on('resize', onResizeHandler);
            onResizeHandler();

            function onResizeHandler() {
                if (window.innerWidth > 480) {
                    let commonSlidesHeight = 0;
                    let mb = parseFloat($galleryItem.css('margin-bottom'));
                    let $btnsWrap = $('.product-card__gallery-btns-wrap');

                    // Я сделал новый jQuery селектор, чтобы удобнее было отлаживать (так можно через devtools добавлять слайды). После отладки можно заменить селектор на $galleryItem
                    $('.product-card__gallery-item').each(function (i, e) {
                        commonSlidesHeight += $(e).outerHeight(true);
                    });

                    // Вычитаем один margin-bottom, т.к. Swiper добавляет его даже для последнего элемента
                    commonSlidesHeight -= mb;
                    // Отнимаем несколько пикселей, чтобы стрелки не появлялись, если карточки чуть-чуть не вмещаются
                    commonSlidesHeight -= 10;

                    if ($gallerySlider.height() < commonSlidesHeight) {
                        $btnsWrap.show();
                    } else {
                        $btnsWrap.hide();
                    }
                }
            }
        }
    }


    // -------------------------------------
    // Стилизованный счетчик и стилизованный список
    // -------------------------------------
    initStyledCounter();
}

/**
 * Изменение кол-ва товара.
 */
function changeCountItemInCart($productItem, forbidZero, $target) {
    forbidZero = typeof forbidZero !== 'undefined' ? forbidZero : false;
    $target = typeof $target !== 'undefined' ? $target : null;

    // Товар в корзине?
    let inCart = false;
    // Счетчик с кол-вом товара
    let $inputAmount;

    // Все формы чанка
    let $forms = functions.getActiveForm($productItem);
    // Системные формы, которые нужны для управления корзиной
    let $systemForm = $forms['system'];
    if ($productItem.hasClass('js-product-in-cart')) {
        inCart = true;
    }

    if ($target === null) {
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
    } else {
        $inputAmount = $target;
    }

    // Получаем новое кол-во товара, которое будет отображено на счетчике
    let val = $inputAmount.val();

    // Устанавливаем кол-во товара всем input'ам с количеством товара. Дело в том, что их на странице может быть несколько (например, на кровле там - для мобилок одна форма, для ПК - другая. И по-хорошему, они должны быть синхронизированы)
    $forms['action'].each(function (i, e) {
        $(e).find('.custom-counter__amount').each(function (i, e) {
            let valTmp = val;
            let $checkedAmount = $(e);

            // Коэффициент проверяемого счетчика
            let koeff1 = $checkedAmount.attr('data-koeff');
            // Коэффициент изменяемого счетчика
            let koeff2 = $inputAmount.attr('data-koeff');

            // Коэфициент есть у проверяемого счетчика, но нет у изменяемого
            let cond1 = typeof koeff1 !== 'undefined' && typeof koeff2 === 'undefined';
            // Коэфициент есть у изменяемого счетчика, но нет у проверяемого
            let cond2 = typeof koeff1 === 'undefined' && typeof koeff2 !== 'undefined';

            // Если ни одно из условий в switch не сработало, значит, коэфициента нет ни у проверяемого, ни у изменяемого счетчиков
            switch (true) {
                // Коэфициент есть у проверяемого счетчика, но нет у изменяемого
                case (cond1):
                    valTmp = koeff1 * valTmp;
                    break;
                // Коэфициент есть у изменяемого счетчика, но нет у проверяемого
                case (cond2):
                    valTmp = valTmp / koeff2;
                    break;
            }

            if ($productItem.find('.custom-counter_type_fractional').length) {
                valTmp = Number(valTmp).toFixed(2);
            } else {
                if ($('body.kirpich-m').length) {
                    valTmp = Math.round(valTmp);
                } else {
                    valTmp = Math.ceil(valTmp);
                }
            }

            if (!$checkedAmount.is($inputAmount)) {
                if (!$checkedAmount.parent().hasClass('custom-counter_type_fractional')) {
                    valTmp = Math.ceil(valTmp);
                }

                // parseFloat нужен, чтобы удалить ненужные нули в конце числа
                valTmp = parseFloat(valTmp);
                $checkedAmount.val(valTmp);
            }

            if (cond2) {
                val = valTmp;
            }
        });
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
            let $elemsAdd = $productItem.find('.js-product__controls_action_add');
            // refreshInput нужен, чтобы inputFilter запомнил текущее значение. И потом, если пользователь установит меньше минимального, подставится 1
            $elemsAdd.find('[name="count"]').each(function (i, e) {
                let $e = $(e);
                let newVal = 1;
                if ($e.attr('data-koeff')) {
                    newVal = $e.attr('data-koeff') * newVal;
                }
                $e.val(newVal).trigger('refreshInput');
            });
            // Удаление класса, что товар этой карточки в корзине
            $productItem.removeClass('js-product-in-cart');
        }
    }

    $productItem.trigger('changeAmount');
}


/**
 * Получить кол-во товара, которое будет добавлено в корзину (зависит от выбранной единицы измерения).
 */
function getItemCount($productItem, count) {
    let unitVal = functions.getActiveUnitValue($productItem);
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


/**
 * Смена цены в соответствии с ед. измерения.
 */
function calcPrice($productItem) {
    let unitVal = functions.getActiveUnitValue($productItem);
    let selectors = [];

    selectors.push('.js-product__price');
    if ($productItem.hasClass('js-product_with-discount')) {
        selectors.push('.js-product__new-price');
    }

    selectors.forEach(function (selector) {
        let $elem = $productItem.find(selector);

        if ($elem.length) {
            let value = parseFloat($elem.attr('data-default').replace(/\s/g, ''));
            if (isNaN(value)) {
                value = 0;
            }

            value = 1 / unitVal * value;
            if ($('body.kirpich-m').length) {
                value = Math.round(value);
            } else {
                value = Math.ceil(value);
            }

            value = Number((value).toFixed(2));
            value = functions.numberWithSpaces(value);
            $elem.text(value);
        }
    });
}


/**
 * Если товаров в корзине 0. И если мы на странице корзины, то перезагружаем страницу.
 */
function checkCart(total_count) {
    if (total_count === 0 && $('.sect-cart').length) {
        location.reload();
    }
}


/**
 * Работа с миникорзиной в шапке сайта (изменить кол-во, скрыть номерок, если товаров 0, показать номерок в противном случае).
 */
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
        $cartInfoCountText.text(functions.formOfWord(count, 'товар', 'товара', 'товаров'));
    } else {
        cartValue = parseFloat($cartValueElem.text());
        cartValue = Number((cartValue).toFixed(2));
    }

    let cartCost;
    if (typeof cost !== 'undefined') {
        cost = Number((cost).toFixed(2));
        cartCost = functions.numberWithSpaces(cost);
        $cartInfoCostVal.text(cartCost);
    }

    if (cartValue > 0) {
        $cartValueElem.removeClass('hidden');
    } else {
        $cartValueElem.addClass('hidden');
    }
}


/**
 * Инициализация стилизованного счетчика и стилизованного списка.
 */
function initStyledCounter() {
    $('.not-init.listing__products-item, .product-card .js-product, .cart-table__table-row_type_product').each(function () {
        // Основные переменные
        let $item = $(this);
        let $counterInput = $item.find('.custom-counter__amount');

        // Инициализируем стилизованный список для смены единиц измерения
        let $select = $item.find('select.custom-select');
        $select.euv_custom_select();
        $select.on('beforeChange.euv_custom_select', function () {
            $item.attr('data-last-unit-value', functions.getActiveUnitValue($item));
        });

        if (!$item.hasClass('cart-table__table-row_type_product')) {
            // Вешаем обработчик на смену единицы измерения - менять шаг и кол-во
            $item.on('changeUnit', function (e) {
                setStepAndAmount($item, !$item.hasClass('js-product-in-cart'));
            });
            // Устанавливаем шаг и кол-во
            if ($item.hasClass('js-product-in-cart')) {
                setStepAndAmount($item, true);
            } else {
                setStepAndAmount($item, true);
            }
        }

        // Инициализируем фильтры для счетчика
        $counterInput.each(function () {
            let filter;
            const $this = $(this);
            const minVal = parseFloat($this.attr('data-min'));

            // Фильтр для изменения значения
            let regexp = /(^$)|(^(0|[1-9][0-9]{0,})$)/;
            if ($this.closest('.custom-counter_type_fractional').length) {
                regexp = /(^$)|(^((0|[1-9][0-9]{0,})(\.[0-9]{0,2}){0,1})$)/;
            }
            filter = function (value) {
                let floatVal = parseFloat(value);
                let condition = !isNaN(floatVal) && regexp.test(value);

                if (!isNaN(minVal)) {
                    condition = condition && (floatVal >= minVal);
                }
                return condition;
            };

            // Фильтр для изменения значения
            $this.inputFilter(filter);

            // Фильтр для ввода (input) значения
            $this.inputFilter(function (value) {
                return regexp.test(value);
            }, {'event': 'input'});
        });

        // Обработчик кнопок стилизованного счетчкика
        $item.find('.custom-counter__btn').on('click', function (e) {
            e.preventDefault();

            // Основные переменные
            let $this = $(this);
            let $counter = $this.closest('.custom-counter');
            let $inputValue = $counter.find('.custom-counter__amount');
            let step = 1;

            // Установка val
            let val = parseFloat($inputValue.val());
            val = Math.floor(val / step);

            switch (true) {
                case $this.hasClass('custom-counter__btn_dir_less'):
                    val -= 1;
                    break;
                case $this.hasClass('custom-counter__btn_dir_more'):
                    val += 1;
                    break;
            }
            val = val * step;

            $inputValue.val(val);

            // При щелчке по кнопкам на странице корзины и так вызывается change, поэтому повторно его вызывать здесь не надо. Я бегло посмотрел файл плагина, чтобы удалить его оттуда и убрать эти строки. Но ничего там не нашел. По-хорошему надо подправить этот момент в фале плагина. Эти строки тут выглядят как костыль
            if (!$inputValue.closest('.ms2_form').length) {
                $inputValue.trigger('change');
            }

            // Если кнопка находится в карточке товара корзины, то отправляем форму (кликаем по кнопке для отправки формы)
            $this.closest('.cart-table__table-row').find('.btn-sm').click();
        });

        // Удаляем у чанка класс о том, что чанк еще не инициализирован
        $item.removeClass('not-init');
    });
};


/**
 * Конвертация кол-ва товара в корзине при смене единиц изменения.
 */
function setStepAndAmount($item, dontChangeAmount) {
    dontChangeAmount = (typeof dontChangeAmount !== 'undefined') ? dontChangeAmount : false;

    // ---------------------------------------------
    // Определяем основные переменные
    // ---------------------------------------------
    // Текущий шаг
    let step = 1;

    // Поле в текущей форме
    let $activeFormInput = functions.getActiveForm($item)['action'].find('.custom-counter__amount');

    // Значение активной ед. измерения
    let unitVal = functions.getActiveUnitValue($item);

    // ---------------------------------------------
    // Устанавливаем новый шаг и новое число (если шаг изменился)
    // ---------------------------------------------
    // Получаем коэффициент. Пока что он задан только у кирпичей. Он нам нужен для установки нового шага
    // let coeff = parseFloat($item.attr('data-coefficient'));
    let coeff;
    if (isNaN(coeff)) {
        coeff = 0;
    }

    // Получаем step
    if (coeff === 0) {
        step = 1;
    } else {
        if (unitVal === 1) {
            // Если это 1 (штуки), то умножаем коэффициент на активную ед. измерения
            step = coeff * unitVal;
        } else {
            // Если это что-то другое, то формула другая. Нужно разделить коэффициент на активную ед. измерения и округлить в большую сторону
            step = Math.ceil(coeff / unitVal);
        }
    }

    // Получаем новое количество товара
    let lastUnitValue = $item.attr('data-last-unit-value');
    let newVal = $activeFormInput.val();
    if (typeof lastUnitValue !== 'undefined') {
        // Если мы с штук перешли на другую ед. измерения
        if (lastUnitValue == 1) {
            newVal = newVal * unitVal;
        } else {
            // Если мы НЕ СО ШТУК перешли на любую другую единицу измерения
            newVal = newVal / lastUnitValue * unitVal;
        }
    } else {
        // Если мы не переходили ни с каких единиц измерения - просто произошла загрузка страницы
        newVal = newVal * step;
    }

    // Округляем новое значение в большую сторону
    newVal = Math.ceil(newVal);

    // Пересчитываем кол-во товара с учетом step
    // newVal = functions.getCorrectValueToCounter(step, newVal);

    // Устанавливаем новый шаг
    // $item.attr('data-step', step);

    // Устанавливаем новое количество
    if (!dontChangeAmount) {
        $activeFormInput.val(newVal);
    }
}
