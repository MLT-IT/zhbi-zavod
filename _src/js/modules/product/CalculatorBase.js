import CalculatorInput from "./CalculatorInput";
import { MsCartController } from "./MsCartAdapter";
import UnitController from "./UnitController";
import { addCurrency, prettify } from "./utils";

export default class CalculatorBase {
  product = null; // этот элемент ключевой и передается в другие объекты. стандартно это враппер .js-product в данный момент
  selectors = {
    price: ".calcPrice",
    inCartCount: ".calcInCart",
    result: {
      wrapper: ".calcResult",
      volume: `${this.wrapper}__volume`,
      price: `${this.wrapper}__price`,
    },
    input: ".calcInput",
  };
  _volume = 0;
  priceBase = {
    default: 0,
  };
  nodes = {}; // nodes tree with structure equal to selectors

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
      this.initNodes();
      this.initInputs();
      this.unitController = new UnitController(this.product);
      this.cartHandler = new MsCartController(this.product);
      this.priceBase = this.nodes.priceInput.value;
    } catch (e) {
      console.log("Calculator instance construction error");
      console.log(e);
    }
  }

  get unit() {
    const unit = this.unitController.getUnitValue();
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

  isInCart() {
    return this.product.classList.contains("js-product-in-cart");
  }

  initInputs() {
    const initialValue = this.nodes.inCartCount.value;

    const onChange = (val) => {
      this.count = val;
      this.update();
    };

    this.input = new CalculatorInput(
      this.nodes.input,
      onChange,
      initialValue
    );
  }

  initNodes(selectors = this.selectors, node = this.nodes) {
    Object.keys(selectors).forEach((key) => {
      // console.log(`setting ${key} by selector ${selectors[key].toString()}`);
      if (typeof selectors[key] === "object" && !Array.isArray(selectors[key]) && !!selectors[key]) {
        node[key] = {};
        // console.log('nested selector: ', selectors[key]);
        node[key] = this.initNodes(selectors[key], node[key]);
      } else if (Array.isArray(selectors[key]) && selectors[key].length) {
        node[key] = [];
        for (let item in selectors[key]) {
          node[key].push(this.initNodes(item, node[key]));
        }
      } else {
        node[key] = this.product.querySelector(selectors[key]);
      }
    });
  }

  update() {
    this.cartHandler.update(this.volume);
    this.render();
  }

  render() {
    if ("result" in this.nodes) {
      this.nodes.result.volume.innerText = this.volume;
      this.nodes.result.price.innerText = this.formatPrice(
        this.priceBase * this.volume
      );
    }
  }

  formatPrice(value) {
    return addCurrency(prettify(value), " руб.");
  }
}
