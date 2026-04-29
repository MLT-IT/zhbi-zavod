# 🌐 Virtual Router для MODX

Модуль для работы с виртуальными поддоменами без использования `ContextRouter`

## 📁 Структура проекта

- Данные

## 🚀 Установка

- Создать плагин в админке `virtual-router/plugins/VirtualRouter.php`
- Добавить данные аналогично тестовым

## Как пользоваться (Владимир <ghost66pva@gmail.com>)
- Модуль помещает все данные плейсхолдер virtual-router: `$modx->getPlaceholder('virtual-router')`
- Если плейсхолдер пуст, создайте объект: 
```php
    $module_path = MODX_BASE_PATH . "core/elements/modules/virtual-router";
    include "$module_path/index.php";
    $virtual_router = new VirtualRouter();
```
- После этого плейсхолдер будет доступен
- Создайте json файл `core\elements\modules\virtual-router\data\global\regions\<регион>\<поддомен>.json`. Название региона может быть любым, название файла - поддомен. Для `ekaterinburg.osnova.spb.ru` сработает файл `core\elements\modules\virtual-router\data\global\regions\ekaterinburg\ekaterinburg.json`
- Создайте _default.json в папке региона
- В файлах json пропишите все необходимые опции, они будут доступны как `$modx->getPlaceholder('virtual-router')['ваша опция']`
- id битрикса читается из опции `bx_id`.
- Яндекс-карты: `ymap`
- Склады: `warehouses`