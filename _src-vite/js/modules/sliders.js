import Swiper from "swiper";
import { Navigation, EffectFade, Pagination, Autoplay, Thumbs } from "swiper/modules";

const SWIPER_MODULES = [Navigation, EffectFade, Pagination, Autoplay, Thumbs];

export default async function initSliders() {

  const ctx = body.getAttribute('data-ctx');

  const mainScreenSliderContainer = document.querySelector(
    '[data-template="main"] .main-screen__slider'
  );

  if (mainScreenSliderContainer) {

    let effect = 'fade';
    let clickable = false;
    switch(ctx){
      case 'web':
        effect = '';
        clickable = true;
      break;
      default:
      break;
    }

    new Swiper(
      mainScreenSliderContainer.querySelector(".swiper-container"),
      {
        modules: SWIPER_MODULES,
        slidesPerView: 1,
        spaceBetween: 0,
        autoplay: {
          delay: 5000,
        },
        effect: effect,
        fadeEffect: {
          crossFade: true,
        },
        navigation: {
          prevEl: mainScreenSliderContainer.querySelector(".swiper-button-prev") || null,
          nextEl: mainScreenSliderContainer.querySelector(".swiper-button-next") || null,
        },
        pagination: {
          el: mainScreenSliderContainer.querySelector(".swiper-pagination") || null,
          type: "bullets",
          clickable: clickable
        },
      }
    );
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

  const productsPreviewSliderContainer = document.querySelector(".products-preview__slider");

  if (productsPreviewSliderContainer) {
    new Swiper(
      productsPreviewSliderContainer.querySelector(".swiper-container"),
      {
        modules: SWIPER_MODULES,
        slidesPerView: "auto",
        spaceBetween: 9,
        navigation: {
          prevEl: productsPreviewSliderContainer.querySelector(".swiper-button-prev") || null,
          nextEl: productsPreviewSliderContainer.querySelector(".swiper-button-next") || null,
        },
      }
    );
  }

  const productPicturesSliderContainer = document.querySelector(".product__pictures-slider");

  if (productPicturesSliderContainer) {
    const productPicturesSliderThumbsContainer = document.querySelector(
      ".product__pictures-thumbs"
    );
    let productPicturesSliderThumbs;
    if (productPicturesSliderThumbsContainer) {
      productPicturesSliderThumbs = new Swiper(productPicturesSliderThumbsContainer, {
        modules: SWIPER_MODULES,
        loop: false,
        spaceBetween: 5,
        slidesPerView: 3,
        direction: "horizontal",
        watchSlidesProgress: true,
        breakpoints: {
          1200: {
            direction: "vertical",
            slidesPerView: 4,
            spaceBetween: 15,
          },
          768: {
            slidesPerView: 4,
            spaceBetween: 15,
          },
        },
      });
    }

    new Swiper(productPicturesSliderContainer, {
      modules: SWIPER_MODULES,
      navigation: {
        nextEl: ".swiper-button-next.thumbs", // Селектор кнопки "Вперед"
        prevEl: ".swiper-button-prev.thumbs", // Селектор кнопки "Назад"
      },
      loop: true,
      spaceBetween: 0,
      slidesPerView: 1,
      effect: "fade",
      fadeEffect: {
        crossFade: true,
      },
      thumbs: {
        swiper: productPicturesSliderThumbs || null,
      },
    });
  }

  const reviewsSliderContainer = document.querySelector(".reviews__slider");

  if (reviewsSliderContainer) {
    new Swiper(reviewsSliderContainer.querySelector(".swiper-container"), {
      modules: SWIPER_MODULES,
      slidesPerView: 1,
      spaceBetween: 0,
      effect: "fade",
      fadeEffect: {
        crossFade: true,
      },
      navigation: {
        prevEl: reviewsSliderContainer.querySelector(".swiper-button-prev") || null,
        nextEl: reviewsSliderContainer.querySelector(".swiper-button-next") || null,
      },
    });
  }
  // Находим все элементы с классом 'other-products__slider'
  const otherProductsSliders = document.querySelectorAll(".other-products__slider");
  if (otherProductsSliders.length) {
    // Перебираем каждый найденный элемент и инициализируем слайдер для него
    otherProductsSliders.forEach((sliderContainer) => {
      new Swiper(sliderContainer.querySelector(".swiper-container"), {
        modules: SWIPER_MODULES,
        slidesPerView: "auto",
        spaceBetween: 6,
        navigation: {
          prevEl: sliderContainer.querySelector(".swiper-button-prev") || null,
          nextEl: sliderContainer.querySelector(".swiper-button-next") || null,
        },
        breakpoints: {
          768: {
            spaceBetween: 16,
          },
        },
      });
    });
  }

  // галерея в карточке товара "Фото покупателей"
  const uggSwiper = document.querySelector(".ugg");

  if (uggSwiper) {
    new Swiper(uggSwiper.querySelector(".ugg__container"), {
      modules: SWIPER_MODULES,
      slidesPerView: 3,
      spaceBetween: 6,
      loop: true,
      navigation: {
        prevEl: uggSwiper.querySelector(".swiper-button-prev") || null,
        nextEl: uggSwiper.querySelector(".swiper-button-next") || null,
      },
      breakpoints: {
        768: {
          spaceBetween: 16,
          slidesPerView: 4,
        },
      },
    });
  }

  const showroomSliderContainer = document.querySelector(".showroom-objects__slider");

  if (showroomSliderContainer) {
    new Swiper(showroomSliderContainer.querySelector(".swiper-container"), {
      modules: SWIPER_MODULES,
      slidesPerView: 2,
      spaceBetween: 10,
      navigation: {
        prevEl: showroomSliderContainer.querySelector(".swiper-button-prev") || null,
        nextEl: showroomSliderContainer.querySelector(".swiper-button-next") || null,
      },
      breakpoints: {
        768: {
          slidesPerView: 3,
        },
        1400: {
          slidesPerView: 4,
          spaceBetween: 15,
        },
      },
    });
  }

  const servicesWorksSwiper = document.querySelector(".services-works .swiper");

  if (servicesWorksSwiper) {
    new Swiper(servicesWorksSwiper, {
      modules: SWIPER_MODULES,
      slidesPerView: 1.1,
      spaceBetween: 12,
      navigation: {
        prevEl: document.querySelector(".services-works-button-prev") || null,
        nextEl: document.querySelector(".services-works-button-next") || null,
      },
      breakpoints: {
        576: {
          slidesPerView: 2,
        },
        768: {
          slidesPerView: 2.5,
          spaceBetween: 14,
        },
        1024: {
          slidesPerView: 3,
          spaceBetween: 16,
        },
        1280: {
          slidesPerView: 4,
          spaceBetween: 20,
        },
      },
    });
  }

  // логотипы партнеров sections/partners .our-partners
  const partnersBlock = document.querySelector(".our-partners .swiper");
  if (partnersBlock) {
    new Swiper(partnersBlock, {
      modules: SWIPER_MODULES,
      slidesPerView: 3,
      spaceBetween: 10,
      loop: true,
      lazy: { loadPrevNext: true },
      breakpoints: {
        768: {
          spaceBetween: 20,
          slidesPerView: 5,
        },
      },
      observer: true,
      observeParents: true,
    });
  }

  // логотипы партнеров sections/partners .our-partners
  const equipmentSwiper = document.querySelector(".equipment .swiper");
  if (equipmentSwiper) {
    new Swiper(equipmentSwiper, {
      modules: SWIPER_MODULES,
      slidesPerView: 1,
      spaceBetween: 20,
      breakpoints: {
        768: {
          slidesPerView: 3,
        },
        480: {
          slidesPerView: 2,
        },
      },
      navigation: {
        prevEl: document.querySelector(".equipment-button-prev"),
        nextEl: document.querySelector(".equipment-button-next"),
      },
    });
  }
  // логотипы партнеров sections/partners .our-partners
  const aboutZbiSwiper = document.querySelector(".about-zbi .swiper");
  if (aboutZbiSwiper) {
    new Swiper(aboutZbiSwiper, {
      modules: SWIPER_MODULES,
      slidesPerView: 1,
      autoplay: true,
      spaceBetween: 30,
      delay: 500,
      navigation: {
        prevEl: document.querySelector(".about-zbi-button-prev"),
        nextEl: document.querySelector(".about-zbi-button-next"),
      },
    });
  }

  // Слайдер баннеров в каталоге
  const catalogSideCarousel = document.querySelector(".catalog-side-carousel .swiper");
  if (catalogSideCarousel) {
    new Swiper(catalogSideCarousel, {
      modules: SWIPER_MODULES,
      slidesPerView: 1,
      spaceBetween: 0,
      loop: true,
      autoplay: {
        delay: 6000,
        disableOnInteraction: false,
      },
      navigation: {
        prevEl: document.querySelector(".catalog-side-carousel .swiper-button-prev"),
        nextEl: document.querySelector(".catalog-side-carousel .swiper-button-next"),
      },
    });
  }
}
