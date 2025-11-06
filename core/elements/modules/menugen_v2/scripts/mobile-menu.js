const config = {
  container: '.menugen-mobile-catalog-menu__wrap',
  showBtn: '.menugen-mobile-catalog-menu__show-more-link',
  edge: 6, //при каком кол-ве активировать кнопку "показать еще"
  itemsToShow: 6, //Сколько элементов показывать в свернутом виде

  accordionCont: '.menugen-mobile-catalog-menu__wrap',
  accordionItem: '.menugen-mobile-catalog-menu__catitem',
  accordionItemBtn: '.menugen-mobile-catalog-menu__catitem-title-link',
  accordionSubItemWrap: '.menugen-mobile-catalog-menu__catitem-children'

};

class ElementProvider {
  elems = { //доступ к элементам по селекторам
  }

  getContainer() {
    if(this.elems.container)return this.elems.container;
    this.elems.container = document.querySelector(config.container);
    return this.elems.container;
  }

  getBtn() {
    if(this.elems.btn)return this.elems.btn;
    this.elems.btn = document.querySelector(config.showBtn);
    return this.elems.btn;
  }
}
const ep = new ElementProvider();

class ShowMore {
  btnListener = null;
  constructor() {
  }

  #expand() {
    const cont = ep.getContainer();
    const btn = ep.getBtn();
    const cnt = cont.children.length;
    for(let i = 0; i < cnt; ++i) {
      if(i < config.itemsToShow)continue;
      cont.children[i].classList.remove('hidden');
    }
    const oldText = btn.innerHTML;
    btn.innerHTML = btn.dataset.toggleText;
    btn.dataset.toggleText = oldText;
    btn.dataset.expanded = 1;
  }

  #collapse() {
    const cont = ep.getContainer();
    const btn = ep.getBtn();
    const cnt = cont.children.length;
    for(let i = 0; i < cnt; ++i) {
      if(i < config.itemsToShow)continue;
      cont.children[i].classList.add('hidden');
    }
    const oldText = btn.innerHTML;
    btn.innerHTML = btn.dataset.toggleText;
    btn.dataset.toggleText = oldText;
    btn.dataset.expanded = 0;
  }

  attachBtnListener() {
    const host = this;
    const btn = ep.getBtn();
    this.btnListener = btn.addEventListener('click', function(e) {
      e.preventDefault();
      const expanded = parseInt(btn.dataset.expanded);
      if(expanded){ //был развернут - надо свернуть
        console.log('collapsing');
        host.#collapse();
      }else { //был свернут - надо развернуть
        console.log('expanding');
        host.#expand();
      }
    });
  }

  detachBtnListener() {
    const btn = ep.getBtn();
    btn.removeEventListener('click', this.btnListener);
    this.btnListener = null;
  }

  hideShowBtn() {
    const btn = ep.getBtn();
    const item = btn.closest(config.item);
    this.savedBtnItem = item;
    item.remove();
  }

  showShowBtn() {
    //const btn = ep.getBtn();
    //const item = btn.closest(config.item);
    if(this.savedBtnItem) {
      const cont = ep.getContainer();
      cont.append(this.savedBtnItem);
    }
    //item.classList.remove('hidden');
  }

  //Спрятать элементы при активной кнопке 'показать еще'
  activateShowBtn(cont, cnt) {
    for(let i = 0; i < cnt; ++i) {
      if(i < config.itemsToShow)continue;
      cont.children[i].classList.add('hidden');
    }
  }

  //Этот метод главный
  attach() {
    const host = this;
    const cont = ep.getContainer();
    if(!cont)throw 'Can\'t find container';
    const cnt = cont.children.length; 
    const btn = ep.getBtn();
    if(cnt <= config.edge){
      this.hideShowBtn(btn);
      return;
    }
    this.activateShowBtn(cont, cnt);
    this.attachBtnListener();
  }

  //Этот метод тоже главный
  detach() {
    this.hideShowBtn();
    this.detachBtnListener();
  }
}

class Accordion {
  constructor() {

  }

  #showSubitems(item) {
    const subitem = item.querySelector(config.accordionSubItemWrap);
    subitem.classList.add('active');
  }

  #hideSubitems(item) {
    const subitem = item.querySelector(config.accordionSubItemWrap);
    subitem.classList.remove('active');
  }

  attach() {
    try {
      const host = this;
      //console.log('here!');
      const cont = document.querySelector(config.accordionCont);
      const items = cont.querySelectorAll(config.accordionItem);
      items.forEach((item) => {
        //console.log('item!');
        const btn = item.querySelector(config.accordionItemBtn);
        btn.addEventListener('click', function(e) {
          //console.log('click!');
          e.preventDefault();
          if(btn.classList.contains('active')) { //Скрываем
            btn.classList.remove('active');
            host.#hideSubitems(item);
          }else { //Показываем
            btn.classList.add('active');
            host.#showSubitems(item);
          }
        });
      });
    }catch(t) {
      //console.error(t);
    }
  }
}

class CatalogMobileMenu {
  showMore = null
  accordion = null
  constructor() {
    this.showMore = new ShowMore();
    this.accordion = new Accordion();
  }

  run() {
    this.showMore.attach();
    this.accordion.attach();
  }
}

function initCatalogMobileMenu() {
  try {
    const cmm = new CatalogMobileMenu();
    cmm.run();
  }catch(t) {
    console.error(t);
  }
}

export {
  initCatalogMobileMenu
}