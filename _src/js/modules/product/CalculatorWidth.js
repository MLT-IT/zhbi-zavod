import { CalculatorBase } from "./CalculatorBase";

export class CalculatorWidth extends CalculatorBase{
  constructor(...args){
    this.selectors.width = '.calcWidth';
    this.input = {
      length:'.calcInput calcInput_length',
      count:'.calcInput calcInput_count',
    }
    super(args);
  }
  calculate(){
    
  }
};
