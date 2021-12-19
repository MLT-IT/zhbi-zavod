$(function() {

    // -------------------------------
    // Расчет текста для кнопки "Показать еще"
    // -------------------------------
    window.getRemainder = function () {
        let amount = $('#mse2_mfilter .product-item').length;
        if (typeof mSearch2 !== 'undefined' && mSearch2 && amount) {
            let total = parseInt(mSearch2.total.text());
            let remainder = 0;

            if (total > amount) {
                remainder = total - amount;
            }
            if (remainder > 42) {
                remainder = 42;
            }
            $('#mse2_mfilter .btn_more').text('Показать еще ' + remainder);
        }
    }
    window.getRemainder();

})
