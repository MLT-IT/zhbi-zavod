import { DistrictsMap } from "./districts_map/DistrictsMap";

async function doDefaultInit() {
  const {defaultInit} = await import(/* webpackChunkName: "dynamics_1" */ "./districts_map/default-init"
    );
  return defaultInit();
}

function initDistrictsMap() {
  try {
    const dm = new DistrictsMap();
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
          dm.createMap({id: "districts_map", center: data.center, zoom: data.zoom});
          const options = dm.setIconOptions({
            iconLayout: "default#image",
            iconImageHref: "assets/template/img/icons/warehouse-2.png",
            iconImageSize: [42, 42],
            iconImageOffset: [-21, -21],
          });

          const phoneNumber = data.phone ?? window.regionData.phone;
          const tel = phoneNumber.trim().replaceAll(/[^0-9+]/g, '');
          //console.log(tel);
          const balloonContentHTML =
            `<div style="text-align: center;">Часы работы: ежедневно с 8:00 до 21:00<br>Стоимость доставки до 30 км: 990 рублей<br>Телефон склада: <a href="tel:${tel}">${phoneNumber}</a></div>`;
          data.warehouses.map((el) => {
            dm.addWarehouse({coords: el.coords, options,
              baloonHeader: '<div style="' + el.style + '">' + el.name + "</div>",
              baloonContent: balloonContentHTML
            });
          });
        }
      ).fail((err) => {
        console.error('initDistrictsMap:',err.statusText);
        doDefaultInit().then().catch((err) => {console.error(err)});
        return;
      });
  }catch(t) {
    console.error(t);
  }
}

export default initDistrictsMap;
