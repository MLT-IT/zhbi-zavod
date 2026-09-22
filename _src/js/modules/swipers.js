import Swiper from "swiper";
import { Navigation, Autoplay, Thumbs } from "swiper/modules";

import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";

export default function iniSwipers() {
  new Swiper('[data-slider="slider-categories"]', {
    modules: [Navigation],
    loop: false,
    // slidesPerView: 5,
    spaceBetween: 10,
    // lazy: { loadPrevNext: true },
    // autoplay: {
    //   delay: 4000,
    //   disableOnInteraction: false,
    // },
    breakpoints: {
      1200: {
        slidesPerView: 5.3,
      },
      992: {
        slidesPerView: 3,
      },
      576: {
        slidesPerView: 2.1,
        spaceBetween: 8,
      },
      320: {
        slidesPerView: 2.1,
        spaceBetween: 8,
      },
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    direction: "horizontal",
  });

  new Swiper('[data-slider="default-product-slider"]', {
    modules: [Navigation],
    slideClass: "product-card",
    loop: false,
    spaceBetween: 10,
    breakpoints: {
      1200: {
        slidesPerView: 4,
      },
      992: {
        slidesPerView: 3,
      },
      576: {
        slidesPerView: 2,
        spaceBetween: 8,
      },
      320: {
        slidesPerView: 2,
        spaceBetween: 8,
      },
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    direction: "horizontal",
  });

  let product_thumbs = new Swiper('[data-slider="product-gallery-thumbs"]', {
    modules: [Navigation],
    slidesPerView: 4,
    freeMode: true,
    watchSlidesProgress: true,
    direction: "horizontal",
    spaceBetween: 12,
    breakpoints: {
      768: {
        direction: "vertical",
      },
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
  });
  new Swiper('[data-slider="product-gallery-preview"]', {
    modules: [Thumbs],

    thumbs: {
      swiper: product_thumbs,
    },
  });

  new Swiper('[data-slider="main-banner-slider"]', {
    modules: [Navigation],
    loop: false,
    slidesPerView: 1,
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    direction: "horizontal",
  });

  document
    .querySelectorAll('[data-slider="catalog-side-carousel"]')
    .forEach((sliderElement) => {
      const prevEl = sliderElement.querySelector(".swiper-button-prev");
      const nextEl = sliderElement.querySelector(".swiper-button-next");

      new Swiper(sliderElement, {
        modules: [Navigation, Autoplay],
        loop: false,
        slidesPerView: 1,
        autoplay: {
          delay: 5000,
          disableOnInteraction: false,
          stopOnLastSlide: false,
        },
        navigation:
          prevEl && nextEl
            ? {
                nextEl,
                prevEl,
              }
            : false,
        direction: "horizontal",
      });
    });

  new Swiper('[data-slider="showroom-objects"]', {
    modules: [Navigation],
    loop: false,
    spaceBetween: 10,
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    breakpoints: {
      1200: {
        slidesPerView: 4,
      },
      992: {
        slidesPerView: 3,
      },
      576: {
        slidesPerView: 2,
        spaceBetween: 8,
      },
      320: {
        slidesPerView: 2,
        spaceBetween: 8,
      },
    },
    direction: "horizontal",
  });

  ["about-zbi-gallery", "equipment-gallery"].forEach((id) => {
    document.querySelectorAll(`[data-slider="${id}"]`).forEach((el) => {
      new Swiper(el, {
        modules: [Navigation],
        loop: false,
        spaceBetween: 10,
        navigation: {
          nextEl: el.querySelector(".swiper-button-next"),
          prevEl: el.querySelector(".swiper-button-prev"),
        },
        breakpoints: {
          992: { slidesPerView: 3 },
          576: { slidesPerView: 2 },
          320: { slidesPerView: 1 },
        },
      });
    });
  });
}
