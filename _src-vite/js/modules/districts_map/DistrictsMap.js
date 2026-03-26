class DistrictsMap {
  districtsMap;
  polygons;
  hoverObj;
  activeObj;

  createMap({id, center, zoom}) {
    if(!ymaps){ throw "No ymaps";}
    id = id ?? 'default_id';
    center = center ?? [59.94313797002322, 30.3010448956483]; //СПБ по умолчанию
    zoom = zoom ?? 8;
    const districtsMap = new ymaps.Map(id, {
          center,
          zoom,
        });
    this.districtsMap = districtsMap;
    this.polygons = new Map();
    return districtsMap;
  }
  addWarehouse({coords, options, baloonHeader, baloonContent}) {
    if(typeof coords != 'object'){console.error('No coords'); return;}
    if(typeof options != 'object'){console.error('No options'); return;}
    if(!baloonHeader){console.error('baloonHeader is undefined')}
    if(!baloonContent){console.error('baloonContent is undefined')}
    this.districtsMap.geoObjects.add(
      new ymaps.Placemark(
        coords,
        {
          balloonContentHeader: baloonHeader,
          balloonContent: baloonContent,
        },
        options
      )
    );
  }
  setIconOptions({iconLayout, iconImageHref, iconImageSize, iconImageOffset}) {
    if(!iconImageHref){console.error('No icon href')}
    return {
      iconLayout: iconLayout ?? "default#image",
      iconImageHref,
      iconImageSize: iconImageSize ?? [42, 42],
      iconImageOffset: iconImageOffset ?? [-21, -21]
    };
  }

  createPolygon({coords, id, name, color, strokeColor, fillOpacity, strokeWidth, strokeStyle, baloonHeader, baloonContent, hintContent}) {
    if(typeof coords != 'object') { console.error('No coords'); return;}
    if(typeof id === 'undefined'){console.error('Id must be set'); return;}

    const myGeoObject = new ymaps.GeoObject(
    {
      geometry: {
        type: "Polygon",
        coordinates: coords,
      },
      properties: {
        hintContent: hintContent ?? name,
        balloonContentHeader: baloonHeader ?? name,
        balloonContent: baloonContent ?? "",
        districtId: id,
        districtName: name,
        polygonColor: color ?? "#00ff22",
      },
    },
    {
      fillColor: color ?? "#00ff22",
      strokeColor: strokeColor ?? "#000000",
      fillOpacity: fillOpacity ?? 0.3,
      strokeWidth: strokeWidth ?? 1,
      strokeStyle: strokeStyle ?? "solid",
    }
  );
  this.polygons.set(id, myGeoObject);
  this.districtsMap.geoObjects.add(myGeoObject);
  return myGeoObject;
  }

  setPolygonEventOpts({poly, activeOpts, hoverOpts, leaveOpts}) {
    if(typeof poly != 'object')return;
    const host = this;
    poly.events.add("mouseenter", function (e) {
      const tarId = e.originalEvent.target.properties.get("districtId");
      const d = host.polygons.get(tarId);
      if(!d)return;
      if(tarId != host.activeObj?.properties.get("districtId"))d.options.set(hoverOpts);
      host.hoverObj = d;
    });

    poly.events.add("mouseleave", function (e) {
      const tarId = e.originalEvent.target.properties.get("districtId");
      const d = host.polygons.get(tarId);
      if(!d)return;
      if(host.activeObj?.properties.get("districtId") != tarId)d.options.set(leaveOpts);
    });

    poly.events.add("click", function (e) {
      const tarId = e.originalEvent.target.properties.get("districtId");
      const d = host.polygons.get(tarId);
      if(!d)return;
      host.activeObj?.options.set(leaveOpts);
      d.options.set(activeOpts);
      host.activeObj = d;
    });
  }
}

export {
  DistrictsMap
}