import logger from "../debug/Logger";
import CalculatorBase from "./CalculatorBase";
import CalculatorInput from "./CalculatorInput";

const customSelectors = {
  width: ".calcWidth",
  defaultLength: ".calcLength",
  inCart: ".calcInCart",
  input: {
    len: ".calcInput_length",
    count: ".calcInput_count",
  },
};

export default class CalculatorWidth extends CalculatorBase {
  constructor(product, callBack) {
    try {
      super(product, callBack, customSelectors);
    } catch (e) {
      logger.error(`CalculatorWidth init failed: ${e.message}`, e);
    }
  }

  get volume() {
    const volume =
      Math.round(100 * (this.count * this.widthM * this.len)) / 100;
    // logger.log(`Calculating volume = ${this.count} * ${this.width} * ${this.len} = ${volume}`);
    return volume;
  }

  initInputs() {
    logger.warn("CalculatorWidth overrides CalculatorBase initInputs called in base constructor");
    this.initValues();
    this.lengthInput = new CalculatorInput(
      this.nodes.input.len,
      (value) => {
        this.len = +value / 1000;
        this.update();
      },
      this.lenM * 1000
    );

    this.countInput = new CalculatorInput(
      this.nodes.input.count,
      (value) => {
        this.count = +value;
        this.update();
      },
      this.count
    );
  }

  initValues() {
    this.inCartCount = +this.nodes.inCart.value;
    this.widthM = +this.nodes.width.value / 1000 || 0;
    this.lenM = +this.nodes.defaultLength.value / 1000 || 0; // TODO: LocalStorage for selection
    this.count = this.convertCountBySize();
  }

  // just a helper
  convertCountBySize() {
    const { inCartCount, widthM, lenM } = this;
    const countOfLists =
      Math.ceil((inCartCount * 100) / (lenM * widthM)) / 100 || 1;
    return countOfLists;
  }
}
