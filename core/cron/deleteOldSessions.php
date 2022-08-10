<?php

// -----------------------------------
// Подключаем MODX
// -----------------------------------
define('MODX_API_MODE', true);

$current_dir = !empty($current_dir) ? $current_dir : dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR;
$index_php = $current_dir . 'index.php';

$i = 0;
while (!file_exists($index_php) && $i < 9) {
    $current_dir = dirname(dirname($index_php)) . '/';
    $index_php = $current_dir . 'index.php';
    $i++;
}

if (file_exists($index_php)) {
    require_once $index_php;
}

if (!is_object($modx)) {
    exit('ERROR: Не удалось подгрузить MODX.');
}


// -----------------------------------
// Выполняем скрипт
// -----------------------------------
$maxlifetime = $modx->getOption('session_gc_maxlifetime');
$maxlifetime = abs(intval($maxlifetime));
if ($maxlifetime === 0) {
    exit('ERROR: Некорректное значение $maxlifetime.');
}

// Данный запрос УДАЛЯЕТ все записи из таблицы с сессиями, кроме записей за последнее время ($maxlifetime)
$query = "DELETE FROM `" . $modx->getOption('table_prefix') . "session`
          WHERE access < (UNIX_TIMESTAMP() - " . $maxlifetime . ")";
$result = $modx->query($query);

if ($result === false) {
    exit('ERROR: Произошла ошибка при попытке удалить старые сессии.');
}

exit('SUCCESS: Старые сессии успешно удалены!');
