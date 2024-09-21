import logger from "../debug/Logger";


/**
 * Класс для создания обработчика инпута
 */
export default class CalculatorInput {
  wrapper = null;
  selectors = {
    input: "input",
    inc: ".increment",
    dec: ".decrement",
  };
  validatorConstraints = {
    min: 1,
    max: 10000,
    step: 1,
  };
  onChange = () => {
    throw new Error("Input onChange not set");
  };
  _value = 0;

  /**
   * @param {HTMLElement|string} wrapper контейнер инпута
   * @param {*} onChange колбэк из родителя
   * @param {*} initialValue начальное значение
   * @param {*} config дополнительный конфиг, если добавлены какие-то элементы или валидации
   */
  constructor(wrapper, onChange, initialValue, config = {}) {
    try {
      if (!wrapper instanceof HTMLElement) {
        const wrapperElement = document.querySelector(wrapper);
        if (!wrapperElement || !wrapper) {
          throw new Error("Wrapper does not exist");
        }
        this.wrapper = wrapperElement;
      }
      this.wrapper = wrapper;

      if (config) {
        this.selectors = { ...this.selectors, ...config.selectors };
        this.validatorConstraints = {
          ...this.validatorConstraints,
          ...config.validators,
        };
      }
      this.value = initialValue;
      logger.warn(`Initial value is set to ${this.value}`);
      this.onChange = onChange;
      this.setValidatorValues();
      this.setEvents();
    } catch (e) {
      logger.error(e);
    }
  }

  get value() {
    return this._value;
  }

  /**
   * Автоматически валидирует устанавливаемое значение
   */
  set value(val) {
    try {
      const validValue = this.validateInput(val);
      if (validValue) {
        this._value = validValue;
        const inputNode = this.wrapper.querySelector(this.selectors.input);
        inputNode.value = validValue;
      } else {
        throw new Error(
          `Value incorrect: ${val}, ${JSON.stringify(
            this.validatorConstraints
          )}`
        );
      }
    } catch (e) {
      logger.error(e);
    }
  }

  /**
   * Инпуты подразумеваются числовые, в шаблоне расставляем min max step - здесь используем для валидации
   */
  setValidatorValues() {
    const inputNode = this.wrapper.querySelector(this.selectors.input);
    inputNode.setAttribute("type", "number");
    const { min, max, step } = inputNode;
    this.validatorConstraints = {
      min: +min || this.validatorConstraints.min,
      max: +max || this.validatorConstraints.max,
      step: +step || this.validatorConstraints.step,
    };
  }

  setEvents() {
    try {
      const inputNode = this.wrapper.querySelector(this.selectors.input);
      const incNode = this.wrapper.querySelector(this.selectors.inc);
      const decNode = this.wrapper.querySelector(this.selectors.dec);
      const { step } = this.validatorConstraints;

      let prevValue = 0;

      inputNode.addEventListener("focus", () => {
        prevValue = +inputNode.value;
        inputNode.value = "";
      });
      inputNode.addEventListener("blur", ({ target }) => {
        if (!target.value && prevValue) {
          this.value = prevValue;
        } else {
          this.value = target.value;
        }
        if(this.value != prevValue){
          this.onChange(this.value);
        }
      });

      inputNode.addEventListener("change", () => {
        logger.log("Change triggered");
        this.onChange(this.value);
      });
      inputNode.addEventListener("input", ({ target }) => {
        logger.log("Input triggered");
      });

      incNode.addEventListener("click", (e) => {
        logger.warn("INC");
        this.value += step;
        inputNode.dispatchEvent(new Event("change"));
      });
      decNode.addEventListener("click", (e) => {
        logger.warn("DEC");
        this.value -= step;
        inputNode.dispatchEvent(new Event("change"));
      });
    } catch (e) {
      throw e;
    }
  }

  validateInput(value) {
    const { min, max, step } = this.validatorConstraints;
    const constrainedValue = Math.max(min, Math.min(max, value)); // Clamp value within min and max
    const result = Math.round(constrainedValue / step) * step;
    if(value !== result){
      logger.log(`Validator converted ${value} to ${result}`);
    }
    return result;
  }
}
