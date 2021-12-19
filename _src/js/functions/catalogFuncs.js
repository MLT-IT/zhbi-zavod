/**
 * Функции, относящиеся к каталогу (в основном работа с mFilter2).
 */
export default function catalogFuncs() {
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

    // -------------------------------
    // Конфликтующие фильтры
    // -------------------------------
    // Переключение конфликтующих фильтров: Длина, Ширина, Толщина и Размеры
    $('.listing__filter-block-content input[type="checkbox"]').on('change', function () {
        let $block = $(this).closest('.listing__filter-block');
        let $conflictingFilters;
        let dontDoAnything = false;

        switch (true) {
            case $block.hasClass('filter_type_razmer'):
                $conflictingFilters = $('.filter_type_thickness, .filter_type_width, .filter_type_length');
                break;

            case ($block.hasClass('filter_type_thickness') ||
                $block.hasClass('filter_type_width') ||
                $block.hasClass('filter_type_length')
            ):
                $conflictingFilters = $('.filter_type_razmer');
                break;

            default:
                dontDoAnything = true
                break;
        }

        if (dontDoAnything === false) {
            if ($block.find('input[type="checkbox"]:checked').length) {
                $conflictingFilters.css('display', 'none');
            } else {
                $conflictingFilters.css('display', '');
            }
        }
    });
}
