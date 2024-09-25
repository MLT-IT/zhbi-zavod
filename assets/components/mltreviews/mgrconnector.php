<?php
define('MODX_API_MODE', true);

include $_SERVER['DOCUMENT_ROOT'] . '/index.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Получение сырых данных JSON из тела запроса
    $input = file_get_contents('php://input');

    $data = json_decode($input, true);

    $result = $modx->runProcessor($_REQUEST['action'], $data, [
        'processors_path' => MODX_CORE_PATH . 'components/mltreviews/processors/mgr/'
    ]);

    if ($result) {
        exit(json_encode($result->response, JSON_UNESCAPED_UNICODE));
    } else {
        exit(json_encode([
            'success' => false,
            'message' => "",
            'object' => []
        ], JSON_UNESCAPED_UNICODE));
    }
}
