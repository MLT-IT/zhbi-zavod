import ImageZoom from "js-image-zoom";

$(function () {
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
    const $productCardImg = $(".product-card__img");
    if ($productCardImg.length) {
        new ImageZoom($productCardImg[0], {
            fillContainer: true,
            height: 260,
            zoomWidth: 500,
            offset: {vertical: 0, horizontal: 10},
        });
    }

});
