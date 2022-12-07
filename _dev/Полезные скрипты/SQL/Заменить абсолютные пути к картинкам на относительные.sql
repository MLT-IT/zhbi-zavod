START TRANSACTION;

UPDATE `modx_ms2_product_files`
SET `url` = REPLACE(`url`, 'https://minvata-78.ru', '')
WHERE `url` LIKE 'https://minvata-78.ru/%';

UPDATE `modx_ms2_products`
SET `image` = REPLACE(`image`, 'https://minvata-78.ru', '')
WHERE `image` LIKE 'https://minvata-78.ru/%';

UPDATE `modx_ms2_products`
SET `thumb` = REPLACE(`thumb`, 'https://minvata-78.ru', '')
WHERE `thumb` LIKE 'https://minvata-78.ru/%';

COMMIT;
