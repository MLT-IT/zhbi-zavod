$(function() {
    $(document).on('af_complete', function(event, response) {
        // $fancybox.close() не сработает. Даже если в консоль браузера ввести fancybox, то ничего не выведет. Кажется, есть два подключения JQuery или ее части. Поэтому пришлось написать костыль с click.
        $('.fancybox-close-small').trigger('click');
    });
});
