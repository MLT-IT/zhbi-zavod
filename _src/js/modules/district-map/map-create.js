export default function mapCreate() {
  if (!document.getElementById("districts_map")) return;

  let districtsMap = new ymaps.Map("districts_map", {
    center: [59.94313797002322, 30.3010448956483],
    zoom: 8,
  });

  fetch("/assets/template/json/address-map/districts.json")
    .then((response) => {
      if (!response.ok) {
        throw new Error(
          `Ошибка загрузки JSON: ${response.status} ${response.statusText}`
        );
      }
      return response.json();
    })
    .then((data) => {
      addPolygonsToMap(data);
    })
    .catch((error) => {
      console.error("Ошибка загрузки JSON:", error);
    });

  function addPolygonsToMap(spbDistricts) {
    let districtNum = 0;

    spbDistricts.forEach(function (sd) {
      sd.coords.forEach(function (coord) {
        var myGeoObject = new ymaps.GeoObject(
          {
            geometry: {
              type: "Polygon",
              coordinates: coord,
            },
            properties: {
              hintContent: sd.name,
              balloonContentHeader: sd.name,
              balloonContent: "",
              districtId: districtNum,
              districtName: sd.name,
              polygonColor: sd.color,
            },
          },
          {
            fillColor: sd.color,
            strokeColor: "#000000",
            fillOpacity: 0.3,
            strokeWidth: 1,
            strokeStyle: "solid",
          }
        );
        myGeoObject.events.add("mouseenter", function (e) {
          let tar = e.originalEvent.target;
          let tarId = tar.properties.get("districtId");
          districtsMap.geoObjects.each(function (d) {
            if (d.options.get("fillOpacity") !== 0.6) {
              if (d.properties.get("districtId") === tarId) {
                d.options.set({ fillOpacity: 0.5 });
              } else {
                d.options.set({ fillOpacity: 0.3 });
              }
            }
          });
        });

        myGeoObject.events.add("mouseleave", function (e) {
          districtsMap.geoObjects.each(function (d) {
            if (d.options.get("fillOpacity") !== 0.6) {
              d.options.set({ fillOpacity: 0.3 });
            }
          });
        });

        myGeoObject.events.add("click", function (e) {
          let tar = e.originalEvent.target;
          let tarId = tar.properties.get("districtId");
          districtsMap.geoObjects.each(function (d) {
            if (d.properties.get("districtId") === tarId) {
              d.options.set({ fillOpacity: 0.6 });
            } else {
              d.options.set({ fillOpacity: 0.3 });
            }
          });
        });
        districtsMap.geoObjects.add(myGeoObject);
      });
      districtNum++;
    });
  }

  let options = {
    iconLayout: "default#image",
    iconImageHref:
      "/assets/template/images/sections/address-map/warehouse-2.png",
    iconImageSize: [42, 42], // Размеры метки.
    iconImageOffset: [-21, -21], // Смещение левого верхнего угла иконки относительно её "ножки" (точки привязки).
  };

  let phoneNumber = document.querySelector("[href^='tel']")?.textContent;

  let balloonContentHTML =
    '<div style="text-align: center;">Часы работы: ежедневно с 8:00 до 21:00<br>Стоимость доставки до 30 км: 1100 рублей<br>Телефон склада: <a href="tel:' +
    phoneNumber +
    '">' +
    phoneNumber +
    "</a></div>";

  districtsMap.geoObjects
    .add(
      new ymaps.Placemark(
        [59.994992, 30.293467],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад метро Пионерская</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [60.069773, 30.350095],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Парнас</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.81716, 30.165481],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Красносельский район</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.801154, 30.375384],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Шушары</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.98495, 30.454456],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Полюстрово</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [60.041875, 30.474897],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Мурино</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.855832, 30.528814],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Новосаратовка</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.896878, 30.352717],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад метро Волковская</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.943607, 30.439485],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад метро Ладожская</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.942827, 30.696826],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Колтуши</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.832629, 30.298908],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Предпортовая</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.988707, 30.452143],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Шафировский проспект</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.87439, 30.342898],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад метро Парк Победы</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.585767, 30.158156],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Гатчина</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    )
    .add(
      new ymaps.Placemark(
        [59.978459, 30.459773],
        {
          balloonContentHeader:
            '<div style="text-align: center;">Склад Ржевка</div>',
          balloonContent: balloonContentHTML,
        },
        options
      )
    );
}
