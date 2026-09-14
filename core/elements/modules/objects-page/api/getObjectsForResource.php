<?php
// НЕ ИСПОЛЬЗУЕТСЯ - ДЛЯ СПРАВКИ

header("Access-Control-Allow-Origin: *"); // Allow your client’s origin
header("Access-Control-Allow-Methods: POST, OPTIONS");   // Allow necessary HTTP methods
header("Access-Control-Allow-Headers: Content-Type, X-Requested-With");
header('Content-Type: application/json');

// Respond to preflight (OPTIONS) request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    // Respond with 200 OK and the necessary CORS headers
    http_response_code(200);
    exit(0);
}

$json = file_get_contents('php://input');

// Decode the JSON data to a PHP array
$request = json_decode($json, true);
// handle pagination


$page = $request['page'] ?? 1;  // Current page number (default to 1 if not provided)
$perPage = $request['per_page'] ?? 10;  // Number of items per page (default to 10)
$totalCount = 0;

// echo json_encode($request);

$query = $request['query'];
$product_id = $request['id'];
$context = $request['context'] ?: 'web';

if (empty($_SERVER['HTTP_X_REQUESTED_WITH']) || strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) != 'fetch' || (empty($query) && empty($product_id))) {
    die(json_encode(['error' => 'Headers not set or empty query']));
}

// initialize modX
if (!isset($modx)) {
    try {
        require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/config.core.php';
        require_once MODX_CORE_PATH . 'model/modx/modx.class.php';
        $modx = new modX();
        $modx->initialize($context);
    } catch (Error $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}

// Create a new query
$res = $modx->newQuery('msProductData');

echo json_encode($result);
