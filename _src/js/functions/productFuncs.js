import functions from "./functions";

/**
 * Функции, относящиеся к товару (добавление в корзину, изменение, удаление, переключение единиц измерения...).
 */
export default function productFuncs() {
    // -------------------------------
    // Добавление товара в корзину
    // -------------------------------
    // TODO: лучше это переписать. Делать trigger submit скрытой формы minishop2
    $(document).on('submit', '.product-item__form', function (e) {
        e.preventDefault();

        let $this = $(this);
        let $productItem = $this.closest('.product-item');

        if (!$productItem.length) {
            return;
        }

        let key = $productItem.attr('data-key'); // Ключ. Нужно для правильной работы Minishop2
        if (!key.length) {
            return;
        }

        let ctx = $('body').attr('data-ctx'); // Нужно для правильной работы Minishop2
        let sendingData; // Массив с отправляемыми данными
        let count = $this.find('.product-item__precount').val(); // Кол-во товара

        // Рассчет и установка кол-ва
        count = functions.getItemCount($productItem, count);
        $this.find('.product-item__count').val(count);
        let id = $this.find('[name="id"]').val();

        // ajax
        sendingData = {
            action: 'cart/add',
            count: count,
            key: key,
            ctx: ctx,
            id: id,
        }

        console.log('Дошел до ajax', sendingData)

        $.ajax({
            method: "POST",
            dataType: "json",
            url: window.location.origin + '/assets/components/minishop2/action.php',
            data: sendingData,
            success: function (data) {
                console.log('ajax завершен', data);
                if (data.success) {
                    handleMiniCart(data.data.total_count, data.data.total_cost);

                    $productItem.find('.product-item__controls').show();
                    $productItem.find('.product-item__form').hide();
                    // trigger change нужен, чтобы фильтр запомнил текущее значение. И потом, если пользователь установит меньше минимального, подставится 1
                    $productItem.find('.product-item__controls .custom-counter__amount').val(count);

                    miniShop2.Message.success(data.message);
                }
            }
        });
    });

    // -------------------------------
    // Работа со страницей товара
    // -------------------------------
    if ($('.product-card').length) {
        // Переключение цен на странице товара
        $('.product-card__unit-link').on('click', function (e) {
            e.preventDefault();
            let $this = $(this);
            $('.product-card__unit-link.active').removeClass('active');
            $this.addClass('active');
            $('[name="unit"]').val($this.attr('data-val'));
        });

        // Вкладки на мобилках
        // Расставляем data-tab-page. Он нужен для кода в base.js. Это не только для мобилок, но и для ПК. Важно делать это через JS, т.к. некоторые вкладки могут не выводиться. А index должен быть по порядку
        $('.product-card__tabs-button').each(function (i, e) {
            $(this).attr('data-tab-page', i);
        });

        // Обработчик
        $('.product-card__mobile-tabs-button').on('click', function (e) {
            e.preventDefault();
            let $this = $(this);
            let $tabsPage = $this.closest('.product-card__tabs-page');

            $('.product-card__tabs-page.active').removeClass('active');
            $this.closest('.product-card__tabs-page').addClass('active');

            let index = $tabsPage.index() + 1;
            $('.product-card__tabs-button.active').removeClass('active');
            $('.product-card__tabs-button:nth-child(' + index + ')').addClass('active');
        });
    }
}
