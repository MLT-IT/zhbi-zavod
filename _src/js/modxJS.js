import functions from "./functions/functions";
import funcsCatalog from "./functions/funcsCatalog";
import funcsProduct from "./functions/funcsProduct";

export default function modxJS(lazyLoadInstance) {
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

        $('.category-header .category-header__inner-text').text(result);
    }


    // -------------------------------
    // Работа с mse2_load (mFilter2) и pdopage_load (pdoPage)
    // -------------------------------
    $(document).on('mse2_load pdopage_load', function (e, data) {
        $('.listing__content .msearch2message').text('Подходящих результатов не найдено.');
        funcsCatalog.getRemainder();
        funcsProduct.initStyledCounter();
        catalogH1FromGetParams();

        // Кирилл сказал отменить сортировку, поэтому я закомментировал ее вызов
        // funcsCatalog.catalogSortFilters();

        lazyLoadInstance.update();
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
                ym(86220330, 'reachGoal', 'Otpravka-iz-bannera-na-glavnoj-stranice--30%');
            }

            // Форма для оформления заказа
            if ($form.hasClass('popup-order__form')) {
                document.location.href = "/";
            }

            // Далее идут повторяющиеся формы, где важен не класс формы, а элемент, которым вызвали форму
            let currentPopupKey;
            if (typeof parent.$.fancybox.getInstance().$trigger !== 'undefined') {
                currentPopupKey = parent.$.fancybox.getInstance().$trigger.attr('data-btn-key');
            }
            if (currentPopupKey) {
                switch (currentPopupKey) {
                    case 'banner-delivery':
                        console.log('banner-delivery');
                        ym(86220330, 'reachGoal', 'Otpravka-formy-iz-bannera-na-stranice-dostavka');
                        break;
                    case 'banner-main':
                        console.log('banner-main');
                        ym(86220330, 'reachGoal', 'Otpravka-iz-bannera-na-glavnoj-stranice--30%');
                        break;
                    case 'header-link':
                        console.log('header-link');
                        ym(86220330, 'reachGoal', 'Otpravka-formy-iz-zakazat-zvonok');
                        break;
                    case 'cart':
                        console.log('cart');
                        ym(86220330, 'reachGoal', 'Otpravka-zajavki-iz-korziny');
                        break;
                    case 'turnkey':
                        console.log('turnkey');
                        ym(86220330, 'reachGoal', 'Otpravka-formy-iz-bannera-poluchit-skidku-na-stroitelstvo-pod-kljuch');
                        break;
                }
            }

            // Закрываем fancybox
            parent.$.fancybox.close();
        }
    });
}
