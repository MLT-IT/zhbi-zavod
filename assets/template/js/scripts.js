// Я вынес работу с ajaxForm в отдельный файл, т.к. почему-то браузер не реагирует на событие af_complete, если собирать через webpack.
$(function() {
    $(document).on('af_complete', function(event, response) {
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

            if (window.currentPopupKey) {
                switch (window.currentPopupKey) {
                    case 'banner-delivery':
                        console.log('banner-delivery')
                        ym(86220330,'reachGoal','Otpravka-formy-iz-bannera-na-stranice-dostavka')
                        break;
                    case 'banner-main':
                        console.log('banner-main')
                        ym(86220330,'reachGoal','Otpravka-iz-bannera-na-glavnoj-stranice--30%')
                        break;
                    case 'header-link':
                        console.log('header-link')
                        ym(86220330,'reachGoal','Otpravka-formy-iz-zakazat-zvonok');
                        break;
                    case 'cart':
                        console.log('cart')
                        ym(86220330,'reachGoal','Otpravka-zajavki-iz-korziny');
                        break;
                    case 'turnkey':
                        console.log('turnkey')
                        ym(86220330,'reachGoal','Otpravka-formy-iz-bannera-poluchit-skidku-na-stroitelstvo-pod-kljuch')
                        break;
                }
                window.currentPopupKey = '';
            }
        }
    });
});
