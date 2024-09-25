<?php
define('MODX_API_MODE', true);

include $_SERVER['DOCUMENT_ROOT'] . '/index.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $result = $modx->runProcessor($_REQUEST['action'], $_POST, [
        'processors_path' => MODX_CORE_PATH . 'components/mltreviews/processors/web/'
    ]);

    if ($result) {
        exit(json_encode($result->response, JSON_UNESCAPED_UNICODE));
    } else {
        exit(json_encode([
            'success' => false,
            'message' => $modx->lexicon('mlt_review_created_error'),
            'object' => []
        ], JSON_UNESCAPED_UNICODE));
    }
}
