export default function initDistrictsMap() {
    let districtsMap = new ymaps.Map("districts_map", {
        center: [59.94313797002322, 30.3010448956483],
        zoom: 6
    });

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
    };

    let phoneNumber = $('.header__phone').text().trim();
    let balloonContentHTML = '<div style="text-align: center;">Часы работы: ежедневно с 8:00 до 21:00<br>Стоимость доставки до 30 км: 990 рублей<br>Телефон склада: <a href="tel:' + phoneNumber + '">' + phoneNumber + '</a></div>';

    districtsMap.geoObjects
        .add(new ymaps.Placemark(
            [60.095437, 30.302033],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад СПБ Север</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.888841, 30.507709],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад СПБ Восток</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.809960, 30.164158],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад СПБ ЮГ</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [61.034092, 30.118767],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Приозерск</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [60.704906, 28.781041],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Выборг</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [60.560001, 30.218770],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Сосново</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.572289, 30.154513],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Гатчина</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.403185, 28.477475],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Кингисепп</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.105408, 28.080176],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Сланцы</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [58.751428, 29.852831],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Луга</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.552136, 30.833349],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Тосно</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [60.254115, 29.575553],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Рощино</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.728510, 30.100380],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Красное Село</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.882822, 29.101508],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Сосновый Бор</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.460055, 29.498431],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Волосово</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.915849, 32.348457],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Волхов</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.449051, 32.041397],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Кириши</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [60.728961, 33.593527],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Лодейное Поле</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ))
        .add(new ymaps.Placemark(
            [59.669877, 33.499404],
            {
                balloonContentHeader: '<div style="text-align: center;">Склад Тихвин</div>',
                balloonContent: balloonContentHTML,
            },
            options
        ));
}
