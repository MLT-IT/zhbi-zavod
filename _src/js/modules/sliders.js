import Swiper, {Navigation, Pagination, Scrollbar, Thumbs, Autoplay, Lazy} from 'swiper';

Swiper.use([Navigation, Pagination, Scrollbar, Thumbs, Autoplay, Lazy]);

// Галерея на странице товара
new Swiper(".product-card_type_usual .product-card__gallery-slider, .product-card_type_relinking-btns .product-card__gallery-slider", {
    loop: false,
    spaceBetween: 4,
    slidesPerView: 'auto', // Чтобы размер фоток был как в CSS, делаем auto
    lazy: {loadPrevNext: true},
    navigation: {
        nextEl: ".product-card__gallery-btn_dir_next",
        prevEl: ".product-card__gallery-btn_dir_prev"
    },
});

// Галерея на странице товара с перелинковкой
new Swiper(".product-card_type_relinking .product-card__gallery-slider", {
    loop: false,
    spaceBetween: 8,
    slidesPerView: 'auto', // Чтобы размер фоток был как в CSS, делаем auto
    lazy: {loadPrevNext: true},
    direction: 'horizontal',
    navigation: {
        nextEl: ".product-card__gallery-btn_dir_next",
        prevEl: ".product-card__gallery-btn_dir_prev"
    },

    breakpoints: {
        481: {
            direction: 'vertical',
            spaceBetween: 4,
        }
    }
});

// Слайдер с популярными товарами и слайдер на странице сравнения
let sliderPopCompare = new Swiper(".product-slider-1 .swiper-container", {
    loop: false,
    slidesPerView: "auto",
    lazy: {loadPrevNext: true},
    navigation: {
        nextEl: ".product-slider-1 .swiper-button-next",
        prevEl: ".product-slider-1 .swiper-button-prev"
    },
    scrollbar: {draggable: true, el: ".product-slider-1 .swiper-scrollbar"}
});

// Слайдер с недавно просмотренными товарами
let sliderRecentlyViewed = new Swiper(".product-slider-2 .swiper-container", {
    loop: false,
    slidesPerView: "auto",
    lazy: {loadPrevNext: true},
    navigation: {
        nextEl: ".product-slider-2 .swiper-button-next",
        prevEl: ".product-slider-2 .swiper-button-prev"
    },
    scrollbar: {draggable: true, el: ".product-slider-2 .swiper-scrollbar"}
});

// Слайдер "Распродажа" на новой странице каталога
let sliderSales = new Swiper(".product-slider-3 .swiper-container", {
    loop: false,
    slidesPerView: "auto",
    lazy: {loadPrevNext: true},
    navigation: {
        nextEl: ".product-slider-3 .swiper-button-next",
        prevEl: ".product-slider-3 .swiper-button-prev"
    },
    scrollbar: {draggable: true, el: ".product-slider-3 .swiper-scrollbar"}
});

// Слайдер с тегами
new Swiper(".listing__tags", {
    slidesPerView: "auto",
    freeMode: true,
    scrollbar: {
        draggable: true,
        el: ".listing__tags .swiper-scrollbar"
    }
});


// ---------------------------------------
// Исправление одного бага на мобилках для слайдеров с товарами.
//
// Подробнее о баге см. скриншот:
// _dev/screenshots/photo_2022-05-26_17-55-36.jpg
// ---------------------------------------
$(sliderPopCompare, sliderRecentlyViewed, sliderSales).each(function (i, e) {
    if (e.slides) {
        e.on('slideChange', setZIndexToSlides);
        setZIndexToSlides(e);
    }
});

function setZIndexToSlides(slider) {
    let amount = slider.slides.length + 10;
    slider.slides.each(function (e, i) {
        $(e).css('z-index', amount - i);
    });
}


// ---------------------------------------
// Слайдер с логотипами партнеров
// ---------------------------------------
let sliderClients = null;

function breakpointChecker() {
    if (window.innerWidth < 1350) {
        sliderClientsEnable();
    } else {
        if (sliderClients !== null) {
            sliderClients.destroy(true, true);
            sliderClients = null;
            // spaceBetween прописывается в style. А если слайдера нет, то и spaceBetween не нужен
            $('.clients__list-img').css('margin-right', '');
        }
    }

    if (window.innerWidth >= 500) {
        // На 500 slidesPerView устанавливается как auto. Это значит, что ширина больше не задается через JS. Но она и не сбрасывается. Видимо, так написан swiper.js. Возможно, есть способ настроить плагин так, чтобы ширина сбрасывалась. Но я пока этот способ не знаю.
        $('.clients__list-img').css('width', '');
    }
}

function sliderClientsEnable() {
    if (sliderClients === null) {
        sliderClients = new Swiper(".clients__list", {
            loop: false,
            lazy: {loadPrevNext: true},
            spaceBetween: 30,
            navigation: {nextEl: ".clients__list .swiper-button-next", prevEl: ".clients__list .swiper-button-prev"},
            breakpoints: {
                300: {spaceBetween: 30, slidesPerView: 1},
                400: {slidesPerView: 2, spaceBetween: 10},
                500: {slidesPerView: 'auto'}
            },

            // Если убрать эти строки, то при загрузке страницы стрелки слайдера будут неактивны, т.к. картинки подгружаются через lazyload, а ширина слайдов зависит от картинок. Если картинок нет, то и ширина нулевая. А это значит, что и стрелки не нужны, чтобы листать слайды.
            // Подробнее: https://stackoverflow.com/questions/43770106/swiper-slider-not-working-unless-page-is-resized
            observer: true,
            observeParents: true
        });
    }
}

$(window).on('resize', function () {
    breakpointChecker();
});
breakpointChecker();
