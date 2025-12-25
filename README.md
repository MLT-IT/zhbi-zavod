# Новый строймаркет

## DEV

Файлы всего репо можно закинуть в корень сайта. .gitrignore не даст заметить лишние файлы сайта

- На пустой проект MODX в корень сайта накатить git clone
- node version - 22^
- npm install
- npm run dev

## descr

- Чаще пользуйтесь поиском. Много классов, чанков и тд вызываются в разных местах
- Необходимые опции для контекстов можно подсмотреть в файлах core/elements/config/placeholders/data. Получаю их через $modx->getOption
- Все опции контекстов желательно проводить через вышеупомянутый путь

- Для быстроты работы сайта, выбран принцип построения кэшированной карты ресурсов. В layouts/base.tpl вызываются modules/map-resources/mapResources.php с необходимыми параметрами. Скрипт получает необходимые реусрсы, кэширует и сохраняет в плейсхолдер. Далее на всем сайте мы работаем с данными массивами, благодаря чему отпадает необходимость каждый раз дергать ресурсы из бд.
- JS привязывал только к data аттрибутам что дает гибкость и прозрачность
- SCSS общие стили вынес на классы в scss/classes/

## TV - поля

- main_image - Основная картинка ресурса
- priority [Число] - Приоритет товара
- filters - Фильтры
- mfilter_depth - Глубина поиска товаров. полезно на каталоге указать 1, быстрее работать будет
- tags [migx] - Теги категории

Инсерт в базу основных TV

```sql
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (1, 1, 0, 'text', 'filters', 'Фильтры на категории', '', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:5:{s:10:"allowBlank";s:4:"true";s:9:"minLength";s:0:"";s:9:"maxLength";s:0:"";s:5:"regex";s:0:"";s:9:"regexText";s:0:"";}', 'a:0:{}', 0, '');
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (2, 1, 0, 'image', 'main_image', 'Картинка', '', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:1:{s:10:"allowBlank";s:4:"true";}', 'a:0:{}', 0, '');
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (3, 1, 0, 'number', 'priority', 'Приоритет', '', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:8:{s:10:"allowBlank";s:4:"true";s:13:"allowDecimals";s:4:"true";s:13:"allowNegative";s:5:"false";s:16:"decimalPrecision";s:1:"2";s:22:"strictDecimalPrecision";s:5:"false";s:16:"decimalSeparator";s:1:".";s:8:"maxValue";s:0:"";s:8:"minValue";s:0:"";}', 'a:0:{}', 0, '');
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (4, 1, 0, 'number', 'mfilter_depth', 'Глубина поиска товаров Filter', '', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:8:{s:10:"allowBlank";s:4:"true";s:13:"allowDecimals";s:4:"true";s:13:"allowNegative";s:4:"true";s:16:"decimalPrecision";s:1:"2";s:22:"strictDecimalPrecision";s:5:"false";s:16:"decimalSeparator";s:1:".";s:8:"maxValue";s:0:"";s:8:"minValue";s:0:"";}', 'a:0:{}', 0, '');
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (6, 1, 0, 'text', 'video', 'Видео', 'Перечислить через запятую', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:5:{s:10:"allowBlank";s:4:"true";s:9:"minLength";s:0:"";s:9:"maxLength";s:0:"";s:5:"regex";s:0:"";s:9:"regexText";s:0:"";}', 'a:0:{}', 0, '');
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (7, 3, 0, 'text', 'range_remains', 'Остатки. от - до (10-100)', '', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:5:{s:10:"allowBlank";s:4:"true";s:9:"minLength";s:0:"";s:9:"maxLength";s:0:"";s:5:"regex";s:0:"";s:9:"regexText";s:0:"";}', 'a:0:{}', 0, '');
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (8, 3, 0, 'text', 'warehouse_additional_number', 'Добавочный номер', '', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:5:{s:10:"allowBlank";s:4:"true";s:9:"minLength";s:0:"";s:9:"maxLength";s:0:"";s:5:"regex";s:0:"";s:9:"regexText";s:0:"";}', 'a:0:{}', 0, '');
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (9, 3, 0, 'text', 'warehouse_address', 'Адрес', '', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:5:{s:10:"allowBlank";s:4:"true";s:9:"minLength";s:0:"";s:9:"maxLength";s:0:"";s:5:"regex";s:0:"";s:9:"regexText";s:0:"";}', 'a:0:{}', 0, '');
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (10, 3, 0, 'text', 'big_tags', 'Больше теги', 'ID категорий тегов через запятую', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:5:{s:10:"allowBlank";s:4:"true";s:9:"minLength";s:0:"";s:9:"maxLength";s:0:"";s:5:"regex";s:0:"";s:9:"regexText";s:0:"";}', 'a:0:{}', 0, '');
INSERT INTO `modx_site_tmplvars` (`id`, `source`, `property_preprocess`, `type`, `name`, `caption`, `description`, `editor_type`, `category`, `locked`, `elements`, `rank`, `display`, `default_text`, `properties`, `input_properties`, `output_properties`, `static`, `static_file`) VALUES (11, 3, 0, 'text', 'small_tags', 'Маленькие теги', 'ID категорий тегов через запятую', 0, 0, 0, '', 0, 'default', '', 'a:0:{}', 'a:5:{s:10:"allowBlank";s:4:"true";s:9:"minLength";s:0:"";s:9:"maxLength";s:0:"";s:5:"regex";s:0:"";s:9:"regexText";s:0:"";}', 'a:0:{}', 0, '');
```

## Настройки контекста

```sql
INSERT INTO `modx_context_setting` (`context_key`, `key`, `value`, `xtype`, `namespace`, `area`, `editedon`) VALUES
	('mgr', 'allow_tags_in_post', '1', 'combo-boolean', 'core', 'system', NULL),
	('mgr', 'modRequest.class', 'modManagerRequest', 'textfield', 'core', 'system', NULL),
	('web', 'address', 'Санкт-Петербург, ул. Руставели, 13, офис 457', 'textfield', 'core', '', '2023-03-29 11:18:13'),
	('web', 'base_url', 'https://stroymarket.waskuli.beget.tech/', 'textfield', 'core', '', '2025-06-30 15:38:48'),
	('web', 'cart_id', '17398', 'textfield', 'core', 'resource_ids', '2025-06-08 18:16:40'),
	('web', 'catalog_id', '3723', 'textfield', 'core', 'resource_ids', '2025-06-03 16:53:58'),
	('web', 'category_template_id', '2', 'textfield', 'core', '', NULL),
	('web', 'comparison_id', '17413', 'textfield', 'core', 'resource_ids', '2025-06-08 18:17:19'),
	('web', 'dostavka_id', '3722', 'textfield', 'core', '', NULL),
	('web', 'error_page', '', 'textfield', 'core', '', '2025-04-22 12:36:15'),
	('web', 'favorites_id', '17412', 'textfield', 'core', 'resource_ids', '2025-06-08 18:16:31'),
	('web', 'footer_category_ids', '8531,8527,8510,10607,10738,8192,8227,12593', 'textfield', 'core', 'resource_ids', '2025-06-16 17:28:20'),
	('web', 'footer_menu_ids', '17410,3721,3722,17409,17392', 'textfield', 'core', 'resource_ids', '2025-06-16 11:42:57'),
	('web', 'garantii_id', '17392', 'textfield', 'core', 'resource_ids', '2025-06-08 18:15:39'),
	('web', 'header_menu_ids', '17410,17393,3722,17431,3721', 'textfield', 'core', 'resource_ids', '2025-06-03 16:55:32'),
	('web', 'header_mobile_categories_ids', '3724,3972,4245,4466,8303,10481,13292,13297,13327,13347,13378,13387,13416,13552,13769,13830,13955,14019,14492', 'textfield', 'core', 'resource_ids', '2025-06-03 16:47:14'),
	('web', 'http_host', 'stroymarket.waskuli.beget.tech', 'textfield', 'core', '', '2025-06-30 15:38:49'),
	('web', 'phone', '', 'textfield', 'core', '', '2025-06-09 08:27:32'),
	('web', 'policy_id', '17404', 'textfield', 'core', '', NULL),
	('web', 'site_start', '3720', 'textfield', 'core', 'resource_ids', '2025-06-03 16:12:32'),
	('web', 'site_url', 'https://stroymarket.waskuli.beget.tech/', 'textfield', 'core', '', '2025-08-08 08:45:00');
```

## Структура

- Для сложных элементов таких как секции (sections), модули (modules), шаблоны (templates) создаю отдельную папку где главным будет файл wrapper.tpl.

  - Пример: templates/product/wrapper.tpl - Теперь тут можно создавать вспомогательные элементы templates/product/gallery.tpl и тд
