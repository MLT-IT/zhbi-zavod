// сильно завязано на бэкэнд, пока не придумал, что можно придумать, выводится в шаблоне как data-аттрибуты со значением коэффифиента умножения
const unitsMap = {
  1: 1,
  2: "data-m2",
  3: "data-m3",
  4: "data-pm",
  5: "data-list",
  6: "data-thing",
  7: "data-pilomat_thing",
  8: "data-k_m2seam",
  9: "data-k_m3seam",
  10: "data-meter",
  11: "data-upk",
  12: "data-pdn",
};

export default class UnitController {
  config = {
    unitSelector: "[name='unit]",
  };
  cache = {
    unitValues: null,
  };

  constructor(product) {
    if (!product instanceof HTMLElement) {
      throw new Error("Unit init failed");
    }
    this.product = product;
  }

  getUnitValue() {
    const unitId = this.product.querySelector(this.config.unitSelector).value;
    if (!unitId) {
      console.log("Unit value not found");
      return null;
    }
    if (!this.cache.unitValues) {
      // берет карту {'1' : 'data-m2'} из unitsMap и заменяет все значения из data-аттрибутов по values, возвращает новую карту только с данными значениями
      this.cache.unitValues = Object.keys(unitsMap).reduce((res, key) => {
        const unitDataValue = this.product.getAttribute(unitsMap[key]);
        if (unitDataValue) {
          res[key] = unitDataValue;
        }
        return res;
      }, {});
    }
    return this.cache.unitValues[unitId];
  }
}
