-- Таблица с сессиями на некоторых хостингах не очищается и разрастается до огромного веса.

-- Данный запрос ВЫВОДИТ 20 последних записей из таблицы, кроме записей за последние 30 дней. Пригодится для проверок
SELECT id, FROM_UNIXTIME(access) as creationDate
FROM modx_session
WHERE access < (UNIX_TIMESTAMP() - 2629743)
ORDER BY access DESC
LIMIT 20

-- Данный запрос УДАЛЯЕТ все записи из таблицы, кроме записей за последние 30 дней
DELETE FROM modx_session
WHERE access < (UNIX_TIMESTAMP() - 2629743)
