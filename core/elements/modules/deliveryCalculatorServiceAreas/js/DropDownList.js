class DropDownList {
  //config:
  //config.contSel - селектор контейнера с элементами списка
  constructor(config) {
    this.config = config;
    this.container = document.querySelector(config.contSel);
    if(!this.container)throw 'Can\'t get ' + config.contSel;
  }
  fill(elems, onClick) {
    if(!elems)return;
    const children = [];
    elems.forEach((elem) => {
      const node = document.createElement('div');
      node.setAttribute('data-coords', elem.coords);
      node.setAttribute('data-key', elem.key);
      node.setAttribute('class', this.config.elemClass);
      node.innerHTML = elem.text;
      node.addEventListener('click', function(e) {
        if(typeof onClick == 'function')onClick(e, this);
        //console.log(this);
      });
      children.push(node);
    });
    this.container.replaceChildren(...children);
  }

  hide() {
    this.container.style.display = 'none';
  }

  show() {
    this.container.style.display = 'block';
  }
}

export {
  DropDownList
}