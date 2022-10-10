import functions from "./functions/functions";
import funcsCatalog from "./functions/funcsCatalog";
import funcsProduct from "./functions/funcsProduct";

export default function modxJS(lazyLoadInstance, yandexMetrikaId) {
    // -------------------------------
    // Подстановка h1 на странице каталога
    // -------------------------------
    function catalogH1FromGetParams() {
        let result = [];
        let filters = {};
        let params = functions.getSearchParameters();

        // Заполняем filters
        $('.listing__filter-block').each(function (index, elem) {
            let $elem = $(elem);

            let elemId = $elem.attr('id');
            if (typeof elemId !== "undefined") {
                filters[elemId] = $elem.find('.listing__filter-block-title').text();
            }
        });

        // Проходим по get-параметрам и заполняем result
        for (let param in params) {
            if (typeof filters['mse2_' + param] !== 'undefined') {
                result.push(filters['mse2_' + param] + ' - ' + params[param].replaceAll('~', ', '));
            }
        }

        if (result.length) {
            result = result.join('; ');
            result = ', ' + result;
        } else {
            result = '';
        }

        const $categoryHeader = $('.category-header');
        $categoryHeader.text($categoryHeader.attr('data-title') + result);
    }


    // -------------------------------
    // Работа с mse2_load (mFilter2) и pdopage_load (pdoPage)
    // -------------------------------
    $(document).on('mse2_load pdopage_load', function (e, data) {
        let $catalog = $('.js-catalog');
        if ($catalog.length) {
            $('.listing__content .msearch2message').text('Подходящих результатов не найдено.');
            funcsCatalog.getRemainder();
            funcsProduct.initStyledCounter();

            if ($('#mse2_filters').length) {
                catalogH1FromGetParams();
            }

            funcsCatalog.wrapTitle();

            // TODO: я забыл, а зачем здесь сортировка? Разве при загрузке страницы не хватает? Напиши комментарий, когда разберешься.
            // Наверно, при применении какого-либо фильтра / обнулении всех фильтров блок с фильтрами тоже обновляется (помимо листинга товаров). А если так, то, очевидно, сортировка нужна.
            funcsCatalog.catalogSortColorless();

            // Кирилл сказал отменить сортировку, поэтому я закомментировал ее вызов
            // funcsCatalog.catalogSortFilters();

            // Обновить lazyload, ведь новые товары, скорее всего, появились
            lazyLoadInstance.update();

            // Изменить единицы измерения у появившихся карточек, если контекст - кирпич
            if ($('body.kirpich-m').length) {
                let lastKirpichUnit = funcsProduct.getLastKirpichUnit();
                $catalog.find('.product-card__unit-link[data-val="' + lastKirpichUnit + '"]').eq(0).click();
            }
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

            // Если это форма с отзывами, то сбрасываем рейтинг, чтобы при следующем открытии он не был задан
            if ($form.hasClass('popup-reviews__form')) {
                $form.find('.popup-reviews__stars svg').removeClass('active');
            }

            // Форма из баннера в каталоге
            if ($form.hasClass('catalog-banner__form')) {
                console.log('banner-catalog');
                if (typeof ym !== 'undefined') {
                    ym(yandexMetrikaId, 'reachGoal', 'Otpravka-iz-bannera-na-glavnoj-stranice--30%');
                }
            }

            // Форма для оформления заказа
            if ($form.hasClass('popup-order__form')) {
                console.log('succesbuyingform');
                if (typeof ym !== 'undefined') {
                    ym(yandexMetrikaId, 'reachGoal', 'succesbuyingform');
                }

                if (location.pathname === '/cart/') {
                    funcsProduct.handleMiniCart(0, 0, 0, 0);
                    funcsProduct.resetCountProductsOnPage();
                }

                let phone = $('.header__phone').text();
                let html = `<div class="wrapper">
                              <section class="sect-thanks">
                                <div class="sect-thanks__svg-wrap">
                                    <svg class="svg sect-thanks__svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="55" height="54" viewBox="0 0 55 54">
                                        <use xlink:href="/assets/template/img/svg-sprite.svg#success"></use>
                                    </svg>
                                </div>
                                <h1 class="sect-thanks__header">Спасибо за заявку</h1>
                                <p class="sect-thanks__text">В ближайшее время менеджер свяжется с вами!</p>
                                <a href="/" class="sect-thanks__btn custom-btn">Вернуться на главную</a>
                                <div class="sect-thanks__info">
                                  <a href="tel:` + phone + `" class="sect-thanks__info-phone">` + phone + `</a>
                                  <p class="sect-thanks__info-text">
                                    Вы также можете связаться с нами по контактному номеру телефона
                                  </p>  
                                </div>
                              </section> 
                            </div>`;
                $('.current-page').html(html);

            } else {
                // Далее идут повторяющиеся формы, где важен не класс формы, а элемент, которым вызвали форму
                let currentPopupKey;
                if (typeof parent.$.fancybox.getInstance().$trigger !== 'undefined') {
                    currentPopupKey = parent.$.fancybox.getInstance().$trigger.attr('data-btn-key');
                }
                if (currentPopupKey) {
                    switch (currentPopupKey) {
                        case 'banner-delivery':
                            console.log('banner-delivery');
                            if (typeof ym !== 'undefined') {
                                ym(yandexMetrikaId, 'reachGoal', 'Otpravka-formy-iz-bannera-na-stranice-dostavka');
                            }
                            break;
                        case 'banner-main':
                            console.log('banner-main');
                            if (typeof ym !== 'undefined') {
                                ym(yandexMetrikaId, 'reachGoal', 'Otpravka-iz-bannera-na-glavnoj-stranice--30%');
                            }
                            break;
                        case 'header-link':
                            console.log('header-link');
                            if (typeof ym !== 'undefined') {
                                ym(yandexMetrikaId, 'reachGoal', 'Otpravka-formy-iz-zakazat-zvonok');
                            }
                            break;
                        case 'cart':
                            console.log('cart');
                            if (typeof ym !== 'undefined') {
                                ym(yandexMetrikaId, 'reachGoal', 'Otpravka-zajavki-iz-korziny');
                            }
                            break;
                        case 'turnkey':
                            console.log('turnkey');
                            if (typeof ym !== 'undefined') {
                                ym(yandexMetrikaId, 'reachGoal', 'Otpravka-formy-iz-bannera-poluchit-skidku-na-stroitelstvo-pod-kljuch');
                            }
                            break;
                        case 'discount':
                            console.log('discount');
                            if (typeof ym !== 'undefined') {
                                ym(yandexMetrikaId, 'reachGoal', 'nashli_deshevle');
                            }
                            break;
                    }
                }
            }

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
        }
    });
}
