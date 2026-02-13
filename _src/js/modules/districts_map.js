//import { defaultInit } from "./districts_map/default-init";

async function doDefaultInit() {
  const {defaultInit} = await import(/* webpackChunkName: "dynamics_1" */ "./districts_map/default-init"
    );
  return defaultInit();
}

function initDistrictsMap() {
  if(!window.regionData.region) {
    doDefaultInit().then().catch((err) => {console.error(err)}); return;
  }

  // Московские склады вывести только для gazosilikatstroy
  if(window.regionData.region == 'moscow' && document.body.dataset.ctx != 'gazosilikatstroy') {
    doDefaultInit().then().catch((err) => {console.error(err)}); return;
  }

  $.getJSON(
      `assets/template/json/district_stores/${window.regionData.region}.json`,
      function (data) {
        //console.log(data);
        const districtsMap = new ymaps.Map("districts_map", {
          center: data.center ?? [59.94313797002322, 30.3010448956483], //СПБ по умолчанию
          zoom: data.zoom ?? 8,
        });
        const options = {
          iconLayout: "default#image",
          iconImageHref: "assets/template/img/icons/warehouse-1.png",
          iconImageSize: [42, 42],
          iconImageOffset: [-21, -21],
        };

        const phoneNumber = data.phone ?? window.regionData.phone;
        const tel = phoneNumber.trim().replaceAll(/[^0-9+]/g, '');
        //console.log(tel);
        const balloonContentHTML =
          `<div style="text-align: center;">Часы работы: ежедневно с 8:00 до 21:00<br>Стоимость доставки до 30 км: 990 рублей<br>Телефон склада: <a href="tel:${tel}">${phoneNumber}</a></div>`;
        data.warehouses.map((el) => {
          districtsMap.geoObjects.add(
            new ymaps.Placemark(
              el.coords,
              {
                balloonContentHeader:
                  '<div style="' + el.style + '">' + el.name + "</div>",
                balloonContent: balloonContentHTML,
              },
              options
            )
          );
        });
      }
    ).fail((err) => {
      console.error(err.statusText);
      doDefaultInit().then().catch((err) => {console.error(err)});
      return;
    });
}

export default initDistrictsMap;
