export default function initAssort(){
   // -------------------------------
    // Новый блок с ассортиментом товаров
    // -------------------------------
    let $assort = $('.assort');
    if ($assort.length) {
        // Основные переменные и константы
        const ACTIVE = {
            SIDEBAR: 1,
            CONTENT: 2
        }
        let $backBtnText = $assort.find('.assort__back-text');

        // Вспомогательная функция для анимации при переключении табов
        function toggleClasses(classConst, oldHeight) {
            // Завершаем предыдущую анимацию (если она выполняется)
            $assort.finish();
            switch (classConst) {
                case ACTIVE.SIDEBAR:
                    $assort.removeClass('assort_active_content').addClass('assort_active_sidebar');
                    break;
                case ACTIVE.CONTENT:
                    $assort.removeClass('assort_active_sidebar').addClass('assort_active_content');
                    break;
            }
            let newHeight = $assort.height();
            $assort.height(oldHeight);
            $assort.animate({
                'height': newHeight
            }, 300, function () {
                $assort.css('height', '');
            });
        }

        $assort.find('.assort__sidebar-item').on('click', function (e) {
            e.preventDefault();
            let $this = $(this);

            if ($this.hasClass('active')) {
                return;
            }

            let oldHeight = $assort.height();
            $assort.find('.active.assort__sidebar-item, .active.assort__content-wrap').removeClass('active');
            $this.addClass('active');
            $assort.find('.assort__content-wrap[data-tab="' + $this.attr('data-tab') + '"]').addClass('active');
            toggleClasses(ACTIVE.CONTENT, oldHeight);
            $backBtnText.text($this.text());
        });

        $assort.find('.assort__back').on('click', function (e) {
            e.preventDefault();
            toggleClasses(ACTIVE.SIDEBAR, $assort.height());
            $backBtnText.text('');
        });
    }
}
