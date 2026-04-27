import { EventKeeper } from "./EventKeeper";
import { Suggestions } from "./suggestions";
import { DropDownList } from "./DropDownList";
import { InputIndicator} from './InputIndicator';
import { coordsFromStr } from "./Utils";
import { Events } from "./Events";
//TODO: сделать взаимодействие компонентов через систему событий
class Utils {
  static containsPoint (bounds, point) {
    return point[0] >= bounds[0][0] && point[0] <= bounds[1][0] &&
            point[1] >= bounds[0][1] && point[1] <= bounds[1][1];
  }

  //Заменить пробелы на &nbsp;
  static priceFormat(price) {
    if(!price)return;
    price = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "&nbsp;");
    return price.replace(/ /, '&nbsp;');
  }
}

const Constraints = {
  restrictedArea: [[53.91320802837306, 32.844467773437486],[57.80159739262526, 42.937626211638694]] //левый нижний, правый верхний
};




class AddressFieldKeeper {
  constructor(owner, config = {
    addrS: '.js-delivery-calculator__form-address',
    addrMsgS: '.js-delivery-calculator__form-address-message',
    dropDownSel: '.js-delivery-calculator__form-address-dropdown',
    inputDelay: 1000
  }){
    this.config = config;
    this.addrField = body.querySelector(this.config.addrS);
    if(!this.addrField)throw 'Couldn\'t find address field';
    this.addrMsg = body.querySelector(this.config.addrMsgS);
    if(!this.addrMsg)throw 'Couldn\'t find address message element';
    this.addrMsg.dataset['origMessage'] = this.addrMsg.innerHTML;
    //console.log(this.addrMsg.dataset['origMessage']);
    this.owner = owner;
    this.suggestions = new Suggestions({
      bounds: Constraints.restrictedArea
    });
    this.dropDownList = new DropDownList({
      contSel: this.config.dropDownSel,
      elemClass: 'delivery-calculator__form-address-dropdown-item'
    });
    this.inputIndicator = new InputIndicator();
  }

  bindAddressField() {
    const host = this;
    let timer;
    this.addrField.addEventListener('keyup', (e) => {
      host.setAddrMessage('');
      if(timer)clearTimeout(timer);
      this.inputIndicator.setLoading();
      timer = setTimeout(async () => {
        //console.log(this.addrField.value);
        await this.processSuggestions();
        this.inputIndicator.setReady();
        //host.pointFromAddress(this.addrField.value);
      }, this.config.inputDelay);
    });
  }

  async processSuggestions() {
    const host = this;
    const suggestions = await this.suggestions.get(this.addrField.value, {kind: 'province', name: 'Московская область'});
    //console.log(suggestions);
    if(!suggestions || suggestions.length < 1) {
      this.owner.ui.setService(false, true);
      return;
    }
    if(suggestions && suggestions.length == 1) {
      const coords = suggestions[0].coords;
      const text = suggestions[0].text;
      host.pointFromCoords(coords, text);
      return;
    }
    this.dropDownList.fill(suggestions, (e, elem) => {
      const coords = coordsFromStr(elem.dataset.coords);
      const text = elem.innerHTML;
      //console.log(coords);
      host.pointFromCoords(coords, text);
      this.dropDownList.hide();
      this.addrField.value = text;
    });
    if(suggestions)this.dropDownList.show();
  }

  setAddrMessage(msg) {
    //console.log('setAddrMessage');
    //console.log(msg);
    if(!msg){
      this.addrMsg.innerHTML = this.addrMsg.dataset['origMessage'];
      return;
    }
    this.addrMsg.innerHTML = '<span class="msg-error">' + msg + '</span>';
  }

  setAddrField(text) {
    //console.log('setAddrField');
    //console.log(text);
    this.addrField.value = text;
  }

  addrByCoords(coords){
    if(!coords)return;
    if(coords.constructor != Array)return;
    this.setAddrMessage();
    const host = this;
    const gc = ymaps.geocode(coords);
    gc.then((res) => {
      const nearest = res.geoObjects.get(0);
      //console.log(nearest.properties);
      const addr = nearest.properties.get('text');
      host.setAddrField(addr);
      host.owner.setMark(coords, nearest.properties.get('name'));
    }, (err) => {
      console.error("Ошибка геокодера");
      console.error(err);
    });
  }

  pointFromAddress(addr) {
    const host = this;
    if(!addr)return;
    //console.log(addr);
    const gc = ymaps.geocode(addr);
    gc.then((res)=>{
      const nearest = res.geoObjects.get(0);
      //console.log(nearest.geometry.getCoordinates());
      host.owner.setMark(nearest.geometry.getCoordinates(), nearest.properties.get('name'));
    }, (err) => {
      console.error("Ошибка геокодера");
      console.error(err);
    });
  }

  pointFromCoords(coords, text) {
    if(!coords)return;
    this.owner.setMark(coords, text);
  }

}

class CoordinatesFixer {
  static fixCoordBlock(coordBlock) {
    //console.log("before");
    //console.log(coordBlock);
    for(let i = 0; i < coordBlock.length; ++i) {
      [ coordBlock[i][0],coordBlock[i][1] ] = [ coordBlock[i][1], coordBlock[i][0] ];
      //[a, b] = [b, a];
    }
    //console.log("after");
    //console.log(coordBlock);
  }
  static fixCoords(feature) {
    for(let i = 0; i < feature.geometry.coordinates.length; ++i) {
      CoordinatesFixer.fixCoordBlock(feature.geometry.coordinates[i]);
    }
  }
}

class AreasKeeper {
  constructor(owner, config = {
    areasJSONPath: 'assets/template/json/deliveryCalculatorServiceAreas/geojson/Areas.geojson'
  }) {
    this.owner = owner;
    this.config = config;
    this.areas = null;
    const host = this;
    const p = fetch(this.config.areasJSONPath);
    p.then((res) => {
      if(!res.ok){console.error("Error fetching Areas.geojson"); console.error(res.statusText);}
      //host.#renderAreas(res.text()); //.json();
      return res.json();
    }, (err) => { console.error('promise error Areas.geojson'); console.error(err);
    }).then((res) => {
      //console.log(res);
      //console.log(typeof res);
      host.#fixCoords(res.features);
      host.#renderAreas(res);
      EventKeeper.trigger(Events.areasRendered, res);
    }, (err) => {console.error(err);});
  }

  #fixCoords(features) {
    //console.log(features);
    for(let i = 0; i < features.length; ++i) {
      CoordinatesFixer.fixCoords(features[i]);
      //features[i].geometry.coordinates[0]
    }
  }

  #renderAreas(json) {
    const host = this;
    //console.log(json);
    //console.log(typeof json);
    //this.#fixCoords(json.features);
    //console.log(ymaps.geoQuery(json));
    //console.log(this.owner.map);
    this.areas = ymaps.geoQuery(json).addToMap(this.owner.map);
    //console.log(this.owner.map.geoObjects);
    //this.owner.map.geoObjects.add(this.areas);
    //console.log(this.areas);
    
    this.areas.each((obj) => {
        //console.log(obj.properties.get('fill'));
        obj.options.set({
            fillColor: obj.properties.get('fill'),
            fillOpacity: obj.properties.get('fill-opacity'),
            //strokeColor: obj.properties.get('stroke'),
            strokeWidth: 0,//obj.properties.get('stroke-width'),
            strokeOpacity: 0,//obj.properties.get('stroke-opacity')
        });
        obj.events.add('click', (e) => {
          const coords = e.get('coords');
          host.owner.afk.addrByCoords(coords);
          //console.log(coords.join(', '));
          //console.log('Clicked!');
          //console.log(e);
        });
        //obj.properties.set('balloonContent', obj.properties.get('description'));
    });
  }
}

class ResultsRenderer {
  constructor(owner, config = {
    dataPath: 'assets/template/json/deliveryCalculatorServiceAreas/area-delivery-data.json'
  }) {
    this.owner = owner;
    this.config = config;
    this.ready = false;
    this.areas = null;
    const host = this;
    this.load(this.config.dataPath).then((res) => {
      host.ready = true;
      //console.log(res);
      EventKeeper.trigger(Events.pricesLoaded);
    }, (err) => {
      console.error("Error loading delivery data json");
      console.error(err);
    });
  }

  async load(path) {
    const resp = await fetch(path);
    //console.log(resp);
    if(!resp.ok) throw resp;
    const result = await resp.json();
    this.areas = result;
    //console.log(result);
  }

  #clearAreaInfo() {
    const weights = [
      '',
      '0,5',
      '1,5',
      '3,5',
      '5',
      '10'
    ];
    for(let w in weights) {
      this.owner.ui.setPrices('handler', w, '-', '-');
    }
    /*
    this.owner.ui.setPrices('car', '0,5', '-', '-');
    this.owner.ui.setPrices('car', '1,5', '-', '-');
    this.owner.ui.setPrices('car', '3,5', '-', '-');
    this.owner.ui.setPrices('car', '5', '-', '-');
    this.owner.ui.setPrices('car', '10', '-', '-');*/
  }

  #setAreaInfo(area) {
    this.#clearAreaInfo();
    //console.log(area);
    /*
    if(area.handler){
      this.owner.ui.setPrices('handler', '', area.handler.dur, area.handler.exact);
    }else {
      this.owner.ui.setPrices('handler', '', '-', '-');
    }*/
    console.log(area);
    if(area.car){
      for(let p in area.car){
        //console.log(p);
        //console.log(area.car[p]);
        this.owner.ui.setPrices('car', p, area.car[p].dur, area.car[p].exact);
      }
      //console.log('car is empty');
    }
    if(area.handler){
      //console.log(area.car);
      for(let p in area.handler){
        //console.log(p);
        //console.log(area.handler[p]);
        this.owner.ui.setPrices('handler', p, area.handler[p].dur, area.handler[p].exact);
      }
    }
  }

  async render(desc) {
    if(!desc){
      //this.owner.afk.setAddrMessage('Адрес за пределами области обслуживания');
      this.owner.ui.setService(false, true);
      return;
    }
    //console.log(desc);
    //console.log(this.areas);
    const area = this.areas[desc];
    if(!area){console.error('Area not found in delivery data.'); return;}
    this.owner.ui.setService(true, false);
    this.#setAreaInfo(area);
  }
}

class UIHandler {
  owner;
  constructor(owner, config = {
    mapWrapperSel: '.js-delivery-calculator__map-wrapper',
    mapSel: '.js-delivery-calculator__map',
    vehicleSel: '.js-delivery-calculator__vehicle',
    weightsSel: '.js-delivery-calculator__weights',
    weightLinkSel: '.js-delivery-calculator__weights a',
    priceTabs: '.js-delivery-calculator__price',
    priceDurSel: '.js-delivery-calculator__price-dur .js-delivery-calculator__price-value',
    priceExactSel: '.js-delivery-calculator__price-exact .js-delivery-calculator__price-value',
    tabInServiceSel: '.js-delivery-calculator__in-service',
    tabOutOfServiceSel: '.js-delivery-calculator__out-of-service'
  }) {
    this.owner = owner;
    this.config = config;
    this.formData = {
      vehicleId: 'car',
      carWeight: '0,5',
      handlerWeight: '5',
    }
  }

  #toggleWeights() {
    const host = this;
    const weightsCars = body.querySelector(this.config.weightsSel + '.cars');
    const weightsHandlers = body.querySelector(this.config.weightsSel + '.handlers');
    //if(!weights)throw 'Can\'t find weights block';
    //console.log(this.formData);
    //console.log(weights);
    if(this.formData.vehicleId == 'car') {
      weightsCars.classList.add('active');
      weightsHandlers.classList.remove('active');
      const links = weightsCars.querySelectorAll('a');
      links.forEach((link) => {
        const weight = link.dataset.value;
        link.classList.remove('active');
        if(weight == host.formData.carWeight)link.classList.add('active');
      });
    }else if(this.formData.vehicleId == 'handler') { 
      weightsHandlers.classList.add('active');
      weightsCars.classList.remove('active');
      const links = weightsHandlers.querySelectorAll('a');
      links.forEach((link) => {
        const weight = link.dataset.value;
        link.classList.remove('active');
        if(weight == host.formData.handlerWeight)link.classList.add('active');
      });
    }
  }

  #togglePrices() {
    const host = this;
    const priceTabs = body.querySelectorAll(this.config.priceTabs);
    if(!priceTabs)throw 'Can\'t find price tabs';
    priceTabs.forEach((tab) => {
      tab.classList.remove('active');
      const weight = tab.dataset.weight;
      const vehicleId = tab.dataset.vehicle;
      const formDataWeight = host.formData.vehicleId == 'car'?host.formData.carWeight:host.formData.handlerWeight;
      if(vehicleId == host.formData.vehicleId && (weight == formDataWeight)){ 
        tab.classList.add('active');
      }
      //if(vehicleId == host.formData.vehicleId && (weight == host.formData.handlerWeight)){ 
      //tab.classList.add('active');
      //}
      //console.log(weight);
      //console.log(host.formData.weight);
      /*if(host.formData.vehicleId == 'car' && (weight == host.formData.weight)){
        //console.log('car weight');
        tab.classList.add('active');
      }*/
    });
  }

  #setActiveLink(linkElem) {
    const weightLinks = body.querySelectorAll(this.config.weightLinkSel);
    if(weightLinks.length < 1)throw 'Can\'t find weight links';
    weightLinks.forEach((link) => {
      link.classList.remove('active');
    });
    linkElem.classList.add('active');
  }

  setPrices(vehicle, weight, priceDur, priceExact) {
    if(!priceDur)priceDur = '-';
    if(!priceExact)priceExact = '-';
    //console.log(vehicle, weight, priceDur, priceExact);
    const host = this;
    const priceTabs = body.querySelectorAll(this.config.priceTabs);
    if(!priceTabs)throw 'Can\'t find price tabs';
    priceTabs.forEach((tab) => {
      const tabWeight = tab.dataset.weight;
      const vehicleId = tab.dataset.vehicle;
      const priceDurElem = tab.querySelector(host.config.priceDurSel);
      const priceExactElem = tab.querySelector(host.config.priceExactSel);
      if(vehicle == 'handler' && vehicleId == 'handler'){
        if(tabWeight == weight) {
          priceDurElem.innerHTML = Utils.priceFormat(priceDur);
          priceExactElem.innerHTML = Utils.priceFormat(priceExact);
        }
      }
      if(vehicle == 'car' && vehicleId == 'car'){
        if(tabWeight == weight) {
          priceDurElem.innerHTML = Utils.priceFormat(priceDur);
          priceExactElem.innerHTML = Utils.priceFormat(priceExact);
        }
      }
    });
  }

  setService(showInSevice, showOutOfService) {
    const inService = document.querySelector(this.config.tabInServiceSel);
    if(!inService)throw 'Can\'t find In service tab';
    const outOfService = document.querySelector(this.config.tabOutOfServiceSel);
    if(!outOfService)throw 'Can\'t find Out of service tab';
    if(showInSevice){inService.classList.add('active');}else {inService.classList.remove('active');}
    if(showOutOfService){outOfService.classList.add('active');}else {outOfService.classList.remove('active');}
  }

  #bindMapScrollHover() {
    const wrapper = body.querySelector(this.config.mapWrapperSel);
    if(!wrapper)throw 'Can\'t find map scroll hover overlay';
    const map = body.querySelector(this.config.mapSel);
    wrapper.addEventListener('click', (e) => {
      //console.log('click');
      map.classList.add('active');
    });
    map.addEventListener('mouseout', (e) => {
      //console.log('out');
      //console.log(e.fromElement);
      //console.log(e.fromElement.closest(this.config.mapSel));
      if(e.fromElement.closest(this.config.mapSel)){
        map.classList.remove('active');
      }
    });
  }

  bind() {
    const host = this;
    this.#bindMapScrollHover();
    const vehicles = body.querySelectorAll(this.config.vehicleSel + ' label');
    //console.log(this.config.vehicleSel + ' label');
    if(vehicles.length < 1)throw 'Can\'t find vehicles';
    //console.log(vehicles);
    vehicles.forEach((obj) => {
      obj.addEventListener('click', function(e){
        if(e.target.nodeName != 'INPUT')return;
        //console.log(e);
        //console.log(e.target);
        //const val = e.target.value;
        const vehicleId =  e.target.dataset.value;
        host.formData.vehicleId = vehicleId;
        host.#toggleWeights();
        host.#togglePrices();
        //console.log(vehicleId);
      });
    }); 

    const weightLinks = body.querySelectorAll(this.config.weightLinkSel);
    if(weightLinks.length < 1)throw 'Can\'t find weight links';
    //console.log(weightLinks);
    weightLinks.forEach((link) => {
      link.addEventListener('click', (e) => {
        e.preventDefault();
        const linkElem = e.target.closest(this.config.weightLinkSel);
        if(!linkElem)throw 'Can\'t find link element';
        //console.log(linkElem);
        const weight = linkElem.dataset.value;
        host.formData.vehicleId == 'car'?host.formData.carWeight = weight:host.formData.handlerWeight = weight;
        host.#setActiveLink(linkElem);
        host.#togglePrices();
        //console.log(host.formData);
      });
    });
  }
}

class DeliveryCalculatorServiceAreas {
  constructor(config = {
    mapid: 'delivery-calculator-map'
  }) {
    this.config = config;
    this.map = null;
    const elem = document.getElementById(config.mapid);
    if(!elem)throw 'Map id not found: #' + config.mapid;
    //this.restrictedArea = [[54.63970408670057, 35.36583007812499],[56.6400464750958, 39.738388671874986]]; //левый нижний, правый верхний
    this.afk = new AddressFieldKeeper(this);
    this.rr = new ResultsRenderer(this);
    this.ui = new UIHandler(this);
    this.areas = null;
    this.placemark = null;
  }

  #ymapsInit() {
    const host = this;
    ymaps.ready(function() {
        // Создание карты.
      host.map = new ymaps.Map(host.config.mapid, {
          // Координаты центра карты.
          // Порядок по умолчанию: «широта, долгота».
          // Чтобы не определять координаты центра карты вручную,
          // воспользуйтесь инструментом Определение координат.
          center: [55.76, 37.64],
          // Уровень масштабирования. Допустимые значения:
          // от 0 (весь мир) до 19.
          controls: ['zoomControl'],
          zoom: 7
      }, {
        restrictMapArea: Constraints.restrictedArea
      });
      try{
        host.areas = new AreasKeeper(host);
        const cursor = host.map.cursors.push('pointer');
        //host.map.setBounds([[54.63970408670057, 35.36583007812499],[56.6400464750958, 39.738388671874986]]);
        host.afk.bindAddressField();
        host.#bindMapEvents();
        try {
          host.ui.bind();
        }catch(t){
          console.error(t);
        }
        EventKeeper.trigger(Events.mapLoaded);
      }catch(t){
        console.error(t);
      }
    });
  }

  setMark(coords, name = false){
    if(!coords)return;
    if(coords.constructor != Array)return;
    this.map.geoObjects.remove(this.placemark); //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    this.placemark = new ymaps.Placemark(coords);
    //const name = pm.properties.get('name');
    if(name)this.placemark.properties.set('iconContent', name);
    this.placemark.options.set('preset', 'islands#redStretchyIcon');
    
    const polygon = this.areas.areas.searchContaining(coords).get(0);
    //console.log("Polygon: ");
    //console.log(typeof polygon);
    try {
      if(!polygon) {this.rr.render();}
      if(polygon && this.rr.ready){
        this.rr.render(polygon.properties.get('description'));
      }
      this.map.geoObjects.add(this.placemark);
      this.map.panTo(coords);
    }catch(t) {
      console.error(t);
    }
    
  }


  #bindMapEvents() {
    const host = this;
    this.map.events.add('click', function (e) {
      const coords = e.get('coords');
      host.afk.addrByCoords(coords);
      //console.log(coords.join(', '));
      //console.log(host.map.getZoom());
  });
  }

  #setEventHandlers() {
    const host = this;
    const states = {
      areasRendered: false,
      pricesLoaded: false,
      mapLoaded: false
    };
    function readyToGo() {
      if(states.areasRendered && states.pricesLoaded && states.mapLoaded){
        EventKeeper.trigger(Events.readyToGo);
      }
    }
    EventKeeper.bindHandler(Events.areasRendered, () => {
      states.areasRendered = true;
      readyToGo();
    });
    EventKeeper.bindHandler(Events.mapLoaded, () => {
      states.mapLoaded = true;
      readyToGo();
    });
    EventKeeper.bindHandler(Events.pricesLoaded, () => {
      states.pricesLoaded = true;
      readyToGo();
    });
    EventKeeper.bindHandler(Events.readyToGo, () => {
      host.setMark([55.75351431510645, 37.618027343749986]);
    });
  }

  #setFormHandler() {
    const form = document.querySelector('.js-delivery-calculator__form');
    if(!form)return;
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      console.log('submit');
      return false;
    });
  }

  run() {
    this.#setEventHandlers();
    this.#ymapsInit();
    this.#setFormHandler();
    //console.log("Delivery Calculator running");
  }
}

export {
  DeliveryCalculatorServiceAreas
}