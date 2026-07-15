import functions from "./functions";
import funcsCatalog from "./funcsCatalog";
import funcsProduct from "./funcsProduct";

export default function modxJS(lazyLoadInstance, yandexMetrikaId) {
    const policySelector = 'input[name="privacy"], input[name="callback-policy"]';
    const policyErrorText = 'Необходимо принять политику конфиденциальности';
    const softBlockedForms = new Set();
    let ajaxFormSuccess = null;

    function getPolicyContainer($policy) {
        return $policy.closest('.default-checkbox, .form__checkbox');
    }

    function saveFormSnapshot(form) {
        return Array.from(form.elements).map((field) => ({
            field,
            value: field.value,
            checked: field.checked,
            selectedIndex: field.selectedIndex
        }));
    }

    function restoreFormSnapshot(snapshot) {
        (snapshot || []).forEach(({field, value, checked, selectedIndex}) => {
            if (!field || !field.isConnected || field.name === 'already_sent') {
                return;
            }

            if (field.type === 'checkbox' || field.type === 'radio') {
                field.checked = checked;
            } else if (field.tagName === 'SELECT') {
                field.selectedIndex = selectedIndex;
            } else if (field.type !== 'file') {
                field.value = value;
            }
        });
    }

    function showPolicyError($form) {
        const $policy = $form.find(policySelector).first();
        const $container = getPolicyContainer($policy);

        if (!$container.length) {
            return;
        }

        $container.addClass('policy-invalid');
        $policy.attr('aria-invalid', 'true');
        if (!$container.next('.policy-error-msg').length) {
            $('<div class="policy-error-msg" role="alert"></div>')
                .text(policyErrorText)
                .insertAfter($container);
        }
    }

    function muteAjaxFormSuccess() {
        if (typeof AjaxForm === 'undefined' || !AjaxForm.Message ||
            typeof AjaxForm.Message.success !== 'function') {
            return;
        }

        if (ajaxFormSuccess === null) {
            ajaxFormSuccess = AjaxForm.Message.success;
            AjaxForm.Message.success = function () {};
        }
    }

    function restoreAjaxFormSuccess() {
        if (softBlockedForms.size === 0 && ajaxFormSuccess !== null &&
            typeof AjaxForm !== 'undefined' && AjaxForm.Message) {
            AjaxForm.Message.success = ajaxFormSuccess;
            ajaxFormSuccess = null;
        }
    }

    function restorePolicySuccessState(form) {
        const $form = $(form);
        const $popup = $form.closest('.popup');
        const originalReset = $form.data('policy-original-reset');

        softBlockedForms.delete(form);
        $form.removeData('policy-soft-block').removeClass('policy-required');
        $popup.removeData('policy-soft-block').removeClass('policy-required');
        getPolicyContainer($form.find(policySelector).first()).removeClass('policy-invalid');
        $form.find(policySelector).first().removeAttr('aria-invalid');
        $form.find('.policy-error-msg').remove();

        if (originalReset) {
            form.reset = originalReset;
            $form.removeData('policy-original-reset');
        }

        const callbackOpen = $popup.data('callback-open-saved');
        if (callbackOpen !== undefined) {
            $popup.attr('data-callback-open', callbackOpen);
            $popup.removeData('callback-open-saved');
        }

        restoreAjaxFormSuccess();
    }

    document.addEventListener('submit', function (event) {
        const form = event.target;
        if (!(form instanceof HTMLFormElement)) {
            return;
        }

        const $form = $(form);
        const $policy = $form.find(policySelector).first();
        const $popup = $form.closest('.popup');
        const policyWasPresent = $policy.length > 0;
        const policyIsRequired = policyWasPresent || $form.hasClass('policy-required') ||
            $popup.hasClass('policy-required') || $popup.data('policy-soft-block');

        if (!policyIsRequired) {
            return;
        }

        if ($popup.data('already-sent') && !$form.find('input[name="already_sent"]').length) {
            $('<input type="hidden" name="already_sent" value="1">').appendTo($form);
        }

        $form.addClass('policy-required');
        $popup.addClass('policy-required');

        if (policyWasPresent && $policy.prop('checked')) {
            restorePolicySuccessState(form);
            return;
        }

        $form.data('policy-soft-block', true);
        $popup.data('policy-soft-block', true);
        $form.data('policy-snapshot', saveFormSnapshot(form));
        softBlockedForms.add(form);

        if (!$form.data('policy-original-reset')) {
            $form.data('policy-original-reset', form.reset);
            form.reset = function () {};
        }

        const callbackOpen = $popup.attr('data-callback-open');
        if (callbackOpen !== undefined) {
            $popup.data('callback-open-saved', callbackOpen);
            $popup.removeAttr('data-callback-open');
        }

        muteAjaxFormSuccess();
    }, true);

    $(document).on('change', policySelector, function () {
        if (this.checked) {
            restorePolicySuccessState(this.form);
        }
    });

    // -------------------------------
    // Подстановка h1 на странице каталога
    // -------------------------------
    // function catalogH1FromGetParams() {
    //     let result = [];
    //     let filters = {};
    //     let params = functions.getSearchParameters();
    //
    //     // Заполняем filters
    //     $('.listing__filter-block').each(function (index, elem) {
    //         let $elem = $(elem);
    //
    //         let elemId = $elem.attr('id');
    //         if (typeof elemId !== "undefined") {
    //             filters[elemId] = $elem.find('.listing__filter-block-title').text();
    //         }
    //     });
    //
    //     // Проходим по get-параметрам и заполняем result
    //     for (let param in params) {
    //         if (typeof filters['mse2_' + param] !== 'undefined') {
    //             result.push(filters['mse2_' + param] + ' - ' + params[param].replaceAll('~', ', '));
    //         }
    //     }
    //
    //     if (result.length) {
    //         result = result.join('; ');
    //         result = ', ' + result;
    //     } else {
    //         result = '';
    //     }
    //
    //     const $categoryHeader = $('.category-header');
    //     $categoryHeader.text($categoryHeader.attr('data-title') + result);
    // }


    // -------------------------------
    // Работа с mse2_load (mFilter2) и pdopage_load (pdoPage)
    // -------------------------------
    $(document).on('mse2_load pdopage_load', function (e, data) {
        let $catalogTop = $(".js-catalog");
        if ($catalogTop.length) {
            let title1OffsetTop = $catalogTop.offset().top;
            if (e.type == 'mse2_load'
                && $(e.target.activeElement).is('.default-checkbox__input, .ui-slider-handle')
                && window.innerWidth >= 1200
                && $('.product-card_catalog').length <= 6
            ) {
                $([document.documentElement, document.body]).animate({
                    scrollTop: title1OffsetTop
                }, 300);
            }
        }

        let $catalog = $('.js-catalog');
        if ($catalog.length) {
            $('.msearch2message').text('Подходящих результатов не найдено.');
            funcsCatalog.getRemainder();
            funcsProduct.initStyledCounter();
            lazyLoadInstance.update();
        }
    });


    // -------------------------------
    // Работа с ajaxForm
    // -------------------------------
    $(document).on('af_complete', function (event, response) {
        if (response.success === true) {
            // Проверка ответа, это нужно чтобы получить форму
            if (typeof response.form !== 'object' ||
                Array.isArray(response.form) ||
                response.form === null) {
                return;
            }
            // Получаем форму
            let $form = $(response.form[0]);

            if ($form.data('policy-soft-block') || $form.hasClass('policy-required') &&
                !$form.find(policySelector).first().prop('checked')) {
                restoreFormSnapshot($form.data('policy-snapshot'));

                if (!$form.find('input[name="already_sent"]').length) {
                    $('<input type="hidden" name="already_sent" value="1">').appendTo($form);
                }

                const $popup = $form.closest('.popup');
                $popup.data('already-sent', true);
                showPolicyError($form);

                if (typeof $.jGrowl === 'function') {
                    $.jGrowl('close');
                }

                return;
            }

            // Если это форма с отзывами, то сбрасываем рейтинг, чтобы при следующем открытии он не был задан
            // if ($form.hasClass('popup-reviews__form')) {
            //     $form.find('.popup-reviews__stars svg').removeClass('active');
            // }

            // Форма из баннера в каталоге
            // if ($form.hasClass('catalog-banner__form')) {
            //     console.log('banner-catalog');
            //     if (typeof ym !== 'undefined') {
            //         ym(yandexMetrikaId, 'reachGoal', 'Otpravka-iz-bannera-na-glavnoj-stranice--30%');
            //     }
            // }

            // Форма для оформления заказа
            // if ($form.hasClass('popup-order__form')) {
            //     console.log('succesbuyingform');
            //     if (typeof ym !== 'undefined') {
            //         ym(yandexMetrikaId, 'reachGoal', 'succesbuyingform');
            //     }
            //
            //     if (location.pathname === '/cart/') {
            //         funcsProduct.handleMiniCart(0, 0, 0, 0);
            //         funcsProduct.resetCountProductsOnPage();
            //     }
            //
            //     let phone = $('.header__phone').text();
            //     let html = `<div class="wrapper">
            //                   <section class="sect-thanks">
            //                     <div class="sect-thanks__svg-wrap">
            //                         <svg class="svg sect-thanks__svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="55" height="54" viewBox="0 0 55 54">
            //                             <use xlink:href="/assets/template/img/svg-sprite.svg#success"></use>
            //                         </svg>
            //                     </div>
            //                     <h1 class="sect-thanks__header">Спасибо за заявку</h1>
            //                     <p class="sect-thanks__text">В ближайшее время менеджер свяжется с вами!</p>
            //                     <a href="/" class="sect-thanks__btn custom-btn">Вернуться на главную</a>
            //                     <div class="sect-thanks__info">
            //                       <a href="tel:` + phone + `" class="sect-thanks__info-phone">` + phone + `</a>
            //                       <p class="sect-thanks__info-text">
            //                         Вы также можете связаться с нами по контактному номеру телефона
            //                       </p>
            //                     </div>
            //                   </section>
            //                 </div>`;
            //     $('.current-page').html(html);
            //
            // } else {
            //     // Далее идут повторяющиеся формы, где важен не класс формы, а элемент, которым вызвали форму
            //     let currentPopupKey;
            //     if (typeof parent.$.fancybox.getInstance().$trigger !== 'undefined') {
            //         currentPopupKey = parent.$.fancybox.getInstance().$trigger.attr('data-btn-key');
            //     }
            //     if (currentPopupKey) {
            //         switch (currentPopupKey) {
            //             case 'banner-delivery':
            //                 console.log('banner-delivery');
            //                 if (typeof ym !== 'undefined') {
            //                     ym(yandexMetrikaId, 'reachGoal', 'Otpravka-formy-iz-bannera-na-stranice-dostavka');
            //                 }
            //                 break;
            //             case 'banner-main':
            //                 console.log('banner-main');
            //                 if (typeof ym !== 'undefined') {
            //                     ym(yandexMetrikaId, 'reachGoal', 'Otpravka-iz-bannera-na-glavnoj-stranice--30%');
            //                 }
            //                 break;
            //             case 'header-link':
            //                 console.log('header-link');
            //                 if (typeof ym !== 'undefined') {
            //                     ym(yandexMetrikaId, 'reachGoal', 'Otpravka-formy-iz-zakazat-zvonok');
            //                 }
            //                 break;
            //             case 'cart':
            //                 console.log('cart');
            //                 if (typeof ym !== 'undefined') {
            //                     ym(yandexMetrikaId, 'reachGoal', 'Otpravka-zajavki-iz-korziny');
            //                 }
            //                 break;
            //             case 'turnkey':
            //                 console.log('turnkey');
            //                 if (typeof ym !== 'undefined') {
            //                     ym(yandexMetrikaId, 'reachGoal', 'Otpravka-formy-iz-bannera-poluchit-skidku-na-stroitelstvo-pod-kljuch');
            //                 }
            //                 break;
            //             case 'discount':
            //                 console.log('discount');
            //                 if (typeof ym !== 'undefined') {
            //                     ym(yandexMetrikaId, 'reachGoal', 'nashli_deshevle');
            //                 }
            //                 break;
            //             case 'showroom':
            //                 console.log('showroom');
            //                 if (typeof ym !== 'undefined') {
            //                     ym(yandexMetrikaId, 'reachGoal', 'posehenie shouryma');
            //                 }
            //                 break;
            //             case 'help-in-choice':
            //                 console.log('help-in-choice');
            //                 if (typeof ym !== 'undefined') {
            //                     ym(yandexMetrikaId, 'reachGoal', 'pomosh_v_podbore');
            //                 }
            //                 break;
            //         }
            //     }
            // }
           
            // Закрываем fancybox / выводим сообщение о благодарности
            let $popup = $form.closest('.popup');
            if ($popup.hasClass('js-thanks')) {
                let html = '';
                if ($popup.hasClass('popup-reviews')) {
                    html = '<div class="js-thanks__message popup__form form"><h2 class="title-2 form__title">Спасибо за отзыв</h2><p class="form__text js-thanks__text">Как только модератор его проверит он сразу будет опубликован</p></div>';
                } else {
                    html = '<div class="js-thanks__message popup__form form"><h2 class="title-2 form__title">Спасибо за заявку!</h2><p class="form__text js-thanks__text">С вами свяжется в ближайшее время наш менеджер</p></div>';
                }
                $popup.find('form').remove();
                $popup.prepend(html);
            } else {
                parent.$.fancybox.close();
            }
            
            if (typeof ym !== 'undefined') {
                ym(93462900, 'reachGoal', 'succesbuyingform');
                console.log('Достигнута цель: ' + 'succesbuyingform' + ', id счетчика: ' + window.ymid);
            }
        }
    });
}
