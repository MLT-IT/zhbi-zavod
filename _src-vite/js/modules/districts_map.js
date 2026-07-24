import { DistrictsMap } from "./districts_map/DistrictsMap";

async function doDefaultInit() {
  const {defaultInit} = await import(/* webpackChunkName: "dynamics_1" */ "./districts_map/default-init"
    );
  return defaultInit();
}

function renderWarehouses(data) {
  const dm = new DistrictsMap();
  dm.createMap({id: "districts_map", center: data.center, zoom: data.zoom});
  const options = dm.setIconOptions({
    iconLayout: "default#image",
    iconImageHref: "assets/template/img/icons/warehouse-2.png",
    iconImageSize: [42, 42],
    iconImageOffset: [-21, -21],
  });

  const phoneNumber = data.phone ?? window.regionData.phone;
  const tel = phoneNumber.trim().replaceAll(/[^0-9+]/g, '');
  const balloonContentHTML =
    `<div style="text-align: center;">Часы работы: ежедневно с 8:00 до 21:00<br>Стоимость доставки до 30 км: 990 рублей<br>Телефон склада: <a href="tel:${tel}">${phoneNumber}</a></div>`;
  data.warehouses.map((el) => {
    dm.addWarehouse({coords: el.coords, options,
      baloonHeader: '<div style="' + el.style + '">' + el.name + "</div>",
      baloonContent: balloonContentHTML
    });
  });
}

// Склады по контексту (assets/template/json/location/toponims/{ctx}/district_stores.json) —
// применяются, когда для поддомена региона нет своего файла складов.
function loadContextWarehouses(ctx) {
  $.getJSON(
      `assets/template/json/location/toponims/${ctx}/district_stores.json`,
      renderWarehouses
    ).fail((err) => {
      console.error('initDistrictsMap:context', err.statusText);
      doDefaultInit().then().catch((err) => {console.error(err)});
    });
}

function initDistrictsMap() {
  try {
    const ctx = document.body.dataset.ctx;
    const region = window.regionData.region;

    // Московские склады вывести только для gazosilikatstroy,
    // а gazoclone всегда использует свои собственные склады контекста
    const useRegionStores = region && ctx != 'gazoclone' && !(region == 'moscow' && ctx != 'gazosilikatstroy');

    if (!useRegionStores) {
      loadContextWarehouses(ctx);
      return;
    }

    // Склады поддомена региона имеют высший приоритет над складами контекста
    $.getJSON(
        `assets/template/json/district_stores/${region}.json`,
        renderWarehouses
      ).fail((err) => {
        console.error('initDistrictsMap:region', err.statusText);
        loadContextWarehouses(ctx);
      });
  }catch(t) {
    console.error(t);
  }
}

export default initDistrictsMap;
