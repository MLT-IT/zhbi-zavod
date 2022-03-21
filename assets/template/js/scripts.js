// Я вынес работу с плагинами MODX в отдельный файл, т.к. почему-то браузер не реагирует на события (например: af_complete, mse2_load), если собирать через webpack.
$(function () {
    // -------------------------------
    // Подстановка h1 на странице каталога
    // -------------------------------
    function catalogH1FromGetParams() {
        let result = [];
        let filters = {};
        let params = getSearchParameters();

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
    // Функции для работы с GET-параметрами.
    // Взял их отсюда и немного улучшил:
    // https://stackoverflow.com/questions/5448545/how-to-retrieve-get-parameters-from-javascript
    // TODO: хорошо бы их как-нибудь в functions.js поместить. Вдруг еще где пригодятся
    // -------------------------------
    function getSearchParameters() {
        let prmstr = window.location.search.substr(1);
        return prmstr != null && prmstr != "" ? transformToAssocArray(decodeURI(prmstr)) : {};
    }
    function transformToAssocArray(prmstr) {
        let params = {};
        let prmarr = prmstr.split("&");
        for (let i = 0; i < prmarr.length; i++) {
            let tmparr = prmarr[i].split("=");
            params[tmparr[0]] = tmparr[1];
        }
        return params;
    }

    // -------------------------------
    // Работа с mse2_load
    // -------------------------------
    $(document).on('mse2_load', function (e, data) {
        $('.listing__content .msearch2message').text('Подходящих результатов не найдено.');
        window.getRemainder();
        window.initStyledCounter();
        catalogH1FromGetParams();
        // window.catalogSortFilters();
    });

    // -------------------------------
    // Работа с ajaxForm
    // -------------------------------
    $(document).on('af_complete', function (event, response) {
        if (response.success === true) {
            // $fancybox.close() не сработает. Даже если в консоль браузера ввести fancybox, то ничего не выведет. Вероятно, это из-за webpack. Поэтому пришлось написать костыль с click.
            $('.fancybox-close-small').trigger('click');

            if (typeof response.form !== 'object' ||
                Array.isArray(response.form) ||
                response.form === null) {
                return;
            }

            let $form = $(response.form[0]);

            // Если это форма с отзывами, то сбрасываем рейтинг
            if ($form.hasClass('popup-reviews__form')) {
                $form.find('.popup-reviews__stars svg').removeClass('active');
            }

            // Если это форма из баннера в каталоге, то с целью все понятно, так как она не из всплывашки
            if ($form.hasClass('catalog-banner__form')) {
                delete window.currentPopupKey;
                console.log('banner-catalog')
                ym(86220330, 'reachGoal', 'Otpravka-iz-bannera-na-glavnoj-stranice--30%')
            }

            if (window.currentPopupKey) {
                switch (window.currentPopupKey) {
                    case 'banner-delivery':
                        console.log('banner-delivery')
                        ym(86220330, 'reachGoal', 'Otpravka-formy-iz-bannera-na-stranice-dostavka')
                        break;
                    case 'banner-main':
                        console.log('banner-main')
                        ym(86220330, 'reachGoal', 'Otpravka-iz-bannera-na-glavnoj-stranice--30%')
                        break;
                    case 'header-link':
                        console.log('header-link')
                        ym(86220330, 'reachGoal', 'Otpravka-formy-iz-zakazat-zvonok');
                        break;
                    case 'cart':
                        console.log('cart')
                        ym(86220330, 'reachGoal', 'Otpravka-zajavki-iz-korziny');
                        break;
                    case 'turnkey':
                        console.log('turnkey')
                        ym(86220330, 'reachGoal', 'Otpravka-formy-iz-bannera-poluchit-skidku-na-stroitelstvo-pod-kljuch')
                        break;
                }
                window.currentPopupKey = '';
            }

            if ($form.hasClass('popup-order__form')) {
                document.location.href = "/";
            }
        }
    });
});
