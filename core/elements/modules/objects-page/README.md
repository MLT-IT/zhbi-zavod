Модуль для шаблона Наши объекты под сетку Строймаркет.
По мотивам 
- https://zhbi-market.ru/nashi-obekty/ (KKiriakov)
- https://gbi78.ru/obyekty.html (tedgregory)

требует migx поля

---
"objects_migx"
```json
[{"caption":"Объект","fields":[
{"field":"name","caption":"Заголовок"},
{"field":"location","caption":"Местоположение"},
{"field":"year","caption":"Год строительства"},
{"field":"description","caption":"Описание","inputTVtype":"textarea"},
{"field":"coord","caption":"Координаты через запятую"},
{"field":"products","caption":"ID товаров через запятую"},
{"field":"images","caption":"фото", "inputTV": "object_photo"}
]}]


[
{"header": "Заголовок", "dataIndex": "name"},
{"header": "Координаты", "dataIndex": "coord"}
]
```
"gallery_item"
```json
[{"caption":"Фото", "fields": [
{"field":"img", "caption":"Фото", "inputTVtype":"image", "sourceFrom":"migx"}
]}]

[{"header": "Фото", "sortable": "false", "dataIndex": "img","renderer": "this.renderImage", "width": "200"}]
```
одиночный список "object_type"
```
Многоквартирные дома и жилые комплексы==mkd||ТРК и ТРЦ==trk||Дорожное строительство==road
```
