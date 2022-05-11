-- Если перенести сайт на локалку или еще куда, то придется переносить еще и картинки. А они очень много весят. Куда проще подправить ссылки у товаров, чтобы картинки брались с боевого сайта. Данный код это и делает.
-- Транзакция на самом деле не нужна. Я написал ее просто для того, чтобы объединить несколько запросов в 1.

START TRANSACTION;

UPDATE modx_ms2_product_files
SET url = (CONCAT('https://www-knauf.ru', url))
WHERE url LIKE '/assets/%';

UPDATE modx_ms2_products
SET image = (CONCAT('https://www-knauf.ru', image))
WHERE image LIKE '/assets/%';

UPDATE modx_ms2_products
SET thumb = (CONCAT('https://www-knauf.ru', thumb))
WHERE thumb LIKE '/assets/%';

COMMIT;
