//import "./default.sass";
//import "./krovelnyjstroymarket/style.sass";
//import {TipsProduct} from "../../../../_src-vite/js/modules/tips"
import Swiper from "swiper";
import { Navigation, EffectFade, Pagination, Autoplay, Thumbs } from "swiper/modules";

document.addEventListener('DOMContentLoaded',async () => {
    //console.log("DOM loaded!");
    // ------------------------------------
    //Слайдеры 
    // ------------------------------------
    const productPicturesSliderContainer = document.querySelector('.product__pictures-slider');
    if (productPicturesSliderContainer) {
      const swiperModules = [Navigation, EffectFade, Pagination, Autoplay, Thumbs];
        const productPicturesSliderThumbsContainer = document.querySelector('.product__pictures-thumbs');
        let productPicturesSliderThumbs;
        if (productPicturesSliderThumbsContainer) {
            productPicturesSliderThumbs = new Swiper(productPicturesSliderThumbsContainer, {
                modules: swiperModules,

                loop: false,
                spaceBetween: 5,
                slidesPerView: 3,
                direction: 'horizontal',
                watchSlidesVisibility: true,
                watchSlidesProgress: true,
                breakpoints: {
                    1200: {
                        direction: 'vertical',
                        slidesPerView: 4,
                        spaceBetween: 15
                    },
                    768: {
                        slidesPerView: 4,
                        spaceBetween: 15
                    }
                }
            });
        }

        const productPicturesSlider = new Swiper(productPicturesSliderContainer, {
            modules: swiperModules,
            navigation: {
                nextEl: '.swiper-button-next.thumbs', // Селектор кнопки "Вперед"
                prevEl: '.swiper-button-prev.thumbs', // Селектор кнопки "Назад"
            },
            loop: true,
            spaceBetween: 0,
            slidesPerView: 1,
            effect: 'fade',
            fadeEffect: {
                crossFade: true,
            },
            thumbs: {
                swiper: productPicturesSliderThumbs || null,
            },
        });
    }

    // -------------------------------
    // Работа со страницей товара с перелинковкой со списками
    // -------------------------------
    const $productInfoSelect = $('.product-info .euv-custom-select');
    if ($productInfoSelect.length) {
        let plugin_name = 'euv_custom_select';
        let toggleDuration = 200;
        let custom_select_visible_class = 'euv-custom-select_visible',
            custom_select_option_class = 'euv-custom-select__option',
            custom_select_class = 'euv-custom-select',
            custom_select_options_wrap_class = 'euv-custom-select__options-wrap';

        // -------------------------------
        // Стилизованный список
        // -------------------------------
        let $productInfoSelect = $('.product-info .euv-custom-select');

        // Обработчик на клик по списку
        $productInfoSelect.on('click', function (e) {
            // Исключаем клик по подсказке или по кнопке для вызова подсказки
            let $target = $(e.target);
            if ($target.hasClass('filter-option__tip') ||
                $target.closest('.filter-option__tip').length) {
                return;
            }

            function close_select(e) {
                let $target = $(e.target);
                let $target_select = $target.closest('.' + custom_select_class);
                $('.' + custom_select_visible_class).each(function () {
                    let $this = $(this);
                    if ($this[0] != $target_select[0] || $target.hasClass(custom_select_option_class)) {
                        if ($('.' + custom_select_visible_class).length < 2) {
                            $(document).off('click.' + plugin_name, close_select);
                        }
                        $this.removeClass(custom_select_visible_class);
                        $this.find('.' + custom_select_options_wrap_class).slideToggle(toggleDuration);
                    }
                });
            }

            let $this = $(this);
            $this.toggleClass(custom_select_visible_class);
            $this.find('.' + custom_select_options_wrap_class).slideToggle(toggleDuration);
            if ($this.hasClass('euv-custom-select_visible')) {
                $(document).off('click.' + plugin_name, close_select);
                $(document).on('click.' + plugin_name, function (e) {
                    let $target = $(e.target);
                    if ($target.hasClass('wintip') ||
                        $target.closest('.wintip').length) {
                        return;
                    }
                    close_select(e);
                });
            } else {
                $(document).off('click.' + plugin_name, close_select);
            }
        });

        $productInfoSelect.each(function () {
            let $this = $(this);
            let $scroll = $this.find('.euv-custom-select__options-wrap-scroll');

            // Стилизованные скроллбары внутри списков
            // $scroll.overlayScrollbars({});

            // Выбор цвета / оттенка в списке
            let $selectColors = $('.colors-options');
            $selectColors.on('change', selectColorsOnChange);
            function selectColorsOnChange(elem) {
                let $this = $(elem.target);
                let $parent = $this.closest('.euv-custom-select');
                let val = $parent.find('.euv-custom-select__selected-option').attr('data-val');
                $parent.find('.euv-custom-select__input-value').attr('data-val', val);
            }
            $selectColors.on('euv_custom_select_init', function () {
                selectColorsOnChange({target: $selectColors[0]});
            });
        });

        // Из-за стилизованных скроллбаров внутри списков плохо работает анимация для раскрытия списков при первом открытии после загрузки страницы. Данный код исправляет это
        // $('.' + custom_select_options_wrap_class).each(function () {
        //     let $elem = $(this);
        //     $elem.show();
        //     $elem.css('opacity', 0);
        //     let $osContentGlue = $elem.find('.os-content-glue');
        //     setTimeout(function () {
        //         $osContentGlue.css('height', $osContentGlue.outerHeight());
        //         $elem.hide();
        //         $elem.css('opacity', '');
        //     }, 300);
        // });
    }

    const ctx = document.body.getAttribute("data-ctx");
    switch(ctx){
        case "krovelnyjstroymarket":
            const {TipsProduct} = await import(/* webpackChunkName: "dynamics_1" */  "../../../../_src-vite/js/modules/tips");
            new TipsProduct('.colors-options .euv-custom-select__option');
            //tips.run();
            //import(/* webpackChunkName: "product-card-krovelnyjstroymarket" */ "./krovelnyjstroymarket/style.sass");
            //console.log("Context: krovelnyjstroymarket");
        break;
        default:
            //import(/* webpackChunkName: "product-card-default" */ "./default.sass");
        break;
    }
});
