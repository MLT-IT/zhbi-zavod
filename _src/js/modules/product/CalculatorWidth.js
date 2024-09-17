import logger from "../debug/Logger";
import CalculatorBase from "./CalculatorBase";
import CalculatorInput from "./CalculatorInput";

const customSelectors = {
  width: ".calcWidth",
  input: {
    len: ".calcInput_length",
    count: ".calcInput_count",
  },
};

export default class CalculatorWidth extends CalculatorBase {
  constructor(product, callBack) {
    super(product, callBack, customSelectors);
    try {
      this.initInputs(); // second call

      this.inCartCount = +this.nodes.inCartCount.value || 1;
      this.widthM = +this.nodes.width.value / 1000 || 1;
    } catch (e) {
      logger.error(`CalculatorWidth init failed: ${e.message}`, e);
    }
  }

  get volume() {
    const volume =
      Math.round(100 * (+this.count * +this.widthM * +this.len)) / 100;
    // logger.log(`Calculating volume = ${this.count} * ${this.width} * ${this.len} = ${volume}`);
    return volume;
  }

  initInputs() {
    this.count = this.convertCountBySize();

    this.len = +this.nodes.input.len.querySelector("input").value / 1000;

    this.lengthInput = new CalculatorInput(
      this.nodes.input.len,
      (value) => {
        this.len = +value / 1000;
        this.update();
      },
      this.len
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

  // just a helper
  convertCountBySize() {
    const { inCartCount, widthM, len } = this;
    const listSizeM2 = inCartCount / (len * widthM) || 1;
    return listSizeM2;
  }
}
