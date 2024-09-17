import logger from "../debug/Logger";

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

  constructor(wrapper, onChange, initialValue = 0, config = {}) {
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
      this._value = initialValue;
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
      const { min, max, step } = this.validatorConstraints;

      let prevValue = 0;

      inputNode.addEventListener("focus", () => {
        prevValue = +inputNode.value;
        inputNode.value = "";
      });
      inputNode.addEventListener("blur", () => {
        if (!inputNode.value && prevValue) {
          this.value = prevValue;
        } else {
          // inputNode.dispatchEvent(new Event("change"));
        }
      });

      inputNode.addEventListener("change", () => {
        this.onChange(this.value);
        logger.log("Change triggered");
      });
      inputNode.addEventListener("input", ({ target }) => {
        this.value = target.value;
        // this.onChange(this.value);
        // inputNode.dispatchEvent(new Event("change"));
        logger.log("Input triggered");
      });

      incNode.addEventListener("click", (e) => {
        e.preventDefault();
        logger.warn("INC");
        this.value += step;
        inputNode.dispatchEvent(new Event("change"));
      });
      decNode.addEventListener("click", (e) => {
        e.preventDefault();
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
    const result = Math.ceil(constrainedValue / step) * step;
    return result;
  }
}
