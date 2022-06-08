-- Если в Minishop2 картинка добавлена по ссылке, то в плагине YandexMarket2 будет некорректный путь. Нужно заменить ссылку на путь

-- Транзакция на самом деле не нужна. Я написал ее просто для того, чтобы объединить несколько запросов в 1.
START TRANSACTION;

-- Замена minvata-78.ru
UPDATE modx_ms2_product_files
SET url = (REPLACE(url, 'https://minvata-78.ru', ''))
WHERE url LIKE 'https://minvata-78.ru%';
UPDATE modx_ms2_products
SET image = (REPLACE(image, 'https://minvata-78.ru', ''))
WHERE image LIKE 'https://minvata-78.ru%';
UPDATE modx_ms2_products
SET thumb = (REPLACE(thumb, 'https://minvata-78.ru', ''))
WHERE thumb LIKE 'https://minvata-78.ru%';

-- Замена www-knauf.ru
UPDATE modx_ms2_product_files
SET url = (REPLACE(url, 'https://www-knauf.ru', ''))
WHERE url LIKE 'https://www-knauf.ru%';
UPDATE modx_ms2_products
SET image = (REPLACE(image, 'https://www-knauf.ru', ''))
WHERE image LIKE 'https://www-knauf.ru%';
UPDATE modx_ms2_products
SET thumb = (REPLACE(thumb, 'https://www-knauf.ru', ''))
WHERE thumb LIKE 'https://www-knauf.ru%';

-- Замена kirpich-m.ru
UPDATE modx_ms2_product_files
SET url = (REPLACE(url, 'https://kirpich-m.ru', ''))
WHERE url LIKE 'https://kirpich-m.ru%';
UPDATE modx_ms2_products
SET image = (REPLACE(image, 'https://kirpich-m.ru', ''))
WHERE image LIKE 'https://kirpich-m.ru%';
UPDATE modx_ms2_products
SET thumb = (REPLACE(thumb, 'https://kirpich-m.ru', ''))
WHERE thumb LIKE 'https://kirpich-m.ru%';

COMMIT;
