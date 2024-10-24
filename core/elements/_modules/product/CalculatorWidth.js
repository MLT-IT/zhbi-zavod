import CalculatorBase from "./CalculatorBase";
import CalculatorInput from "./CalculatorInput";
import { hashString } from "./utils";

const customSelectors = {
  width: ".calcWidth",
  defaultLength: ".calcLength",
  inCart: ".calcInCart",
  input: {
    len: ".calcInput_length",
    count: ".calcInput_count",
  },
};


/**
 * - Наследуется от базового класса, 
 * - через конфиг прокидывает селекторы дополнительных элементов
 * - переопределяет 
 *   - расчет количества кв.м. 
 *   - инициализацию инпутов (добавляет поле длины листа)
 * - добавляет хранение и чтение выбранной длины из storage
 * - и дополнительные хэлперы.
 */
export default class CalculatorWidth extends CalculatorBase {
  constructor(product, callBack) {
    try {
      super(product, callBack, customSelectors);
    } catch (e) {
      console.error(`CalculatorWidth init failed: ${e.message}`, e);
    }
  }

  get volume() {
    const volume =
      Math.round(100 * (this.count * this.widthM * this.lenM)) / 100;
    // console.log(`Calculating volume = ${this.count} * ${this.widthM} * ${this.lenM} = ${volume}`);
    return volume;
  }

  initInputs() {
    console.warn(
      "CalculatorWidth overrides CalculatorBase initInputs called in base constructor"
    );
    
    this.initValues();

    this.lengthInput = new CalculatorInput(
      this.nodes.input.len,
      (value) => {
        this.lenM = +value / 1000;
        this.storage.setItem(this.lengthUid, +value);
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
    this.lengthUid = hashString(this.nodes.input.len.className + window.location.href);
    console.warn(`UID created for input length: "${this.lengthUid}"`);
    this.inCartCount = +this.nodes.inCart.value;
    this.widthM = +this.nodes.width.value / 1000 || 0;
    this.lenM =
      this.storage.getItem(this.lengthUid) / 1000 ||
      +this.nodes.defaultLength.value / 1000 ||
      0;
    this.count = this.convertCountBySize();
    // update results with actual values
  }



  // just a helper
  convertCountBySize() {
    const { inCartCount, widthM, lenM } = this;
    const countOfLists =
      Math.ceil((inCartCount * 100) / (lenM * widthM)) / 100 || 1;
    return countOfLists;
  }
}
