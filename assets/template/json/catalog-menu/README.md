# Элементы меню для каталога

- По хорошему формирование таких json делать пакетом. TODO - Написать пакет для modx

## Структура

- Первый уровень отвечает за левый столбец в меню (родители)
- Раскрывающиеся дочерние списки children разбиваются по GROUP_NAME

```json
[
  {
    "title": "Утеплитель Rockwool",
    "uri": "/rockwool/",
    "children": {
      "GROUP_NAME": [
        {
          "title": "Лайт Баттс",
          "uri": "/rockwool/light-batts/"
        },
        {
          "title": "Скандик Лайт Баттс",
          "uri": "/rockwool/light-batts/light-batts-scandic/"
        }
      ]
    }
  }
]
```
