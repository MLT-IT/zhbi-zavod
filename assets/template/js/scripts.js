// Я вынес работу с плагинами MODX в отдельный файл, т.к. почему-то браузер не реагирует на события (например: af_complete, mse2_load), если собирать через webpack.
$(function () {
    // -------------------------------
    // Работа с mse2_load
    // -------------------------------
    $(document).on('mse2_load', function (e, data) {
        $('.listing__content .msearch2message').text('Подходящих результатов не найдено.');
        window.getRemainder();
        window.initStyledCounter();
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
                console.log('banner-main')
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
