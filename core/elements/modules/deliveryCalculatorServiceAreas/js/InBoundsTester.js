import { EventKeeper } from "./EventKeeper";
import { Events } from "./Events";
import { coordsFromStr } from "./Utils";

//Предполагалось, что это будет интерфейс
class InBoundsTester {
  inBounds(...args) {
  }
}

class InBoundsByAreas extends InBoundsTester {
  //coords - массив из 2х координат
  //ymaps.geometry.base.Polygon
  areaPolygons = [];
  constructor() {
    super();
    EventKeeper.bindHandler(Events.areasRendered, (areas) => {
      //console.log('rendered!');
      //console.log(areas);
      this.#polygonsFromAreas(areas);
    });
    //this.areaPolygons = areaPolygons;
  }

  #polygonsFromAreas(areas) {
    const host = this;
    const features = areas.features;
    features.forEach((f) => {
      let coords = f.geometry.coordinates;
      //console.log(coords);
      const poly = new ymaps.geometry.base.Polygon(coords);
      host.areaPolygons.push(poly);
    });
  }

  #pointInPolygons(coords) {
    if(!this.areaPolygons || this.areaPolygons.length < 1)return true;
    [coords[0], coords[1]] = [coords[1], coords[0]]; //Координаты все равно надо переворачивать
    for(let i = 0; i < this.areaPolygons.length; ++i) {
      const poly = this.areaPolygons[i];
      const r = poly.contains(coords);
      if(r){
        //console.log('contains!');
        return true;
      }
    }
    return false;
  }
  //GeoObjectCollection.featureMember
  inBounds(entries) {
    const host = this;
    const output = [];
    entries.forEach((e) => {
      const coords = coordsFromStr(e.GeoObject.Point.pos, ' ');
      if(host.#pointInPolygons(coords))output.push(e);
      //console.log(coords);
    });
    //console.log(output);
    return output;
  }
}

class InBoundsByGeoCode extends InBoundsTester {
  constructor() {
    super();
  }
  //параметр - results.GeoObjectCollection.featureMember из ymaps.geocode() в виде json
  inBounds(entries, where) {
    //console.log(entries);
    if(!where)return entries;
    const output = [];
    entries.forEach((entry) => {
      const components = entry.GeoObject.metaDataProperty.GeocoderMetaData.Address.Components
      for(let i = 0; i < components.length; ++i) {
        if(components[i].kind != where.kind)continue;
        if(components[i].name != where.name)continue;
        output.push(entry);
        break;
      }
    });
    //console.log(output);
    return output;
  }
}

export {
  InBoundsByAreas,
  InBoundsByGeoCode
}