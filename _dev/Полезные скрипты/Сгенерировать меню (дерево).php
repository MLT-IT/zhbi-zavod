<?php

// ---------------------------------------
// Настройки
// ---------------------------------------
$ctx = 'fasad';
$resources = '36783,36785,36786,36787,76478,76482,76492,36784,36789,36790,36791,34819,34933,34934,34935,34936,47182,47188,36793,36794,36795,36797,36798,36799,36800,36801,36807,36808,36806,36804';


// ---------------------------------------
// Работа скрипта
// ---------------------------------------
$result = $modx->runSnippet('pdoMenu', [
    'parents' => '0',
    'resources' => $resources,
    'templates' => 5,
    'tplOuter' => '@INLINE [[[+wrapper]]]',
    'showUnpublished' => 1,
    'showHidden' => 1,
    'showDeleted' => 1,
    'sortby' => 'menuindex',
    'sortdir' => 'ASC',
    'level' => 0,
    'context' => $ctx,
    'tpl' => '@INLINE [ "uri" => "[[+link]]", "name" => "[[+menutitle]]" [[+wrapper:is=``:then=``:else=`,"children" => [[+wrapper]]`]] ],',
]);

$result = str_replace(',]', ']', $result);

// Делаем ссылки относительными (чтобы не было проблем, когда я перенесу сайт на тестовый домен или на локалку
$ctx = $modx->getContext($ctx);
$contextUri = $ctx->getOption('base_url');
$result = str_replace($contextUri, '', $result);

// Вывод. Br нужно, чтобы проще было выделить результат (вывод). Просто ставим каретку в начало первой строки. Зажимаем ЛКМ и перемещаем вниз
echo '$categories = ' . $result . '<br>;';
