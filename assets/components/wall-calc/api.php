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

if (!isset($modx)) {
  try {
    require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/config.core.php';
    require_once MODX_CORE_PATH . 'model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('web');
  } catch (Error $e) {
    echo json_encode(['error' => $e->getMessage()]);
  }
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

if (empty($_SERVER['HTTP_X_REQUESTED_WITH']) || strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) != 'fetch' || (empty($query) && empty($product_id))) {
  die(json_encode(['error' => 'Headers not set or empty query']));
}

// Create a new query
$c = $modx->newQuery('msProductData');

// Select fields from msProductData and modResource (modx_site_content)
$c->select($modx->getSelectColumns('msProductData', 'msProductData'));
$c->select($modx->getSelectColumns('modResource', 'modResource', '', ['pagetitle', 'menutitle', 'id']));  // Adjust fields as needed
$c->select([
  'item_length.value AS height',
  'item_width.value AS width'
]);


// Join with modResource where msProductData.id matches modResource.id
$c->leftJoin('modResource', 'modResource', 'msProductData.id = modResource.id');

// Left join modx_ms2_product_options for item_length and item_width
$c->leftJoin('msProductOption', 'item_length', "item_length.product_id = msProductData.id AND item_length.key = 'item_length'");
$c->leftJoin('msProductOption', 'item_width', "item_width.product_id = msProductData.id AND item_width.key = 'item_width'");

if(!empty($query)){
  if (preg_match('/^\w+-\d+/', $query)) {
    // Add WHERE condition for 'article' field
    $c->where([
      'msProductData.article:LIKE' => "%{$query}%"
    ]);
  } else {
    $whereSt = [
      'OR:modResource.pagetitle:LIKE' => "%{$query}%",
      'OR:modResource.menutitle:LIKE' => "%{$query}%"
    ];
    // get total
    $countQuery = $modx->newQuery('modResource');
    $countQuery->where($whereSt);
    $totalCount = $modx->getCount('modResource', $countQuery);

    $c->where($whereSt);

    // add limits to query if total is big
    if ($totalCount && $totalCount > $perPage) {
      $c->limit($perPage, ($page - 1) * $perPage);
    }
  }
} elseif (!empty($product_id)) {
  $c->where([
    'modResource.id:=' => "{$product_id}"
  ]);
}



// Execute the query
$products = $modx->getCollection('msProductData', $c);

// Prepare the results as an array
$output = [];
foreach ($products as $product) {
  $output[] = $product->toArray();
}

$result['data'] = $output;
if ($totalCount > 0) {
  $result['total'] = $totalCount;
  if ($page * $perPage < $totalCount) {
    $result['next'] = $page + 1;
  }
}

// Output as JSON
echo json_encode($result);
