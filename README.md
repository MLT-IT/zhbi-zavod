# Рекомендации

- Версия Node.js >= 24.0.0

# Структура

```
_src-vite/          # исходники проекта
dist/               # папка сборки
core/elements/vite/
  ├─ css.tpl        # сгенерированные теги <link>
  └─ js.tpl         # сгенерированные теги <script>
```

# Начало работы

1. Установить зависимости: `npm install`
2. Для разработки использовать `APP_ENV=development` и запустить `npm run dev`
3. После завершения изменений выполнить `npm run build`
4. После сборки Vite обновит `core/elements/vite/js.tpl` и `core/elements/vite/css.tpl`
