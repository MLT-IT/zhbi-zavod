const config = {
  selectors: '.catalog-screen__text, .collapse-long-text',
  maxHeight: "3em",
  buttonClass: "read-all-button",
  eventPrefix: 'collapse-long-texts',
  expandedText: 'Свернуть',
  collapsedText: 'Читать полностью'
}

class TextBlock {
  textBlock = null;
  constructor(textBlock) {
    this.textBlock = textBlock;
  }

  setMaxHeight() {
    this.textBlock.style.maxHeight = config.maxHeight;
  }
  isExpanded() {
    return this.textBlock.classList.contains("expand");
  }
  collapse() {
    this.textBlock.dispatchEvent(new CustomEvent(`${config.eventPrefix}-textblock-collapsed`, {}));
    this.textBlock.style.maxHeight = config.maxHeight;
  }
  expand() {
    this.textBlock.dispatchEvent(new CustomEvent(`${config.eventPrefix}-textblock-expanded`, {}));
    this.textBlock.style.maxHeight = this.textBlock.scrollHeight + 'px';//"1000px";
  }
  toggleExpand() {
    this.textBlock.classList.toggle("expand");
  }
  insertAdjacent(elem) {
    this.textBlock.insertAdjacentElement("afterend", elem); // Добавляем кнопку после блока с 
  }

  onToggleButtonClick(e) {
    e.preventDefault();
    if (this.isExpanded()){
      this.collapse();
    }else{
      this.expand();
    }
    this.toggleExpand();
  }
}

class ToggleButton {
  toggleButton = null;
  constructor() {
    this.toggleButton = document.createElement("div");
    this.toggleButton.classList.add(config.buttonClass);
    this.toggleButton.innerText = config.collapsedText;
  }

  getButton() {
    return this.toggleButton;
  }

  registerElemHandlers(elem) {
    const host = this;
    elem.addEventListener(`${config.eventPrefix}-textblock-collapsed`, (e) => {
      //console.log('textblock-collapsed');
      host.onTextBlockCollapsed(e);
    });
    elem.addEventListener(`${config.eventPrefix}-textblock-expanded`, (e) => {
      //console.log('textblock-expanded');
      host.onTextBlockExpanded(e);
    });
  }

  onTextBlockCollapsed(e) {
    this.toggleButton.innerText = config.collapsedText;
  }

  onTextBlockExpanded(e) {
    this.toggleButton.innerText = config.expandedText;
  }

}

function getBlocks() {
  return document.querySelectorAll(config.selectors);
}

function checkForErrors(textBlock) {
  if (!textBlock.innerText.length) {
    console.log(`No text to collapse skip`);
    return true;
  }
  if (textBlock.scrollHeight <= textBlock.clientHeight) {
    console.log(`Text is not high enough to collapse, skipping`);
    return true;
  }
  if (textBlock.parentElement.querySelector(`.${config.buttonClass}`)) {
    console.log("Skip existing long text wrap");
    return true;
  }
  return false;
}

function processBlock(textBlock) {
  const hasErrors = checkForErrors(textBlock);
  if(hasErrors)return;

  console.log("Creating long text collapse wrap");
  const textBlockObj = new TextBlock(textBlock);
  textBlockObj.setMaxHeight();
  
  const toggleButtonObj = new ToggleButton();
  toggleButtonObj.registerElemHandlers(textBlock);//linkTextBlock(textBlockObj); //Кнопка должна знать о текстовом блоке

  const toggleButton = toggleButtonObj.getButton();
  textBlockObj.insertAdjacent(toggleButton);

  toggleButton.addEventListener("click", (e) => {
    //console.log('toggle button click');
    textBlockObj.onToggleButtonClick(e);
  });
}

export default function collapseLongTexts() {
  try {
    const textBlocks = getBlocks();
    if(!textBlocks)return;
    textBlocks.forEach((textBlock) => {
      processBlock(textBlock);
    });
  } catch (e) {
    console.error("Error applying long-text wrap", e);
  }
}
