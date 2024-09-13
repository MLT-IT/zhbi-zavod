import { CalculatorInput } from "./CalculatorInput";

export class CalculatorBase {
  product = null;
  volume = 0;
  price = 0;
  input = null;
  selectors = {
    calculator: ".calcProduct",
    price: ".calcPrice",
    result: {
      wrapper: ".calcResult",
      volume: `${this.wrapper}__volume`,
      price: `${this.wrapper}__price`,
    },
    forms: {
      add: "js-product__form-add",
      change: "js-product__form-change",
    },
  };

  nodes = {
    product: null, // js-product HTMLElement
  };

  cache = {
    unitValues:null
  }

/**
 * 
 * @param {*} product - DOM element with data-attributes and .js-product__in-cart
 * @param {*} callBack 
 * @param {*} options 
 */

  constructor(product, callBack, options) {
    try {
      if (!product) {
        throw new Error("Product element missing");
      }

      this.product = product;

      this.callBack = callBack;
      
      this.initNodes();
      this.selectors = { ...this.selectors, ...options.selectors };
      this.input = new CalculatorInput(this.calculate)

    } catch (e) {
      console.log("Calculator instance construction error");
      console.log(e);
    }
  }

  initNodes(selectors = this.selectors, node = this.nodes) {
    Object.keys(selectors).forEach((key) => {
      if (typeof selectors[key] === "object" && !!selectors[key]) {
        node[key] = this.initNodes(selectors[key], node[key]);
      } else if (Array.isArray(selectors[key]) && selectors[key].length) {
        for (let item in selectors[key]) {
          node[key].push(this.initNodes(item, node[key]));
        }
      } else {
        node[key] = this.product.querySelector(selectors[key]);
      }
    });
  }

  render() {}

  calculate(volume = this.volume) {
    const price = this.nodes.price.value;
    const unitMultiplier = this.getUnitValue(); 
  }

  setEvents() {}

  getUnitValue() {
    
    const unitId = this.product.querySelector('[name="unit"]');
    if(!this.cache.unitValues){
      // берет карту {'1' : 'data-m2'} и собирает все значения из data-аттрибутов вместо ключей, возвращает новую карту только с данными значениями
      this.cache.unitValues = Object.keys(unitsMap).reduce((res, key) => {
        const unitDataValue = this.product.getAttribute(unitsMap[key]);
        if (unitDataValue) {res[key] = unitDataValue;}
        return res;
      }, {});
    }
    return this.cache.unitValues[unitId];
  }
}
