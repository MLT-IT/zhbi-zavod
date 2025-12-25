export default function mapCreate() {
  if (!document.getElementById("districts_map")) return;

  let districtsMap = new ymaps.Map("districts_map", {
    center: [55.755864, 37.617698],
    zoom: 9
  });

  // fetch("/assets/template/json/address-map/districts.json")
  //   .then((response) => {
  //     if (!response.ok) {
  //       throw new Error(
  //         `Ошибка загрузки JSON: ${response.status} ${response.statusText}`
  //       );
  //     }
  //     return response.json();
  //   })
  //   .then((data) => {
  //     addPolygonsToMap(data);
  //   })
  //   .catch((error) => {
  //     console.error("Ошибка загрузки JSON:", error);
  //   });

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
    .add(new ymaps.Placemark(
      [55.955882, 37.824850],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Ярославское шоссе</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.901516, 37.681362],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Мытищи</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.683899, 37.895493],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Люберцы</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.643404, 37.837642],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Дзержинский</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.583469, 37.711168],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад МКАД 25</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.607611, 37.457493],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Калужское шоссе</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.700106, 37.385295],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Новоивановское</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.921067, 37.409163],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Химки</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.712442, 37.797676],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Ферганский 1</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.829896, 37.373347],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Волоколамское шоссе</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
    .add(new ymaps.Placemark(
      [55.454097, 37.757867],
      {
        balloonContentHeader: '<div style="text-align: center;">Склад Каширское шоссе</div>',
        balloonContent: balloonContentHTML,
      },
      options
    ))
}
