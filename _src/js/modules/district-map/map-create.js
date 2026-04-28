export default function mapCreate() {
  if (!document.getElementById("districts_map") || !window.map_data) return;

  const ymap = new ymaps.Map("districts_map", {
    center: [59.94313797002322, 30.3010448956483], //Спб
    zoom: 8,
  });

  const options = {
    iconLayout: "default#image",
    iconImageHref:
      "/assets/template/images/sections/address-map/warehouse-2.png",
    iconImageSize: [42, 42], // Размеры метки.
    iconImageOffset: [-21, -21], // Смещение левого верхнего угла иконки относительно её "ножки" (точки привязки).
  };

  const phone_number = document.querySelector("[href^='tel']")?.textContent;
  const baloon_content =
    `<div style="text-align: center;">Часы работы: ежедневно с 8:00 до 21:00<br>Стоимость доставки до 30 км: 1100 рублей<br>Телефон склада: <a href="tel:${phone_number}">${phone_number}</a></div>`;

  /**
   * Если есть полигоны, то загружаем их
   */
  if (window.map_data.polygons_path) {
    fetch(window.map_data.polygons_path)
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
  }

  /**
   * Если есть склады, то добавляем их на карту
   * И тут же устанавливаем center и zoom
   */
  if (window.map_data.warehouses_path) {
    fetch(window.map_data.warehouses_path)
      .then((response) => {
        if (!response.ok) {
          throw new Error(
            `Ошибка загрузки JSON: ${response.status} ${response.statusText}`
          );
        }
        return response.json();
      })
      .then((data) => {
        if(data.center)ymap.setCenter(data.center);
        if(data.zoom)ymap.setZoom(data.zoom);
        if(data.warehouses)addWarehousesToMap(data.warehouses);
      })
      .catch((error) => {
        console.error("Ошибка загрузки JSON:", error);
      });
  }

  function addWarehousesToMap(warehouses) {
    warehouses.forEach(function (warehouse) {
      ymap.geoObjects.add(new ymaps.Placemark(warehouse.coords, {
        balloonContentHeader: `<div style="text-align: center;">${warehouse.name}</div>`,
        balloonContent: baloon_content,
      }, options));
    });
  }

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
          ymap.geoObjects.each(function (d) {
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
          ymap.geoObjects.each(function (d) {
            if (d.options.get("fillOpacity") !== 0.6) {
              d.options.set({ fillOpacity: 0.3 });
            }
          });
        });

        myGeoObject.events.add("click", function (e) {
          let tar = e.originalEvent.target;
          let tarId = tar.properties.get("districtId");
          ymap.geoObjects.each(function (d) {
            if (d.properties.get("districtId") === tarId) {
              d.options.set({ fillOpacity: 0.6 });
            } else {
              d.options.set({ fillOpacity: 0.3 });
            }
          });
        });
        ymap.geoObjects.add(myGeoObject);
      });
      districtNum++;
    });
  }
}
