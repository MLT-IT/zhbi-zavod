//import ReplacerImage from "../../../../../_src/js/class/product/ReplacerImage";

const config = {
  container: '.product-info__color-list-wrap',
  sliderCont: '.product-info__color-list-slider',
  navCont: '.product-info__color-list-nav',
  item: '.product-info__color-list-item',
  itemLink: '.product-info__color-list-item-a', //элемент с data-product и всем остальным, участвующим в подмене изображений
  showBtn: '.product-info__color-list-show-more',
  gallery: '.product__picture .product__pictures-image', //Контейнер, в котором заменять картинки при наведении
  edge: 6, //при каком кол-ве активировать кнопку "показать еще"
  itemsToShow: 6, //Сколько элементов показывать в свернутом виде
  btn: {
    expandedText: 'Показать<br> еще',
    collapsedText: 'Скрыть',
  },
  captionHolder: '.product-info__color-list-caption .placeholder',
  winEdge: 431
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

  expand() {
    const cont = ep.getContainer();
    const btn = ep.getBtn();
    const cnt = cont.children.length - 1;
    for(let i = 0; i < cnt; ++i) {
      if(i < config.itemsToShow)continue;
      cont.children[i].classList.remove('hidden');
    }
    btn.innerHTML = config.btn.collapsedText;
    btn.dataset.expanded = 1;
  }

  collapse() {
    const cont = ep.getContainer();
    const btn = ep.getBtn();
    const cnt = cont.children.length - 1;
    for(let i = 0; i < cnt; ++i) {
      if(i < config.itemsToShow)continue;
      cont.children[i].classList.add('hidden');
    }
    btn.innerHTML = config.btn.expandedText;
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
        host.collapse();
      }else { //был свернут - надо развернуть
        console.log('expanding');
        host.expand();
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

  attach() {
    const host = this;
    const cont = ep.getContainer();
    if(!cont)throw 'Can\'t find container';
    const cnt = cont.children.length - 1; //Кнопка 'показать еще' не учитывается
    const btn = ep.getBtn();
    if(cnt <= config.edge){
      this.hideShowBtn(btn);
      return;
    }
    this.activateShowBtn(cont, cnt);
    this.attachBtnListener();
  }

  detach() {
    this.hideShowBtn();
    this.detachBtnListener();
  }
}

class ColorListSlider {
  constructor() {

  }
  async activate() {
    const { default: Swiper } = await import("swiper");
    const { Navigation, EffectFade, Pagination, Scrollbar, Autoplay, Thumbs } = await import("swiper/modules");
    //const sliderCont = document.querySelector(config.sliderCont);
    this.swiper = new Swiper(config.sliderCont, {
      modules: [Navigation, EffectFade, Pagination, Scrollbar, Autoplay, Thumbs],
      slidesPerView: 'auto',
      spaceBetween: 4,
      loop: false,
      navigation: {
        prevEl: document.querySelector(`${config.navCont} .swiper-button-prev`) || null,
        nextEl: document.querySelector(`${config.navCont} .swiper-button-next`) || null,
      },
      scrollbar: {
        el: '.swiper-scrollbar',
        draggable: true,
      },
      breakpoints: {

      },
    });
  }

  deactivate() {
  }
}

class ColorList {
  showMore;
  constructor() {
    this.showMore = new ShowMore();
    this.slider = new ColorListSlider();
  }
  run() {

    const cont = ep.getContainer();
    cont.addEventListener('thumb-active', (e) => {
      if(!e.detail)return;
      const title = e.detail.dataset.colorTitle;
      const captionElem = document.querySelector(config.captionHolder);
      if(!captionElem)return;
      captionElem.innerHTML = title;
      //console.log(title);
    });

    //Отображать картинку в основном слайдере в карточке товара при наведении на эскиз из блока со списком цветов/оттенков
    //this.re = new ReplacerImage(config.container, config.itemLink, '.product__picture .product__pictures-image', config.container);

    //console.log('run!');
    //console.log(window.innerWidth);
    if(window.innerWidth < config.winEdge) {
      this.showMore.detach();
      this.slider.activate().then((output) => {console.log(output)}, (err) => {console.error(err)});
    }else {
      this.showMore.attach();
      this.slider.deactivate();
    }
  }
}

export {
  ColorList
}