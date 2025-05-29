# Компонент: CategoryProductRules

## 📁 Структура проекта

```
components/
└── CategoryProductRules/
    ├── app/            # Исходники фронтенда (React + Vite)
    ├── controllers/    # Инициализация страницы в админке MODX
    ├── actions/        # Экшены для работы с данными в базе
        └── mgr         # Для доступа к mgr контексту проверяется авторизация
        └── web
    ├── templates/      # Сборка фронта (index.html, assets)
    └── action.php      # API-обработчик для фронта
```

---

## 🚀 Production

1. Для деплоя залейте каталог в `{core_path}components/CategoryProductRules/`
2. Создайте записи в "Пространство имен"

```code
{core_path}components/CategoryProductRules/
{assets_path}components/CategoryProductRules/
```

3. Проверить что в action.php `const PRODUCTION = true;`
4. С app/ запустить `npm run build`
5. Запустить миграции `database/migrations/table_name.php` (Пока через консоль. Не придумал как упростить установку)

---

## 🛠️ Разработка

### Фронтенд админка (`app/`)

```bash
cd app/
npm install         # Установка зависимостей
npm run dev         # Запуск dev-сервера (Vite)
npm run build       # Сборка production-версии в ../templates/
```

### Бэкенд

- `action.php` Для выполнения запросов в базу установи
  `const PRODUCTION = false;`

  **⚠️ НЕ ЗАБУДЬ ВЕРНУТЬ ОБРАТНО НА TRUE ПРИ ДЕПЛОЕ!**

---
