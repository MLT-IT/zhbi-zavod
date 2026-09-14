import Swiper from "swiper";
import { Navigation, EffectFade, Pagination, Autoplay, Thumbs } from "swiper/modules";

export default async function initObjects(selectorId = "yMapObjects") {
  if (!document.querySelector(`#${selectorId}`)) return;
  const mscript = document.createElement("script");
  mscript.setAttribute("type", "text/javascript");
  mscript.setAttribute(
    "src",
    "https://api-maps.yandex.ru/2.1/?lang=ru_RU&apikey=99aa267b-edef-422a-b3d8-12bfaa6253a1"
  );
  mscript.onload = async () => {
    await initYmapsObjects(selectorId);
  };
  // initMsGallery();
  initObjectsGallery();
  initSimpleGallery();
  document.body.append(mscript);
}

async function initYmapsObjects(selectorId = "yMapObjects") {
  if (!window.hasOwnProperty("ymaps")) return;

  const defaultMarkerPath = "/assets/template/img/icons/object-marker.svg";

  /**
   * array[{title,address,coords,supply,photo}]
   */
  // const objectsMapDataJson = await fetch("/assets/json/maps/objects.json").then(
  //   async (response) => await response.json()
  // );
  const objectsMapDataJson = window.objectsList || null;

  if (!objectsMapDataJson) {
    console.log("NO MAPS POINTS, EXIT");

    return;
  }
  const ymaps = window["ymaps"];
  ymaps.ready(function () {
    const myMap = new ymaps.Map(
      selectorId,
      {
        center: [55.755989, 37.617359],
        zoom: 9,
      },
      {
        searchControlProvider: "yandex#search",
      }
    );
    // Создаём макет содержимого.
    const MyIconContentLayout = ymaps.templateLayoutFactory.createClass(
      '<div style="color: #2596d9; font-weight: bold;">$[properties.iconContent]</div>'
    );

    // console.log(objectsMapDataJson);
    objectsMapDataJson.forEach((object, i) => {
      const coords = object.coord.replace(/\s+/g, "").split(",");
      const myPlacemarkWithContent = new ymaps.Placemark(
        coords,
        {
          hintContent: object.name,
          // balloonContent: `
          //   <p>
          //     <em>Объект:</em> ${object.name}<br>
          //     <em>Адрес:</em> ${object.location}<br>
          //     <em>Поставлено:</em> 
          //   </p>
          //   <ul>
          //     ${object.supply
          //       ?.split(",")
          //       .map((product) => `<li>${product}</li>`)
          //       .join("")}
          //   </ul>
          // `,
          balloonContent: `
            <p>
              <em>Объект:</em> ${object.name}<br>
              <em>Адрес:</em> ${object.location}<br>
            </p>
          `,
          iconContent: "",
        },
        {
          // Опции.
          // Необходимо указать данный тип макета.
          iconLayout: "default#imageWithContent",
          // Своё изображение иконки метки.
          iconImageHref: defaultMarkerPath,
          // Размеры метки.
          iconImageSize: [30, 30],
          // Смещение левого верхнего угла иконки относительно
          // её "ножки" (точки привязки).
          iconImageOffset: [-10, -10],
          // Смещение слоя с содержимым относительно слоя с картинкой.
          iconContentOffset: [0, 0],
          // Макет содержимого.
          iconContentLayout: MyIconContentLayout,
        }
      );

      myMap.geoObjects.add(myPlacemarkWithContent);
    });
  });
}

// это простая галерея
function initSimpleGallery() {
  const galleries = document.querySelectorAll(".simple-gallery");
  if (!galleries) {
    // console.log('');
    return;
  }
  galleries.forEach((gal) => {
    const wrapper = gal.querySelector(".mySwiper");
    if (!wrapper) {
      // console.log('');
      return;
    }
    new Swiper(wrapper, {
      modules: [Navigation, EffectFade, Pagination, Autoplay, Thumbs],
      loop: true,
      spaceBetween: 10,
      slidesPerView: 2,
      freeMode: true,
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });
  });
}

// это галерея групп объексто
function initObjectsGallery() {
  const galleries = document.querySelectorAll(".group-swiper");
  if (!galleries.length) {
    return;
  }
  galleries.forEach((gal) => {
    const slides = gal.querySelectorAll(".object");

    if (slides.length < 2) {
      return;
    }
    new Swiper(gal, {
      modules: [Navigation, EffectFade, Pagination, Autoplay, Thumbs],
      loop: false,
      spaceBetween: 10,
      slidesPerView: 1,
      noSwipingClass: 'mySwiper',
      noSwiping: true,
      navigation: {
        nextEl: ".group-button-next",
        prevEl: ".group-button-prev",
      },
      breakpoints:{
        640: {
          slidesPerView: 2,
        }
      }
    });
  });
}

// это для галереи типа gallery-thumbs
/* 
[      ]
[      ]
[][][][]
*/

function initMsGallery() {
  const galleries = document.querySelectorAll(".thumbs-gallery");
  if (!galleries) {
    // console.log('');
    return;
  }
  galleries.forEach((gal) => {
    const swiper1 = gal.querySelector(".mySwiper");
    const swiper2 = gal.querySelector(".mySwiper2");
    if (!swiper1 || !swiper2) {
      // console.log('');
      return;
    }
    const swiper = new Swiper(swiper1, {
      modules: [Navigation, EffectFade, Pagination, Autoplay, Thumbs],
      loop: true,
      spaceBetween: 10,
      slidesPerView: 4,
      freeMode: true,
      watchSlidesProgress: true,
    });
    new Swiper(swiper2, {
      modules: [Navigation, EffectFade, Pagination, Autoplay, Thumbs],
      loop: true,
      spaceBetween: 10,
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
      thumbs: {
        swiper,
      },
    });
  });
}
