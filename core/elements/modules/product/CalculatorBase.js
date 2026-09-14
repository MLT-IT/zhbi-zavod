import CalculatorInput from "./CalculatorInput";
import { MsCartController } from "./MsCartController";
import UnitController from "./UnitController";
import { prettify } from "./utils";

export default class CalculatorBase {
  product = null; // этот элемент ключевой и передается в другие объекты. стандартно это враппер .js-product в данный момент
  selectors = {
    price: ".calcPrice",
    inCartCount: ".calcInCart",
    result: {
      wrapper: ".calcResult",
      volume: `.calcResult_volume .value`,
      price: `.calcResult_price .value`,
    },
    input: ".calcInput",
  };
  priceBase = 0;
  nodes = {}; // nodes tree with structure equal to selectors

  _volume = 0;
  _listeners = []; // array of callbacks, called on render with Calculator this context!

  /**
   *
   * @param {HTMLElement|string} product - DOM element with data-attributes and .js-product__in-cart
   * @param {*} callBack
   * @param {*} customSelectors
   */

  constructor(product, callBack, customSelectors) {
    try {
      if (
        !product ||
        (!product instanceof HTMLElement && typeof product !== "string")
      ) {
        throw new Error("Product element missing");
      }
      if (typeof product === "string") {
        const productElement = document.querySelector(product);
        if (!productElement) {
          throw new Error("Product wrapper not found");
        }
        this.product = productElement;
      } else {
        this.product = product;
      }

      this.callBack = callBack;

      if (customSelectors) {
        this.selectors = { ...this.selectors, ...customSelectors };
      }
      this.nodes = this.initNodes();
      this.storage = localStorage;
      this.initInputs(); // depends on this.storage
      this.unitController = new UnitController(this.product);
      this.cartHandler = new MsCartController(this.product);
      this.priceBase = this.cartHandler.price;
      this.render();
    } catch (e) {
      console.error("Calculator instance construction error", e);
    }
  }

  get unit() {
    const unit = this.unitController.getUnitValue();
    console.log(`Getting unit = ${unit}`);

    if (!unit) {
      throw new Error("Volume error");
    }
    return unit;
  }

  get volume() {
    return this.count * this.unit;
  }

  get price() {
    return this.priceBase * this.unit;
  }

  initInputs() {
    const initialValue = this.nodes.inCartCount.value;
    const onChange = (val) => {
      this.count = +val;
      this.update();
    };
    this.input = new CalculatorInput(this.nodes.input, onChange, initialValue);
  }

  initNodes(selectors = this.selectors) {
    const result = {};
    for (const key in selectors) {
      if (selectors.hasOwnProperty(key)) {
        if (
          typeof selectors[key] === "object" &&
          !Array.isArray(selectors[key])
        ) {
          result[key] = this.initNodes(selectors[key]);
        } else if (Array.isArray(selectors[key]) && selectors[key].length) {
          result[key] = [];
          for (let item of selectors[key]) {
            result[key].push(this.initNodes(item));
          }
        } else if (typeof selectors[key] === "string") {
          result[key] = this.product.querySelector(selectors[key]);
        }
      }
    }
    return result;
  }

  update() {
    // console.log(`Calculator update: ${this.volume}`);
    this.cartHandler.update(this.volume);
    this.render();
  }

  render() {
    if ("result" in this.nodes) {
      const { volume, priceBase } = this;
      this.nodes.result.volume.innerText = volume;
      this.nodes.result.price.innerText = this.formatPrice(
        Math.ceil(priceBase * volume).toFixed(0)
      );
      console.log(
        `Render VOLUME: ${volume}, COST (${priceBase} x ${volume}): ${
          priceBase * volume
        }`
      );
    }
    this.processCountersFallback();
    this.processListeners();
  }

  processListeners() {
    try {
      this._listeners.forEach((fn) => fn.call(this));
      this.callBack();
    } catch (e) {
      console.error(`Failer execution of listeners`, e);
    }
  }

  addListener(fn) {
    if (typeof fn === "function") {
      this._listeners.push(fn);
    }
    this.processListeners();
  }

  formatPrice(value) {
    return prettify(value);
    // return addCurrency(prettify(value), " руб.");
  }

  processCountersFallback() {
    // a hook to update all .custom-counter__amount values, because it's used by funcsProduct
    const counters = this.product.querySelectorAll(".custom-counter__amount");
    if (counters.length) {
      counters.forEach((counter) => {
        const volume = this.volume;
        counter.value = volume;
        counter.setAttribute("value", volume);
        if (counter.tagName.toLowerCase() !== "input") {
          console.log(`Updated value text of ${counter.tagName}`);
          counter.innerText = volume;
        }
      });
    }
  }
}
