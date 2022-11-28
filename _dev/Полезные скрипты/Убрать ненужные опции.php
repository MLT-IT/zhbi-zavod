<?php

// Шаг 1. Получаем все привязки категория-опция
$sql = 'SELECT o.id, o.key, o.caption
        FROM modx_ms2_category_options as co
        JOIN modx_ms2_options AS o ON co.option_id = o.id
        GROUP BY o.key';
$catopts = $modx->query($sql);
$catopts = $catopts->fetchAll(PDO::FETCH_ASSOC);
// Получаем только ключи
$catoptsKeys = array_column($catopts, 'key');

// Шаг 2. Получаем вообще все опции на сайте (даже которые не привязаны)
$sql = 'SELECT `id`, `key`, `caption`
        FROM modx_ms2_options
        GROUP BY `key`';
$opts = $modx->query($sql);
$opts = $opts->fetchAll(PDO::FETCH_ASSOC);
// Получаем только ключи
$optsKeys = array_column($opts, 'key');

// Шаг 3. Ищем расхождение
$diffKeys = array_diff($optsKeys, $catoptsKeys);
// Находим по ключам другие поля
$diffVals = [];
foreach ($diffKeys as $key) {
    foreach ($opts as $v) {
        if ($v['key'] == $key) {
            $diffVals[] = $v;
        }
    }
}

// Шаг 4. Выводим сообщение, какие опции будут удалены
echo 'В результате работы скрипта были удалены следующие опции:<table>';
foreach ($diffVals as $val) {
    echo '<tr><td style="padding-right: 30px;">'.$val['id'] . '</td><td style="padding-right: 15px;">' . $val['key'] . '</td><td>' . $val['caption'] . '</td></tr>';
}
echo '</table>';

// Шаг 5. Получаем из других полей ТОЛЬКО ids, нам это надо для вызова процессора, который удаляет опции
$diffIds = array_column($diffVals, 'id');

// Шаг 6. Вызываем процессор для удаления неиспользуемых опций
$minishop2 = $modx->getService('miniShop2');

$result = $minishop2->runProcessor('mgr/settings/option/multiple', [
    'ids' => json_encode($diffIds, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
    'method' => 'remove'
]);
echo $result->response['success'];
