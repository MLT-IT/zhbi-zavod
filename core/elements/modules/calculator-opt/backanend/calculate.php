<?php
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

$count = $request['count'];
$productId = $request['productId'];
$context = $request['context'] ?: 'web';

if (empty($_SERVER['HTTP_X_REQUESTED_WITH']) || strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) != 'fetch' || (empty($count) || empty($productId))) {
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

class CalculatorOpt
{
    public function __construct($product, $count)
    {
        $this->count = $count;
        $this->product = $product;
    }

    public function sale($count)
    {
        if ($count < 100) {
            return 0;
        }
        if ($count < 300) {
            return 5;
        }
        if ($count < 500) {
            return 7;
        }
        return 10;
    }

    public function calculate()
    {
        $sum = $this->product->get("price") * $this->count;

        return [
            "sale_sum" => (int)($sum - (($sum / 100) * $this->sale($this->count))),
            "sum" => (int)$sum
        ];
    }
}

try{
    $product = $modx->getObject("msProduct", ['id' => $productId] );
    $calculator = new CalculatorOpt($product, $count);

    echo json_encode($calculator->calculate());
}catch (Throwable $e){
    echo json_encode([
        "error" => "При запросе возникли ошибки",
        "message" => $e->getMessage()
    ]);
}
