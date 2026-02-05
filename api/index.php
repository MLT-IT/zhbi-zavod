<?php

if ($_SERVER['REQUEST_METHOD'] !== 'POST') return;

$input = file_get_contents('php://input');
$data = json_decode($input, true);

if (empty($data['action'])) return;

define('MODX_API_MODE', true);
include $_SERVER['DOCUMENT_ROOT'] . '/index.php';


if ($data['action'] === 'get-product-image') {
  $product = $modx->getObject('msProduct', $data['id']);
  if (!$product) exit("Товар с id {$data['id']} не найден");

  exit(json_encode(["image" => $product->get('image')]));
}
