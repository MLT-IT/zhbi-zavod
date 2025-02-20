// import Swiper from "swiper";
// import {Navigation, EffectFade, Pagination, Autoplay, Thumbs} from "swiper";
// Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);

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

    const { Swiper, Navigation, EffectFade, Pagination, Autoplay, Thumbs } = await import(
      /* webpackChunkName: "swiper" */ "swiper"
    );
    Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);
    new Swiper(
      mainScreenSliderContainer.querySelector(".swiper-container"),
      {
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
    const { Swiper, Navigation, EffectFade, Pagination, Autoplay, Thumbs } = await import(
      /* webpackChunkName: "swiper" */ "swiper"
    );
    Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);
    new Swiper(
      productsPreviewSliderContainer.querySelector(".swiper-container"),
      {
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
    const { Swiper, Navigation, EffectFade, Pagination, Autoplay, Thumbs } = await import(
      /* webpackChunkName: "swiper" */ "swiper"
    );
    Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);
    if (productPicturesSliderThumbsContainer) {
      productPicturesSliderThumbs = new Swiper(productPicturesSliderThumbsContainer, {
        loop: false,
        spaceBetween: 5,
        slidesPerView: 3,
        direction: "horizontal",
        watchSlidesVisibility: true,
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
    const { Swiper, Navigation, EffectFade, Pagination, Autoplay, Thumbs } = await import(
      /* webpackChunkName: "swiper" */ "swiper"
    );
    Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);
    new Swiper(reviewsSliderContainer.querySelector(".swiper-container"), {
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
    const { Swiper, Navigation, EffectFade, Pagination, Autoplay, Thumbs } = await import(
      /* webpackChunkName: "swiper" */ "swiper"
    );
    Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);
    // Перебираем каждый найденный элемент и инициализируем слайдер для него
    otherProductsSliders.forEach((sliderContainer) => {
      new Swiper(sliderContainer.querySelector(".swiper-container"), {
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
    const { Swiper, Navigation, EffectFade, Pagination, Autoplay, Thumbs } = await import(
      /* webpackChunkName: "swiper" */ "swiper"
    );
    Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);
    new Swiper(uggSwiper.querySelector(".ugg__container"), {
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
    const { Swiper, Navigation, EffectFade, Pagination, Autoplay, Thumbs } = await import(
      /* webpackChunkName: "swiper" */ "swiper"
    );
    Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);
    new Swiper(showroomSliderContainer.querySelector(".swiper-container"), {
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

  // логотипы партнеров sections/partners .our-partners
  const partnersBlock = document.querySelector(".our-partners .swiper");
  if (partnersBlock) {
    const { Swiper, Navigation, EffectFade, Pagination, Autoplay, Thumbs } = await import(
      /* webpackChunkName: "swiper" */ "swiper"
    );
    Swiper.use([Navigation, EffectFade, Pagination, Autoplay, Thumbs]);
    new Swiper(partnersBlock, {
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
    const { Swiper, Navigation } = await import(/* webpackChunkName: "swiper" */ "swiper");
    Swiper.use([Navigation]);
    new Swiper(equipmentSwiper, {
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
    const { Swiper, Navigation, Autoplay } = await import(
      /* webpackChunkName: "swiper" */ "swiper"
    );
    Swiper.use([Navigation, Autoplay]);
    new Swiper(aboutZbiSwiper, {
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
}
