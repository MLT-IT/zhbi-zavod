export default function initDistrictsMap() {
    let districtsMap = new ymaps.Map("districts_map", {
        center: [59.94313797002322, 30.3010448956483],
        zoom: 6
    })

    $.getJSON('assets/template/json/districts.json', function (data) {
        addPolygonsToMap(data);
    });

    function addPolygonsToMap(spbDistricts) {
        let districtNum = 0;

        spbDistricts.forEach(function (sd) {
            sd.coords.forEach(function (coord) {
                var myGeoObject = new ymaps.GeoObject({
                    geometry: {
                        type: "Polygon",
                        coordinates: coord
                    },
                    properties: {
                        hintContent: sd.name,
                        balloonContentHeader: sd.name,
                        balloonContent: '',
                        districtId: districtNum,
                        districtName: sd.name,
                        polygonColor: sd.color
                    }
                }, {
                    fillColor: sd.color,
                    strokeColor: '#000000',
                    fillOpacity: 0.3,
                    strokeWidth: 1,
                    strokeStyle: 'solid'
                });
                myGeoObject.events.add('mouseenter', function (e) {
                    let tar = e.originalEvent.target;
                    let tarId = tar.properties.get('districtId');
                    districtsMap.geoObjects.each(function (d) {
                        if (d.options.get('fillOpacity') !== 0.9) {
                            if (d.properties.get('districtId') === tarId) {
                                d.options.set({fillOpacity: 0.8});
                            } else {
                                d.options.set({fillOpacity: 0.3});
                            }
                        }
                    });
                });

                myGeoObject.events.add('mouseleave', function (e) {
                    districtsMap.geoObjects.each(function (d) {
                        if (d.options.get('fillOpacity') !== 0.9) {
                            d.options.set({fillOpacity: 0.3});
                        }
                    });
                });

                myGeoObject.events.add('click', function (e) {
                    let tar = e.originalEvent.target;
                    let tarId = tar.properties.get('districtId');
                    districtsMap.geoObjects.each(function (d) {
                        if (d.properties.get('districtId') === tarId) {
                            d.options.set({fillOpacity: 0.9});
                        } else {
                            d.options.set({fillOpacity: 0.3});
                        }
                    });

                });
                districtsMap.geoObjects.add(myGeoObject);
            });
            districtNum++;
        });
    }

    let options = {
        iconLayout: 'default#image',
        iconImageHref: 'assets/template/img/icons/warehouse-1.png',
        iconImageSize: [42, 42], // Размеры метки.
        iconImageOffset: [-21, -21] // Смещение левого верхнего угла иконки относительно её "ножки" (точки привязки).
    }

    districtsMap.geoObjects
        .add(new ymaps.Placemark(
            [60.095437, 30.302033],
            {balloonContent: 'Склад СПБ Север'},
            options
        ))
        .add(new ymaps.Placemark(
            [59.888841, 30.507709],
            {balloonContent: 'Склад СПБ Восток'},
            options
        ))
        .add(new ymaps.Placemark(
            [59.809960, 30.164158],
            {balloonContent: 'Склад СПБ ЮГ'},
            options
        ))
        .add(new ymaps.Placemark(
            [61.034092, 30.118767],
            {balloonContent: 'Склад Приозерск'},
            options
        ))
        .add(new ymaps.Placemark(
            [60.704906, 28.781041],
            {balloonContent: 'Склад Выборг'},
            options
        ))
        .add(new ymaps.Placemark(
            [60.560001, 30.218770],
            {balloonContent: 'Склад Сосново'},
            options
        ))
        .add(new ymaps.Placemark(
            [59.572289, 30.154513],
            {balloonContent: 'Склад Гатчина'},
            options
        ))
        .add(new ymaps.Placemark(
            [59.403185, 28.477475],
            {balloonContent: 'Склад Кингисепп'},
            options
        ))
        .add(new ymaps.Placemark(
            [59.105408, 28.080176],
            {balloonContent: 'Склад Сланцы'},
            options
        ))
        .add(new ymaps.Placemark(
            [58.751428, 29.852831],
            {balloonContent: 'Склад Луга'},
            options
        ))
        .add(new ymaps.Placemark(
            [59.552136, 30.833349],
            {balloonContent: 'Склад Тосно'},
            options
        ))
        .add(new ymaps.Placemark(
            [60.254115, 29.575553],
            {balloonContent: 'Склад Рощино'},
            options
        ))
        .add(new ymaps.Placemark(
            [59.728510, 30.100380],
            {balloonContent: 'Склад Красное Село'},
            options
        ))
}
