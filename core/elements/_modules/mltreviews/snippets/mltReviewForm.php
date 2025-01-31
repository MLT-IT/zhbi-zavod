<?php
$mainService = $modx->getService('mainService', 'mainService', MODX_CORE_PATH . 'components/mltreviews/services/');

if (!$pdoTools = $modx->getService("pdoTools")) return;

if (empty($tpl)) {
    $tpl = '@FILE _modules/mltreviews/chunks/tplForm.tpl';
}

$params = [
    'action' => $mainService->config['connector_url'] . '?action=create'
];

return $pdoTools->getChunk($tpl, $params);
