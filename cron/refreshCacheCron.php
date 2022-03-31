<?php

// -------------------------------
// Основные переменные и константы
// -------------------------------
define('IS_CLI', php_sapi_name() === 'cli');
define('START_TIME', time());
define('PATH_LOGS', __DIR__ . DIRECTORY_SEPARATOR . 'logs');
define('LIMIT', 1000);
$message = '';
$counter = 0;

// Кодировка - если это режим HTTP
if (!IS_CLI) {
    header('Content-Type: text/html; charset=utf-8');
}

// Хак - чтобы не выводились ненужные заголовки. Например, такие: header("Content-Type:text/xml");
echo " ";

output('Начало работы скрипта');


// -------------------------------
// Определение функций
// -------------------------------
// Логирование
function output($text, $isEnd = false) {
    global $message;

    if (IS_CLI) {
        fwrite(STDOUT, $text . "\n");
    } else {
        $message .= $text . '<br>';
    }

    if (!is_dir(PATH_LOGS)) {
        mkdir(PATH_LOGS);
    }
    file_put_contents(PATH_LOGS . DIRECTORY_SEPARATOR . 'log-' . START_TIME . '.txt', $text . "\r\n", FILE_APPEND);

    if ($isEnd) {
        if (!IS_CLI) {
            output($message);
        }
    }
}

// Удаление кеша
function cacheRegenerate($resource) {
    global $modx;

    $id = $resource->id;
    $placeholders = $modx->placeholders;
    $modx->user = $modx->newObject("modUser");
    $modx->request = null;
    $modx->getRequest();

    if ($modx->context->key != $resource->context_key) {
        $modx->contexts = [];
        $modx->switchContext($resource->context_key);
    }

    $modx->user = $modx->newObject("modUser");
    $modx->resourceIdentifier = $id;
    $_REQUEST['id'] = $modx->resourceIdentifier;
    $modx->jscripts = [];
    $modx->sjscripts = [];
    $modx->loadedjscripts = [];

    if (
        $resource->checkPolicy('load')
        && $resource->checkPolicy('view')
        && $modx->resource = $modx->request->getResource('id', $modx->resourceIdentifier)
    ) {
        if (!$modx->resource->getProcessed()) {
            $modx->placeholders = $placeholders;
            $modx->elementCache = [];
            unset($modx->smarty, $modx->services['smarty']);
            $modx->invokeEvent("OnHandleRequest");
            $modx->resource->_output = $modx->resource->process();

            if ($modx->jscripts) {
                $modx->resource->set("_jscripts", $modx->jscripts);
            }

            if ($modx->sjscripts) {
                $modx->resource->set("_sjscripts", $modx->sjscripts);
            }

            if ($modx->loadedjscripts) {
                $modx->resource->set("_loadedjscripts", $modx->loadedjscripts);
            }

            $options = [];
            $modx->getParser();
            $maxIterations = intval($modx->getOption('parser_max_iterations', $options, 10));

            $modx->parser->processElementTags('', $modx->resource->_output, true, false, '[[', ']]', [], $maxIterations);
            $modx->parser->processElementTags('', $modx->resource->_output, true, true, '[[', ']]', [], $maxIterations);

            if (strpos($modx->resource->ContentType->mime_type, 'text/html') !== false) {
                // Вставить начальные JS и CSS в шаблон. Шаблон должен иметь </head> тег
                if (($js = $modx->getRegisteredClientStartupScripts())
                    && (strpos($modx->resource->_output, '</head>') !== false)) {
                    $modx->resource->_output = preg_replace("/(<\/head>)/i", $js . "\n\\1", $modx->resource->_output, 1);
                }

                // Вставить конечные JS и CSS в шаблон. Шаблон должен иметь </body> тег
                if ((strpos($modx->resource->_output, '</body>') !== false) && ($js = $modx->getRegisteredClientScripts())) {
                    $modx->resource->_output = preg_replace("/(<\/body>)/i", $js . "\n\\1", $modx->resource->_output, 1);
                }
            }

            $modx->beforeRender();
            $modx->cacheManager->generateResource($modx->resource);
        }
    }
}


// -------------------------------
// Подключение MODX
// -------------------------------
define('MODX_API_MODE', true);

// Ищем и подключаем index.php
$currentDir = dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR;
$indexPhp = $currentDir . 'index.php';

$i = 0;
while (!file_exists($indexPhp) && $i < 9) {
    $currentDir = dirname(dirname($indexPhp)) . '/';
    $indexPhp = $currentDir . 'index.php';
    $i++;
}

if (file_exists($indexPhp)) {
    require_once $indexPhp;
}

if (!is_object($modx)) {
    output('Не удалось подгрузить MODX', 1);
    die;
}


// -------------------------------
// Работа скрипта
// -------------------------------
// Временная установка настройки для MODX
$modx->setOption("syncsite_default", false);

// Формирование запроса на выборку ресурсов. Исключаем sitemap (template 8), поскольку там по умолчанию forceXML, из-за которого срабатывает exit, что прерывает выполнение скрипта. Также исключаем modWebLink - для него кеш не создается, зачем тратить время и ресурсы на его обработку
$where = 'cacheable = 1 AND published = 1 AND deleted = 0 AND template <> 8 AND class_key <> "modWebLink"';

// Получение общего количества
$query = 'SELECT COUNT(id) FROM ' . $modx->getOption('table_prefix') . 'site_content WHERE ' . $where;
$count = $modx->query($query);
$count = $count->fetchAll(PDO::FETCH_COLUMN);
$count = reset($count);
$maxOffset = $count + LIMIT;

// Запрос для получения ресурсов
$query = 'SELECT id
          FROM ' . $modx->getOption('table_prefix') . 'site_content
          WHERE ' . $where . '
          LIMIT ' . LIMIT;

// Основная работа скрипта
for ($offset = 0; $offset < $maxOffset; $offset += LIMIT) {
    // Выборка id из БД
    $q = $query . ' OFFSET ' . $offset;
    $data = $modx->query($q);
    $data = $data->fetchAll(PDO::FETCH_COLUMN);

    // Обработка выборки
    foreach ($data as $id) {
        if ($resource = $modx->getObject('modResource', $id)) {
            output('Обработка ресурса с id ' . $id);

            cacheRegenerate($resource);
        } else {
            output('Не удалось найти ресурс с id ' . $id);
        }
    }

}

output('Конец работы скрипта', 1);
