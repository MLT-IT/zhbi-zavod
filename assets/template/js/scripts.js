$(function() {
    $(document).on('af_complete', function(event, response) {
        if (response.success === true) {
            // $fancybox.close() не сработает. Даже если в консоль браузера ввести fancybox, то ничего не выведет. Кажется, есть два подключения JQuery или ее части. Поэтому пришлось написать костыль с click.
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
        }
    });
});
