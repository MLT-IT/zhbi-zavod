# Работа с Codeception

### Установка

Шаг 1. Перейти в папку `_tests`.

Шаг 2. Скачать все пакеты.
```
composer update
```

Шаг 3. Установить codeception.
```
"vendor/bin/codecept" bootstrap
```

Шаг 4. Установить Selenium. Глобально, т.к. Selenium - это программа, а не библиотека. Она может использоваться для разных проектов.
```
npm install selenium-standalone -g
selenium-standalone install
```

Шаг 5. В git есть файл: `_tests/tests/example.acceptance.suite.yml`. Берем его содержимое и помещаем в `acceptance.suite.yml`, который находится в той же папке. Скорее всего, придется еще подправить его - указать свой домен (на локалке у каждого разработчика домен может называться по-разному):
```
- WebDriver:
    url: 'домен сайта на локалке'
```

### Запуск

Шаг 1. Запускаем Selenium.
```
selenium-standalone start
```

Шаг 2. Запускаем все тесты. Важно, чтобы Chrome был версии, которая соответствует WebDriver (его мы установили командой composer update).
```
"vendor/bin/codecept" run acceptance --steps
```

### Контексты
В `acceptance.suite.yml` есть настройка `env`. В ней записаны режимы для запуска тестов на других доменах.

Вот пример запуска тестов на домене `krovlyasp.local`:
```
"vendor/bin/codecept" run acceptance --steps --env krovlyasp
```
Через `&&` можно объединять команды. И таким образом одной командой запустить тесты сразу на нескольких контекстах. Пример:
```
"vendor/bin/codecept" run acceptance --steps && "vendor/bin/codecept" run acceptance --steps --env krovlyasp && "vendor/bin/codecept" run acceptance --steps --env armatura-178
```
