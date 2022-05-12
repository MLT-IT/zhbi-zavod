import Swiper, { Navigation, Pagination, Scrollbar, Thumbs, Autoplay, Lazy } from 'swiper';
Swiper.use([Navigation, Pagination, Scrollbar, Thumbs, Autoplay, Lazy]);

const bannerSwiper = new Swiper('.banner .swiper-container', {
    loop: true,
    slidesPerView: 'auto',
    lazy: {
        loadPrevNext: true
    },
    navigation: {
        nextEl: '.banner .swiper-button-next',
        prevEl: '.banner .swiper-button-prev',
    }
})
const popularSwiper = new Swiper('.product-slider .swiper-container', {
    loop: true,
    slidesPerView: 'auto',
    lazy: {
        loadPrevNext: true
    },
    navigation: {
        nextEl: '.product-slider .swiper-button-next',
        prevEl: '.product-slider .swiper-button-prev',
    }
})