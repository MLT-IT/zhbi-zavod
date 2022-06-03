<?php

$query = "
SELECT product_id, `file`
FROM modx_ms2_product_files
INNER JOIN modx_site_content resources ON resources.id = product_id
WHERE `file` LIKE '%no-photo.jpg' AND resources.context_key = 'kirpich-m'
";

$val = $modx->query($query);
$val = $val->fetchAll(PDO::FETCH_ASSOC);

echo implode(',', (array_unique(array_column($val, 'product_id'))));
echo '<br>.';
