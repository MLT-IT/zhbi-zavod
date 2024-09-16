export default class CalculatorInput {
  wrapper = null;
  selectors = {
    input: "input",
    inc: ".increment",
    dec: ".decrement",
  };
  validators = {
    min: 0,
    max: 10,
    step: 1,
  }
  onChange = () => {throw new Error('Input onChange not set')};
  _value = null;

  constructor(wrapper, onChange, initialValue = 0, config = {}) {
    try {
      if (!wrapper instanceof HTMLElement){
        const wrapperElement = document.querySelector(wrapper)
        if(!wrapperElement || !wrapper){
          throw new Error('Wrapper does not exist');
        }
        this.wrapper = wrapper;
      }  
      if(config){
        this.selectors = {...this.selectors, ...config.selectors}
        this.validators = {...this.validators, ...config.validators}
      }
      this.onChange = onChange;
      this.setValidatorValues();
      this.setEvents();
    } catch (e) {
      console.error(e);
    }
  }

  get value(){
    return this._value;
  }

  set value(val){
    const {min,max} = this.validators;
    if(+val && val < max && val > min){
      this._value = val
    } else {
      throw new Error('Value incorrect')
    }
  }

  setValidatorValues(){
    const {min = 0, max = 1, step = 1} = inputNode;
    this.validators = {min, max, step};
  }

  setEvents() {
    try {
      const inputNode = this.wrapper.querySelector(this.selectors.input);
      const incNode = this.wrapper.querySelector(this.selectors.inc);
      const decNode = this.wrapper.querySelector(this.selectors.dec);
      const {min, max, step} = inputNode;

      let prevValue = 0;

      inputNode.addEventListener('focus', () => {
        prevValue = inputNode.value;
        inputNode.value = '';
      });
      inputNode.addEventListener('blur', () => {
        if(!inputNode.value && prevValue) {
          inputNode.value = prevValue;
        }
      });
      inputNode.addEventListener('change', ({target}) => {
        inputNode.value = parseFloat(target.value);
        this.value = inputNode.value;
        this.onChange(inputNode.value);
      });
      incNode.addEventListener('click', () => {
        inputNode.stepUp();
        inputNode.dispatchEvent(new Event("change"));
      })
      decNode.addEventListener('click', () => {
        inputNode.stepDown();
        inputNode.dispatchEvent(new Event("change"));
      })

    } catch (e) {
      throw e;
    }
  }
}
