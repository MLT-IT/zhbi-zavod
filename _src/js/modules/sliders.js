import Swiper from "swiper";
import {Navigation, EffectFade, Pagination, Autoplay, Thumbs} from "swiper";
Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);

export function initSliders() {
    const mainScreenSliderContainer = document.querySelector('[data-template="main"] .main-screen__slider');

    if (mainScreenSliderContainer) {
        const mainScreenSlider = new Swiper(mainScreenSliderContainer.querySelector('.swiper-container'), {
            slidesPerView: 1,
            spaceBetween: 0,
            autoplay: {
                delay: 5000
            },
            effect: 'fade',
            fadeEffect: {
                crossFade: true,
            },
            navigation: {
                prevEl: mainScreenSliderContainer.querySelector('.swiper-button-prev') || null,
                nextEl: mainScreenSliderContainer.querySelector('.swiper-button-next') || null,
            },
            pagination: {
                el: mainScreenSliderContainer.querySelector('.swiper-pagination') || null,
                type: 'bullets',
            }
        })
    }

    /*
    const mainScreenSubSliderContainer = document.querySelector('.main-screen__sub-slider');
    if (mainScreenSubSliderContainer) {
        const mainScreenSubSlider = new Swiper(mainScreenSubSliderContainer.querySelector('.swiper-container'), {
            slidesPerView: 1,
            spaceBetween: 0,
            loop: true,
            autoplay: {
                delay: 7500
            },
            effect: 'fade',
            fadeEffect: {
                crossFade: true,
            },
            pagination: {
                el: mainScreenSubSliderContainer.querySelector('.swiper-pagination') || null,
                type: 'bullets',
            }
        })
    }
    */

    const productsPreviewSliderContainer = document.querySelector('.products-preview__slider');

    if (productsPreviewSliderContainer) {
        const productsPreviewSlider = new Swiper(productsPreviewSliderContainer.querySelector('.swiper-container'), {
            slidesPerView: 'auto',
            spaceBetween: 9,
            navigation: {
                prevEl: productsPreviewSliderContainer.querySelector('.swiper-button-prev') || null,
                nextEl: productsPreviewSliderContainer.querySelector('.swiper-button-next') || null,
            },
        })
    }

    const productPicturesSliderContainer = document.querySelector('.product__pictures-slider');

    if (productPicturesSliderContainer) {
        const productPicturesSliderThumbsContainer = document.querySelector('.product__pictures-thumbs');
        let productPicturesSliderThumbs;
        if (productPicturesSliderThumbsContainer) {
            productPicturesSliderThumbs = new Swiper(productPicturesSliderThumbsContainer, {

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

    const reviewsSliderContainer = document.querySelector('.reviews__slider');

    if (reviewsSliderContainer) {
        const reviewsSlider = new Swiper(reviewsSliderContainer.querySelector('.swiper-container'), {
            slidesPerView: 1,
            spaceBetween: 0,
            effect: 'fade',
            fadeEffect: {
                crossFade: true,
            },
            navigation: {
                prevEl: reviewsSliderContainer.querySelector('.swiper-button-prev') || null,
                nextEl: reviewsSliderContainer.querySelector('.swiper-button-next') || null,
            },
        })
    }
// Находим все элементы с классом 'other-products__slider'
    const otherProductsSliders = document.querySelectorAll('.other-products__slider');

// Перебираем каждый найденный элемент и инициализируем слайдер для него
    otherProductsSliders.forEach(sliderContainer => {
        const otherProductsSlider = new Swiper(sliderContainer.querySelector('.swiper-container'), {
            slidesPerView: 'auto',
            spaceBetween: 6,
            navigation: {
                prevEl: sliderContainer.querySelector('.swiper-button-prev') || null,
                nextEl: sliderContainer.querySelector('.swiper-button-next') || null,
            },
            breakpoints: {
                768: {
                    spaceBetween: 16
                }
            }
        });
    });

    // галерея в карточке товара "Фото покупателей"
    const uggSwiper = document.querySelector('.ugg');

    if(uggSwiper){
        new Swiper(uggSwiper.querySelector('.ugg__container'), {
            slidesPerView: 3,
            spaceBetween: 6,
            loop: true,
            navigation: {
                prevEl: uggSwiper.querySelector('.swiper-button-prev') || null,
                nextEl: uggSwiper.querySelector('.swiper-button-next') || null,
            },
            breakpoints: {
                768: {
                    spaceBetween: 16,
                    slidesPerView: 4
                }
            }
        });
    }
}
