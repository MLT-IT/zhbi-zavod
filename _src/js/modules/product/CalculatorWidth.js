import CalculatorBase from "./CalculatorBase";
import CalculatorInput from "./CalculatorInput";

export default class CalculatorWidth extends CalculatorBase {
  constructor(product, callBack) {
    const customSelectors = {
      width: ".calcWidth",
      input: {
        len: ".calcInput_length",
        count: ".calcInput_count",
      },
    };
    super(product, callBack, customSelectors);
    // console.log(this.nodes);

    this.initNodes();
    console.log(this.nodes);
    this.initInputs();

    this.width = +this.nodes.width.value;
  }

  initInputs() {
    const initialCount = this.nodes.inCartCount.value;
    const initialLength = this.nodes.input.len.dataset.min || 0;

    this.lengthInput = new CalculatorInput(
      this.nodes.input.len,
      (value) => {
        this.len = +value;
        this.update();
      },
      initialLength
    );
    this.countInput = new CalculatorInput(
      this.nodes.input.count,
      (value) => {
        this.count = +value;
        this.update();
      },
      initialCount
    );
  }

  get volume() {
    const volume = this.count * this.width * this.length;
    return volume;
  }
}
