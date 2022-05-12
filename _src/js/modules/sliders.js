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
new Swiper(".product-slider-1 .swiper-container", {
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
new Swiper(".product-slider-2 .swiper-container", {
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
new Swiper(".product-slider-3 .swiper-container", {
    loop: false,
    slidesPerView: "auto",
    lazy: {loadPrevNext: true},
    navigation: {
        nextEl: ".product-slider-3 .swiper-button-next",
        prevEl: ".product-slider-3 .swiper-button-prev"
    },
    scrollbar: {draggable: true, el: ".product-slider-3 .swiper-scrollbar"}
});

// Слайдер с логотипами партнеров
if (window.matchMedia("(max-width: 1349px)").matches) {
    new Swiper(".clients__list", {
        loop: false,
        lazy: {loadPrevNext: true},
        spaceBetween: 30,
        navigation: {nextEl: ".clients__list .swiper-button-next", prevEl: ".clients__list .swiper-button-prev"},
        breakpoints: {
            300: {spaceBetween: 30, slidesPerView: 1},
            400: {slidesPerView: 2, spaceBetween: 10},
            500: {slidesPerView: 'auto'}
        }
    });
}

// Слайдер с тегами
new Swiper(".listing__tags", {
    slidesPerView: "auto",
    freeMode: true,
    scrollbar: {
        draggable: true,
        el: ".listing__tags .swiper-scrollbar"
    }
});
