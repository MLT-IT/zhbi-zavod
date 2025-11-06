class InputIndicator {
  constructor(config = {}) {
    const defConfig = {
      indicatorSel: '.js-delivery-calculator__form-indicator',
      inputSel: '.js-delivery-calculator__form-address',
      loadingMask: '/assets/template/img/deliveryCalculatorServiceAreas/line-md--loading-twotone-loop.svg',
      loadingColor: '#464646',
      readyMask: '/assets/template/img/deliveryCalculatorServiceAreas/line-md--confirm.svg',
      readyColor: 'green',
      showTime: 2000
    };
    this.config = defConfig;
    this.config = Object.assign(this.config, defConfig, config); 
    this.timer = null;
  }

  setLoading() {
    const cont = document.querySelector(this.config.indicatorSel);
    if(!cont)return;
    const input = document.querySelector(this.config.inputSel);
    clearTimeout(this.timer);
    if(input)input.style.outline = 'none';
    cont.style.mask = `url('${this.config.loadingMask}')`;
    cont.style.background = this.config.loadingColor;
    cont.style.opacity = 1;
  }
  setReady() {
    const cont = document.querySelector(this.config.indicatorSel);
    if(!cont)return;
    const input = document.querySelector(this.config.inputSel);
    clearTimeout(this.timer);
    cont.style.mask = `url('${this.config.readyMask}')`;
    cont.style.background = this.config.readyColor;
    cont.style.opacity = 1;
    if(input)input.style.outline = `1px solid ${this.config.readyColor}`;
    this.timer = setTimeout(() => {
      cont.style.opacity = 0;
      if(input)input.style.outline = 'none';
    }, this.config.showTime);
  }
}

export {
  InputIndicator
}