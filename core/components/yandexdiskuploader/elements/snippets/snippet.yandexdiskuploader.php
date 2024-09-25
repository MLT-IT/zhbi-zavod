<?php
/** @var modX $modx */
/** @var array $scriptProperties */

$sp = &$scriptProperties;

$tpl = $modx->getOption('tpl', $sp, 'tpl.YandexDiskUploader');
$inputId = $modx->getOption('inputId', $sp, 'file');
$css = $modx->getOption('yandexdiskuploader_frontend_css', null, '[[+cssUrl]]web/default.css');
$js = $modx->getOption('yandexdiskuploader_frontend_js', null, '[[+jsUrl]]web/default.js?v=1.0.0-beta-1');
$css = str_replace('[[+cssUrl]]', $modx->getOption('assets_url') . 'components/yandexdiskuploader/css/', $css);
$js = str_replace('[[+jsUrl]]', $modx->getOption('assets_url') . 'components/yandexdiskuploader/js/', $js);

$modx->regClientStartupScript($modx->getOption('assets_url') . 'components/yandexdiskuploader/js/web/dropzone.js');
$modx->regClientCSS($modx->getOption('assets_url') . 'components/yandexdiskuploader/css/web/dropzone.css');
$modx->regClientCSS($css);
$modx->regClientScript($js);
return $modx->getChunk($tpl, array('name' => $inputId));