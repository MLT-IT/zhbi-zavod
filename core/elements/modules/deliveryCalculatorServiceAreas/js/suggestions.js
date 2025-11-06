import { InBoundsByAreas, InBoundsByGeoCode } from "./InBoundsTester";

class Suggestions {

  areaPolygons = [];
  inBoundsTester = null;
  constructor(settings) {
    this.settings = settings;
    this.inBoundsTester = new InBoundsByAreas();
    //this.inBoundsTester = new InBoundsByGeoCode();
  }

  //where - объект {kind: 'province', name: 'Московская область'}, который фильтрует результаты на принадлежность к территории
  async get(text, where = null) {
    if(!text)return;
    const host = this;
    //console.log('get!');
    const results = await ymaps.geocode(text, { results: 5, boundedBy: host.settings.bounds, json: true });
    let entries = results.GeoObjectCollection.featureMember;
    //if(where)entries = this.inBounds(entries, where);
    //entries = this.inBoundsByAreas(entries);
    entries = this.inBoundsTester.inBounds(entries, where);
    return this.prepareSuggestions(entries);
  }

  prepareSuggestions(features) { //features из геокодера, функция достает нужную информацию и помещает ее в массив
    //console.log(features);
    const result = [];
    features.forEach(f => {
      //console.log(f);
      const pos = this.normalizePos(f.GeoObject.Point.pos);
      const key = pos[0] + '_' + pos[1];
      result.push({
        coords: pos,
        key,
        text: f.GeoObject.metaDataProperty.GeocoderMetaData.text
      });
    });
    return result;
  }

  normalizePos(posStr) { //Приводит координаты из геокодера к правильному виду (преобразует в массив, меняет местами и преобразует в числа)
    const pos = posStr.split(' ');
    [pos[0], pos[1]] = [parseFloat(pos[1]), parseFloat(pos[0])];
    return pos;
  }
}

export {
  Suggestions
}