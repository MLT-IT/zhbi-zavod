-- Транзакция на самом деле не нужна. Я написал ее просто для того, чтобы объединить несколько запросов в 1.
START TRANSACTION;

-- Обновление картинок для товаров
-- Если перенести сайт на локалку или еще куда, то придется переносить еще и картинки. А они очень много весят. Куда проще подправить ссылки у товаров, чтобы картинки брались с боевого сайта. Данный код это и делает.
UPDATE modx_ms2_product_files
SET url = (CONCAT('https://www-knauf.ru', url))
WHERE url LIKE '/assets/%';

UPDATE modx_ms2_products
SET image = (CONCAT('https://www-knauf.ru', image))
WHERE image LIKE '/assets/%';

UPDATE modx_ms2_products
SET thumb = (CONCAT('https://www-knauf.ru', thumb))
WHERE thumb LIKE '/assets/%';

-- Обновление настроек контекстов
-- krovlyasp
UPDATE modx_context_setting
SET `value` = 'http://krovlyasp.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'krovlya');
UPDATE modx_context_setting
SET `value` = 'krovlyasp.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'krovlya';

-- kirpich-m
UPDATE modx_context_setting
SET `value` = 'http://kirpich-m.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'kirpich-m');
UPDATE modx_context_setting
SET `value` = 'kirpich-m.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'kirpich-m';

-- fasady-pro
UPDATE modx_context_setting
SET `value` = 'http://fasady-pro.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'fasady-pro');
UPDATE modx_context_setting
SET `value` = 'fasady-pro.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'fasady-pro';

-- fasad
UPDATE modx_context_setting
SET `value` = 'http://www-fasad.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'fasad');
UPDATE modx_context_setting
SET `value` = 'www-fasad.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'fasad';

-- armatura-178
UPDATE modx_context_setting
SET `value` = 'http://armatura-178.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'armatura-178');
UPDATE modx_context_setting
SET `value` = 'armatura-178.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'armatura-178';

-- asfalt-prof
UPDATE modx_context_setting
SET `value` = 'http://asfalt-prof.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'asconcrete');
UPDATE modx_context_setting
SET `value` = 'asfalt-prof.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'asconcrete';

-- pilomat-pro
UPDATE modx_context_setting
SET `value` = 'http://pilomat-pro.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'pilomat');
UPDATE modx_context_setting
SET `value` = 'pilomat-pro.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'pilomat';

-- plitaosb
UPDATE modx_context_setting
SET `value` = 'http://plitaosb.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'plitaosb');
UPDATE modx_context_setting
SET `value` = 'plitaosb.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'plitaosb';

-- pro-fanera
UPDATE modx_context_setting
SET `value` = 'http://pro-fanera.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'pro-fanera');
UPDATE modx_context_setting
SET `value` = 'pro-fanera.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'pro-fanera';

-- plity-mdvp
UPDATE modx_context_setting
SET `value` = 'http://plity-mdvp.skderdom.beget.tech/'
WHERE (`key` = 'base_url' OR `key` = 'site_url') AND (context_key = 'plity-mdvp');
UPDATE modx_context_setting
SET `value` = 'plity-mdvp.skderdom.beget.tech'
WHERE `key` = 'http_host' AND context_key = 'plity-mdvp';

COMMIT;
