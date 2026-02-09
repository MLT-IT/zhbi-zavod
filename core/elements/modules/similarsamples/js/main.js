import Swiper from "swiper";
import { Navigation } from "swiper/modules";


(() => {
  // Контейнер для результатов
  const container_result = document.querySelector('[data-ss-tab-content]');
  if (!container_result) return;

  const first_tab_items = document.querySelectorAll('[data-ss-tab-item]');

  // Если страница дошла до блока подгрузить информацию из первого таба
  const observer = new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        container_result.classList.add('loading');

        if (first_tab_items.length) first_tab_items[0].click()

        observer.disconnect();  // если нужно только один раз
      }
    });
  }, {
    root: null,
    // threshold: 0.1
  });
  observer.observe(container_result);


  // Глобальная функция для переключения табов
  window.ssGetContent = (target, rule_id, resource_id) => {
    container_result.classList.add('loading')

    // Сбросили активный класс у прошлого элемента
    first_tab_items.forEach(tabs_item => {
      if (tabs_item.classList.contains('active')) tabs_item.classList.remove('active')
    })

    // Активный класс новому элементу
    target.classList.add('active')

    fetch('/', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        rule_id, resource_id,
        action: "similarsamples"
      }),
    })
      .then(res => res.json())
      .then(response => {
        if (!response.status) {
          console.error(response?.message)
        } else if (response.status) {
          container_result.innerHTML = response.data
          container_result.style = "" // Очистили стили так как это свайпер, его могли сдвинуть

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
        }
      })
      .catch(err => {
        console.error('Ошибка: ', err);
      })
      .finally(() => {
        container_result.classList.remove('loading')
      });
  }
})()