import { DistrictsMap } from "./DistrictsMap";

function defaultInit() {
  try {
    const dm = new DistrictsMap();
    dm.createMap({
      id: "districts_map",
      center: [59.94313797002322, 30.3010448956483],
      zoom: 8
    });

    $.getJSON("assets/template/json/districts.json", function (data) {
      addPolygonsToMap(data);
    });

    function addPolygonsToMap(spbDistricts) {
      let districtNum = 0;

      spbDistricts.forEach(function (sd) {
        sd.coords.forEach(function (coord) {
          const myGeoObject = dm.createPolygon({
            coords: coord,
            id: districtNum,
            name: sd.name,
            color: sd.color
          });

          dm.setPolygonEventOpts({
            poly: myGeoObject,
            activeOpts : { fillOpacity: 0.6 },
            hoverOpts: { fillOpacity: 0.5 },
            leaveOpts: { fillOpacity: 0.3 }
          });

        });
        districtNum++;
      });
    }

    const options = dm.setIconOptions({
      iconLayout: "default#image",
      iconImageHref: "assets/template/img/icons/warehouse-2.png",
      iconImageSize: [42, 42], // Размеры метки.
      iconImageOffset: [-21, -21], // Смещение левого верхнего угла иконки относительно её "ножки" (точки привязки).
    });

    const phoneNumber = $(".h-subinfo__link_type_phone:first").text().trim();
    const tel = phoneNumber.trim().replaceAll(/[^0-9+]/g, '');
    const balloonContentHTML =
      '<div style="text-align: center;">Часы работы: ежедневно с 8:00 до 21:00<br>Стоимость доставки до 30 км: 1100 рублей<br>Телефон склада: <a href="tel:' +
      tel +
      '">' +
      phoneNumber +
      "</a></div>";

    const warehouses = [
      {coords: [59.994992, 30.293467],
        balloonContentHeader: '<div style="text-align: center;">Склад метро Пионерская</div>',
      },
      {coords: [60.069773, 30.350095],
      balloonContentHeader: '<div style="text-align: center;">Склад Парнас</div>',
      },
      {coords: [59.81716, 30.165481],
      balloonContentHeader: '<div style="text-align: center;">Склад Красносельский район</div>',
      },
      {coords: [59.801154, 30.375384],
      balloonContentHeader: '<div style="text-align: center;">Склад Шушары</div>',
      },
      {coords: [59.98495, 30.454456],
      balloonContentHeader: '<div style="text-align: center;">Склад Полюстрово</div>',
      },
      {coords: [60.041875, 30.474897],
      balloonContentHeader: '<div style="text-align: center;">Склад Мурино</div>',
      },
      {coords: [59.855832, 30.528814],
      balloonContentHeader: '<div style="text-align: center;">Склад Новосаратовка</div>',
      },
      {coords: [59.896878, 30.352717],
      balloonContentHeader: '<div style="text-align: center;">Склад метро Волковская</div>',
      },
      {coords: [59.943607, 30.439485],
      balloonContentHeader: '<div style="text-align: center;">Склад метро Ладожская</div>',
      },
      {coords: [59.942827, 30.696826],
      balloonContentHeader: '<div style="text-align: center;">Склад Колтуши</div>',
      },
      {coords: [59.832629, 30.298908],
      balloonContentHeader: '<div style="text-align: center;">Склад Предпортовая</div>',
      },
      {coords: [59.988707, 30.452143],
      balloonContentHeader: '<div style="text-align: center;">Склад Шафировский проспект</div>',
      },
      {coords: [59.87439, 30.342898],
      balloonContentHeader: '<div style="text-align: center;">Склад метро Парк Победы</div>',
      },
      {coords: [59.585767, 30.158156],
      balloonContentHeader: '<div style="text-align: center;">Склад Гатчина</div>',
      },
      {coords: [59.978459, 30.459773],
      balloonContentHeader: '<div style="text-align: center;">Склад Ржевка</div>',
      }
    ];

    warehouses.map((warehouse) => {
      dm.addWarehouse({
        coords: warehouse.coords,
        options,
        baloonHeader: warehouse.balloonContentHeader,
        baloonContent: balloonContentHTML
      });
    });
  }catch(t) {
    console.error(t);
  }
}

export {
  defaultInit
}